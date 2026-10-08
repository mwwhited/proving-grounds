using OoBDev.Plugins.Protocol;
using Xunit;

namespace OoBDev.Plugins.Host.Tests;

public class SupervisorTests
{
    static (ManagedPlugin Plugin, Router Router) Make(FakeLauncher launcher, SupervisorOptions? options = null, PluginSpec? spec = null)
    {
        var router = new Router();
        return (new ManagedPlugin(spec ?? Fast.Spec(), launcher, router, options ?? Fast.Options()), router);
    }

    static Task<bool> Reach(ManagedPlugin p, PluginState s, int ms = 5000) => p.WaitForStateAsync(s, TimeSpan.FromMilliseconds(ms));

    [Fact]
    public async Task Start_reaches_Running_and_Stop_ends_Stopped_with_a_requested_exit()
    {
        var launcher = new FakeLauncher(Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        await p.StopAsync();
        Assert.Equal(PluginState.Stopped, p.State);
        Assert.Equal([PluginState.Stopped, PluginState.Starting, PluginState.Running, PluginState.Stopping, PluginState.Stopped], p.History);
        Assert.Equal(ExitReason.Requested, Assert.Single(p.Exits).Reason);
        Assert.Equal(0, p.Exits[0].ExitCode);
        Assert.Equal(1, launcher.Launches);
    }

    [Fact]
    public async Task A_crash_is_restarted_after_backoff()
    {
        var launcher = new FakeLauncher(n => n == 1 ? Scripts.CrashAfterReady(3) : Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Fast.UntilAsync(() => launcher.Launches >= 2 && p.State == PluginState.Running));
        Assert.Equal(ExitReason.Exited, p.Exits[0].Reason);
        Assert.Equal(3, p.Exits[0].ExitCode);
        Assert.Contains(PluginState.Backoff, p.History);
        await p.StopAsync();
    }

    [Fact]
    public async Task A_crash_loop_reaches_Failed_after_five_crashes_and_stops_launching()
    {
        var launcher = new FakeLauncher(Scripts.CrashAfterReady());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Reach(p, PluginState.Failed, 10000));
        Assert.Equal(5, launcher.Launches);
        await Task.Delay(300);
        Assert.Equal(5, launcher.Launches);          // Failed is terminal until someone intervenes
        Assert.Equal(PluginState.Failed, p.State);
        Assert.Equal(5, p.Exits.Count(e => e.Reason == ExitReason.Exited));
    }

    [Fact]
    public void Backoff_doubles_and_is_capped()
    {
        var o = Fast.Options();
        var d = o.BackoffInitial;
        var seen = new List<TimeSpan>();
        for (var i = 0; i < 8; i++) { seen.Add(d); d = ManagedPlugin.NextBackoff(d, o); }
        Assert.Equal(o.BackoffInitial, seen[0]);
        Assert.Equal(o.BackoffInitial * 2, seen[1]);
        Assert.Equal(o.BackoffMax, seen[^1]);
        Assert.All(seen, s => Assert.True(s <= o.BackoffMax));
    }

    [Fact]
    public async Task Stop_during_Backoff_does_not_restart()
    {
        var launcher = new FakeLauncher(Scripts.CrashAfterReady());
        var o = Fast.Options() with { BackoffInitial = TimeSpan.FromSeconds(3), BackoffMax = TimeSpan.FromSeconds(3) };
        var (p, _) = Make(launcher, o);
        p.Start();
        Assert.True(await Reach(p, PluginState.Backoff));
        await p.StopAsync();
        Assert.Equal(PluginState.Stopped, p.State);
        await Task.Delay(300);
        Assert.Equal(1, launcher.Launches);
        Assert.Equal(PluginState.Stopped, p.State);
    }

    [Fact]
    public async Task Stop_while_Starting_does_not_leave_a_process_behind()
    {
        var launcher = new FakeLauncher(Scripts.NeverReady());
        var (p, _) = Make(launcher, Fast.Options() with { ReadyTimeout = TimeSpan.FromSeconds(30) });
        p.Start();
        Assert.True(await Reach(p, PluginState.Starting));
        await p.StopAsync();
        Assert.Equal(PluginState.Stopped, p.State);
        Assert.True(await Fast.UntilAsync(() => launcher.Processes.All(x => x.WasKilled)));
        Assert.Equal(1, launcher.Launches);
    }

    [Fact]
    public async Task Never_ready_times_out_and_is_retried()
    {
        var launcher = new FakeLauncher(n => n == 1 ? Scripts.NeverReady() : Scripts.WellBehaved());
        var (p, _) = Make(launcher, Fast.Options() with { ReadyTimeout = TimeSpan.FromMilliseconds(100) });
        p.Start();
        Assert.True(await Fast.UntilAsync(() => launcher.Launches >= 2 && p.State == PluginState.Running));
        Assert.Equal(ExitReason.StartTimeout, p.Exits[0].Reason);
        await p.StopAsync();
    }

