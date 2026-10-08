// echo-dotnet: the same behaviour as echo-python, in C#. Standard library only.
// Protocol: see ../../PROFILE.md. stdout is frames only; logs go to stderr.
using System.Buffers.Binary;
using System.Text.Json;
using System.Text.Json.Serialization;

const int MaxFrame = 1024 * 1024;
const string Id = "echo-dotnet", Version = "0.1.0";

var json = new JsonSerializerOptions(JsonSerializerDefaults.Web)
{
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
};
using var stdin = Console.OpenStandardInput();
using var stdout = Console.OpenStandardOutput();

void Write(Envelope env)
{
    var body = JsonSerializer.SerializeToUtf8Bytes(env, json);
    var header = new byte[4];
    BinaryPrimitives.WriteUInt32LittleEndian(header, (uint)body.Length);
    stdout.Write(header);
    stdout.Write(body);
    stdout.Flush();
}

Envelope? Read()
{
    var header = new byte[4];
    if (stdin.ReadAtLeast(header, 4, throwOnEndOfStream: false) < 4) return null; // EOF: host is gone
    var length = BinaryPrimitives.ReadUInt32LittleEndian(header);
    if (length > MaxFrame) throw new InvalidDataException("frame too large");
    var body = new byte[length];
    if (stdin.ReadAtLeast(body, body.Length, throwOnEndOfStream: false) < body.Length) return null;
    // Concrete record, no type-name handling; unknown fields are ignored.
    return JsonSerializer.Deserialize<Envelope>(body, json);
}

void Reply(Envelope req, string type = "Response", object? payload = null) =>
    Write(new Envelope(type, Guid.NewGuid(), req.RequestId, req.Topic,
        payload is null ? null : JsonSerializer.SerializeToElement(payload, json)));

Write(new Envelope("Event", Guid.NewGuid(), null, "lifecycle.ready",
    JsonSerializer.SerializeToElement(new { id = Id, version = Version }, json)));

while (Read() is { } env)
{
    if (env.Type == "Shutdown") return 0;
    switch (env.Type)
    {
        case "Heartbeat": // same loop as requests: a stuck handler stops this too
            Write(new Envelope("Heartbeat", Guid.NewGuid(), env.RequestId));
            break;
        case "Request" when env.Topic == "echo":
            Reply(env, payload: env.Payload);
            break;
        case "Request" when env.Topic == "add":
            if (env.Payload is { ValueKind: JsonValueKind.Object } p
                && p.TryGetProperty("a", out var a) && a.ValueKind == JsonValueKind.Number && a.TryGetDouble(out var x)
                && p.TryGetProperty("b", out var b) && b.ValueKind == JsonValueKind.Number && b.TryGetDouble(out var y))
                Reply(env, payload: new { sum = x + y });
            else
                Reply(env, "Error", new { code = "bad-payload", message = "expected {a, b} numbers" });
            break;
        case "Request":
            Reply(env, "Error", new { code = "unknown-topic", message = $"no handler for '{env.Topic}'" });
            break;
        default:
            Console.Error.WriteLine($"ignoring {env.Type}");
            break;
    }
}
return 0;

// Wire envelope (PROFILE.md). `Source` is host-stamped; this plugin never sets or reads it.
record Envelope(
    string Type,
    Guid RequestId,
    Guid? CorrelationId = null,
    string? Topic = null,
    JsonElement? Payload = null);
