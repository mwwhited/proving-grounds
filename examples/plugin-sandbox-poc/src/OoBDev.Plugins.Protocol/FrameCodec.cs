using System.Buffers.Binary;

namespace OoBDev.Plugins.Protocol;

/// <summary>
/// Frame = uint32 little-endian body length, then that many bytes of UTF-8 JSON (PROFILE.md).
/// Reading any byte sequence yields exactly one of: a frame, end of stream, or a violation. It never throws
/// for bad input; only cancellation propagates.
/// </summary>
public static class FrameCodec
{
    public const int DefaultMaxFrameBytes = 1_048_576;
    public const int HeaderBytes = 4;

    public static async ValueTask<FrameReadResult> ReadAsync(
        Stream stream, int maxFrameBytes = DefaultMaxFrameBytes, CancellationToken ct = default)
    {
        var header = new byte[HeaderBytes];
        var got = await ReadExactAsync(stream, header, ct).ConfigureAwait(false);
        if (got == 0) return new(FrameReadKind.EndOfStream);
        if (got < HeaderBytes) return new(FrameReadKind.EndOfStream, Truncated: true);

        var length = BinaryPrimitives.ReadUInt32LittleEndian(header);
        if (length > (uint)maxFrameBytes)
            return new(FrameReadKind.Violation, Reason: $"frame length {length} exceeds {maxFrameBytes}");
        if (length == 0)
            return new(FrameReadKind.Violation, Reason: "empty frame body");

        var body = new byte[length];
        got = await ReadExactAsync(stream, body, ct).ConfigureAwait(false);
        if (got < body.Length) return new(FrameReadKind.EndOfStream, Truncated: true);

        return EnvelopeSerializer.TryParse(body, out var envelope, out var error)
            ? new(FrameReadKind.Frame, envelope)
            : new(FrameReadKind.Violation, Reason: $"bad frame body: {error}");
    }

    /// <summary>Header plus body as one buffer, so a single write cannot interleave with another.</summary>
    public static byte[] Encode(Envelope envelope, int maxFrameBytes = DefaultMaxFrameBytes)
    {
        var body = EnvelopeSerializer.Serialize(envelope);
        if (body.Length > maxFrameBytes)
            throw new FrameTooLargeException(body.Length, maxFrameBytes);
        var frame = new byte[HeaderBytes + body.Length];
        BinaryPrimitives.WriteUInt32LittleEndian(frame, (uint)body.Length);
        body.CopyTo(frame, HeaderBytes);
        return frame;
    }

    public static async ValueTask WriteAsync(
        Stream stream, Envelope envelope, int maxFrameBytes = DefaultMaxFrameBytes, CancellationToken ct = default)
    {
        await stream.WriteAsync(Encode(envelope, maxFrameBytes), ct).ConfigureAwait(false);
        await stream.FlushAsync(ct).ConfigureAwait(false);
    }

    /// <summary>Reads until <paramref name="buffer"/> is full or the stream ends. Returns the bytes read.</summary>
    private static async ValueTask<int> ReadExactAsync(Stream stream, byte[] buffer, CancellationToken ct)
    {
        var total = 0;
        while (total < buffer.Length)
        {
            int n;
            try { n = await stream.ReadAsync(buffer.AsMemory(total), ct).ConfigureAwait(false); }
            catch (Exception ex) when (ex is IOException or ObjectDisposedException) { return total; }
            if (n == 0) break;
            total += n;
        }
        return total;
    }
}
