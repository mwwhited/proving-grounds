using System.Collections.Concurrent;
using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host;

/// <summary>A frame the router refused because the plugin's policy does not allow it.</summary>
public sealed record PolicyDenial(string PluginId, string Action, string? Topic, string? Target, string Reason);

/// <summary>
/// The hub in hub-and-spoke. Receives stamped frames from sessions and applies default-deny policy:
/// a plugin may publish, subscribe and send only to what its policy lists. Plugin-to-plugin traffic is
/// always relayed here; plugins never learn about each other.
/// </summary>
public sealed class Router : IFrameSink
{
    public const int MaxHops = 8;
    static readonly TimeSpan DefaultForwardTtl = TimeSpan.FromSeconds(5);

    readonly TimeProvider _time;
    readonly ConcurrentDictionary<string, PluginSpec> _specs = new();
    readonly ConcurrentDictionary<string, PluginSession> _sessions = new();
    readonly ConcurrentDictionary<Guid, Forward> _forwards = new();
    readonly ConcurrentDictionary<string, Func<Envelope, CancellationToken, Task<JsonElement?>>> _handlers = new();

    sealed record Forward(string OriginId, Guid OriginRequestId, string TargetId, string? Topic, DateTimeOffset Expires);

    public Router(TimeProvider? time = null) => _time = time ?? TimeProvider.System;

    /// <summary>Every event a plugin was allowed to publish, with <c>Source</c> stamped. Includes <c>lifecycle.*</c>.</summary>
    public event Action<Envelope>? EventPublished;

    public event Action<PolicyDenial>? Denied;

    public void Register(PluginSpec spec) => _specs[spec.Id] = spec;

    public void Attach(PluginSession session) => _sessions[session.Id] = session;

    public void Detach(PluginSession session) => _sessions.TryRemove(KeyValuePair.Create(session.Id, session));

    /// <summary>Handles plugin-to-host requests with no <c>Target</c> on <paramref name="topic"/>.</summary>
    public void MapRequest(string topic, Func<Envelope, CancellationToken, Task<JsonElement?>> handler)
        => _handlers[topic] = handler;

    /// <summary>The host publishes to every plugin subscribed to <paramref name="topic"/>.</summary>
    public void Publish(string topic, JsonElement? payload = null)
    {
        foreach (var session in _sessions.Values)
            if (Allows(_specs.GetValueOrDefault(session.Id)?.Policy.Subscribe, topic))
                TryDeliver(session, Envelope.Create(MessageType.Event, topic, payload) with { Source = "host" });
    }

    public async ValueTask OnFrameAsync(PluginSession from, Envelope frame)
    {
        var policy = (_specs.GetValueOrDefault(from.Id) ?? from.Spec).Policy;
        switch (frame.Type)
        {
            case MessageType.Event:
                OnEvent(from, frame, policy);
                break;
            case MessageType.Request:
                await OnRequestAsync(from, frame, policy).ConfigureAwait(false);
                break;
            case MessageType.Response or MessageType.Error:
                OnReply(from, frame);
                break;
        }
    }

    // ---- events ------------------------------------------------------------------------------

    void OnEvent(PluginSession from, Envelope frame, PluginPolicy policy)
    {
        var topic = frame.Topic;
        if (string.IsNullOrEmpty(topic)) { Deny(from, "publish", null, null, "event without a topic"); return; }

        // Only the ready announcement is a plugin's to make; the rest of lifecycle.* is reserved for the host.
        var lifecycle = topic == PluginSession.ReadyTopic;
        if (!lifecycle && (topic.StartsWith("lifecycle.", StringComparison.Ordinal) || !Allows(policy.Publish, topic))) { Deny(from, "publish", topic, null, "topic not in publish list"); return; }

        EventPublished?.Invoke(frame);
        if (lifecycle) return;   // host-only

        var hops = (frame.Hops ?? 0) + 1;
        if (hops > MaxHops) { Deny(from, "publish", topic, null, "hop limit"); return; }
        foreach (var peer in _sessions.Values)
        {
            if (peer.Id == from.Id) continue;
            if (!Allows(_specs.GetValueOrDefault(peer.Id)?.Policy.Subscribe, topic)) continue;
            TryDeliver(peer, frame with { RequestId = Guid.NewGuid(), Hops = hops, Target = null });
        }
    }

    // ---- requests ----------------------------------------------------------------------------

