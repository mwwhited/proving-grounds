using System.Text.Json;

namespace OoBDev.Plugins.Host;

/// <summary>Everything a launcher and a session need to run one plugin. OS-specific grants will join it in phase 2.</summary>
public sealed record PluginSpec(string Id, IReadOnlyList<string> Command, string WorkingDirectory)
{
    public string Version { get; init; } = "0.0.0";
    public Lifetime Lifetime { get; init; } = Lifetime.Bound;
    public PluginPolicy Policy { get; init; } = PluginPolicy.DenyAll;
    public PluginLimits Limits { get; init; } = new();
    /// <summary>Extra folders the plugin may read or write. Its own folder is always readable and executable.</summary>
    public IReadOnlyList<PathGrant> Grants { get; init; } = [];
    public TimeSpan HeartbeatTimeout { get; init; } = TimeSpan.FromSeconds(10);
    /// <summary>Answer to the plugin's <c>config.get</c> request. An empty object when null.</summary>
    public JsonElement? Config { get; init; }
}
