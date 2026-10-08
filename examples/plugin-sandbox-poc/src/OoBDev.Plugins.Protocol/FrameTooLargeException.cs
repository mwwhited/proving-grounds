namespace OoBDev.Plugins.Protocol;

public sealed class FrameTooLargeException(int size, int max)
    : InvalidOperationException($"frame body of {size} bytes exceeds the {max} byte limit")
{
    public int Size { get; } = size;
    public int Max { get; } = max;
}
