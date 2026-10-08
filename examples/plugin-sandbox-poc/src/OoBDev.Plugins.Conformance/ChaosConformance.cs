using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.Conformance;

/// <summary>Each misbehaviour of <c>chaos-python</c> must be detected and handled by the host.</summary>
[TestClass]
public class ChaosConformance(TestContext output)
{
    private static readonly TimeSpan Wait = TimeSpan.FromSeconds(10);

    private static Harness Chaos(string mode, SupervisorOptions? options = null) => new("chaos-python", new { mode }, options);

    /// <summary>Starts a chaos plugin and returns once its first run has ended (or the wait expired).</summary>
    private static async Task<Harness> RunUntilFirstExitAsync(string mode)
    {
        var h = Chaos(mode);
        h.Plugin.Start();
        Harness.Until(() => h.Plugin.Exits.Count >= 1, Wait);
        await Task.CompletedTask;
        return h;
    }

    [TestMethod]

    [RequiresTool("python")]
    public async Task All_nine_checks_for_the_eight_modes()
    {
        output.WriteLine("[chaos-python] each mode must be detected by the host");
        var c = new Checks(output);

        await using (var h = await RunUntilFirstExitAsync("crash"))
        {
            var e = h.Plugin.Exits.FirstOrDefault();
            c.Check("crash: unexpected nonzero exit is observable",
                e is { Reason: ExitReason.Exited, ExitCode: 3 }, e?.ToString() ?? "no exit");
        }

        await using (var h = await RunUntilFirstExitAsync("exit-clean"))
        {
            var e = h.Plugin.Exits.FirstOrDefault();
            c.Check("exit-clean: exit 0 without Shutdown is still an unexpected stop",
                e is { Reason: ExitReason.Exited, ExitCode: 0 }, e?.ToString() ?? "no exit");
        }

        await using (var h = await RunUntilFirstExitAsync("hang"))
        {
            var e = h.Plugin.Exits.FirstOrDefault();
            c.Check("hang: heartbeat goes unanswered (host declares hung)",
                e is { Reason: ExitReason.Hung }, e?.ToString() ?? "no exit");
        }

        await using (var h = Chaos("sidebeat"))
        {
            Assert.IsTrue(await h.StartAndWaitRunningAsync());
            var session = h.FirstSession;
            await Task.Delay(300);
            var beat = await session.HeartbeatAsync(TimeSpan.FromSeconds(1));
            var stuck = false;
            try { await session.RequestAsync("echo", Json.Of(1), TimeSpan.FromSeconds(1)); }
            catch (TimeoutException) { stuck = true; }
            c.Check("sidebeat: heartbeat alone looks healthy", beat);
            c.Check("sidebeat: the unanswered request still exposes the stuck loop (TTL expires)", stuck);
        }

        await using (var h = Chaos("flood"))
        {
            Assert.IsTrue(await h.StartAndWaitRunningAsync());
            var session = h.FirstSession;
            Harness.Until(() => session.Received >= 5000, TimeSpan.FromSeconds(5));
            c.Check("flood: observed rate exceeds the 200 msg/s limit (host throttles or drops)",
                session.Received > 200 && session.Dropped > 0, $"received={session.Received} dropped={session.Dropped}");
        }

        await using (var h = await RunUntilFirstExitAsync("oversize"))
        {
            var s = h.FirstSession;
            c.Check("oversize: a 2 MiB frame is a violation and the plugin is disconnected",
                s.Violations.Count == 1 && s.Violations.First().Contains("exceeds")
                && h.Plugin.Exits.FirstOrDefault() is { Reason: ExitReason.Violation }, string.Join("; ", s.Violations));
        }

        await using (var h = await RunUntilFirstExitAsync("garbage"))
        {
            var s = h.FirstSession;
            c.Check("garbage: an invalid body is a violation and the plugin is disconnected",
                s.Violations.Count == 1 && s.Violations.First().Contains("bad frame")
                && h.Plugin.Exits.FirstOrDefault() is { Reason: ExitReason.Violation }, string.Join("; ", s.Violations));
        }

        await using (var h = Chaos("spoof"))
        {
            h.Plugin.Start();
            var ev = h.WaitEvent("chaos.spoof", TimeSpan.FromSeconds(10));
            var s = h.FirstSession;
            c.Check("spoof: plugin claimed source 'admin' but the host stamped the real channel",
                ev is not null && s.ClaimedSources.SequenceEqual(["admin"]) && ev.Source == "chaos-python",
                $"claimed={string.Join(",", s.ClaimedSources)} source={ev?.Source}");
        }

        Assert.AreEqual(9, c.Count);
        c.AssertAllPassed();
    }
}
