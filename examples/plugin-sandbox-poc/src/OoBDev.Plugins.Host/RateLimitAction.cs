
namespace OoBDev.Plugins.Host;

public enum RateLimitAction
{
    /// <summary>Discard frames over the limit and count them.</summary>
    Drop,
    /// <summary>Treat exceeding the limit as a violation: kill the plugin.</summary>
    Disconnect,
}
