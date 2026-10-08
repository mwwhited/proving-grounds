using System.Collections.Concurrent;
using System.Text;
using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host;

/// <summary>Where a session hands the frames it does not handle itself.</summary>
public interface IFrameSink
{
    ValueTask OnFrameAsync(PluginSession from, Envelope frame);
}

/// <summary>
/// The host's side of one plugin process: frame I/O, <c>Source</c> stamping, <c>config.get</c>, heartbeat
/// bookkeeping, rate limiting and request/response matching. One session per launch; a restart builds a new one.
/// </summary>
public sealed class PluginSession : IAsyncDisposable
{
    public const string ReadyTopic = "lifecycle.ready";
    public const string ConfigTopic = "config.get";

    static readonly JsonElement EmptyObject = JsonDocument.Parse("{}").RootElement.Clone();

    readonly PluginSpec _spec;
    readonly IPluginProcess _process;
    readonly IFrameSink _sink;
    readonly TimeProvider _time;
    readonly TimeSpan _writeTimeout;
    readonly CancellationTokenSource _cts = new();

    readonly ConcurrentDictionary<Guid, TaskCompletionSource<Envelope>> _pending = new();
    // Two lanes: control frames (heartbeat, shutdown) are always written before queued data.
    readonly ConcurrentQueue<byte[]> _control = new();
    readonly ConcurrentQueue<byte[]> _data = new();
    readonly SemaphoreSlim _signal = new(0);
    int _dataQueued;

    readonly TaskCompletionSource<Envelope> _ready = new(TaskCreationOptions.RunContinuationsAsynchronously);
    readonly TaskCompletionSource<string> _faulted = new(TaskCreationOptions.RunContinuationsAsynchronously);
    readonly ConcurrentQueue<string> _violations = new();
    readonly ConcurrentQueue<string> _claimedSources = new();
    readonly ConcurrentQueue<string> _stderrTail = new();

    long _lastHeartbeatTicks;
    int _consecutiveTimeouts;
    long _received;
    long _dropped;
    long _windowStart;
    int _windowCount;
    int _disposed;
    Task _readLoop = Task.CompletedTask, _writeLoop = Task.CompletedTask, _errorLoop = Task.CompletedTask;

    public PluginSession(PluginSpec spec, IPluginProcess process, IFrameSink sink,
        TimeProvider? time = null, TimeSpan? writeTimeout = null)
    {
        _spec = spec;
        _process = process;
        _sink = sink;
        _time = time ?? TimeProvider.System;
        _writeTimeout = writeTimeout ?? TimeSpan.FromSeconds(5);
        _lastHeartbeatTicks = _time.GetUtcNow().UtcTicks;
        _windowStart = _time.GetTimestamp();
    }

    public string Id => _spec.Id;
    public PluginSpec Spec => _spec;

    /// <summary>Completes when the plugin announces <c>lifecycle.ready</c>.</summary>
    public Task<Envelope> Ready => _ready.Task;

    /// <summary>Completes with the reason when the host disconnected the plugin (violation, write timeout).</summary>
    public Task<string> Faulted => _faulted.Task;

    /// <summary>Completes with the exit code once the process is gone.</summary>
    public Task<int> Exited => _process.Exited;

    public DateTimeOffset LastHeartbeatReply => new(Interlocked.Read(ref _lastHeartbeatTicks), TimeSpan.Zero);

    /// <summary>Host requests in a row that timed out. A heartbeat does not reset it (that is the point).</summary>
    public int ConsecutiveRequestTimeouts => Volatile.Read(ref _consecutiveTimeouts);

    public long Received => Interlocked.Read(ref _received);
    public long Dropped => Interlocked.Read(ref _dropped);
    public IReadOnlyCollection<string> Violations => _violations;

    /// <summary>Values the plugin put in <c>source</c>. Ignored for routing; kept so spoofing is visible.</summary>
    public IReadOnlyCollection<string> ClaimedSources => _claimedSources;

    public IReadOnlyCollection<string> StderrTail => _stderrTail;

    public event Action<string, string>? LogLine;

    public void Start()
    {
        _readLoop = Task.Run(ReadLoopAsync);
        _writeLoop = Task.Run(WriteLoopAsync);
        _errorLoop = Task.Run(ErrorLoopAsync);
    }

    // ---- sending -------------------------------------------------------------------------------

