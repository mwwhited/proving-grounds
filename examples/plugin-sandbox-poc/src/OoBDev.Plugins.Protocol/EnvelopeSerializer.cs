using System.Buffers;
using System.Text.Json;

namespace OoBDev.Plugins.Protocol;

/// <summary>
/// Strict-schema (de)serializer for <see cref="Envelope"/>. No type-name or polymorphic deserialization:
/// every field is read by name into a fixed shape, unknown fields are ignored, wrong types are rejected.
/// </summary>
public static class EnvelopeSerializer
{
    /// <summary>Nesting limit applied to the whole body, payload included.</summary>
    public const int MaxDepth = 32;

    private static readonly JsonDocumentOptions ParseOptions = new()
    {
        MaxDepth = MaxDepth,
        CommentHandling = JsonCommentHandling.Disallow,
        AllowTrailingCommas = false,
    };

    // Exact, case-sensitive names only. Enum.TryParse would also accept numbers and "A,B" combinations.
    private static readonly Dictionary<string, MessageType> Types =
        Enum.GetValues<MessageType>().ToDictionary(t => t.ToString(), StringComparer.Ordinal);

    public static byte[] Serialize(Envelope e)
    {
        var buffer = new ArrayBufferWriter<byte>();
        using (var w = new Utf8JsonWriter(buffer))
        {
            w.WriteStartObject();
            w.WriteString("type", e.Type.ToString());
            w.WriteString("requestId", e.RequestId);
            if (e.CorrelationId is { } c) w.WriteString("correlationId", c);
            if (e.Topic is not null) w.WriteString("topic", e.Topic);
            if (e.Target is not null) w.WriteString("target", e.Target);
            if (e.Source is not null) w.WriteString("source", e.Source);
            if (e.TtlMs is { } ttl) w.WriteNumber("ttlMs", ttl);
            if (e.Hops is { } hops) w.WriteNumber("hops", hops);
            if (e.Payload is { } p)
            {
                w.WritePropertyName("payload");
                p.WriteTo(w);
            }
            w.WriteEndObject();
        }
        return buffer.WrittenSpan.ToArray();
    }

    /// <summary>Parses a frame body. Never throws on malformed input; returns false with a reason.</summary>
    public static bool TryParse(ReadOnlySpan<byte> body, out Envelope? envelope, out string error)
    {
        envelope = null;
        // JsonDocument only checks UTF-8 lazily (GetString throws), so reject bad encoding up front.
        if (!System.Text.Unicode.Utf8.IsValid(body)) return Fail("body is not valid UTF-8", out error);
        try
        {
            using var doc = JsonDocument.Parse(body.ToArray(), ParseOptions);
            var root = doc.RootElement;
            if (root.ValueKind != JsonValueKind.Object) return Fail("body is not a JSON object", out error);

            if (!TryString(root, "type", required: true, out var typeText, out error)) return false;
            if (!Types.TryGetValue(typeText!, out var type))
                return Fail($"unknown message type '{Truncate(typeText!)}'", out error);

            if (!TryGuid(root, "requestId", required: true, out var requestId, out error)) return false;
            if (!TryGuid(root, "correlationId", required: false, out var correlation, out error)) return false;
            if (!TryString(root, "topic", false, out var topic, out error)) return false;
            if (!TryString(root, "target", false, out var target, out error)) return false;
            if (!TryString(root, "source", false, out var source, out error)) return false;
            if (!TryInt(root, "ttlMs", out var ttl, out error)) return false;
            if (!TryInt(root, "hops", out var hops, out error)) return false;

            JsonElement? payload = null;
            if (root.TryGetProperty("payload", out var p) && p.ValueKind != JsonValueKind.Undefined)
                payload = p.Clone();   // outlive the document

            envelope = new Envelope(type, requestId.GetValueOrDefault(), correlation, topic, target, source, ttl, hops, payload);
            error = "";
            return true;
        }
        catch (JsonException ex)
        {
            return Fail($"invalid JSON: {Truncate(ex.Message)}", out error);
        }
        catch (Exception ex) when (ex is ArgumentException or InvalidOperationException)
        {   // defence in depth: the parser must never throw on hostile input
            return Fail($"invalid body: {Truncate(ex.Message)}", out error);
        }
    }

    private static bool Fail(string reason, out string error) { error = reason; return false; }

    private static string Truncate(string s) => s.Length <= 80 ? s : s[..80];

    private static bool TryString(JsonElement root, string name, bool required, out string? value, out string error)
    {
        value = null; error = "";
        if (!root.TryGetProperty(name, out var el) || el.ValueKind == JsonValueKind.Null)
            return required ? Fail($"missing '{name}'", out error) : true;
        if (el.ValueKind != JsonValueKind.String) return Fail($"'{name}' must be a string", out error);
        value = el.GetString();
        return true;
    }

    private static bool TryGuid(JsonElement root, string name, bool required, out Guid? value, out string error)
    {
        value = null;
        if (!TryString(root, name, required, out var text, out error)) return false;
        if (text is null) return true;
        if (!Guid.TryParseExact(text, "D", out var g)) return Fail($"'{name}' must be a GUID", out error);
        value = g;
        return true;
    }

    private static bool TryInt(JsonElement root, string name, out int? value, out string error)
    {
        value = null; error = "";
        if (!root.TryGetProperty(name, out var el) || el.ValueKind == JsonValueKind.Null) return true;
        if (el.ValueKind != JsonValueKind.Number || !el.TryGetInt32(out var n) || n < 0)
            return Fail($"'{name}' must be a non-negative 32-bit integer", out error);
        value = n;
        return true;
    }
}
