using Xunit;

namespace OoBDev.Plugins.Launchers.Linux.Tests;

/// <summary>A fact that is skipped (not failed) when the suite is run on another OS, so the whole solution can be tested anywhere.</summary>
public sealed class LinuxFactAttribute : FactAttribute
{
    public LinuxFactAttribute() { if (!OperatingSystem.IsLinux()) Skip = "Linux only"; }
}
