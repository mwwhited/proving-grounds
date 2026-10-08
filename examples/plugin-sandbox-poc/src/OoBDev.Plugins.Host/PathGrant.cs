
namespace OoBDev.Plugins.Host;

/// <summary>A folder a sandboxed plugin may use besides its own. Honoured by launchers that sandbox; ignored by the plain one.</summary>
public sealed record PathGrant(string Path, bool Write = false);
