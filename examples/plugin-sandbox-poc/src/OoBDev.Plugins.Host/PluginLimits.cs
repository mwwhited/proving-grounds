using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host;

public sealed record PluginLimits
{
    /// <summary>Hard per-process memory cap enforced by the OS (job object on Windows). Null = none.</summary>
    public long? MemoryBytes { get; init; }
    /// <summary>Hard CPU cap as a percentage of the whole machine (1-100), enforced by the OS (job object on Windows). Null = none. Not implemented on Linux.</summary>
    public int? CpuPercent { get; init; }
    public int MsgPerSec { get; init; } = 200;
    public int MaxFrameBytes { get; init; } = FrameCodec.DefaultMaxFrameBytes;
    /// <summary>Host-to-plugin data frames waiting to be written. Control frames bypass this queue.</summary>
    public int OutboundQueue { get; init; } = 256;
    public RateLimitAction RateAction { get; init; } = RateLimitAction.Drop;
}
