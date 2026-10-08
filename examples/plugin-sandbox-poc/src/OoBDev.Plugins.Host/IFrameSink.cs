using OoBDev.Plugins.Protocol;

namespace OoBDev.Plugins.Host;

/// <summary>Where a session hands the frames it does not handle itself.</summary>
public interface IFrameSink
{
    public ValueTask OnFrameAsync(PluginSession from, Envelope frame);
}
