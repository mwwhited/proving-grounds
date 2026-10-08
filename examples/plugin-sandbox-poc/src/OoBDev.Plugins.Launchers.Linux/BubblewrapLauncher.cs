using System.Runtime.Versioning;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Plain;

namespace OoBDev.Plugins.Launchers.Linux;

public sealed class LinuxLauncherOptions
{
    /// <summary>Host folders mounted read-only at the same path. Missing ones are skipped. Must cover the language runtimes.</summary>
    public IReadOnlyList<string> ReadOnlyPaths { get; init; } =
        ["/usr", "/etc/alternatives", "/etc/ld.so.cache", "/etc/ssl", "/etc/java-17-openjdk", "/etc/java-21-openjdk", "/etc/java-25-openjdk"];

    /// <summary>
    /// RLIMIT_NPROC for the plugin. Counts threads as well as processes, so a threaded runtime (Go, JVM, Node)
    /// needs a generous value. Null = no limit. A low value is a fork-bomb brake, not a precise "no children" rule.
    /// </summary>
    public int? MaxTasks { get; init; } = 512;

    /// <summary>
    /// False (default): a seccomp filter stops the plugin creating processes (threads are fine). True: no filter, so
    /// a plugin that is allowed to run helpers can; <see cref="MaxTasks"/> still caps a runaway.
    /// </summary>
    public bool AllowChildProcesses { get; init; }

    /// <summary>Path of the bubblewrap binary.</summary>
    public string Bwrap { get; init; } = "bwrap";
}

/// <summary>
/// Runs a plugin inside bubblewrap: new user, pid, ipc, uts, cgroup and network namespaces, a mount namespace that
/// contains only the runtime (read-only), the plugin folder (read-only), the granted folders and a private /tmp,
/// an empty environment, a seccomp filter against creating processes, and rlimits from <c>prlimit</c>. It dies with the host (<c>--die-with-parent</c> plus the
/// pid namespace). Reuses the plain launcher for the process plumbing.
/// </summary>
[SupportedOSPlatform("linux")]
public sealed class BubblewrapLauncher(LinuxLauncherOptions? options = null) : IPluginLauncher
{
    readonly LinuxLauncherOptions _options = options ?? new();
    readonly PlainProcessLauncher _plain = new();
    readonly string? _filterPath = (options ?? new()).AllowChildProcesses ? null : WriteFilter();

    /// <summary>The BPF program is identical for every launch, so write it once per content and share the file.</summary>
    static string WriteFilter()
    {
        var bytes = SeccompFilter.NoNewProcesses();
        var path = Path.Combine(Path.GetTempPath(), $"oobdev-plugin-seccomp-{Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(bytes))[..16]}.bpf");
        if (!File.Exists(path) || new FileInfo(path).Length != bytes.Length)
        {
            var tmp = path + "." + Environment.ProcessId;
            File.WriteAllBytes(tmp, bytes);
            File.Move(tmp, path, overwrite: true);
        }
        return path;
    }

    public ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct)
    {
        if (spec.Lifetime == Lifetime.Detached) throw new NotSupportedException("Detached plugins are not implemented.");
        return _plain.LaunchAsync(spec with { Command = Wrap(spec) }, ct);
    }

    internal IReadOnlyList<string> Wrap(PluginSpec spec)
    {
        var dir = Path.GetFullPath(spec.WorkingDirectory);
        var a = new List<string>
        {
            _options.Bwrap,
            "--unshare-all", "--die-with-parent", "--new-session", "--clearenv",
            "--proc", "/proc", "--dev", "/dev", "--tmpfs", "/tmp",
            "--symlink", "usr/bin", "/bin", "--symlink", "usr/lib", "/lib", "--symlink", "usr/lib64", "/lib64", "--symlink", "usr/sbin", "/sbin",
        };
        foreach (var p in _options.ReadOnlyPaths.Where(p => File.Exists(p) || Directory.Exists(p))) { a.Add("--ro-bind"); a.Add(p); a.Add(p); }
        a.AddRange(["--ro-bind", dir, dir]);
        foreach (var g in spec.Grants)
        {
            var path = Path.GetFullPath(g.Path);
            a.AddRange([g.Write ? "--bind" : "--ro-bind", path, path]);
        }
        foreach (var (k, v) in new[] { ("PATH", "/usr/local/bin:/usr/bin:/bin"), ("HOME", "/tmp"), ("TMPDIR", "/tmp"), ("LANG", "C.UTF-8") })
            a.AddRange(["--setenv", k, v]);
        if (_filterPath is not null) a.AddRange(["--seccomp", "3"]);
        a.AddRange(["--chdir", dir, "--"]);

        var limits = new List<string>();
        if (spec.Limits.MemoryBytes is { } mem) limits.Add($"--data={mem}");
        if (_options.MaxTasks is { } tasks) limits.Add($"--nproc={tasks}");
        if (limits.Count > 0) { a.Add("prlimit"); a.AddRange(limits); a.Add("--"); }

        var command = spec.Command.ToList();
        if (command[0].Contains('/')) command[0] = Path.GetFullPath(command[0], dir);
        a.AddRange(command);
        // bubblewrap reads the filter from file descriptor 3: let a shell open the file there and exec bwrap
        return _filterPath is null ? a : ["sh", "-c", "exec 3<\"$0\" && exec \"$@\"", _filterPath, .. a];
    }
}
