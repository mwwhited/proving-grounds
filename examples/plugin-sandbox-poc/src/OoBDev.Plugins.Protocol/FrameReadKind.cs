namespace OoBDev.Plugins.Protocol;

public enum FrameReadKind
{
    /// <summary>A complete, valid envelope.</summary>
    Frame,
    /// <summary>The peer closed the stream (cleanly between frames, or mid-frame when <see cref="FrameReadResult.Truncated"/>).</summary>
    EndOfStream,
    /// <summary>The peer broke the protocol (oversize frame, bad body). The host disconnects.</summary>
    Violation,
}
