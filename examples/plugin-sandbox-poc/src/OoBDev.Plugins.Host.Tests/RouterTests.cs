using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host.Tests;

[TestClass]
public class RouterTests
{
    private static PluginSpec Spec(string id, string[]? publish = null, string[]? subscribe = null, string[]? sendTo = null)
        => Fast.Spec(id) with { Policy = new PluginPolicy(publish ?? [], subscribe ?? [], sendTo ?? []) };

    private static JsonElement J(object o) => JsonSerializer.SerializeToElement(o);

    private sealed class Rig : IAsyncDisposable
    {
        public PluginManager Manager = null!;
        public List<PolicyDenial> Denials = [];
        public List<Envelope> HostEvents = [];

        public static async Task<Rig> StartAsync(params (PluginSpec Spec, PluginScript Script)[] plugins)
        {
            var rig = new Rig();
            var scripts = plugins.ToDictionary(p => p.Spec.Id, p => p.Script);
            rig.Manager = new PluginManager(new IdLauncher(scripts), Fast.Options());
            rig.Manager.Router.Denied += d => { lock (rig.Denials) rig.Denials.Add(d); };
            rig.Manager.Router.EventPublished += e => { lock (rig.HostEvents) rig.HostEvents.Add(e); };
            foreach (var (spec, _) in plugins) rig.Manager.Register(spec).Start();
            foreach (var (spec, _) in plugins)
                Assert.IsTrue(await rig.Manager.Get(spec.Id).WaitForStateAsync(PluginState.Running, TimeSpan.FromSeconds(5)));
            return rig;
        }

        public int DenialCount { get { lock (Denials) return Denials.Count; } }
        public ValueTask DisposeAsync() => Manager.DisposeAsync();
    }

    /// <summary>Waits for ready (the host's Running state implies it), publishes once, then behaves.</summary>
    private static PluginScript Publisher(string topic, JsonElement? payload = null) => async ch =>
    {
        await ch.SendReadyAsync();
        await Task.Delay(150);   // let every other plugin finish starting so subscribers are attached
        await ch.WriteAsync(Envelope.Create(MessageType.Event, topic, payload));
        while (await ch.ReadAsync() is { } e && e.Type != MessageType.Shutdown)
            if (e.Type == MessageType.Heartbeat) await ch.BeatAsync(e);
        return 0;
    };

    private static PluginScript Collector(List<Envelope> inbox)
        => Scripts.WellBehaved((_, e) => { lock (inbox) inbox.Add(e); return Task.CompletedTask; });

    /// <summary>Sends one request to <paramref name="target"/> and records whatever comes back.</summary>
    private static PluginScript Caller(string target, JsonElement? payload, Action<Envelope> onAnswer) => async ch =>
    {
        await ch.SendReadyAsync();
        await Task.Delay(150);
        await ch.WriteAsync(Envelope.Create(MessageType.Request, "ping", payload, target: target));
        while (await ch.ReadAsync() is { } e && e.Type != MessageType.Shutdown)
        {
            if (e.Type == MessageType.Heartbeat) await ch.BeatAsync(e);
            else onAnswer(e);
        }
        return 0;
    };

    [TestMethod]
    public async Task Publish_without_permission_is_denied_and_not_delivered()
    {
        var inbox = new List<Envelope>();
        await using var rig = await Rig.StartAsync(
            (Spec("pub"), Publisher("secret.x")),
            (Spec("sub", subscribe: ["secret.*"]), Collector(inbox)));
        Assert.IsTrue(await Fast.UntilAsync(() => rig.DenialCount > 0));
        Assert.AreEqual("publish", rig.Denials[0].Action);
        await Task.Delay(100);
        lock (inbox) Assert.IsEmpty(inbox);
    }

