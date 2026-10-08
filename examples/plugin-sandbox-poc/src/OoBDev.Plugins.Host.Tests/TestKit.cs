using System.IO.Pipelines;
using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host.Tests;

/// <summary>The plugin end of an in-memory channel, handed to a test script.</summary>
sealed class FakeChannel(Stream fromHost, Stream toHost, CancellationToken killed)
{
    readonly SemaphoreSlim _writeLock = new(1);

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

delegate Task<int> PluginScript(FakeChannel channel);

/// <summary>A fake OS process whose behaviour is a script running over in-memory pipes.</summary>
sealed class FakeProcess : IPluginProcess
{
    readonly Pipe _toPlugin = new();
    readonly Pipe _fromPlugin = new();
    readonly CancellationTokenSource _kill = new();
    readonly TaskCompletionSource<int> _exited = new(TaskCreationOptions.RunContinuationsAsynchronously);
    readonly Stream _input;
    readonly Stream _output;

    public FakeProcess(PluginScript script)
    {
        _input = _toPlugin.Writer.AsStream();
        _output = _fromPlugin.Reader.AsStream();
        var channel = new FakeChannel(_toPlugin.Reader.AsStream(), _fromPlugin.Writer.AsStream(), _kill.Token);
        _ = Task.Run(async () =>
        {
            var code = 137;   // killed
            try { code = await script(channel); }
            catch (OperationCanceledException) { }
            catch (Exception) { code = 1; }
            finally
            {
                await _fromPlugin.Writer.CompleteAsync();
                await _toPlugin.Reader.CompleteAsync();
                _exited.TrySetResult(_kill.IsCancellationRequested ? 137 : code);
            }
        });
    }

    public bool WasKilled => _kill.IsCancellationRequested;
    public Stream Input => _input;
    public Stream Output => _output;
    public Stream? Error => null;
    public Task<int> Exited => _exited.Task;
    public void Kill() { try { _kill.Cancel(); } catch (ObjectDisposedException) { } }
    public ValueTask DisposeAsync() { Kill(); return ValueTask.CompletedTask; }
}

/// <summary>Launches scripts chosen per attempt (1-based). Counts launches and live processes.</summary>
sealed class FakeLauncher(Func<int, PluginScript?> scriptFor) : IPluginLauncher
{
    int _launches;
    int _live;
    int _maxLive;
    readonly List<FakeProcess> _processes = [];

    public FakeLauncher(PluginScript script) : this(_ => script) { }

    public int Launches => Volatile.Read(ref _launches);
    public int MaxConcurrent => Volatile.Read(ref _maxLive);
    public IReadOnlyList<FakeProcess> Processes { get { lock (_processes) return [.. _processes]; } }

    public ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct)
    {
        var attempt = Interlocked.Increment(ref _launches);
        var script = scriptFor(attempt) ?? throw new InvalidOperationException($"launch #{attempt} failed (test)");
        var live = Interlocked.Increment(ref _live);
        int seen;
        while ((seen = Volatile.Read(ref _maxLive)) < live && Interlocked.CompareExchange(ref _maxLive, live, seen) != seen) { }

        var process = new FakeProcess(async channel =>
        {
            try { return await script(channel); }
            finally { Interlocked.Decrement(ref _live); }
        });
        lock (_processes) _processes.Add(process);
        return ValueTask.FromResult<IPluginProcess>(process);
    }
}

static class Scripts
{
    /// <summary>Ready, then exit with <paramref name="code"/> straight away.</summary>
    public static PluginScript CrashAfterReady(int code = 3) => async ch => { await ch.SendReadyAsync(); return code; };

    public static PluginScript WellBehaved(Func<FakeChannel, Envelope, Task>? onFrame = null)
        => ch => ch.RunWellBehavedAsync(onFrame);

    /// <summary>Ready, then never read or answer anything again.</summary>
    public static PluginScript HangAfterReady() => async ch =>
    {
        await ch.SendReadyAsync();
        await Task.Delay(Timeout.Infinite, ch.Killed);
        return 0;
    };

    /// <summary>Answers heartbeats but never services a request (the "sidebeat" shape).</summary>
    public static PluginScript HeartbeatOnly() => ch => ch.RunWellBehavedAsync((_, _) => Task.CompletedTask);

    public static PluginScript NeverReady() => async ch =>
    {
        await Task.Delay(Timeout.Infinite, ch.Killed);
        return 0;
    };

    /// <summary>Well behaved, except it ignores Shutdown.</summary>
    public static PluginScript IgnoresShutdown() => async ch =>
    {
        await ch.SendReadyAsync();
        while (true)
        {
            var e = await ch.ReadAsync();
            if (e is null) return 0;
            if (e.Type == MessageType.Heartbeat) await ch.BeatAsync(e);
        }
    };
}

static class Fast
{
    /// <summary>Options that make the supervisor's clocks tick in tens of milliseconds.</summary>
    public static SupervisorOptions Options(Func<SupervisorOptions, SupervisorOptions>? tweak = null)
    {
        var o = new SupervisorOptions
        {
            BackoffInitial = TimeSpan.FromMilliseconds(20),
            BackoffMax = TimeSpan.FromMilliseconds(80),
            JitterMax = TimeSpan.FromMilliseconds(5),
            ReadyTimeout = TimeSpan.FromSeconds(2),
            ShutdownGrace = TimeSpan.FromMilliseconds(500),
            HeartbeatInterval = TimeSpan.FromMilliseconds(30),
        };
        return tweak?.Invoke(o) ?? o;
    }

    public static PluginSpec Spec(string id = "p")
        => new(id, ["fake"], ".") { HeartbeatTimeout = TimeSpan.FromMilliseconds(300) };

    public static async Task<bool> UntilAsync(Func<bool> condition, int timeoutMs = 5000)
    {
        var deadline = DateTime.UtcNow.AddMilliseconds(timeoutMs);
        while (DateTime.UtcNow < deadline)
        {
            if (condition()) return true;
            await Task.Delay(5);
        }
        return condition();
    }
}
