using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Conformance;

/// <summary>
/// The 36 checks of <c>host-sim/run_tests.py</c>, run against the real host with the same plugins, unmodified.
/// Check names match the Python runner. Where the real host can do more than the stand-in could (kill a hung
/// plugin, drop flood frames) the check asserts the behaviour the stand-in's wording asks the host to have.
/// </summary>
[TestClass]
public class GoodPluginConformance(TestContext output)
{
    private static readonly TimeSpan Short = TimeSpan.FromSeconds(2);

    [TestMethod]

    [RequiresTool("python")] public Task EchoPython() => RunEcho("echo-python");

    [TestMethod]

    [RequiresTool(file: "echo-dotnet/out/EchoPlugin.dll")] public Task EchoDotnet() => RunEcho("echo-dotnet");

    [TestMethod]

    [RequiresTool(file: "echo-go/out/echo-go.exe")] public Task EchoGo() => RunEcho("echo-go");

    [TestMethod]

    [RequiresTool("java", file: "echo-java/out/EchoPlugin.class",
        appContainerGap: "java cannot open its own java.security under an AppContainer (AccessDenied) although the ACL allows it; see docs/poc/findings.md")] public Task EchoJava() => RunEcho("echo-java");

    private async Task RunEcho(string name)
    {
        output.WriteLine($"[{name}]");
        var c = new Checks(output);
        await using var h = new Harness(name);
        Assert.IsTrue(await h.StartAndWaitRunningAsync(), "plugin did not reach Running");
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

        Assert.AreEqual(10, c.Count);
        c.AssertAllPassed();
    }

    [TestMethod]

    [RequiresTool("node")]
    public async Task TickerNode()
    {
        output.WriteLine("[ticker-node]");
        var c = new Checks(output);
        await using var h = new Harness("ticker-node", new { intervalMs = 50 });
        Assert.IsTrue(await h.StartAndWaitRunningAsync(), "plugin did not reach Running");
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

        Assert.AreEqual(7, c.Count);
        c.AssertAllPassed();
    }

    private static async Task CommonAsync(Checks c, Harness h, string expectId)
    {
        var ready = h.WaitEvent("lifecycle.ready", TimeSpan.FromSeconds(10));
        c.Check("announces lifecycle.ready", ready?.Payload is { } p && p.GetProperty("id").GetString() == expectId);
        c.Check("answers a heartbeat", await h.FirstSession.HeartbeatAsync(TimeSpan.FromSeconds(1)));
        var unknown = await h.Plugin.RequestAsync("no.such.topic", null, Short);
        c.Check("unknown topic returns Error unknown-topic", ErrorCode(unknown) == "unknown-topic");
    }

    private static string? ErrorCode(Envelope e)
        => e.Type == MessageType.Error && e.Payload is { } p ? p.GetProperty("code").GetString() : null;
}
