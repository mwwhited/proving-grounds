namespace OoBDev.Plugins.Host;

public interface IPluginLauncher
{
    /// <summary>
    /// Starts a fresh process for <paramref name="spec"/>. Every call must build a new channel (and, once
    /// sandboxing exists, a new sandbox). Throws if the plugin cannot be started; the supervisor treats that as a crash.
    /// </summary>
    public ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct);
}
