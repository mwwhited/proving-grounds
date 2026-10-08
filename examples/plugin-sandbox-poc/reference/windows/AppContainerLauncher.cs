// REFERENCE SKETCH: written in conversation, never compiled or tested.
// Needs real error handling, cleanup on every failure path, and tests.
//
// Launches a plugin executable inside an AppContainer (Windows 8+). With no capabilities
// granted the container has no network access, and it can only touch files whose ACL grants
// the container's SID. (Process.Start / ProcessStartInfo cannot set this attribute.)
//
// Design rules reflected here (see docs/design.md section 4 and 6):
//  * Only the stdio channel handles are inherited: PROC_THREAD_ATTRIBUTE_HANDLE_LIST with
//    bInheritHandles = true. (Earlier sketch used bInheritHandles = false; superseded.)
//  * Process is created CREATE_SUSPENDED, assigned to its per-plugin job, THEN resumed,
//    so it is never running outside the job. Detached plugins skip the kill-on-close job.
//  * Keep the process handle open; do not rely on Process.GetProcessById for sandboxed
//    processes (it can fail with access denied). Wait on the raw handle.
//  * Grants: container SID needs read+execute on the plugin's platform folder (and, for LPAC,
//    on system paths the runtime needs), plus modify on the plugin's data directory.
//  * ACL changes persist on disk after the plugin stops. Remove them on uninstall.
//  * Fail closed: any failure here means the plugin does not run.

using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Security.AccessControl;
using System.Security.Principal;
using System.Text;

// Uses the Lifetime enum (Bound / Detached) defined in reference/shared/ManagedPlugin.cs.

public sealed record WinGrant(string Path, FileSystemRights Rights);

public sealed record WinLaunchSpec(
    string PluginId,
    string ExePath,
    string Arguments,
    string WorkingDir,
    IReadOnlyList<WinGrant> Grants,
    Lifetime Lifetime,
    long? MemoryLimitBytes = null,
    bool UseLpac = false);

public sealed class WinPluginProcess : IDisposable
{
    public IntPtr ProcessHandle { get; init; }   // keep open: exit code + waiting
    public int ProcessId { get; init; }
    public PluginJob? Job { get; init; }          // null for Detached
    public Stream ToPlugin { get; init; } = Stream.Null;     // host writes -> plugin stdin
    public Stream FromPlugin { get; init; } = Stream.Null;   // host reads  <- plugin stdout

    public void Dispose()
    {
        ToPlugin.Dispose(); FromPlugin.Dispose();
        Job?.Dispose();                               // kills the plugin if KILL_ON_JOB_CLOSE
        if (ProcessHandle != IntPtr.Zero) CloseHandle(ProcessHandle);
    }

    [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr h);
}

