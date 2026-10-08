using System.Buffers.Binary;
using System.Text;
using System.Text.Json;

namespace OoBDev.Plugins.Protocol.Tests;

[TestClass]
public class FrameCodecTests
{
    private static Envelope Sample(JsonElement? payload = null) => new(
        MessageType.Request, Guid.NewGuid(), Guid.NewGuid(), "echo", "billing", "me", 500, 2, payload);

    private static byte[] Frame(string body)
    {
        var b = Encoding.UTF8.GetBytes(body);
        var f = new byte[4 + b.Length];
        BinaryPrimitives.WriteUInt32LittleEndian(f, (uint)b.Length);
        b.CopyTo(f, 4);
        return f;
    }

    private static ValueTask<FrameReadResult> Read(byte[] bytes, int max = FrameCodec.DefaultMaxFrameBytes)
        => FrameCodec.ReadAsync(new MemoryStream(bytes), max);

    private static string ValidBody(string extra = "") =>
        $$"""{"type":"Event","requestId":"{{Guid.NewGuid()}}"{{extra}}}""";

    [TestMethod]
    public async Task Round_trips_every_field()
    {
        var payload = JsonSerializer.SerializeToElement(new { a = 1, b = new[] { "x", "wörld" }, c = (string?)null });
        var original = Sample(payload);

        var result = await Read(FrameCodec.Encode(original));

        Assert.AreEqual(FrameReadKind.Frame, result.Kind);
        var e = result.Envelope!;
        Assert.AreEqual(original.Type, e.Type);
        Assert.AreEqual(original.RequestId, e.RequestId);
        Assert.AreEqual(original.CorrelationId, e.CorrelationId);
        Assert.AreEqual(("echo", "billing", "me", 500, 2), (e.Topic, e.Target, e.Source, e.TtlMs, e.Hops));
        Assert.AreEqual(payload.GetRawText(), e.Payload!.Value.GetRawText());
    }

    [TestMethod]
    public async Task Reads_back_to_back_frames_then_clean_end_of_stream()
    {
        var bytes = FrameCodec.Encode(Sample()).Concat(FrameCodec.Encode(Sample())).ToArray();
        using var s = new MemoryStream(bytes);

        Assert.AreEqual(FrameReadKind.Frame, (await FrameCodec.ReadAsync(s)).Kind);
        Assert.AreEqual(FrameReadKind.Frame, (await FrameCodec.ReadAsync(s)).Kind);
        var end = await FrameCodec.ReadAsync(s);
        Assert.AreEqual(FrameReadKind.EndOfStream, end.Kind);
        Assert.IsFalse(end.Truncated);
    }

    [TestMethod]
    public async Task Oversize_length_is_a_violation_before_any_body_is_read()
    {
        var header = new byte[4];
        BinaryPrimitives.WriteUInt32LittleEndian(header, 2 * 1024 * 1024);

        var r = await Read(header);

        Assert.AreEqual(FrameReadKind.Violation, r.Kind);
        Assert.Contains("exceeds", r.Reason ?? "");
    }

    [TestMethod]
    public async Task Length_equal_to_the_cap_is_allowed_and_one_over_is_not()
    {
        var atCap = Frame("{\"type\":\"Event\",\"requestId\":\"" + Guid.NewGuid() + "\",\"payload\":\"" + new string('x', 200) + "\"}");
        var bodyLength = (int)BinaryPrimitives.ReadUInt32LittleEndian(atCap);

        Assert.AreEqual(FrameReadKind.Frame, (await Read(atCap, bodyLength)).Kind);
        Assert.AreEqual(FrameReadKind.Violation, (await Read(atCap, bodyLength - 1)).Kind);
    }

    [TestMethod]
    [DataRow("not{j")]
    [DataRow("[]")]
    [DataRow("42")]
    [DataRow("{}")]
    [DataRow("{\"type\":\"Event\"}")]                                            // no requestId
    [DataRow("{\"type\":\"Nope\",\"requestId\":\"00000000-0000-0000-0000-000000000001\"}")]
    [DataRow("{\"type\":\"event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\"}")]   // case-sensitive
    [DataRow("{\"type\":\"2\",\"requestId\":\"00000000-0000-0000-0000-000000000001\"}")]       // no numeric enum
    [DataRow("{\"type\":\"Request,Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\"}")]
    [DataRow("{\"type\":1,\"requestId\":\"00000000-0000-0000-0000-000000000001\"}")]
    [DataRow("{\"type\":\"Event\",\"requestId\":\"not-a-guid\"}")]
    [DataRow("{\"type\":\"Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\",\"topic\":5}")]
    [DataRow("{\"type\":\"Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\",\"ttlMs\":-1}")]
    [DataRow("{\"type\":\"Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\",\"ttlMs\":1.5}")]
    [DataRow("{\"type\":\"Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\",\"hops\":99999999999}")]
    [DataRow("{\"type\":\"Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\",}")]   // trailing comma
    [DataRow("{\"type\":\"Event\",\"requestId\":\"00000000-0000-0000-0000-000000000001\"} extra")]
    [DataRow("{\"type\":\"Event\",/*c*/\"requestId\":\"00000000-0000-0000-0000-000000000001\"}")]
    public async Task Malformed_bodies_are_violations(string body)
    {
        var r = await Read(Frame(body));
        Assert.AreEqual(FrameReadKind.Violation, r.Kind);
        Assert.StartsWith("bad frame body", r.Reason);
    }

