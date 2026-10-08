using System.Runtime.InteropServices;

namespace OoBDev.Plugins.Launchers.Linux;

/// <summary>
/// A classic-BPF seccomp program, in the byte format bubblewrap's <c>--seccomp FD</c> reads, that stops a process
/// creating new processes while leaving threads alone:
/// <list type="bullet">
/// <item><c>fork</c> and <c>vfork</c> fail with EPERM;</item>
/// <item><c>clone</c> fails with EPERM unless <c>CLONE_THREAD</c> is set (a thread, not a process);</item>
/// <item><c>clone3</c> fails with ENOSYS, which makes glibc fall back to <c>clone</c> (its flags live behind a
/// pointer that BPF cannot read);</item>
/// <item>a syscall from the wrong ABI (x32, 32-bit compat) kills the process.</item>
/// </list>
/// <c>execve</c> is not restricted: a process may replace itself, it just cannot create another. Everything else is
/// allowed, so this is not a general syscall filter.
/// </summary>
public static class SeccompFilter
{
    private const uint Allow = 0x7fff0000, KillProcess = 0x80000000, Errno = 0x00050000;
    private const uint Eperm = 1, Enosys = 38, CloneThread = 0x00010000, X32Bit = 0x40000000;
    private const ushort Ld = 0x20, Jeq = 0x15, Jset = 0x45, Ret = 0x06;

    private sealed record Ins(ushort Code, uint K, string? Jt = null, string? Jf = null, string? Label = null);

    /// <summary>The filter for this machine's architecture. Throws on one it has no syscall numbers for.</summary>
    public static byte[] NoNewProcesses() => NoNewProcesses(RuntimeInformation.ProcessArchitecture);

    public static byte[] NoNewProcesses(Architecture arch)
    {
        // syscall numbers: x86_64 has fork/vfork; arm64 only has clone (and clone3)
        var (auditArch, fork, vfork, clone, clone3) = arch switch
        {
            Architecture.X64 => (0xC000003Eu, 57u, 58u, 56u, 435u),
            Architecture.Arm64 => (0xC00000B7u, 0u, 0u, 220u, 435u),
            _ => throw new PlatformNotSupportedException($"no seccomp filter for {arch}"),
        };
        var p = new List<Ins>
        {
            new(Ld, 4),                                    // seccomp_data.arch
            new(Jeq, auditArch, "nr", "kill"),
            new(Ld, 0, Label: "nr"),                       // seccomp_data.nr
        };
        if (arch == Architecture.X64) p.Add(new(Jset, X32Bit, "kill", "next"));
        if (fork != 0) p.Add(new(Jeq, fork, "eperm", "next"));
        if (vfork != 0) p.Add(new(Jeq, vfork, "eperm", "next"));
        p.Add(new(Jeq, clone3, "enosys", "next"));
        p.Add(new(Jeq, clone, "flags", "allow"));
        p.Add(new(Ld, 16, Label: "flags"));                // seccomp_data.args[0] = clone flags
        p.Add(new(Jset, CloneThread, "allow", "eperm"));
        p.Add(new(Ret, Errno | Eperm, Label: "eperm"));
        p.Add(new(Ret, Errno | Enosys, Label: "enosys"));
        p.Add(new(Ret, Allow, Label: "allow"));
        p.Add(new(Ret, KillProcess, Label: "kill"));
        return Assemble(p);
    }

    private static byte[] Assemble(List<Ins> program)
    {
        var at = new Dictionary<string, int>();
        for (var i = 0; i < program.Count; i++) if (program[i].Label is { } l) at[l] = i;
        var bytes = new byte[program.Count * 8];
        for (var i = 0; i < program.Count; i++)
        {
            var ins = program[i];
            int Offset(string? target) => target is null ? 0 : target == "next" ? 0 : at[target] - (i + 1);
            var jt = Offset(ins.Jt);
            var jf = Offset(ins.Jf);
            if (jt is < 0 or > 255 || jf is < 0 or > 255) throw new InvalidOperationException("BPF jump out of range");
            BitConverter.TryWriteBytes(bytes.AsSpan(i * 8, 2), ins.Code);
            bytes[i * 8 + 2] = (byte)jt;
            bytes[i * 8 + 3] = (byte)jf;
            BitConverter.TryWriteBytes(bytes.AsSpan(i * 8 + 4, 4), ins.K);
        }
        return bytes;
    }
}
