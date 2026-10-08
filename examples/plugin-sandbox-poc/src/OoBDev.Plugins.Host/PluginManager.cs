using System.Collections.Concurrent;

namespace OoBDev.Plugins.Host;

/// <summary>Owns the plugins of one host: registration, start/stop by id, and host shutdown.</summary>
public sealed class PluginManager : IAsyncDisposable
{
    private readonly ConcurrentDictionary<string, ManagedPlugin> _plugins = new();
    private readonly IPluginLauncher _launcher;
    private readonly SupervisorOptions _options;

    public PluginManager(IPluginLauncher launcher, SupervisorOptions? options = null, Router? router = null)
    {
        _launcher = launcher;
        _options = options ?? new SupervisorOptions();
        Router = router ?? new Router(_options.Time);
    }

    public Router Router { get; }

    public IEnumerable<ManagedPlugin> Plugins => _plugins.Values;

    public ManagedPlugin Register(PluginSpec spec)
    {
        if (spec.Lifetime == Lifetime.Detached)
            throw new NotSupportedException("Detached plugins arrive in phase 7; only Bound is implemented.");

        var plugin = new ManagedPlugin(spec, _launcher, Router, _options);
        if (!_plugins.TryAdd(spec.Id, plugin))
            throw new InvalidOperationException($"plugin '{spec.Id}' is already registered");
        Router.Register(spec);
        return plugin;
    }

    public ManagedPlugin Get(string id) => _plugins.TryGetValue(id, out var p)
        ? p : throw new KeyNotFoundException($"plugin '{id}' is not registered");

    public void Start(string id) => Get(id).Start();
    public Task StopAsync(string id) => Get(id).StopAsync();
    public Task RestartAsync(string id) => Get(id).RestartAsync();
    public PluginState GetState(string id) => Get(id).State;

    /// <summary>Host shutdown: stops Bound plugins gracefully. Detached ones will be left running on purpose.</summary>
    public Task ShutdownAsync() => Task.WhenAll(_plugins.Values
        .Where(p => p.Spec.Lifetime == Lifetime.Bound)
        .Select(p => p.StopAsync()));

    public async ValueTask DisposeAsync() => await ShutdownAsync().ConfigureAwait(false);
}
