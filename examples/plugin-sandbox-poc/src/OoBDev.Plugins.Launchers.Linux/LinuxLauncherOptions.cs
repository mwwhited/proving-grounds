
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
