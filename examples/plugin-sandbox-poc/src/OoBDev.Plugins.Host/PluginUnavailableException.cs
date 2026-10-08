namespace OoBDev.Plugins.Host;

/// <summary>The plugin is not running (or just stopped). Callers fail fast instead of queueing.</summary>
public sealed class PluginUnavailableException(string pluginId, string reason)
    : InvalidOperationException($"plugin '{pluginId}' is unavailable: {reason}")
{
    public string PluginId { get; } = pluginId;
}
