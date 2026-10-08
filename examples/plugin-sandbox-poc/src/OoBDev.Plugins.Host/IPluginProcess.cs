namespace OoBDev.Plugins.Host;

/// <summary>
/// A running plugin as the host sees it: one framed channel plus an exit signal. Everything OS-specific
/// (sandbox, job objects, handle inheritance) lives behind <see cref="IPluginLauncher"/>.
/// </summary>
public interface IPluginProcess : IAsyncDisposable
{
    /// <summary>Host writes frames here (the plugin's stdin).</summary>
    public Stream Input { get; }

    /// <summary>Host reads frames here (the plugin's stdout).</summary>
    public Stream Output { get; }

    /// <summary>Log text from the plugin (stderr). Null if the launcher has none.</summary>
    public Stream? Error { get; }

    /// <summary>Completes with the exit code once the process is gone.</summary>
    public Task<int> Exited { get; }

    /// <summary>Kills the plugin and everything it started. Idempotent, never throws.</summary>
    public void Kill();
}