    async Task OnRequestAsync(PluginSession from, Envelope request, PluginPolicy policy)
    {
        if (request.Target is null)
        {
            await HandleHostRequestAsync(from, request).ConfigureAwait(false);
            return;
        }

        var target = request.Target;
        if (!policy.SendTo.Contains(target, StringComparer.Ordinal))
        {
            Deny(from, "sendTo", request.Topic, target, "target not in sendTo list");
            ReplyError(from, request, "denied", $"not allowed to send to '{target}'");
            return;
        }
        var hops = (request.Hops ?? 0) + 1;
        if (hops > MaxHops)
        {
            ReplyError(from, request, "hop-limit", "too many hops");
            return;
        }
        if (!_sessions.TryGetValue(target, out var peer))
        {
            ReplyError(from, request, "unavailable", $"'{target}' is not running");
            return;
        }

        PruneForwards();
        var relayed = request with { RequestId = Guid.NewGuid(), Hops = hops, Target = null };   // Source is already the sender
        var ttl = request.TtlMs is { } ms ? TimeSpan.FromMilliseconds(ms) : DefaultForwardTtl;
        _forwards[relayed.RequestId] = new Forward(from.Id, request.RequestId, target, request.Topic, _time.GetUtcNow() + ttl);
        try { peer.Send(relayed); }
        catch (Exception ex) when (ex is PluginUnavailableException or PluginQueueFullException)
        {
            _forwards.TryRemove(relayed.RequestId, out _);
            ReplyError(from, request, "unavailable", ex.Message);
        }
    }

    async Task HandleHostRequestAsync(PluginSession from, Envelope request)
    {
        if (request.Topic is null || !_handlers.TryGetValue(request.Topic, out var handler))
        {
            ReplyError(from, request, "unknown-topic", $"no handler for '{request.Topic}'");
            return;
        }
        using var cts = new CancellationTokenSource(request.TtlMs is { } ms ? TimeSpan.FromMilliseconds(ms) : DefaultForwardTtl);
        try
        {
            var payload = await handler(request, cts.Token).ConfigureAwait(false);
            TrySend(from, Envelope.Create(MessageType.Response, request.Topic, payload, correlationId: request.RequestId));
        }
        catch (OperationCanceledException) { ReplyError(from, request, "timeout", "host handler timed out"); }
        catch (Exception) { ReplyError(from, request, "internal", "host handler failed"); }
    }

    /// <summary>A target's answer to a relayed request goes back to whoever asked; anything else is dropped.</summary>
    void OnReply(PluginSession from, Envelope reply)
    {
        if (reply.CorrelationId is not { } id || !_forwards.TryGetValue(id, out var fwd) || fwd.TargetId != from.Id)
            return;   // unsolicited, or a spoofed correlation id for someone else's request
        _forwards.TryRemove(id, out _);
        if (_sessions.TryGetValue(fwd.OriginId, out var origin))
            TrySend(origin, reply with { RequestId = Guid.NewGuid(), CorrelationId = fwd.OriginRequestId });
    }

    void PruneForwards()
    {
        var now = _time.GetUtcNow();
        foreach (var (id, fwd) in _forwards)
            if (fwd.Expires < now) _forwards.TryRemove(id, out _);
    }

    // ---- helpers -----------------------------------------------------------------------------

    /// <summary>Exact match, or a trailing <c>.*</c> prefix wildcard (<c>device.*</c>). Nothing listed means nothing allowed.</summary>
    internal static bool Allows(IReadOnlyList<string>? patterns, string topic)
    {
        if (patterns is null) return false;
        foreach (var p in patterns)
        {
            if (p == topic) return true;
            if (p.EndsWith(".*", StringComparison.Ordinal) && topic.StartsWith(p[..^1], StringComparison.Ordinal)) return true;
        }
        return false;
    }

    void Deny(PluginSession from, string action, string? topic, string? target, string reason)
        => Denied?.Invoke(new PolicyDenial(from.Id, action, topic, target, reason));

    void ReplyError(PluginSession to, Envelope request, string code, string message)
        => TrySend(to, Envelope.Create(MessageType.Error, request.Topic,
            JsonSerializer.SerializeToElement(new { code, message }), correlationId: request.RequestId));

    static void TrySend(PluginSession to, Envelope e)
    {
        try { to.Send(e); } catch (Exception ex) when (ex is PluginUnavailableException or PluginQueueFullException) { }
    }

    static void TryDeliver(PluginSession to, Envelope e) => TrySend(to, e);
}