public static class AppContainerLauncher
{
    public static WinPluginProcess Launch(WinLaunchSpec spec)
    {
        string name = "MyApp.Plugin." + spec.PluginId;     // one profile per plugin

        // 1. Create (or look up) the AppContainer profile -> SID
        int hr = CreateAppContainerProfile(name, name, name, IntPtr.Zero, 0, out IntPtr sid);
        if (hr == unchecked((int)0x800700B7))              // ERROR_ALREADY_EXISTS
            hr = DeriveAppContainerSidFromAppContainerName(name, out sid);
        Marshal.ThrowExceptionForHR(hr);

        IntPtr attrList = IntPtr.Zero, pCaps = IntPtr.Zero, pHandles = IntPtr.Zero, pPolicy = IntPtr.Zero;
        IntPtr inRead = IntPtr.Zero, inWrite = IntPtr.Zero, outRead = IntPtr.Zero, outWrite = IntPtr.Zero;
        PluginJob? job = null;
        try
        {
            // 2. Grant ONLY what the manifest allows
            var secId = new SecurityIdentifier(sid);
            foreach (var g in spec.Grants)
            {
                var di = new DirectoryInfo(g.Path);
                var acl = di.GetAccessControl();
                acl.AddAccessRule(new FileSystemAccessRule(secId, g.Rights,
                    InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit,
                    PropagationFlags.None, AccessControlType.Allow));
                di.SetAccessControl(acl);
            }

            // 3. Anonymous pipes for the stdio channel. Child ends must be inheritable;
            //    the host's ends must NOT be, or the plugin could hold them.
            var sa = new SECURITY_ATTRIBUTES { nLength = Marshal.SizeOf<SECURITY_ATTRIBUTES>(), bInheritHandle = true };
            if (!CreatePipe(out inRead, out inWrite, ref sa, 0)) throw new Win32Exception();
            if (!CreatePipe(out outRead, out outWrite, ref sa, 0)) throw new Win32Exception();
            SetHandleInformation(inWrite, HANDLE_FLAG_INHERIT, 0);    // host end of stdin pipe
            SetHandleInformation(outRead, HANDLE_FLAG_INHERIT, 0);    // host end of stdout pipe

            // 4. Attribute list: SECURITY_CAPABILITIES (+ HANDLE_LIST, + optional LPAC)
            int attrCount = spec.UseLpac ? 3 : 2;
            IntPtr size = IntPtr.Zero;
            InitializeProcThreadAttributeList(IntPtr.Zero, attrCount, 0, ref size);
            attrList = Marshal.AllocHGlobal(size);
            if (!InitializeProcThreadAttributeList(attrList, attrCount, 0, ref size)) throw new Win32Exception();

            var caps = new SECURITY_CAPABILITIES { AppContainerSid = sid };   // no capabilities = no network
            pCaps = Marshal.AllocHGlobal(Marshal.SizeOf<SECURITY_CAPABILITIES>());
            Marshal.StructureToPtr(caps, pCaps, false);
            if (!UpdateProcThreadAttribute(attrList, 0, (IntPtr)PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES,
                    pCaps, (IntPtr)Marshal.SizeOf<SECURITY_CAPABILITIES>(), IntPtr.Zero, IntPtr.Zero))
                throw new Win32Exception();

            // Inherit ONLY the two child pipe ends (stderr shares the stdout pipe's write end here;
            // give it its own pipe if you want logs separated from protocol frames).
            pHandles = Marshal.AllocHGlobal(IntPtr.Size * 2);
            Marshal.WriteIntPtr(pHandles, 0, inRead);
            Marshal.WriteIntPtr(pHandles, IntPtr.Size, outWrite);
            if (!UpdateProcThreadAttribute(attrList, 0, (IntPtr)PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
                    pHandles, (IntPtr)(IntPtr.Size * 2), IntPtr.Zero, IntPtr.Zero))
                throw new Win32Exception();

            if (spec.UseLpac)
            {
                // Opt out of "ALL APPLICATION PACKAGES": stricter, but then even system paths the
                // runtime needs must be granted explicitly to the container SID.
                pPolicy = Marshal.AllocHGlobal(4);
                Marshal.WriteInt32(pPolicy, PROCESS_CREATION_ALL_APPLICATION_PACKAGES_OPT_OUT);
                if (!UpdateProcThreadAttribute(attrList, 0, (IntPtr)PROC_THREAD_ATTRIBUTE_ALL_APPLICATION_PACKAGES_POLICY,
                        pPolicy, (IntPtr)4, IntPtr.Zero, IntPtr.Zero))
                    throw new Win32Exception();
            }

            // 5. Launch suspended
            var si = new STARTUPINFOEX();
            si.StartupInfo.cb = Marshal.SizeOf<STARTUPINFOEX>();
            si.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
            si.StartupInfo.hStdInput = inRead;
            si.StartupInfo.hStdOutput = outWrite;
            si.StartupInfo.hStdError = outWrite;
            si.lpAttributeList = attrList;

            uint flags = EXTENDED_STARTUPINFO_PRESENT | CREATE_SUSPENDED;
            flags |= spec.Lifetime == Lifetime.Detached ? DETACHED_PROCESS : CREATE_NO_WINDOW;
            // For Detached under a parent job that forbids survival, also add CREATE_BREAKAWAY_FROM_JOB
            // (only works if that parent job allows breakaway).

            var cmd = new StringBuilder($"\"{spec.ExePath}\" {spec.Arguments}");
            if (!CreateProcessW(null, cmd, IntPtr.Zero, IntPtr.Zero, /*bInheritHandles*/ true, flags,
                    IntPtr.Zero, spec.WorkingDir, ref si, out var pi))
                throw new Win32Exception();

            // 6. Bind to host lifetime BEFORE it runs a single instruction
            try
            {
                if (spec.Lifetime == Lifetime.Bound)
                {
                    job = new PluginJob(killOnClose: true, spec.MemoryLimitBytes);
                    job.Assign(pi.hProcess);
                }
                else if (spec.MemoryLimitBytes is not null)
                {
                    job = new PluginJob(killOnClose: false, spec.MemoryLimitBytes);
                    job.Assign(pi.hProcess);
                }
                if (ResumeThread(pi.hThread) == unchecked((uint)-1)) throw new Win32Exception();
            }
            catch
            {
                TerminateProcess(pi.hProcess, 1);       // fail closed
                CloseHandle(pi.hProcess); CloseHandle(pi.hThread);
                job?.Dispose();
                throw;
            }
            CloseHandle(pi.hThread);

            // Host must close its copies of the child's pipe ends so EOF works when the plugin exits.
            CloseHandle(inRead); inRead = IntPtr.Zero;
            CloseHandle(outWrite); outWrite = IntPtr.Zero;

            return new WinPluginProcess
            {
                ProcessHandle = pi.hProcess,
                ProcessId = pi.dwProcessId,
                Job = job,
                ToPlugin = new FileStream(new Microsoft.Win32.SafeHandles.SafeFileHandle(inWrite, true), FileAccess.Write, 4096, false),
                FromPlugin = new FileStream(new Microsoft.Win32.SafeHandles.SafeFileHandle(outRead, true), FileAccess.Read, 4096, false),
            };
        }
        finally
        {
            if (attrList != IntPtr.Zero) { DeleteProcThreadAttributeList(attrList); Marshal.FreeHGlobal(attrList); }
            if (pCaps != IntPtr.Zero) Marshal.FreeHGlobal(pCaps);
            if (pHandles != IntPtr.Zero) Marshal.FreeHGlobal(pHandles);
            if (pPolicy != IntPtr.Zero) Marshal.FreeHGlobal(pPolicy);
            if (inRead != IntPtr.Zero) CloseHandle(inRead);
            if (outWrite != IntPtr.Zero) CloseHandle(outWrite);
            FreeSid(sid);
            // NOTE: on failure paths inWrite/outRead leak in this sketch; close them in real code.
        }
    }

