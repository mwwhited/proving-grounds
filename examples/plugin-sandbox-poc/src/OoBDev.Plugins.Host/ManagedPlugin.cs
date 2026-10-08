using System.Text.Json;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host;

public enum PluginState { Stopped, Starting, Running, Stopping, Backoff, Failed }

public sealed record SupervisorOptions
{
    public TimeSpan BackoffInitial { get; init; } = TimeSpan.FromMilliseconds(500);
    public TimeSpan BackoffMax { get; init; } = TimeSpan.FromSeconds(30);
    /// <summary>Random extra delay in [0, JitterMax) added to every backoff.</summary>
    public TimeSpan JitterMax { get; init; } = TimeSpan.FromMilliseconds(250);
    /// <summary>A run at least this long counts as stable and resets the backoff.</summary>
    public TimeSpan StableAfter { get; init; } = TimeSpan.FromMinutes(1);
    public TimeSpan CrashWindow { get; init; } = TimeSpan.FromSeconds(60);
    public int MaxCrashesInWindow { get; init; } = 5;
    /// <summary>How long a launched plugin has to announce <c>lifecycle.ready</c>.</summary>
    public TimeSpan ReadyTimeout { get; init; } = TimeSpan.FromSeconds(10);
    /// <summary>After <c>Shutdown</c>, how long to wait for exit before killing.</summary>
    public TimeSpan ShutdownGrace { get; init; } = TimeSpan.FromSeconds(2);
    /// <summary>Upper bound on the heartbeat period; the real period is also capped at a third of the plugin's timeout.</summary>
    public TimeSpan HeartbeatInterval { get; init; } = TimeSpan.FromSeconds(1);
    /// <summary>Host requests in a row that may time out before the plugin is declared hung.</summary>
    public int MaxConsecutiveRequestTimeouts { get; init; } = 3;
    public TimeProvider Time { get; init; } = TimeProvider.System;
}

public enum ExitReason { Requested, Exited, Hung, Violation, StartFailed, StartTimeout }

public sealed record ExitRecord(ExitReason Reason, int? ExitCode, string? Detail, DateTimeOffset At);

/// <summary>
/// Supervisor for one plugin: desired state versus actual state. <see cref="Start"/> and <see cref="StopAsync"/>
/// change intent; one loop reconciles reality, so manual control and crash recovery share a code path and
/// cannot fight. An intentional stop never restarts. Every restart asks the launcher for a fresh process.
/// </summary>
public sealed class ManagedPlugin
{
    readonly IPluginLauncher _launcher;
    readonly Router _router;
    readonly SupervisorOptions _opt;
    readonly object _gate = new();
    readonly List<PluginState> _history = [PluginState.Stopped];
    readonly List<ExitRecord> _exits = [];
    CancellationTokenSource _cts = new();
    Task _loop = Task.CompletedTask;
    PluginSession? _session;
    PluginState _state = PluginState.Stopped;

    public ManagedPlugin(PluginSpec spec, IPluginLauncher launcher, Router router, SupervisorOptions? options = null)
    {
        Spec = spec;
        _launcher = launcher;
        _router = router;
        _opt = options ?? new SupervisorOptions();
    }

    public PluginSpec Spec { get; }
    public string Id => Spec.Id;

    public PluginState State { get { lock (_gate) return _state; } }

    /// <summary>Every state entered, oldest first. Starts with <see cref="PluginState.Stopped"/>.</summary>
    public IReadOnlyList<PluginState> History { get { lock (_gate) return [.. _history]; } }

    /// <summary>Why each run ended, oldest first.</summary>
    public IReadOnlyList<ExitRecord> Exits { get { lock (_gate) return [.. _exits]; } }

    /// <summary>The live session while <see cref="PluginState.Running"/>, otherwise null.</summary>
    public PluginSession? Session { get { lock (_gate) return _state == PluginState.Running ? _session : null; } }

    public event Action<string, PluginState>? StateChanged;
    public event Action<string, string>? LogLine;

    /// <summary>Raised for every launch, before the plugin is supervised. Restarts raise it again with a new session.</summary>
    public event Action<PluginSession>? SessionCreated;

