using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.Packaging;

/// <summary>A verified, extracted package: the spec to launch and where it lives.</summary>
public sealed record InstalledPlugin(PluginSpec Spec, string Directory, string Platform);
