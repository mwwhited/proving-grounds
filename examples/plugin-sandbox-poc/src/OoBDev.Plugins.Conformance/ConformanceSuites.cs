using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Protocol;
using Xunit;
using Xunit.Abstractions;

namespace OoBDev.Plugins.Conformance;

/// <summary>
/// The 36 checks of <c>host-sim/run_tests.py</c>, run against the real host with the same plugins, unmodified.
/// Check names match the Python runner. Where the real host can do more than the stand-in could (kill a hung
/// plugin, drop flood frames) the check asserts the behaviour the stand-in's wording asks the host to have.
/// </summary>
public class GoodPluginConformance(ITestOutputHelper output)
{
    static readonly TimeSpan Short = TimeSpan.FromSeconds(2);

    [FactRequires("python")] public Task EchoPython() => RunEcho("echo-python");

    [FactRequires(file: "echo-dotnet/out/EchoPlugin.dll")] public Task EchoDotnet() => RunEcho("echo-dotnet");

    [FactRequires(file: "echo-go/out/echo-go.exe")] public Task EchoGo() => RunEcho("echo-go");

    [FactRequires("java", file: "echo-java/out/EchoPlugin.class")] public Task EchoJava() => RunEcho("echo-java");

    async Task RunEcho(string name)
    {
        output.WriteLine($"[{name}]");
        var c = new Checks(output);
        await using var h = new Harness(name);
        Assert.True(await h.StartAndWaitRunningAsync(), "plugin did not reach Running");
        var session = h.FirstSession;

        await CommonAsync(c, h, name);

        var r = await h.Plugin.RequestAsync("echo", Json.Of(new { hello = new object?[] { "wörld", 1, null } }), Short);
        c.Check("echo returns the payload unchanged", Json.Equal(r.Payload, new { hello = new object?[] { "wörld", 1, null } }));

        r = await h.Plugin.RequestAsync("add", Json.Of(new { a = 2, b = 40 }), Short);
        c.Check("add returns the sum", Json.Equal(r.Payload, new { sum = 42 }));

        r = await h.Plugin.RequestAsync("add", Json.Of(new { a = "x" }), Short);
        c.Check("add with a bad payload returns Error bad-payload", ErrorCode(r) == "bad-payload");

        r = await h.Plugin.RequestAsync("echo", Json.Of(new string('x', 200_000)), TimeSpan.FromSeconds(5));
        c.Check("handles a 200 KB payload", r.Payload is { ValueKind: JsonValueKind.String } p && p.GetString()!.Length == 200_000);

        await h.Plugin.StopAsync();
        var exit = h.Plugin.Exits.LastOrDefault();
        c.Check("exits 0 after Shutdown", exit is { Reason: ExitReason.Requested, ExitCode: 0, Detail: null }, exit?.ToString() ?? "no exit");
        c.Check("sent nothing but valid frames", session.Violations.Count == 0, string.Join("; ", session.Violations));
        c.Check("never set a source field", session.ClaimedSources.Count == 0, string.Join(",", session.ClaimedSources));

        Assert.Equal(10, c.Count);
        c.AssertAllPassed();
    }

    [FactRequires("node")]
    public async Task TickerNode()
    {
        output.WriteLine("[ticker-node]");
        var c = new Checks(output);
        await using var h = new Harness("ticker-node", new { intervalMs = 50 });
        Assert.True(await h.StartAndWaitRunningAsync(), "plugin did not reach Running");
        var session = h.FirstSession;

        await CommonAsync(c, h, "ticker-node");

        Harness.Until(() => h.Events("demo.tick").Count >= 3, Short);
        var ticks = h.Events("demo.tick").Take(3).ToList();
        c.Check("publishes demo.tick at the configured interval (3 ticks)", ticks.Count == 3);
        c.Check("ticks count up", ticks.Select(t => t.Payload!.Value.GetProperty("n").GetInt32()).SequenceEqual([1, 2, 3]));

        await h.Plugin.StopAsync();
        var exit = h.Plugin.Exits.LastOrDefault();
        c.Check("exits 0 after Shutdown", exit is { Reason: ExitReason.Requested, ExitCode: 0, Detail: null }, exit?.ToString() ?? "no exit");
        c.Check("sent nothing but valid frames", session.Violations.Count == 0, string.Join("; ", session.Violations));

        Assert.Equal(7, c.Count);
        c.AssertAllPassed();
    }

    static async Task CommonAsync(Checks c, Harness h, string expectId)
    {
        var ready = h.WaitEvent("lifecycle.ready", TimeSpan.FromSeconds(10));
        c.Check("announces lifecycle.ready", ready?.Payload is { } p && p.GetProperty("id").GetString() == expectId);
        c.Check("answers a heartbeat", await h.FirstSession.HeartbeatAsync(TimeSpan.FromSeconds(1)));
        var unknown = await h.Plugin.RequestAsync("no.such.topic", null, Short);
        c.Check("unknown topic returns Error unknown-topic", ErrorCode(unknown) == "unknown-topic");
    }

    static string? ErrorCode(Envelope e)
        => e.Type == MessageType.Error && e.Payload is { } p ? p.GetProperty("code").GetString() : null;
}

/// <summary>Each misbehaviour of <c>chaos-python</c> must be detected and handled by the host.</summary>
public class ChaosConformance(ITestOutputHelper output)
{
    static readonly TimeSpan Wait = TimeSpan.FromSeconds(10);

    static Harness Chaos(string mode, SupervisorOptions? options = null) => new("chaos-python", new { mode }, options);

    /// <summary>Starts a chaos plugin and returns once its first run has ended (or the wait expired).</summary>
    static async Task<Harness> RunUntilFirstExitAsync(string mode)
    {
        var h = Chaos(mode);
        h.Plugin.Start();
        Harness.Until(() => h.Plugin.Exits.Count >= 1, Wait);
        await Task.CompletedTask;
        return h;
    }

    [FactRequires("python")]
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
            Assert.True(await h.StartAndWaitRunningAsync());
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
            Assert.True(await h.StartAndWaitRunningAsync());
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

        Assert.Equal(9, c.Count);
        c.AssertAllPassed();
    }
}
