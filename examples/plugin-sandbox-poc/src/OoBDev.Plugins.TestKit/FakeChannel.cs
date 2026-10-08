using OoBDev.Plugins.Host;
using System.IO.Pipelines;
using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.TestKit;

/// <summary>The plugin end of an in-memory channel, handed to a test script.</summary>
public sealed class FakeChannel(Stream fromHost, Stream toHost, CancellationToken killed)
{
    private readonly SemaphoreSlim _writeLock = new(1);

    public CancellationToken Killed => killed;

    public async Task<Envelope?> ReadAsync()
    {
        var r = await FrameCodec.ReadAsync(fromHost, ct: killed);
        return r.Kind == FrameReadKind.Frame ? r.Envelope : null;
    }

    public async Task WriteAsync(Envelope e)
    {
        await _writeLock.WaitAsync(killed);
        try { await FrameCodec.WriteAsync(toHost, e, ct: killed); }
        finally { _writeLock.Release(); }
    }

    public async Task WriteRawAsync(byte[] bytes)
    {
        await toHost.WriteAsync(bytes, killed);
        await toHost.FlushAsync(killed);
    }

    public Task SendReadyAsync(string id = "fake")
        => WriteAsync(Envelope.Create(MessageType.Event, PluginSession.ReadyTopic, Json(new { id, version = "1" })));

    public Task ReplyAsync(Envelope request, MessageType type = MessageType.Response, object? payload = null)
        => WriteAsync(Envelope.Create(type, request.Topic, payload is null ? null : Json(payload), correlationId: request.RequestId));

    public Task BeatAsync(Envelope heartbeat)
        => WriteAsync(Envelope.Create(MessageType.Heartbeat, correlationId: heartbeat.RequestId));

    public static JsonElement Json(object? value) => JsonSerializer.SerializeToElement(value);

    /// <summary>
    /// A conforming plugin: announces ready, answers heartbeats, exits 0 on Shutdown, and hands every other
    /// frame to <paramref name="onFrame"/>.
    /// </summary>
    public async Task<int> RunWellBehavedAsync(Func<FakeChannel, Envelope, Task>? onFrame = null, string id = "fake")
    {
        await SendReadyAsync(id);
        while (true)
        {
            var e = await ReadAsync();
            if (e is null || e.Type == MessageType.Shutdown) return 0;
            if (e.Type == MessageType.Heartbeat) await BeatAsync(e);
            else if (onFrame is not null) await onFrame(this, e);
        }
    }
}
