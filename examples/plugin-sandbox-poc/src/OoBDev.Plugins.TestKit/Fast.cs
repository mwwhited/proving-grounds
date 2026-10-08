using OoBDev.Plugins.Host;
using System.IO.Pipelines;

namespace OoBDev.Plugins.TestKit;

public static class Fast
{
    /// <summary>Options that make the supervisor's clocks tick in tens of milliseconds.</summary>
    public static SupervisorOptions Options(Func<SupervisorOptions, SupervisorOptions>? tweak = null)
    {
        var o = new SupervisorOptions
        {
            BackoffInitial = TimeSpan.FromMilliseconds(20),
            BackoffMax = TimeSpan.FromMilliseconds(80),
            JitterMax = TimeSpan.FromMilliseconds(5),
            ReadyTimeout = TimeSpan.FromSeconds(2),
            ShutdownGrace = TimeSpan.FromMilliseconds(500),
            HeartbeatInterval = TimeSpan.FromMilliseconds(30),
        };
        return tweak?.Invoke(o) ?? o;
    }

    public static PluginSpec Spec(string id = "p")
        => new(id, ["fake"], ".") { HeartbeatTimeout = TimeSpan.FromMilliseconds(300) };

    public static async Task<bool> UntilAsync(Func<bool> condition, int timeoutMs = 5000)
    {
        var deadline = DateTime.UtcNow.AddMilliseconds(timeoutMs);
        while (DateTime.UtcNow < deadline)
        {
            if (condition()) return true;
            await Task.Delay(5);
        }
        return condition();
    }
}
