using Xunit;

namespace OoBDev.Plugins.Launchers.Windows.Tests;

/// <summary>A fact that is skipped (not failed) when the suite is run on another OS, so the whole solution can be tested anywhere.</summary>
public sealed class WindowsFactAttribute : FactAttribute
{
    public WindowsFactAttribute() { if (!OperatingSystem.IsWindows()) Skip = "Windows only"; }
}