    /// <summary>Remove the AppContainer profile (e.g. on plugin uninstall). Also remove granted ACLs.</summary>
    public static void DeleteProfile(string pluginId) =>
        DeleteAppContainerProfile("MyApp.Plugin." + pluginId);

    // ----- constants -----
    const int PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES = 0x20009;
    const int PROC_THREAD_ATTRIBUTE_HANDLE_LIST = 0x20002;
    const int PROC_THREAD_ATTRIBUTE_ALL_APPLICATION_PACKAGES_POLICY = 0x2000F;
    const int PROCESS_CREATION_ALL_APPLICATION_PACKAGES_OPT_OUT = 1;
    const uint EXTENDED_STARTUPINFO_PRESENT = 0x00080000;
    const uint CREATE_SUSPENDED = 0x00000004;
    const uint CREATE_NO_WINDOW = 0x08000000;
    const uint DETACHED_PROCESS = 0x00000008;          // do not combine with CREATE_NO_WINDOW
    const int STARTF_USESTDHANDLES = 0x00000100;
    const uint HANDLE_FLAG_INHERIT = 0x00000001;

    // ----- structs -----
    [StructLayout(LayoutKind.Sequential)]
    struct SECURITY_CAPABILITIES
    {
        public IntPtr AppContainerSid;
        public IntPtr Capabilities;
        public uint CapabilityCount;
        public uint Reserved;
    }

    [StructLayout(LayoutKind.Sequential)]
    struct SECURITY_ATTRIBUTES { public int nLength; public IntPtr lpSecurityDescriptor; public bool bInheritHandle; }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    struct STARTUPINFO
    {
        public int cb; public string? lpReserved, lpDesktop, lpTitle;
        public int dwX, dwY, dwXSize, dwYSize, dwXCountChars, dwYCountChars, dwFillAttribute, dwFlags;
        public short wShowWindow, cbReserved2;
        public IntPtr lpReserved2, hStdInput, hStdOutput, hStdError;
    }

    [StructLayout(LayoutKind.Sequential)]
    struct STARTUPINFOEX { public STARTUPINFO StartupInfo; public IntPtr lpAttributeList; }

    [StructLayout(LayoutKind.Sequential)]
    struct PROCESS_INFORMATION { public IntPtr hProcess, hThread; public int dwProcessId, dwThreadId; }

    // ----- P/Invoke -----
    [DllImport("userenv.dll", CharSet = CharSet.Unicode)]
    static extern int CreateAppContainerProfile(string name, string display, string desc, IntPtr caps, uint capCount, out IntPtr sid);

    [DllImport("userenv.dll", CharSet = CharSet.Unicode)]
    static extern int DeriveAppContainerSidFromAppContainerName(string name, out IntPtr sid);

    [DllImport("userenv.dll", CharSet = CharSet.Unicode)]
    static extern int DeleteAppContainerProfile(string name);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool InitializeProcThreadAttributeList(IntPtr list, int count, int flags, ref IntPtr size);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool UpdateProcThreadAttribute(IntPtr list, uint flags, IntPtr attr, IntPtr value, IntPtr size, IntPtr prev, IntPtr retSize);

    [DllImport("kernel32.dll")] static extern void DeleteProcThreadAttributeList(IntPtr list);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool CreatePipe(out IntPtr read, out IntPtr write, ref SECURITY_ATTRIBUTES sa, uint size);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool SetHandleInformation(IntPtr h, uint mask, uint flags);

    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Unicode)]
    static extern bool CreateProcessW(string? app, StringBuilder cmd, IntPtr pa, IntPtr ta, bool inherit, uint flags,
        IntPtr env, string? dir, ref STARTUPINFOEX si, out PROCESS_INFORMATION pi);

    [DllImport("kernel32.dll", SetLastError = true)] static extern uint ResumeThread(IntPtr hThread);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool TerminateProcess(IntPtr h, uint code);
    [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr h);
    [DllImport("advapi32.dll")] static extern IntPtr FreeSid(IntPtr sid);
}
