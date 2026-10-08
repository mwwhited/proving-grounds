using OoBDev.Plugins.Host;
using System.IO.Pipelines;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.TestKit;

public static class Scripts
{
    /// <summary>Ready, then exit with <paramref name="code"/> straight away.</summary>
    public static PluginScript CrashAfterReady(int code = 3) => async ch => { await ch.SendReadyAsync(); return code; };

    public static PluginScript WellBehaved(Func<FakeChannel, Envelope, Task>? onFrame = null)
        => ch => ch.RunWellBehavedAsync(onFrame);

    /// <summary>Ready, then never read or answer anything again.</summary>
    public static PluginScript HangAfterReady() => async ch =>
    {
        await ch.SendReadyAsync();
        await Task.Delay(Timeout.Infinite, ch.Killed);
        return 0;
    };

    /// <summary>Answers heartbeats but never services a request (the "sidebeat" shape).</summary>
    public static PluginScript HeartbeatOnly() => ch => ch.RunWellBehavedAsync((_, _) => Task.CompletedTask);

    public static PluginScript NeverReady() => async ch =>
    {
        await Task.Delay(Timeout.Infinite, ch.Killed);
        return 0;
    };

    /// <summary>Well behaved, except it ignores Shutdown.</summary>
    public static PluginScript IgnoresShutdown() => async ch =>
    {
        await ch.SendReadyAsync();
        while (true)
        {
            var e = await ch.ReadAsync();
            if (e is null) return 0;
            if (e.Type == MessageType.Heartbeat) await ch.BeatAsync(e);
        }
    };
}
