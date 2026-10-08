using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Runtime.Versioning;
using System.Security.AccessControl;
using System.Security.Principal;
using System.Text;
using Microsoft.Win32.SafeHandles;
using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.Launchers.Windows;

/// <summary>
/// Starts a plugin inside an AppContainer with no capabilities (no network, no user files), in its own job
/// object, inheriting only its three stdio pipe ends. Fail closed: if any step fails the plugin does not run.
/// Granted ACLs persist on disk after the plugin stops (a restart reuses them). Every grant is recorded in a ledger;
/// <see cref="Uninstall"/> revokes them all and removes the container.
/// </summary>
[SupportedOSPlatform("windows")]
public sealed class AppContainerLauncher(WindowsLauncherOptions? options = null) : IPluginLauncher
{
    private readonly WindowsLauncherOptions _options = options ?? new();

    public ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct)
    {
        ct.ThrowIfCancellationRequested();
        return ValueTask.FromResult<IPluginProcess>(Launch(spec));
    }

    private static string ProfileName(string pluginId)
    {
        var clean = new string(pluginId.Select(c => char.IsAsciiLetterOrDigit(c) || c is '.' or '-' or '_' ? c : '_').ToArray());
        var name = "OoBDev.Plugin." + clean;
        return name.Length <= 64 ? name : name[..64];
    }

    public static void RemoveProfile(string pluginId) => DeleteAppContainerProfile(ProfileName(pluginId));

    private static string LedgerPath(string profileName) => Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "OoBDev", "Plugins", "grants", profileName + ".txt");

    private static void Record(string profileName, string path)
    {
        var ledger = LedgerPath(profileName);
        Directory.CreateDirectory(Path.GetDirectoryName(ledger)!);
        if (File.Exists(ledger) && File.ReadLines(ledger).Contains(path, StringComparer.OrdinalIgnoreCase)) return;
        using var f = new FileStream(ledger, FileMode.Append, FileAccess.Write, FileShare.ReadWrite);
        using var w = new StreamWriter(f);
        w.WriteLine(path);
    }

    /// <summary>
    /// Undoes a plugin's installation: removes every ACL entry the launcher added for it (from the ledger, plus
    /// <paramref name="extraPaths"/> for grants made before the ledger existed), then deletes its container profile.
    /// Returns the number of folders it revoked access on. Idempotent. Do it while the plugin is stopped.
    /// </summary>
    public static int Uninstall(string pluginId, IEnumerable<string>? extraPaths = null)
    {
        var name = ProfileName(pluginId);
        Marshal.ThrowExceptionForHR(DeriveAppContainerSidFromAppContainerName(name, out var sidPtr));
        int revoked = 0;
        try
        {
            var sid = new SecurityIdentifier(sidPtr);
            var ledger = LedgerPath(name);
            var paths = (File.Exists(ledger) ? File.ReadAllLines(ledger) : []).Concat(extraPaths ?? [])
                .Where(p => !string.IsNullOrWhiteSpace(p)).Select(Path.GetFullPath).Distinct(StringComparer.OrdinalIgnoreCase);
            foreach (var path in paths)
            {
                var di = new DirectoryInfo(path);
                if (!di.Exists) continue;
                var acl = di.GetAccessControl();
                if (acl.GetAccessRules(true, false, typeof(SecurityIdentifier)).Cast<FileSystemAccessRule>().All(r => !r.IdentityReference.Equals(sid))) continue;
                acl.PurgeAccessRules(sid);
                di.SetAccessControl(acl);
                revoked++;
            }
            DeleteAppContainerProfile(name);
            if (File.Exists(ledger)) File.Delete(ledger);
        }
        finally { FreeSid(sidPtr); }
        return revoked;
    }

    private WinPlugin Launch(PluginSpec spec)
    {
        string name = ProfileName(spec.Id);
        int hr = CreateAppContainerProfile(name, name, name, IntPtr.Zero, 0, out IntPtr sid);
        if (hr == unchecked((int)0x800700B7)) hr = DeriveAppContainerSidFromAppContainerName(name, out sid);   // already exists
        Marshal.ThrowExceptionForHR(hr);

        IntPtr pEnv = IntPtr.Zero, attrList = IntPtr.Zero, pCaps = IntPtr.Zero, pHandles = IntPtr.Zero, pPolicy = IntPtr.Zero;
        IntPtr inRead = 0, inWrite = 0, outRead = 0, outWrite = 0, errRead = 0, errWrite = 0;
        PluginJob? job = null;
        IntPtr hProcess = 0;
        try
        {
            var secId = new SecurityIdentifier(sid);
            Grant(name, secId, spec.WorkingDirectory, FileSystemRights.ReadAndExecute);
            foreach (var p in _options.RuntimeReadPaths) Grant(name, secId, p, FileSystemRights.ReadAndExecute);
            foreach (var g in spec.Grants)
                Grant(name, secId, g.Path, g.Write ? FileSystemRights.Modify : FileSystemRights.ReadAndExecute);

            var sa = new SECURITY_ATTRIBUTES { nLength = Marshal.SizeOf<SECURITY_ATTRIBUTES>(), bInheritHandle = true };
            if (!CreatePipe(out inRead, out inWrite, ref sa, 0)) throw new Win32Exception();
            if (!CreatePipe(out outRead, out outWrite, ref sa, 0)) throw new Win32Exception();
            if (!CreatePipe(out errRead, out errWrite, ref sa, 0)) throw new Win32Exception();
            // the host's ends must not be inheritable, or the plugin could hold them
            foreach (var h in new[] { inWrite, outRead, errRead })
                if (!SetHandleInformation(h, HANDLE_FLAG_INHERIT, 0)) throw new Win32Exception();

            int attrCount = _options.UseLpac ? 3 : 2;
            IntPtr size = IntPtr.Zero;
            InitializeProcThreadAttributeList(IntPtr.Zero, attrCount, 0, ref size);
            attrList = Marshal.AllocHGlobal(size);
            if (!InitializeProcThreadAttributeList(attrList, attrCount, 0, ref size)) throw new Win32Exception();

            var caps = new SECURITY_CAPABILITIES { AppContainerSid = sid };
            pCaps = Marshal.AllocHGlobal(Marshal.SizeOf<SECURITY_CAPABILITIES>());
            Marshal.StructureToPtr(caps, pCaps, false);
            if (!UpdateProcThreadAttribute(attrList, 0, PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES, pCaps,
                    (IntPtr)Marshal.SizeOf<SECURITY_CAPABILITIES>(), IntPtr.Zero, IntPtr.Zero)) throw new Win32Exception();

            pHandles = Marshal.AllocHGlobal(IntPtr.Size * 3);
            Marshal.WriteIntPtr(pHandles, 0, inRead);
            Marshal.WriteIntPtr(pHandles, IntPtr.Size, outWrite);
            Marshal.WriteIntPtr(pHandles, IntPtr.Size * 2, errWrite);
            if (!UpdateProcThreadAttribute(attrList, 0, PROC_THREAD_ATTRIBUTE_HANDLE_LIST, pHandles,
                    (IntPtr)(IntPtr.Size * 3), IntPtr.Zero, IntPtr.Zero)) throw new Win32Exception();

            if (_options.UseLpac)
            {
                pPolicy = Marshal.AllocHGlobal(4);
                Marshal.WriteInt32(pPolicy, 1);   // PROCESS_CREATION_ALL_APPLICATION_PACKAGES_OPT_OUT
                if (!UpdateProcThreadAttribute(attrList, 0, PROC_THREAD_ATTRIBUTE_ALL_APPLICATION_PACKAGES_POLICY, pPolicy,
                        (IntPtr)4, IntPtr.Zero, IntPtr.Zero)) throw new Win32Exception();
            }

            var si = new STARTUPINFOEX();
            si.StartupInfo.cb = Marshal.SizeOf<STARTUPINFOEX>();
            si.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
            si.StartupInfo.hStdInput = inRead;
            si.StartupInfo.hStdOutput = outWrite;
            si.StartupInfo.hStdError = errWrite;
            si.lpAttributeList = attrList;

            var exe = ResolveExecutable(spec);
            var cmd = new StringBuilder(CommandLine(exe, spec.Command.Skip(1)));
            // The plugin gets a minimal environment, never the host's: tokens, connection strings and API keys
            // in the host's variables must not reach it.
            pEnv = Marshal.StringToHGlobalUni(EnvironmentBlock(ContainerFolder(secId)));
            if (!CreateProcessW(null, cmd, IntPtr.Zero, IntPtr.Zero, true,
                    EXTENDED_STARTUPINFO_PRESENT | CREATE_SUSPENDED | CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT,
                    pEnv, Path.GetFullPath(spec.WorkingDirectory), ref si, out var pi)) throw new Win32Exception();
            hProcess = pi.hProcess;

            try
            {
                // Bound is the only lifetime implemented. The process joins its job before it runs one instruction.
                if (spec.Lifetime != Lifetime.Bound) throw new NotSupportedException("Detached plugins are not implemented.");
                job = new PluginJob(killOnClose: true, spec.Limits.MemoryBytes, spec.Limits.CpuPercent);
                job.Assign(pi.hProcess);
                if (ResumeThread(pi.hThread) == unchecked((uint)-1)) throw new Win32Exception();
            }
            catch
            {
                TerminateProcess(pi.hProcess, 1);
                CloseHandle(pi.hProcess); hProcess = 0;
                job?.Dispose();
                throw;
            }
            finally { CloseHandle(pi.hThread); }

            // the host must drop its copies of the child's ends so EOF works when the plugin exits
            CloseHandle(inRead); inRead = 0;
            CloseHandle(outWrite); outWrite = 0;
            CloseHandle(errWrite); errWrite = 0;

            var result = new WinPlugin(hProcess, job,
                new FileStream(new SafeFileHandle(inWrite, true), FileAccess.Write, 1, false),
                new FileStream(new SafeFileHandle(outRead, true), FileAccess.Read, 1, false),
                new FileStream(new SafeFileHandle(errRead, true), FileAccess.Read, 1, false));
            inWrite = outRead = errRead = 0;
            return result;
        }
        catch
        {
            foreach (var h in new[] { inRead, inWrite, outRead, outWrite, errRead, errWrite })
                if (h != 0) CloseHandle(h);
            throw;
        }
        finally
        {
            if (attrList != IntPtr.Zero) { DeleteProcThreadAttributeList(attrList); Marshal.FreeHGlobal(attrList); }
            if (pCaps != IntPtr.Zero) Marshal.FreeHGlobal(pCaps);
            if (pHandles != IntPtr.Zero) Marshal.FreeHGlobal(pHandles);
            if (pPolicy != IntPtr.Zero) Marshal.FreeHGlobal(pPolicy);
            if (pEnv != IntPtr.Zero) Marshal.FreeHGlobal(pEnv);
            FreeSid(sid);
        }
    }

    /// <summary>The container's private, writable folder (under the user's Packages folder). Nothing else can touch it.</summary>
    private static string ContainerFolder(SecurityIdentifier sid)
    {
        Marshal.ThrowExceptionForHR(GetAppContainerFolderPath(sid.Value, out IntPtr p));
        try { return Marshal.PtrToStringUni(p)!; }
        finally { Marshal.FreeCoTaskMem(p); }
    }

    /// <summary>Only what a runtime needs to start. Sorted, double-NUL terminated, as CreateProcess requires.</summary>
    private static string EnvironmentBlock(string containerFolder)
    {
        var system = Environment.GetFolderPath(Environment.SpecialFolder.System);
        var root = Environment.GetEnvironmentVariable("SystemRoot") ?? Path.GetDirectoryName(system)!;
        var temp = Directory.CreateDirectory(Path.Combine(containerFolder, "Temp")).FullName;
        var vars = new SortedDictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
            ["SystemRoot"] = root,
            ["windir"] = root,
            ["SystemDrive"] = Environment.GetEnvironmentVariable("SystemDrive") ?? "C:",
            ["PATH"] = system,
            ["PATHEXT"] = ".COM;.EXE;.BAT;.CMD",
            ["PROCESSOR_ARCHITECTURE"] = Environment.GetEnvironmentVariable("PROCESSOR_ARCHITECTURE") ?? "AMD64",
            ["LOCALAPPDATA"] = containerFolder,   // Windows insists on it; this is the container's own folder, not the user's
            ["TEMP"] = temp,
            ["TMP"] = temp,
            ["NUMBER_OF_PROCESSORS"] = Environment.ProcessorCount.ToString(),
        };
        var sb = new StringBuilder();
        foreach (var (k, v) in vars) sb.Append(k).Append('=').Append(v).Append('\0');
        return sb.Append('\0').ToString();
    }

    private static void Grant(string profileName, SecurityIdentifier sid, string path, FileSystemRights rights)
    {
        Record(profileName, Path.GetFullPath(path));
        var di = new DirectoryInfo(Path.GetFullPath(path));
        var acl = di.GetAccessControl();
        // ACLs persist, so a plugin that restarts finds its grant already in place; rewriting a big tree on every launch is slow
        if (acl.GetAccessRules(true, false, typeof(SecurityIdentifier)).Cast<FileSystemAccessRule>().Any(r =>
                r.IdentityReference.Equals(sid) && r.AccessControlType == AccessControlType.Allow && (r.FileSystemRights & rights) == rights
                && r.InheritanceFlags == (InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit)))
            return;
        acl.AddAccessRule(new FileSystemAccessRule(sid, rights,
            InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit, PropagationFlags.None, AccessControlType.Allow));
        di.SetAccessControl(acl);
    }

    private static string ResolveExecutable(PluginSpec spec)
    {
        var command = spec.Command[0];
        if (command.IndexOfAny(['/', '\\']) >= 0)
        {
            var path = Path.GetFullPath(command, Path.GetFullPath(spec.WorkingDirectory));
            return File.Exists(path) || !File.Exists(path + ".exe") ? path : path + ".exe";
        }
        foreach (var dir in (Environment.GetEnvironmentVariable("PATH") ?? "").Split(Path.PathSeparator, StringSplitOptions.RemoveEmptyEntries))
        {
            var candidate = Path.Combine(dir.Trim('"'), command.EndsWith(".exe", StringComparison.OrdinalIgnoreCase) ? command : command + ".exe");
            if (File.Exists(candidate)) return candidate;
        }
        throw new FileNotFoundException($"Cannot find '{command}' on PATH.");
    }

    private static string CommandLine(string exe, IEnumerable<string> args)
    {
        var sb = new StringBuilder().Append('"').Append(exe).Append('"');
        foreach (var a in args) sb.Append(' ').Append(Quote(a));
        return sb.ToString();
    }

    private static string Quote(string arg)
    {
        if (arg.Length > 0 && arg.IndexOfAny([' ', '\t', '"']) < 0) return arg;
        var sb = new StringBuilder("\"");
        int backslashes = 0;
        foreach (var c in arg)
        {
            if (c == '\\') { backslashes++; continue; }
            if (c == '"') sb.Append('\\', backslashes * 2 + 1).Append('"');
            else sb.Append('\\', backslashes).Append(c);
            backslashes = 0;
        }
        return sb.Append('\\', backslashes * 2).Append('"').ToString();
    }

    private sealed class WinPlugin : IPluginProcess
    {
        private readonly IntPtr _process;
        private readonly PluginJob _job;
        private readonly TaskCompletionSource<int> _exited = new(TaskCreationOptions.RunContinuationsAsynchronously);
        private readonly ManualResetEvent _waitEvent;
        private readonly RegisteredWaitHandle _registration;
        private int _disposed;

        public WinPlugin(IntPtr process, PluginJob job, Stream input, Stream output, Stream error)
        {
            _process = process; _job = job; Input = input; Output = output; Error = error;
            _waitEvent = new ManualResetEvent(false) { SafeWaitHandle = new SafeWaitHandle(process, ownsHandle: false) };
            _registration = ThreadPool.RegisterWaitForSingleObject(_waitEvent, (_, _) =>
            {
                _exited.TrySetResult(GetExitCodeProcess(_process, out uint code) ? unchecked((int)code) : -1);
            }, null, Timeout.Infinite, executeOnlyOnce: true);
        }

        public Stream Input { get; }
        public Stream Output { get; }
        public Stream? Error { get; }
        public Task<int> Exited => _exited.Task;

        public void Kill()
        {
            if (Volatile.Read(ref _disposed) != 0) return;
            try { TerminateProcess(_process, 1); } catch { }
        }

        public ValueTask DisposeAsync()
        {
            if (Interlocked.Exchange(ref _disposed, 1) != 0) return ValueTask.CompletedTask;
            _job.Dispose();   // kill-on-close: whatever is still running dies here
            _registration.Unregister(null);
            Input.Dispose(); Output.Dispose(); Error?.Dispose();
            _exited.TrySetResult(-1);
            _waitEvent.Dispose();
            CloseHandle(_process);
            return ValueTask.CompletedTask;
        }
    }

    private const int PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES = 0x20009;
    private const int PROC_THREAD_ATTRIBUTE_HANDLE_LIST = 0x20002;
    private const int PROC_THREAD_ATTRIBUTE_ALL_APPLICATION_PACKAGES_POLICY = 0x2000F;
    private const uint EXTENDED_STARTUPINFO_PRESENT = 0x00080000;
    private const uint CREATE_SUSPENDED = 0x4;
    private const uint CREATE_UNICODE_ENVIRONMENT = 0x400;
    private const uint CREATE_NO_WINDOW = 0x08000000;
    private const int STARTF_USESTDHANDLES = 0x100;
    private const uint HANDLE_FLAG_INHERIT = 1;

    [StructLayout(LayoutKind.Sequential)]
    private struct SECURITY_CAPABILITIES { public IntPtr AppContainerSid; public IntPtr Capabilities; public uint CapabilityCount; public uint Reserved; }

    [StructLayout(LayoutKind.Sequential)]
    private struct SECURITY_ATTRIBUTES { public int nLength; public IntPtr lpSecurityDescriptor; public bool bInheritHandle; }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    private struct STARTUPINFO
    {
        public int cb; public string? lpReserved, lpDesktop, lpTitle;
        public int dwX, dwY, dwXSize, dwYSize, dwXCountChars, dwYCountChars, dwFillAttribute, dwFlags;
        public short wShowWindow, cbReserved2;
        public IntPtr lpReserved2, hStdInput, hStdOutput, hStdError;
    }

    [StructLayout(LayoutKind.Sequential)]
    private struct STARTUPINFOEX { public STARTUPINFO StartupInfo; public IntPtr lpAttributeList; }

    [StructLayout(LayoutKind.Sequential)]
    private struct PROCESS_INFORMATION { public IntPtr hProcess, hThread; public int dwProcessId, dwThreadId; }

    [DllImport("userenv.dll", CharSet = CharSet.Unicode)] private static extern int CreateAppContainerProfile(string name, string display, string desc, IntPtr caps, uint capCount, out IntPtr sid);
    [DllImport("userenv.dll", CharSet = CharSet.Unicode)] private static extern int DeriveAppContainerSidFromAppContainerName(string name, out IntPtr sid);
    [DllImport("userenv.dll", CharSet = CharSet.Unicode)] private static extern int GetAppContainerFolderPath(string sid, out IntPtr path);
    [DllImport("userenv.dll", CharSet = CharSet.Unicode)] private static extern int DeleteAppContainerProfile(string name);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool InitializeProcThreadAttributeList(IntPtr list, int count, int flags, ref IntPtr size);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool UpdateProcThreadAttribute(IntPtr list, uint flags, IntPtr attr, IntPtr value, IntPtr size, IntPtr prev, IntPtr retSize);
    [DllImport("kernel32.dll")] private static extern void DeleteProcThreadAttributeList(IntPtr list);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool CreatePipe(out IntPtr read, out IntPtr write, ref SECURITY_ATTRIBUTES sa, uint size);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool SetHandleInformation(IntPtr h, uint mask, uint flags);
    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Unicode)]
    private static extern bool CreateProcessW(string? app, StringBuilder cmd, IntPtr pa, IntPtr ta, bool inherit, uint flags, IntPtr env, string? dir, ref STARTUPINFOEX si, out PROCESS_INFORMATION pi);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern uint ResumeThread(IntPtr hThread);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool TerminateProcess(IntPtr h, uint code);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool GetExitCodeProcess(IntPtr h, out uint code);
    [DllImport("kernel32.dll")] private static extern bool CloseHandle(IntPtr h);
    [DllImport("advapi32.dll")] private static extern IntPtr FreeSid(IntPtr sid);
}
