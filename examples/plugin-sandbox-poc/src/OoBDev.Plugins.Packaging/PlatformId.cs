using System.Runtime.InteropServices;

namespace OoBDev.Plugins.Packaging;

/// <summary>The platform names a package uses for its folders and manifest entries (design §3).</summary>
public static class PlatformId
{
    /// <summary>
    /// <c>win-x64</c>, <c>win-arm64</c>, <c>linux-x64</c>, <c>linux-arm64</c> or <c>osx-universal</c>; otherwise <c>unknown</c>.
    /// There is no musl detection: <c>linux-musl-x64</c> would have to be asked for explicitly.
    /// </summary>
    public static string Current { get; } = Of(RuntimeInformation.ProcessArchitecture);

    public static string Of(Architecture arch)
    {
        if (OperatingSystem.IsMacOS()) return "osx-universal";
        var os = OperatingSystem.IsWindows() ? "win" : OperatingSystem.IsLinux() ? "linux" : null;
        var cpu = arch switch { Architecture.X64 => "x64", Architecture.Arm64 => "arm64", _ => null };
        return os is null || cpu is null ? "unknown" : $"{os}-{cpu}";
    }
}
