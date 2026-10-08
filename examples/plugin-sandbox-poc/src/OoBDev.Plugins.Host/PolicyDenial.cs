
namespace OoBDev.Plugins.Host;

/// <summary>A frame the router refused because the plugin's policy does not allow it.</summary>
public sealed record PolicyDenial(string PluginId, string Action, string? Topic, string? Target, string Reason);
