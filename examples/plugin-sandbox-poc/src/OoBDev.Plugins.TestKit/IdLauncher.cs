using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.TestKit;

/// <summary>Launches the script registered for the plugin's id.</summary>
public sealed class IdLauncher(Dictionary<string, PluginScript> scripts) : IPluginLauncher
{
    public ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct)
        => new FakeLauncher(scripts[spec.Id]).LaunchAsync(spec, ct);
}
