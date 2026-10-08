namespace OoBDev.Plugins.Host;

/// <summary>The bounded outbound queue for a plugin is full.</summary>
public sealed class PluginQueueFullException(string pluginId)
    : InvalidOperationException($"outbound queue for plugin '{pluginId}' is full")
{
    public string PluginId { get; } = pluginId;
}