    public void Start()
    {
        lock (_gate)
        {
            if (!_loop.IsCompleted && !_cts.IsCancellationRequested) return;   // already running
            var previous = _loop;
            _cts = new CancellationTokenSource();
            var ct = _cts.Token;
            // A Start that lands while a Stop is still draining waits for it, so two copies never overlap.
            _loop = Task.Run(async () =>
            {
                await previous.ConfigureAwait(false);
                await RunAsync(ct).ConfigureAwait(false);
            });
        }
    }

    /// <summary>Completes only once the process is gone.</summary>
    public Task StopAsync()
    {
        Task loop;
        lock (_gate)
        {
            _cts.Cancel();
            loop = _loop;
        }
        return loop;
    }

    public async Task RestartAsync()
    {
        await StopAsync().ConfigureAwait(false);
        Start();
    }

    /// <summary>Sends a request to the running plugin. Fails fast when it is not running.</summary>
    public Task<Envelope> RequestAsync(string topic, JsonElement? payload, TimeSpan timeout, CancellationToken ct = default)
        => (Session ?? throw new PluginUnavailableException(Id, $"state is {State}"))
            .RequestAsync(topic, payload, timeout, ct);

    public async Task<bool> WaitForStateAsync(PluginState state, TimeSpan timeout)
    {
        using var cts = new CancellationTokenSource(timeout);
        try
        {
            while (State != state)
                await Task.Delay(10, cts.Token).ConfigureAwait(false);
            return true;
        }
        catch (OperationCanceledException) { return State == state; }
    }

    // ---- the loop ----------------------------------------------------------------------------

    async Task RunAsync(CancellationToken ct)
    {
        var crashes = new Queue<DateTimeOffset>();
        var backoff = _opt.BackoffInitial;
        try
        {
            while (!ct.IsCancellationRequested)
            {
                Set(PluginState.Starting);
                var startedAt = _opt.Time.GetUtcNow();
                PluginSession? session = null;
                ExitRecord ended;
                try
                {
                    var process = await _launcher.LaunchAsync(Spec, ct).ConfigureAwait(false);
                    session = new PluginSession(Spec, process, _router, _opt.Time);
                    session.LogLine += (id, line) => LogLine?.Invoke(id, line);
                    _router.Attach(session);
                    session.Start();
                    SessionCreated?.Invoke(session);
                    lock (_gate) _session = session;
                    ended = await SuperviseAsync(session, ct).ConfigureAwait(false);
                }
                catch (OperationCanceledException) when (ct.IsCancellationRequested)
                {
                    ended = Record(ExitReason.Requested, null, null);
                }
                catch (Exception ex)
                {
                    ended = Record(ExitReason.StartFailed, null, ex.Message);
                }

                if (ended.Reason == ExitReason.Requested)
                {
                    Set(PluginState.Stopping);
                    ended = await StopSessionAsync(session, graceful: true).ConfigureAwait(false);
                    Add(ended);
                    return;
                }

                ended = await StopSessionAsync(session, graceful: false, ended).ConfigureAwait(false);
                Add(ended);

                var now = _opt.Time.GetUtcNow();
                crashes.Enqueue(now);
                while (crashes.Count > 0 && now - crashes.Peek() > _opt.CrashWindow) crashes.Dequeue();
                if (crashes.Count >= _opt.MaxCrashesInWindow) { Set(PluginState.Failed); return; }

                if (now - startedAt >= _opt.StableAfter) backoff = _opt.BackoffInitial;   // a stable run forgives earlier crashes
                var delay = backoff + TimeSpan.FromTicks((long)(Random.Shared.NextDouble() * _opt.JitterMax.Ticks));
                backoff = NextBackoff(backoff, _opt);
                Set(PluginState.Backoff);
                try { await Task.Delay(delay, _opt.Time, ct).ConfigureAwait(false); }
                catch (OperationCanceledException) { return; }   // Stop during Backoff: no restart
            }
        }
        finally
        {
            lock (_gate) _session = null;
            if (State != PluginState.Failed) Set(PluginState.Stopped);
        }
    }

