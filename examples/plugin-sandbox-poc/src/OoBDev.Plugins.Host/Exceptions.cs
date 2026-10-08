namespace OoBDev.Plugins.Host;

/// <summary>The plugin is not running (or just stopped). Callers fail fast instead of queueing.</summary>
public sealed class PluginUnavailableException(string pluginId, string reason)
    : InvalidOperationException($"plugin '{pluginId}' is unavailable: {reason}")
{
    public string PluginId { get; } = pluginId;
}

/// <summary>The bounded outbound queue for a plugin is full.</summary>
public sealed class PluginQueueFullException(string pluginId)
    : InvalidOperationException($"outbound queue for plugin '{pluginId}' is full")
{
    public string PluginId { get; } = pluginId;
}