    [TestMethod]
    public async Task Invalid_utf8_is_a_violation()
    {
        var bad = new byte[] { 0x7B, 0x22, 0xFF, 0xFE, 0x22, 0x7D };   // {"..."}
        var frame = new byte[4 + bad.Length];
        BinaryPrimitives.WriteUInt32LittleEndian(frame, (uint)bad.Length);
        bad.CopyTo(frame, 4);

        Assert.AreEqual(FrameReadKind.Violation, (await Read(frame)).Kind);
    }

    [TestMethod]
    public async Task Empty_body_is_a_violation()
        => Assert.AreEqual(FrameReadKind.Violation, (await Read(new byte[4])).Kind);

    [TestMethod]
    public async Task Payload_nested_beyond_the_depth_limit_is_a_violation()
    {
        var deep = new string('[', EnvelopeSerializer.MaxDepth + 5) + new string(']', EnvelopeSerializer.MaxDepth + 5);
        Assert.AreEqual(FrameReadKind.Violation, (await Read(Frame(ValidBody($",\"payload\":{deep}")))).Kind);

        var ok = new string('[', EnvelopeSerializer.MaxDepth - 2) + new string(']', EnvelopeSerializer.MaxDepth - 2);
        Assert.AreEqual(FrameReadKind.Frame, (await Read(Frame(ValidBody($",\"payload\":{ok}")))).Kind);
    }

    [TestMethod]
    public async Task Unknown_fields_and_null_optionals_are_ignored()
    {
        var r = await Read(Frame(ValidBody(",\"future\":{\"x\":1},\"topic\":null,\"payload\":null")));
        Assert.AreEqual(FrameReadKind.Frame, r.Kind);
        Assert.IsNull(r.Envelope!.Topic);
        Assert.AreEqual(JsonValueKind.Null, r.Envelope.Payload!.Value.ValueKind);
    }

    [TestMethod]
    public async Task Type_name_hints_in_the_payload_are_just_data()
    {
        var r = await Read(Frame(ValidBody(",\"payload\":{\"$type\":\"System.Diagnostics.Process, System\"}")));
        Assert.AreEqual(FrameReadKind.Frame, r.Kind);
        Assert.AreEqual("System.Diagnostics.Process, System", r.Envelope!.Payload!.Value.GetProperty("$type").GetString());
    }

    [TestMethod]
    public async Task Truncation_is_end_of_stream_not_a_violation()
    {
        var full = FrameCodec.Encode(Sample());

        foreach (var cut in new[] { 1, 3, 4, 10, full.Length - 1 })
        {
            var r = await Read(full[..cut]);
            Assert.AreEqual(FrameReadKind.EndOfStream, r.Kind);
            Assert.IsTrue(r.Truncated, $"cut at {cut}");
        }
    }

    [TestMethod]
    public async Task Frames_arriving_one_byte_at_a_time_are_reassembled()
    {
        var full = FrameCodec.Encode(Sample());
        await using var slow = new OneByteStream(full);
        var r = await FrameCodec.ReadAsync(slow);
        Assert.AreEqual(FrameReadKind.Frame, r.Kind);
    }

    [TestMethod]
    public void Encoding_over_the_cap_throws_instead_of_sending()
    {
        var big = JsonSerializer.SerializeToElement(new string('x', 2000));
        var ex = Assert.ThrowsExactly<FrameTooLargeException>(() => FrameCodec.Encode(Sample(big), 1000));
        Assert.AreEqual(1000, ex.Max);
    }

    [TestMethod]
    public async Task A_broken_pipe_is_end_of_stream()
    {
        await using var s = new ThrowingStream();
        Assert.AreEqual(FrameReadKind.EndOfStream, (await FrameCodec.ReadAsync(s)).Kind);
    }

