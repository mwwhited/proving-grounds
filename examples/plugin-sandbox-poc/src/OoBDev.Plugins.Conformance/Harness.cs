using System.Collections.Concurrent;
using System.Diagnostics;
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Plain;
using OoBDev.Plugins.Launchers.Linux;
using OoBDev.Plugins.Launchers.Windows;
using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Conformance;

/// <summary>
/// The test-side stand-in for an application using the host: a <see cref="PluginManager"/> running one plugin
/// from <c>plugins/&lt;name&gt;</c> through the plain (unsandboxed) launcher, with every event and session recorded.
/// </summary>
internal sealed class Harness : IAsyncDisposable
{
    private readonly PluginManager _manager;
    private readonly List<Envelope> _events = [];
    private readonly ConcurrentQueue<PluginSession> _sessions = new();

    public ManagedPlugin Plugin { get; }

    public Harness(string pluginName, object? config = null, SupervisorOptions? options = null)
    {
        JsonElement? cfg = config is null ? null : JsonSerializer.SerializeToElement(config);
        var spec = PluginManifest.Load(Paths.Of(pluginName), cfg);
        _manager = new PluginManager(Launcher(), options);
        _manager.Router.EventPublished += e => { lock (_events) _events.Add(e); };
        Plugin = _manager.Register(spec);
        Plugin.SessionCreated += _sessions.Enqueue;
    }

    /// <summary>
    /// Plain by default. <c>PLUGIN_LAUNCHER=appcontainer</c> (Windows) or <c>bubblewrap</c> (Linux) runs the same
    /// checks inside the OS sandbox.
    /// </summary>
    private static IPluginLauncher Launcher()
    {
        var mode = Environment.GetEnvironmentVariable("PLUGIN_LAUNCHER");
        if (OperatingSystem.IsWindows() && string.Equals(mode, "appcontainer", StringComparison.OrdinalIgnoreCase))
            return new AppContainerLauncher(new WindowsLauncherOptions { RuntimeReadPaths = WindowsLauncherOptions.PerUserRuntimes("python", "node", "java", "go") });
        if (OperatingSystem.IsLinux() && string.Equals(mode, "bubblewrap", StringComparison.OrdinalIgnoreCase))
            return new BubblewrapLauncher();
        return new PlainProcessLauncher();
    }

    public Router Router => _manager.Router;

    /// <summary>First session ever launched, even if it has already died.</summary>
    public PluginSession FirstSession
    {
        get
        {
            Until(() => !_sessions.IsEmpty, TimeSpan.FromSeconds(10));
            return _sessions.First();
        }
    }

    public async Task<bool> StartAndWaitRunningAsync(TimeSpan? timeout = null)
    {
        Plugin.Start();
        return await Plugin.WaitForStateAsync(PluginState.Running, timeout ?? TimeSpan.FromSeconds(15));
    }

    public Envelope? WaitEvent(string topic, TimeSpan timeout)
    {
        Envelope? found = null;
        Until(() =>
        {
            lock (_events) found = _events.FirstOrDefault(e => e.Topic == topic);
            return found is not null;
        }, timeout);
        return found;
    }

    public List<Envelope> Events(string topic)
    {
        lock (_events) return _events.Where(e => e.Topic == topic).ToList();
    }

    public static bool Until(Func<bool> condition, TimeSpan timeout)
    {
        var sw = Stopwatch.StartNew();
        while (sw.Elapsed < timeout)
        {
            if (condition()) return true;
            Thread.Sleep(10);
        }
        return condition();
    }

    public ValueTask DisposeAsync() => _manager.DisposeAsync();
}
