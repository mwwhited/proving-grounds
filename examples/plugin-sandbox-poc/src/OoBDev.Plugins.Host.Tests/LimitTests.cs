using System.Text.Json;
using OoBDev.Plugins.Protocol;
using Xunit;

namespace OoBDev.Plugins.Host.Tests;

/// <summary>The two limits the supervisor tests do not reach: the Disconnect rate action and a full outbound queue.</summary>
public class LimitTests
{
    static ManagedPlugin Make(FakeLauncher launcher, PluginLimits limits, out Router router)
    {
        router = new Router();
        var spec = Fast.Spec() with { Limits = limits };
        return new ManagedPlugin(spec, launcher, router, Fast.Options(o => o with { MaxCrashesInWindow = 50 }));
    }

    static Task Flood(FakeChannel ch, int count) => Task.Run(async () =>
    {
        for (var i = 0; i < count; i++)
            await ch.WriteAsync(Envelope.Create(MessageType.Event, "flood.tick", FakeChannel.Json(new { i })));
    });

    [Fact]
    public async Task Exceeding_the_rate_with_Disconnect_kills_the_plugin_and_records_a_violation()
    {
        var launcher = new FakeLauncher(attempt => attempt == 1
            ? async ch => { await ch.SendReadyAsync(); await Flood(ch, 200); await Task.Delay(Timeout.Infinite, ch.Killed); return 0; }
            : Scripts.WellBehaved());
        var plugin = Make(launcher, new PluginLimits { MsgPerSec = 20, RateAction = RateLimitAction.Disconnect }, out _);

        plugin.Start();
        Assert.True(await Fast.UntilAsync(() => plugin.Exits.Any(e => e.Reason == ExitReason.Violation)), "no violation recorded");
        Assert.True(launcher.Processes[0].WasKilled);
        Assert.Contains("rate limit", plugin.Exits.First(e => e.Reason == ExitReason.Violation).Detail);
        // control: a violation is not terminal, the supervisor restarts the plugin and the new one stays up
        Assert.True(await Fast.UntilAsync(() => launcher.Launches >= 2 && plugin.State == PluginState.Running));
        await plugin.StopAsync();
    }

    [Fact]
    public async Task Exceeding_the_rate_with_Drop_keeps_the_plugin_running_and_counts_the_drops()
    {
        var done = new TaskCompletionSource();
        var launcher = new FakeLauncher(_ => async ch =>
        {
            await ch.SendReadyAsync();
            await Flood(ch, 200);
            done.TrySetResult();
            return await ch.RunWellBehavedAsync();
        });
        var plugin = Make(launcher, new PluginLimits { MsgPerSec = 20 }, out _);
        PluginSession? session = null;
        plugin.SessionCreated += s => session = s;

        plugin.Start();
        await done.Task.WaitAsync(TimeSpan.FromSeconds(5));
        Assert.True(await Fast.UntilAsync(() => session is { Dropped: > 100 }), "drops not counted");
        Assert.Equal(PluginState.Running, plugin.State);
        Assert.DoesNotContain(plugin.Exits, e => e.Reason == ExitReason.Violation);
        await plugin.StopAsync();
    }

    [Fact]
    public async Task A_full_outbound_queue_rejects_data_frames_but_still_accepts_control_frames()
    {
        // The plugin is ready but never reads, so the pipe fills and the write loop stalls behind it.
        var launcher = new FakeLauncher(_ => async ch => { await ch.SendReadyAsync(); await Task.Delay(Timeout.Infinite, ch.Killed); return 0; });
        var plugin = Make(launcher, new PluginLimits { OutboundQueue = 4 }, out _);
        plugin.Start();
        Assert.True(await Fast.UntilAsync(() => plugin.Session is not null));
        var session = plugin.Session!;
        var big = FakeChannel.Json(new { blob = new string('x', 30_000) });

        var accepted = 0;
        PluginQueueFullException? full = null;
        for (var i = 0; i < 100 && full is null; i++)
        {
            try { session.Send(Envelope.Create(MessageType.Event, "x.big", big)); accepted++; }
            catch (PluginQueueFullException ex) { full = ex; }
        }

        Assert.NotNull(full);
        Assert.InRange(accepted, 4, 20);   // a few more than the limit: the pipe buffer and the frame being written
        session.SendHeartbeat();           // control lane is not subject to the data limit
        await plugin.StopAsync();
    }
}
