using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host;

/// <summary>Bound plugins die with the host. Detached ones survive it (not implemented before phase 7).</summary>
public enum Lifetime { Bound, Detached }

public enum RateLimitAction
{
    /// <summary>Discard frames over the limit and count them.</summary>
    Drop,
    /// <summary>Treat exceeding the limit as a violation: kill the plugin.</summary>
    Disconnect,
}

/// <summary>What a plugin may do on the bus. Default deny: anything not listed is refused.</summary>
public sealed record PluginPolicy(
    IReadOnlyList<string> Publish,
    IReadOnlyList<string> Subscribe,
    IReadOnlyList<string> SendTo)
{
    public static PluginPolicy DenyAll { get; } = new([], [], []);
}

/// <summary>A folder a sandboxed plugin may use besides its own. Honoured by launchers that sandbox; ignored by the plain one.</summary>
public sealed record PathGrant(string Path, bool Write = false);

public sealed record PluginLimits
{
    /// <summary>Hard per-process memory cap enforced by the OS (job object on Windows). Null = none.</summary>
    public long? MemoryBytes { get; init; }
    public int MsgPerSec { get; init; } = 200;
    public int MaxFrameBytes { get; init; } = FrameCodec.DefaultMaxFrameBytes;
    /// <summary>Host-to-plugin data frames waiting to be written. Control frames bypass this queue.</summary>
    public int OutboundQueue { get; init; } = 256;
    public RateLimitAction RateAction { get; init; } = RateLimitAction.Drop;
}

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
