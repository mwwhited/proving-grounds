namespace OoBDev.Plugins.Protocol;

public readonly record struct FrameReadResult(
    FrameReadKind Kind, Envelope? Envelope = null, string? Reason = null, bool Truncated = false);