    [Fact]
    public async Task A_launcher_that_throws_counts_as_a_start_failure_and_ends_Failed()
    {
        var launcher = new FakeLauncher((int _) => (PluginScript?)null);
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Reach(p, PluginState.Failed, 10000));
        Assert.All(p.Exits, e => Assert.Equal(ExitReason.StartFailed, e.Reason));
    }

    [Fact]
    public async Task A_hung_plugin_is_killed_and_restarted()
    {
        var launcher = new FakeLauncher(n => n == 1 ? Scripts.HangAfterReady() : Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Fast.UntilAsync(() => launcher.Launches >= 2 && p.State == PluginState.Running));
        Assert.Equal(ExitReason.Hung, p.Exits[0].Reason);
        Assert.True(launcher.Processes[0].WasKilled);
        await p.StopAsync();
    }

    [Fact]
    public async Task Answering_heartbeats_but_never_requests_is_declared_hung_after_three_timeouts()
    {
        var launcher = new FakeLauncher(Scripts.HeartbeatOnly());
        var (p, _) = Make(launcher, Fast.Options() with { MaxConsecutiveRequestTimeouts = 3 });
        p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        for (var i = 0; i < 3; i++)
            await Assert.ThrowsAsync<TimeoutException>(() => p.RequestAsync("x", null, TimeSpan.FromMilliseconds(80)));
        Assert.True(await Fast.UntilAsync(() => p.Exits.Count >= 1));
        Assert.Equal(ExitReason.Hung, p.Exits[0].Reason);
        await p.StopAsync();
    }

    [Fact]
    public async Task A_matched_reply_resets_the_consecutive_timeout_count()
    {
        var calls = 0;
        var launcher = new FakeLauncher(Scripts.WellBehaved(async (ch, req) =>
        {
            if (Interlocked.Increment(ref calls) % 3 != 0) return;   // swallow two of every three
            await ch.ReplyAsync(req);
        }));
        var (p, _) = Make(launcher, Fast.Options() with { MaxConsecutiveRequestTimeouts = 3 });
        p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        for (var i = 0; i < 9; i++)
        {
            try { await p.RequestAsync("x", null, TimeSpan.FromMilliseconds(100)); } catch (TimeoutException) { }
        }
        Assert.Empty(p.Exits);
        Assert.Equal(PluginState.Running, p.State);
        await p.StopAsync();
    }

    [Fact]
    public async Task A_plugin_that_ignores_Shutdown_is_killed_after_the_grace_period()
    {
        var launcher = new FakeLauncher(Scripts.IgnoresShutdown());
        var (p, _) = Make(launcher, Fast.Options() with { ShutdownGrace = TimeSpan.FromMilliseconds(100) });
        p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        await p.StopAsync();
        Assert.Equal(PluginState.Stopped, p.State);
        Assert.True(launcher.Processes[0].WasKilled);
        Assert.Equal(ExitReason.Requested, p.Exits[^1].Reason);
    }

    [Fact]
    public async Task Start_during_Stopping_waits_for_the_old_run_and_never_runs_two_processes()
    {
        var launcher = new FakeLauncher(Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        var stop = p.StopAsync();
        p.Start();
        await stop;
        Assert.True(await Reach(p, PluginState.Running));
        Assert.Equal(2, launcher.Launches);
        Assert.Equal(1, launcher.MaxConcurrent);
        await p.StopAsync();
    }

    [Fact]
    public async Task Restart_replaces_the_process()
    {
        var launcher = new FakeLauncher(Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        await p.RestartAsync();
        Assert.True(await Reach(p, PluginState.Running));
        Assert.Equal(2, launcher.Launches);
        Assert.Equal(1, launcher.MaxConcurrent);
        await p.StopAsync();
    }

    [Fact]
    public async Task Restart_while_Starting_still_ends_with_one_running_process()
    {
        var launcher = new FakeLauncher(Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        await p.RestartAsync();
        Assert.True(await Reach(p, PluginState.Running));
        Assert.Equal(1, launcher.MaxConcurrent);
        await p.StopAsync();
    }

    [Fact]
    public async Task Start_is_idempotent_while_running()
    {
        var launcher = new FakeLauncher(Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start(); p.Start(); p.Start();
        Assert.True(await Reach(p, PluginState.Running));
        p.Start();
        await Task.Delay(100);
        Assert.Equal(1, launcher.Launches);
        await p.StopAsync();
    }

    [Fact]
    public async Task Requests_fail_fast_when_the_plugin_is_not_running()
    {
        var (p, _) = Make(new FakeLauncher(Scripts.WellBehaved()));
        await Assert.ThrowsAsync<PluginUnavailableException>(() => p.RequestAsync("x", null, TimeSpan.FromSeconds(1)));
    }

    [Fact]
    public async Task A_protocol_violation_disconnects_and_is_recorded()
    {
        var launcher = new FakeLauncher(n => n == 1
            ? async ch =>
            {
                await ch.SendReadyAsync();
                await ch.WriteRawAsync([5, 0, 0, 0, (byte)'n', (byte)'o', (byte)'p', (byte)'e', (byte)'!']);
                await Task.Delay(Timeout.Infinite, ch.Killed);
                return 0;
            }
            : Scripts.WellBehaved());
        var (p, _) = Make(launcher);
        p.Start();
        Assert.True(await Fast.UntilAsync(() => launcher.Launches >= 2));
        Assert.Equal(ExitReason.Violation, p.Exits[0].Reason);
        await p.StopAsync();
    }

    [Fact]
    public async Task Detached_registration_is_not_supported()
    {
        await using var m = new PluginManager(new FakeLauncher(Scripts.WellBehaved()));
        Assert.Throws<NotSupportedException>(() => m.Register(Fast.Spec() with { Lifetime = Lifetime.Detached }));
    }

    [Fact]
    public async Task Manager_shutdown_stops_every_bound_plugin()
    {
        var launcher = new FakeLauncher(Scripts.WellBehaved());
        var m = new PluginManager(launcher, Fast.Options());
        var a = m.Register(Fast.Spec("a"));
        var b = m.Register(Fast.Spec("b"));
        a.Start(); b.Start();
        Assert.True(await Reach(a, PluginState.Running));
        Assert.True(await Reach(b, PluginState.Running));
        await m.DisposeAsync();
        Assert.Equal(PluginState.Stopped, a.State);
        Assert.Equal(PluginState.Stopped, b.State);
    }
}
