using System.Text.Json;

namespace OoBDev.Plugins.Protocol;

public enum MessageType { Request, Response, Event, Heartbeat, Shutdown, Error }

/// <summary>
/// The message envelope (PROFILE.md). <see cref="Source"/> is stamped by the host from the channel a frame
/// arrived on; whatever a plugin put there is discarded by the host and only kept for diagnostics.
/// </summary>
public sealed record Envelope(
    MessageType Type,
    Guid RequestId,
    Guid? CorrelationId = null,
    string? Topic = null,
    string? Target = null,
    string? Source = null,
    int? TtlMs = null,
    int? Hops = null,
    JsonElement? Payload = null)
{
    public static Envelope Create(
        MessageType type, string? topic = null, JsonElement? payload = null,
        Guid? correlationId = null, string? target = null, int? ttlMs = null, int? hops = null)
        => new(type, Guid.NewGuid(), correlationId, topic, target, null, ttlMs, hops, payload);
}
