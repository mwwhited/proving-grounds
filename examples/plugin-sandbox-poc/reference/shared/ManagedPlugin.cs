// REFERENCE SKETCH: written in conversation, never compiled or tested.
//
// Supervisor model: desired state vs actual state.
//   Start()/Stop() only change intent; ONE loop per plugin reconciles reality.
//   Manual control and crash recovery share one code path, so they can't fight.
//
// Behavior:
//  * Stop never triggers a restart (cancellation takes the stop path).
//  * StopAsync completes only once the process is gone, so RestartAsync can't leave two copies.
//  * Crash OR missed heartbeat -> Backoff (500 ms doubling to 30 s, jitter, reset after 1 stable minute).
//  * 5 crashes in 60 s -> Failed. A manual Start() on a Failed plugin resets it (the loop has exited).
//  * Every restart calls _launch again, which must build a FRESH sandbox (new job, grants, channel).
//
// TODO when making this real:
//  * _launch should return a PluginProcess abstraction (process handle + channel), not System.Diagnostics.Process.
//    On Windows, sandboxed processes may not be openable via Process.GetProcessById; wait on the raw handle.
//  * Heartbeat must be fed by the SAME loop that handles requests inside the plugin (SDK spec),
//    and control traffic needs a priority lane in the router.
//  * Detached plugins: Stop means "reconnect to the well-known endpoint and send an explicit stop",
//    and Start must first check the state file for a live instance (PID + start time) before launching.
//  * Dependencies (start in order, stop in reverse) are not implemented here.
//  * Unit-test: crash loop, stop during Backoff, restart while Starting, hang detection.

using System.Collections.Concurrent;
using System.Diagnostics;

public enum Lifetime { Bound, Detached }
public enum PluginState { Stopped, Starting, Running, Stopping, Backoff, Failed }

public sealed class ManagedPlugin
{
    public string Id { get; }
    public Lifetime Lifetime { get; }
    public PluginState State { get; private set; } = PluginState.Stopped;
    public event Action<string, PluginState>? StateChanged;

    /// <summary>Updated by the IPC reader whenever a heartbeat reply arrives.</summary>
    public volatile DateTime LastHeartbeat;

    readonly Func<Process> _launch;              // builds a fresh sandbox every time
    readonly Func<Task> _requestShutdown;        // sends "shutdown" over IPC
    readonly TimeSpan _heartbeatTimeout = TimeSpan.FromSeconds(10);
    readonly object _gate = new();
    CancellationTokenSource? _cts;
    Task _loop = Task.CompletedTask;

    public ManagedPlugin(string id, Lifetime lifetime, Func<Process> launch, Func<Task> requestShutdown)
        => (Id, Lifetime, _launch, _requestShutdown) = (id, lifetime, launch, requestShutdown);

    public void Start()
    {
        lock (_gate)
        {
            if (!_loop.IsCompleted) return;      // already running
            _cts = new CancellationTokenSource();
            _loop = Task.Run(() => RunAsync(_cts.Token));
        }
    }

    public async Task StopAsync()
    {
        Task loop;
        lock (_gate) { _cts?.Cancel(); loop = _loop; }
        await loop;                              // returns once the process is gone
    }

    public async Task RestartAsync() { await StopAsync(); Start(); }

    async Task RunAsync(CancellationToken ct)
    {
        var crashes = new Queue<DateTime>();
        int backoffMs = 500;
        try
        {
            while (!ct.IsCancellationRequested)
            {
                Set(PluginState.Starting);
                var started = DateTime.UtcNow;
                LastHeartbeat = started;
                using var p = _launch();
                Set(PluginState.Running);

                bool stopRequested = await WaitForExitOrHangAsync(p, ct);
                if (stopRequested)
                {
                    Set(PluginState.Stopping);
                    await GracefulStopAsync(p);
                    return;
                }

                // Crashed or hung: crash-loop protection, then backoff
                var now = DateTime.UtcNow;
                crashes.Enqueue(now);
                while (crashes.Count > 0 && now - crashes.Peek() > TimeSpan.FromMinutes(1))
                    crashes.Dequeue();
                if (crashes.Count >= 5) { Set(PluginState.Failed); return; }

                backoffMs = now - started > TimeSpan.FromMinutes(1) ? 500 : Math.Min(backoffMs * 2, 30_000);
                Set(PluginState.Backoff);
                try { await Task.Delay(backoffMs + Random.Shared.Next(250), ct); }
                catch (OperationCanceledException) { return; }   // Stop during Backoff: no restart
            }
        }
        finally { if (State != PluginState.Failed) Set(PluginState.Stopped); }
    }

    // true = stop requested; false = process exited or hung
    async Task<bool> WaitForExitOrHangAsync(Process p, CancellationToken ct)
    {
        var exit = p.WaitForExitAsync();
        while (true)
        {
            await Task.WhenAny(exit, Task.Delay(1000, CancellationToken.None), Task.Delay(Timeout.Infinite, ct));
            if (ct.IsCancellationRequested) return true;
            if (exit.IsCompleted) return false;
            if (DateTime.UtcNow - LastHeartbeat > _heartbeatTimeout)
            {
                p.Kill(entireProcessTree: true);          // hung -> treat as a crash
                await exit;
                return false;
            }
        }
    }

    async Task GracefulStopAsync(Process p)
    {
        try { await _requestShutdown(); } catch { /* plugin may already be gone */ }
        using var t = new CancellationTokenSource(TimeSpan.FromSeconds(2));
        try { await p.WaitForExitAsync(t.Token); }
        catch (OperationCanceledException)
        {
            try { p.Kill(entireProcessTree: true); } catch { }
            await p.WaitForExitAsync();
        }
    }

    void Set(PluginState s) { State = s; StateChanged?.Invoke(Id, s); }
}

public sealed class PluginManager
{
    readonly ConcurrentDictionary<string, ManagedPlugin> _plugins = new();

    public void Register(ManagedPlugin p) => _plugins[p.Id] = p;
    public void Start(string id) => _plugins[id].Start();
    public Task StopAsync(string id) => _plugins[id].StopAsync();
    public Task RestartAsync(string id) => _plugins[id].RestartAsync();
    public PluginState GetState(string id) => _plugins[id].State;

    // Host shutdown: stop Bound plugins gracefully. Detached ones are left running on purpose.
    // Job objects / pdeathsig remain the backstop if the host crashes before getting here.
    public Task ShutdownAsync() => Task.WhenAll(_plugins.Values
        .Where(p => p.Lifetime == Lifetime.Bound)
        .Select(p => p.StopAsync()));
}
