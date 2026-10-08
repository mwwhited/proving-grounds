namespace OoBDev.Plugins.Host;

/// <summary>
/// A running plugin as the host sees it: one framed channel plus an exit signal. Everything OS-specific
/// (sandbox, job objects, handle inheritance) lives behind <see cref="IPluginLauncher"/>.
/// </summary>
public interface IPluginProcess : IAsyncDisposable
{
    /// <summary>Host writes frames here (the plugin's stdin).</summary>
    Stream Input { get; }

    /// <summary>Host reads frames here (the plugin's stdout).</summary>
    Stream Output { get; }

    /// <summary>Log text from the plugin (stderr). Null if the launcher has none.</summary>
    Stream? Error { get; }

    /// <summary>Completes with the exit code once the process is gone.</summary>
    Task<int> Exited { get; }

    /// <summary>Kills the plugin and everything it started. Idempotent, never throws.</summary>
    void Kill();
}

public interface IPluginLauncher
{
    /// <summary>
    /// Starts a fresh process for <paramref name="spec"/>. Every call must build a new channel (and, once
    /// sandboxing exists, a new sandbox). Throws if the plugin cannot be started; the supervisor treats that as a crash.
    /// </summary>
    ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct);
}
