
namespace OoBDev.Plugins.Host;

/// <summary>Bound plugins die with the host. Detached ones survive it (not implemented before phase 7).</summary>
public enum Lifetime { Bound, Detached }