    /// <summary>Waits for the plugin to become ready, then watches it until it ends or a stop is requested.</summary>
    async Task<ExitRecord> SuperviseAsync(PluginSession session, CancellationToken ct)
    {
        var stop = Task.Delay(Timeout.Infinite, ct);
        var readyTimeout = Task.Delay(_opt.ReadyTimeout, _opt.Time, ct);

        var first = await Task.WhenAny(session.Ready, session.Exited, session.Faulted, readyTimeout, stop).ConfigureAwait(false);
        if (ct.IsCancellationRequested) return Record(ExitReason.Requested, null, null);
        if (first == session.Exited) return Record(ExitReason.Exited, await session.Exited, "exited before ready");
        if (first == session.Faulted) return Record(ExitReason.Violation, null, await session.Faulted);
        if (first == readyTimeout) return Record(ExitReason.StartTimeout, null, $"no {PluginSession.ReadyTopic} within {_opt.ReadyTimeout}");

        Set(PluginState.Running);
        var tick = TimeSpan.FromTicks(Math.Min(_opt.HeartbeatInterval.Ticks, Spec.HeartbeatTimeout.Ticks / 3));
        while (true)
        {
            try { session.SendHeartbeat(); }
            catch (PluginUnavailableException) { }   // channel already gone; the checks below see why

            var next = await Task.WhenAny(session.Exited, session.Faulted, Task.Delay(tick, _opt.Time, ct)).ConfigureAwait(false);
            if (ct.IsCancellationRequested) return Record(ExitReason.Requested, null, null);
            if (next == session.Exited) return Record(ExitReason.Exited, await session.Exited, "exited unexpectedly");
            if (next == session.Faulted) return Record(ExitReason.Violation, null, await session.Faulted);

            if (_opt.Time.GetUtcNow() - session.LastHeartbeatReply > Spec.HeartbeatTimeout)
                return Record(ExitReason.Hung, null, $"no heartbeat reply for {Spec.HeartbeatTimeout}");
            if (session.ConsecutiveRequestTimeouts >= _opt.MaxConsecutiveRequestTimeouts)
                return Record(ExitReason.Hung, null, $"{session.ConsecutiveRequestTimeouts} host requests timed out in a row");
        }
    }

    /// <summary>
    /// Gets the process to end and disposes the session. Graceful: ask first, kill after the grace period.
    /// Otherwise it is a crash, kill straight away. Returns the record with the exit code filled in.
    /// </summary>
    async Task<ExitRecord> StopSessionAsync(PluginSession? session, bool graceful, ExitRecord? crash = null)
    {
        if (session is null)
            return crash ?? Record(ExitReason.Requested, null, "stopped before launch");

        _router.Detach(session);
        int? code = null;
        var detail = crash?.Detail;
        if (graceful)
        {
            try { session.SendShutdown(); } catch (PluginUnavailableException) { }
            try { code = await session.Exited.WaitAsync(_opt.ShutdownGrace, _opt.Time).ConfigureAwait(false); }
            catch (TimeoutException) { detail = $"did not exit within {_opt.ShutdownGrace}; killed"; }
        }
        if (code is null)
        {
            session.Disconnect("host is killing the plugin");   // kills the process
            try { code = await session.Exited.WaitAsync(TimeSpan.FromSeconds(5), _opt.Time).ConfigureAwait(false); }
            catch (TimeoutException) { detail = (detail ?? "") + " (process did not die within 5s)"; }
        }
        await session.DisposeAsync().ConfigureAwait(false);
        lock (_gate) _session = null;

        var reason = crash?.Reason ?? ExitReason.Requested;
        return new ExitRecord(reason, code ?? crash?.ExitCode, detail, _opt.Time.GetUtcNow());
    }

    /// <summary>Doubles, capped at <see cref="SupervisorOptions.BackoffMax"/>.</summary>
    internal static TimeSpan NextBackoff(TimeSpan current, SupervisorOptions opt)
        => TimeSpan.FromTicks(Math.Min(current.Ticks * 2, opt.BackoffMax.Ticks));

    ExitRecord Record(ExitReason reason, int? code, string? detail) => new(reason, code, detail, _opt.Time.GetUtcNow());

    void Add(ExitRecord record) { lock (_gate) _exits.Add(record); }

    void Set(PluginState state)
    {
        lock (_gate)
        {
            if (_state == state) return;
            _state = state;
            _history.Add(state);
        }
        StateChanged?.Invoke(Id, state);
    }
}