    [TestMethod]
    public async Task Cancellation_propagates()
    {
        using var cts = new CancellationTokenSource(50);
        await using var never = new HangingStream();
        await Assert.ThrowsAsync<OperationCanceledException>(async () => await FrameCodec.ReadAsync(never, ct: cts.Token));
    }

    // ---- property tests: never a crash, always one of three outcomes ---------------------------

    [TestMethod]
    public async Task Random_bytes_always_yield_a_frame_end_of_stream_or_violation()
    {
        var rng = new Random(20261008);
        for (var i = 0; i < 3000; i++)
        {
            var bytes = new byte[rng.Next(0, 300)];
            rng.NextBytes(bytes);
            await AssertDrains(bytes);
        }
    }

    [TestMethod]
    public async Task Mutated_valid_frames_never_crash_the_reader()
    {
        var rng = new Random(7);
        var payload = JsonSerializer.SerializeToElement(new { list = new[] { 1, 2, 3 }, s = "wörld", nested = new { ok = true } });
        var seed = FrameCodec.Encode(Sample(payload));

        for (var i = 0; i < 4000; i++)
        {
            var bytes = (byte[])seed.Clone();
            for (var m = rng.Next(1, 6); m > 0; m--)
            {
                switch (rng.Next(3))
                {
                    case 0: bytes[rng.Next(bytes.Length)] = (byte)rng.Next(256); break;
                    case 1: bytes[rng.Next(bytes.Length)] ^= (byte)(1 << rng.Next(8)); break;
                    default: bytes = bytes[..rng.Next(1, bytes.Length)]; break;
                }
            }
            await AssertDrains(bytes);
        }
    }

    [TestMethod]
    public async Task Random_valid_envelopes_round_trip()
    {
        var rng = new Random(99);
        for (var i = 0; i < 500; i++)
        {
            var type = (MessageType)rng.Next(6);
            var topic = rng.Next(3) == 0 ? null : new string(Enumerable.Range(0, rng.Next(0, 40)).Select(_ => (char)rng.Next(32, 0x2FF)).Where(c => !char.IsSurrogate(c)).ToArray());
            var payload = rng.Next(2) == 0 ? (JsonElement?)null : JsonSerializer.SerializeToElement(Enumerable.Range(0, rng.Next(0, 20)).Select(n => rng.NextDouble() * n).ToArray());
            var env = new Envelope(type, Guid.NewGuid(), rng.Next(2) == 0 ? null : Guid.NewGuid(), topic, null, null, rng.Next(2) == 0 ? null : rng.Next(), null, payload);

            var back = (await Read(FrameCodec.Encode(env))).Envelope!;

            Assert.AreEqual(env.Type, back.Type);
            Assert.AreEqual(env.RequestId, back.RequestId);
            Assert.AreEqual(env.CorrelationId, back.CorrelationId);
            Assert.AreEqual(env.Topic, back.Topic);
            Assert.AreEqual(env.TtlMs, back.TtlMs);
            Assert.AreEqual(env.Payload?.GetRawText(), back.Payload?.GetRawText());
        }
    }

    /// <summary>Reads until the stream ends or a violation; every step must be a legal outcome.</summary>
    private static async Task AssertDrains(byte[] bytes)
    {
        using var s = new MemoryStream(bytes);
        for (var guard = 0; guard < 1000; guard++)
        {
            var r = await FrameCodec.ReadAsync(s, 4096);
            switch (r.Kind)
            {
                case FrameReadKind.Frame: Assert.IsNotNull(r.Envelope); continue;
                case FrameReadKind.EndOfStream: return;
                case FrameReadKind.Violation: Assert.IsFalse(string.IsNullOrEmpty(r.Reason)); return;
                default: Assert.Fail("unknown outcome"); return;
            }
        }
        Assert.Fail("reader did not terminate");
    }

    private sealed class OneByteStream(byte[] data) : MemoryStream(data)
    {
        public override ValueTask<int> ReadAsync(Memory<byte> buffer, CancellationToken ct = default)
            => base.ReadAsync(buffer[..Math.Min(1, buffer.Length)], ct);
    }

    private sealed class ThrowingStream : MemoryStream
    {
        public override ValueTask<int> ReadAsync(Memory<byte> buffer, CancellationToken ct = default)
            => throw new IOException("pipe closed");
    }

    private sealed class HangingStream : MemoryStream
    {
        public override async ValueTask<int> ReadAsync(Memory<byte> buffer, CancellationToken ct = default)
        {
            await Task.Delay(Timeout.Infinite, ct);
            return 0;
        }
    }
}