    /// <summary>Queues a frame. Never blocks. Control frames use the priority lane.</summary>
    public void Send(Envelope envelope, bool control = false)
    {
        if (Volatile.Read(ref _disposed) != 0 || _faulted.Task.IsCompleted)
            throw new PluginUnavailableException(Id, "channel closed");

        var bytes = FrameCodec.Encode(envelope, _spec.Limits.MaxFrameBytes);
        if (control)
            _control.Enqueue(bytes);
        else
        {
            if (Interlocked.Increment(ref _dataQueued) > _spec.Limits.OutboundQueue)
            {
                Interlocked.Decrement(ref _dataQueued);
                throw new PluginQueueFullException(Id);
            }
            _data.Enqueue(bytes);
        }
        _signal.Release();
    }

    public void SendHeartbeat() => Send(Envelope.Create(MessageType.Heartbeat), control: true);

    public void SendShutdown() => Send(Envelope.Create(MessageType.Shutdown), control: true);

    /// <summary>
    /// Sends a request and waits for its Response or Error. Always bounded by <paramref name="timeout"/>;
    /// throws <see cref="TimeoutException"/> when it expires.
    /// </summary>
    public Task<Envelope> RequestAsync(string topic, JsonElement? payload, TimeSpan timeout, CancellationToken ct = default)
        => ExchangeAsync(Envelope.Create(MessageType.Request, topic, payload,
            ttlMs: (int)Math.Min(timeout.TotalMilliseconds, int.MaxValue)), timeout, control: false, ct);

    /// <summary>True when the plugin answered a heartbeat within <paramref name="timeout"/>.</summary>
    public async Task<bool> HeartbeatAsync(TimeSpan timeout)
    {
        try
        {
            await ExchangeAsync(Envelope.Create(MessageType.Heartbeat), timeout, control: true, default).ConfigureAwait(false);
            return true;
        }
        catch (TimeoutException) { return false; }
    }

    async Task<Envelope> ExchangeAsync(Envelope request, TimeSpan timeout, bool control, CancellationToken ct)
    {
        var tcs = new TaskCompletionSource<Envelope>(TaskCreationOptions.RunContinuationsAsynchronously);
        _pending[request.RequestId] = tcs;
        try
        {
            Send(request, control);
            return await tcs.Task.WaitAsync(timeout, _time, ct).ConfigureAwait(false);
        }
        catch (TimeoutException)
        {
            if (request.Type == MessageType.Request) Interlocked.Increment(ref _consecutiveTimeouts);
            throw;
        }
        finally { _pending.TryRemove(request.RequestId, out _); }
    }

    // ---- receiving -----------------------------------------------------------------------------

    async Task ReadLoopAsync()
    {
        try
        {
            while (!_cts.IsCancellationRequested)
            {
                var r = await FrameCodec.ReadAsync(_process.Output, _spec.Limits.MaxFrameBytes, _cts.Token).ConfigureAwait(false);
                if (r.Kind == FrameReadKind.EndOfStream) return;
                if (r.Kind == FrameReadKind.Violation) { Fault(r.Reason!, violation: true); return; }
                await HandleAsync(r.Envelope!).ConfigureAwait(false);
            }
        }
        catch (OperationCanceledException) { }
        catch (Exception ex) { Fault($"host error while reading: {ex.Message}", violation: false); }
        finally { FailPending("channel closed"); }
    }

    async ValueTask HandleAsync(Envelope received)
    {
        Interlocked.Increment(ref _received);
        if (received.Source is not null && _claimedSources.Count < 100) _claimedSources.Enqueue(received.Source);
        var env = received with { Source = _spec.Id };   // the host stamps Source; the plugin's value is never used

        switch (env.Type)
        {
            case MessageType.Heartbeat:
                if (env.CorrelationId is { } beatFor)
                {
                    Interlocked.Exchange(ref _lastHeartbeatTicks, _time.GetUtcNow().UtcTicks);
                    if (_pending.TryRemove(beatFor, out var beat)) beat.TrySetResult(env);
                }
                return;
            case MessageType.Shutdown:
                return;   // only the host sends these
            case MessageType.Response or MessageType.Error
                when env.CorrelationId is { } answered && _pending.TryRemove(answered, out var waiter):
                Interlocked.Exchange(ref _consecutiveTimeouts, 0);
                waiter.TrySetResult(env);
                return;
        }

        if (!Admit()) return;

        if (env.Type == MessageType.Request && env.Target is null && env.Topic == ConfigTopic)
        {
            TrySendQuietly(Envelope.Create(MessageType.Response, ConfigTopic, _spec.Config ?? EmptyObject,
                correlationId: env.RequestId));
            return;
        }
        if (env.Type == MessageType.Event && env.Topic == ReadyTopic) _ready.TrySetResult(env);

        try { await _sink.OnFrameAsync(this, env).ConfigureAwait(false); }
        catch (Exception ex) { Log($"router error: {ex.Message}"); }
    }

