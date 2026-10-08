
namespace OoBDev.Plugins.Host;

public sealed record SupervisorOptions
{
    public TimeSpan BackoffInitial { get; init; } = TimeSpan.FromMilliseconds(500);
    public TimeSpan BackoffMax { get; init; } = TimeSpan.FromSeconds(30);
    /// <summary>Random extra delay in [0, JitterMax) added to every backoff.</summary>
    public TimeSpan JitterMax { get; init; } = TimeSpan.FromMilliseconds(250);
    /// <summary>A run at least this long counts as stable and resets the backoff.</summary>
    public TimeSpan StableAfter { get; init; } = TimeSpan.FromMinutes(1);
    public TimeSpan CrashWindow { get; init; } = TimeSpan.FromSeconds(60);
    public int MaxCrashesInWindow { get; init; } = 5;
    /// <summary>How long a launched plugin has to announce <c>lifecycle.ready</c>.</summary>
    public TimeSpan ReadyTimeout { get; init; } = TimeSpan.FromSeconds(10);
    /// <summary>After <c>Shutdown</c>, how long to wait for exit before killing.</summary>
    public TimeSpan ShutdownGrace { get; init; } = TimeSpan.FromSeconds(2);
    /// <summary>Upper bound on the heartbeat period; the real period is also capped at a third of the plugin's timeout.</summary>
    public TimeSpan HeartbeatInterval { get; init; } = TimeSpan.FromSeconds(1);
    /// <summary>Host requests in a row that may time out before the plugin is declared hung.</summary>
    public int MaxConsecutiveRequestTimeouts { get; init; } = 3;
    public TimeProvider Time { get; init; } = TimeProvider.System;
}
