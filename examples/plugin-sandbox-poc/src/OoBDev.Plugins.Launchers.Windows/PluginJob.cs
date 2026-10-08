using System.ComponentModel;
using System.Runtime.InteropServices;

namespace OoBDev.Plugins.Launchers.Windows;

/// <summary>
/// One job object per plugin: kill-on-close (the host dying closes the last handle, which kills the plugin),
/// one process only (no grandchildren), optional memory cap. The handle must never be inherited or duplicated.
/// </summary>
internal sealed class PluginJob : IDisposable
{
    IntPtr _job;

    public PluginJob(bool killOnClose, long? memoryLimitBytes)
    {
        _job = CreateJobObjectW(IntPtr.Zero, null);
        if (_job == IntPtr.Zero) throw new Win32Exception();
        try
        {
            var info = new ExtendedLimit();
            uint flags = JOB_OBJECT_LIMIT_ACTIVE_PROCESS;
            info.Basic.ActiveProcessLimit = 1;
            if (killOnClose) flags |= JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE;
            if (memoryLimitBytes is long mem)
            {
                flags |= JOB_OBJECT_LIMIT_PROCESS_MEMORY;
                info.ProcessMemoryLimit = (UIntPtr)(ulong)mem;
            }
            info.Basic.LimitFlags = flags;
            int len = Marshal.SizeOf<ExtendedLimit>();
            IntPtr p = Marshal.AllocHGlobal(len);
            try
            {
                Marshal.StructureToPtr(info, p, false);
                if (!SetInformationJobObject(_job, 9 /* ExtendedLimitInformation */, p, (uint)len)) throw new Win32Exception();
            }
            finally { Marshal.FreeHGlobal(p); }
        }
        catch { Dispose(); throw; }
    }

    public void Assign(IntPtr hProcess)
    {
        if (!AssignProcessToJobObject(_job, hProcess)) throw new Win32Exception();
    }

    /// <summary>Closing the handle is the kill.</summary>
    public void Dispose()
    {
        var job = Interlocked.Exchange(ref _job, IntPtr.Zero);
        if (job != IntPtr.Zero) CloseHandle(job);
    }

    const uint JOB_OBJECT_LIMIT_PROCESS_MEMORY = 0x100;
    const uint JOB_OBJECT_LIMIT_ACTIVE_PROCESS = 0x8;
    const uint JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE = 0x2000;

    [StructLayout(LayoutKind.Sequential)]
    struct BasicLimit
    {
        public long PerProcessUserTimeLimit, PerJobUserTimeLimit;
        public uint LimitFlags;
        public UIntPtr MinimumWorkingSetSize, MaximumWorkingSetSize;
        public uint ActiveProcessLimit;
        public UIntPtr Affinity;
        public uint PriorityClass, SchedulingClass;
    }

    [StructLayout(LayoutKind.Sequential)]
    struct ExtendedLimit
    {
        public BasicLimit Basic;
        public ulong Io1, Io2, Io3, Io4, Io5, Io6;
        public UIntPtr ProcessMemoryLimit, JobMemoryLimit, PeakProcessMemoryUsed, PeakJobMemoryUsed;
    }

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] static extern IntPtr CreateJobObjectW(IntPtr attrs, string? name);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool SetInformationJobObject(IntPtr job, int cls, IntPtr info, uint len);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool AssignProcessToJobObject(IntPtr job, IntPtr proc);
    [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr h);
}