    /// <summary>Fixed one-second window. A burst can straddle a boundary, so the worst case is twice the limit.</summary>
    bool Admit()
    {
        var now = _time.GetTimestamp();
        if (_time.GetElapsedTime(_windowStart, now) >= TimeSpan.FromSeconds(1))
        {
            _windowStart = now;
            _windowCount = 0;
        }
        if (++_windowCount <= _spec.Limits.MsgPerSec) return true;

        Interlocked.Increment(ref _dropped);
        if (_spec.Limits.RateAction == RateLimitAction.Disconnect)
            Fault($"rate limit exceeded ({_spec.Limits.MsgPerSec} msg/s)", violation: true);
        return false;
    }

    void TrySendQuietly(Envelope e)
    {
        try { Send(e); } catch (Exception ex) when (ex is PluginUnavailableException or PluginQueueFullException) { }
    }

    // ---- writing -------------------------------------------------------------------------------

    async Task WriteLoopAsync()
    {
        var ct = _cts.Token;
        try
        {
            while (true)
            {
                await _signal.WaitAsync(ct).ConfigureAwait(false);
                if (!_control.TryDequeue(out var frame))
                {
                    if (!_data.TryDequeue(out frame)) continue;
                    Interlocked.Decrement(ref _dataQueued);
                }
                try
                {
                    await WriteFrameAsync(frame, ct).WaitAsync(_writeTimeout, _time, ct).ConfigureAwait(false);
                }
                catch (TimeoutException)
                {
                    Fault($"write to plugin timed out after {_writeTimeout.TotalSeconds:0.#}s", violation: false);
                    return;
                }
            }
        }
        catch (Exception ex) when (ex is OperationCanceledException or IOException or ObjectDisposedException) { }
    }

    async Task WriteFrameAsync(byte[] frame, CancellationToken ct)
    {
        await _process.Input.WriteAsync(frame, ct).ConfigureAwait(false);
        await _process.Input.FlushAsync(ct).ConfigureAwait(false);
    }

    // ---- stderr, faults, teardown ------------------------------------------------------------

    async Task ErrorLoopAsync()
    {
        if (_process.Error is null) return;
        try
        {
            using var reader = new StreamReader(_process.Error, Encoding.UTF8);
            while (await reader.ReadLineAsync(_cts.Token).ConfigureAwait(false) is { } line)
                Log(line);
        }
        catch (Exception ex) when (ex is OperationCanceledException or IOException or ObjectDisposedException) { }
    }

    void Log(string line)
    {
        _stderrTail.Enqueue(line);
        while (_stderrTail.Count > 50) _stderrTail.TryDequeue(out _);
        LogLine?.Invoke(Id, line);
    }

    /// <summary>Disconnects the plugin: record why, then kill it.</summary>
    void Fault(string reason, bool violation)
    {
        if (violation) _violations.Enqueue(reason);
        _faulted.TrySetResult(reason);
        _process.Kill();
    }

    /// <summary>Host decision to disconnect, for example after repeated request timeouts.</summary>
    public void Disconnect(string reason) => Fault(reason, violation: false);

    void FailPending(string reason)
    {
        foreach (var (id, tcs) in _pending)
            if (tcs.TrySetException(new PluginUnavailableException(Id, reason)))
                _pending.TryRemove(id, out _);
    }

    public async ValueTask DisposeAsync()
    {
        if (Interlocked.Exchange(ref _disposed, 1) != 0) return;
        _process.Kill();
        _cts.Cancel();
        try { await Task.WhenAll(_readLoop, _writeLoop, _errorLoop).WaitAsync(TimeSpan.FromSeconds(3), _time).ConfigureAwait(false); }
        catch (Exception ex) when (ex is TimeoutException or OperationCanceledException) { }
        FailPending("session disposed");
        await _process.DisposeAsync().ConfigureAwait(false);
        _signal.Dispose();
        _cts.Dispose();
    }
}
