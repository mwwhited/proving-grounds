
namespace OoBDev.Plugins.Host;

/// <summary>What a plugin may do on the bus. Default deny: anything not listed is refused.</summary>
public sealed record PluginPolicy(
    IReadOnlyList<string> Publish,
    IReadOnlyList<string> Subscribe,
    IReadOnlyList<string> SendTo)
{
    public static PluginPolicy DenyAll { get; } = new([], [], []);
}
