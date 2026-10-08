// REFERENCE SKETCH: written in conversation, never compiled or tested.
//
// One job object PER PLUGIN. (The first sketch used a single static job with
// ActiveProcessLimit = 1, which would allow only one plugin to ever run.)
// Create a new PluginJob at every launch; the old one dies with the old process.
//
// Bound plugins:    assign the (suspended) process to this job, then resume it.
// Detached plugins: do NOT use KILL_ON_JOB_CLOSE. Either skip the job, or create
//                   one with only the memory limit (killOnClose: false).
//
// IMPORTANT: never inherit or duplicate this handle into another process. If anything
// else holds it, the job stays open after the host dies and the plugin survives.

using System.ComponentModel;
using System.Runtime.InteropServices;

public sealed class PluginJob : IDisposable
{
    IntPtr _job;

    public PluginJob(bool killOnClose, long? memoryLimitBytes = null)
    {
        _job = CreateJobObjectW(IntPtr.Zero, null);
        if (_job == IntPtr.Zero) throw new Win32Exception();

        var info = new JOBOBJECT_EXTENDED_LIMIT_INFORMATION();
        uint flags = 0;

        if (killOnClose) flags |= JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE;

        // No grandchildren: the plugin itself is the only process allowed in the job.
        flags |= JOB_OBJECT_LIMIT_ACTIVE_PROCESS;
        info.BasicLimitInformation.ActiveProcessLimit = 1;

        if (memoryLimitBytes is long mem)
        {
            flags |= JOB_OBJECT_LIMIT_PROCESS_MEMORY;
            info.ProcessMemoryLimit = (UIntPtr)(ulong)mem;
        }

        info.BasicLimitInformation.LimitFlags = flags;

        int len = Marshal.SizeOf<JOBOBJECT_EXTENDED_LIMIT_INFORMATION>();
        IntPtr p = Marshal.AllocHGlobal(len);
        try
        {
            Marshal.StructureToPtr(info, p, false);
            if (!SetInformationJobObject(_job, JobObjectExtendedLimitInformation, p, (uint)len))
                throw new Win32Exception();
        }
        finally { Marshal.FreeHGlobal(p); }
    }

    /// <summary>Assign a process (ideally created CREATE_SUSPENDED) to this job.</summary>
    public void Assign(IntPtr hProcess)
    {
        if (!AssignProcessToJobObject(_job, hProcess))
            throw new Win32Exception();
    }

    // Closing the handle is what kills a KILL_ON_JOB_CLOSE job. Dispose = intentional kill.
    public void Dispose()
    {
        if (_job != IntPtr.Zero) { CloseHandle(_job); _job = IntPtr.Zero; }
    }

    const uint JOB_OBJECT_LIMIT_PROCESS_MEMORY     = 0x00000100;
    const uint JOB_OBJECT_LIMIT_ACTIVE_PROCESS     = 0x00000008;
    const uint JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE  = 0x00002000;
    const int  JobObjectExtendedLimitInformation   = 9;

    [StructLayout(LayoutKind.Sequential)]
    struct JOBOBJECT_BASIC_LIMIT_INFORMATION
    {
        public long PerProcessUserTimeLimit, PerJobUserTimeLimit;
        public uint LimitFlags;
        public UIntPtr MinimumWorkingSetSize, MaximumWorkingSetSize;
        public uint ActiveProcessLimit;
        public UIntPtr Affinity;
        public uint PriorityClass, SchedulingClass;
    }

    [StructLayout(LayoutKind.Sequential)]
    struct IO_COUNTERS { public ulong a, b, c, d, e, f; }

    [StructLayout(LayoutKind.Sequential)]
    struct JOBOBJECT_EXTENDED_LIMIT_INFORMATION
    {
        public JOBOBJECT_BASIC_LIMIT_INFORMATION BasicLimitInformation;
        public IO_COUNTERS IoInfo;
        public UIntPtr ProcessMemoryLimit, JobMemoryLimit, PeakProcessMemoryUsed, PeakJobMemoryUsed;
    }

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    static extern IntPtr CreateJobObjectW(IntPtr attrs, string? name);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool SetInformationJobObject(IntPtr job, int cls, IntPtr info, uint len);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool AssignProcessToJobObject(IntPtr job, IntPtr proc);

    [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr h);
}