    [TestMethod]
    public async Task A_permitted_publish_reaches_only_matching_subscribers_and_the_host()
    {
        var yes = new List<Envelope>();
        var no = new List<Envelope>();
        await using var rig = await Rig.StartAsync(
            (Spec("pub", publish: ["news.*"]), Publisher("news.flash", J(new { n = 1 }))),
            (Spec("yes", subscribe: ["news.flash"]), Collector(yes)),
            (Spec("no", subscribe: ["other.*"]), Collector(no)));
        Assert.IsTrue(await Fast.UntilAsync(() => { lock (yes) return yes.Count == 1; }));
        await Task.Delay(100);
        lock (no) Assert.IsEmpty(no);
        Assert.AreEqual("pub", yes[0].Source);
        lock (rig.HostEvents) Assert.IsTrue(rig.HostEvents.Any(e => e.Topic == "news.flash" && e.Source == "pub"));
    }

    [TestMethod]
    public async Task Plugins_cannot_publish_lifecycle_topics_even_with_a_wildcard_grant()
    {
        await using var rig = await Rig.StartAsync((Spec("p", publish: ["lifecycle.*"]), Publisher("lifecycle.stopped")));
        Assert.IsTrue(await Fast.UntilAsync(() => rig.DenialCount > 0));
        Assert.AreEqual("lifecycle.stopped", rig.Denials[0].Topic);
    }

    [TestMethod]
    public async Task Sending_to_a_plugin_without_sendTo_permission_is_denied_and_the_target_sees_nothing()
    {
        var inbox = new List<Envelope>();
        Envelope? answer = null;
        await using var rig = await Rig.StartAsync(
            (Spec("caller"), Caller("target", null, e => answer = e)),
            (Spec("target"), Collector(inbox)));
        Assert.IsTrue(await Fast.UntilAsync(() => answer is not null));
        Assert.AreEqual(MessageType.Error, answer!.Type);
        Assert.AreEqual("denied", answer.Payload!.Value.GetProperty("code").GetString());
        lock (inbox) Assert.IsEmpty(inbox);
    }

    [TestMethod]
    public async Task A_permitted_plugin_to_plugin_request_is_relayed_and_the_reply_returns_to_the_caller()
    {
        Envelope? answer = null;
        Envelope? seenByTarget = null;
        var target = Scripts.WellBehaved(async (ch, req) =>
        {
            seenByTarget = req;
            await ch.ReplyAsync(req, payload: new { pong = true });
        });
        await using var rig = await Rig.StartAsync(
            (Spec("caller", sendTo: ["target"]), Caller("target", J(new { q = 1 }), e => answer = e)),
            (Spec("target"), target));
        Assert.IsTrue(await Fast.UntilAsync(() => answer is not null));
        Assert.AreEqual(MessageType.Response, answer!.Type);
        Assert.IsTrue(answer.Payload!.Value.GetProperty("pong").GetBoolean());
        Assert.AreEqual("caller", seenByTarget!.Source);          // stamped by the host
    }

    [TestMethod]
    public async Task A_request_to_a_target_that_is_not_running_gets_an_unavailable_error()
    {
        Envelope? answer = null;
        await using var rig = await Rig.StartAsync((Spec("caller", sendTo: ["ghost"]), Caller("ghost", null, e => answer = e)));
        Assert.IsTrue(await Fast.UntilAsync(() => answer is not null));
        Assert.AreEqual("unavailable", answer!.Payload!.Value.GetProperty("code").GetString());
    }

    [TestMethod]
    [DataRow("a.b", "a.b", true)]
    [DataRow("a.*", "a.b", true)]
    [DataRow("a.*", "a.b.c", true)]
    [DataRow("a.*", "a", false)]
    [DataRow("a.*", "ab.c", false)]
    [DataRow("a.b", "a.bc", false)]
    public void Pattern_matching(string pattern, string topic, bool expected)
        => Assert.AreEqual(expected, Router.Allows([pattern], topic));

    [TestMethod]
    public void No_patterns_means_deny() => Assert.IsFalse(Router.Allows([], "x"));
}
