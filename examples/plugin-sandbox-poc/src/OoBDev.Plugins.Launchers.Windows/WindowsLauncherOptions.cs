using System.ComponentModel;
using System.Security.AccessControl;
using System.Security.Principal;
using Microsoft.Win32.SafeHandles;

namespace OoBDev.Plugins.Launchers.Windows;

public sealed class WindowsLauncherOptions
{
    /// <summary>Folders the plugin's runtime needs that AppContainers cannot read by default (a per-user Python install, for example).</summary>
    public IReadOnlyList<string> RuntimeReadPaths { get; init; } = [];

    /// <summary>
    /// Read grants for runtimes installed per user (python, node, ...), found on PATH. System-wide installs under
    /// Program Files are already readable by every AppContainer and are left alone.
    /// </summary>
    public static IReadOnlyList<string> PerUserRuntimes(params string[] tools)
    {
        var profile = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        var path = (Environment.GetEnvironmentVariable("PATH") ?? "").Split(Path.PathSeparator);
        return tools
            .Select(t => path.FirstOrDefault(d => d.Length > 0 && File.Exists(Path.Combine(d, t + ".exe"))))
            .Where(d => d is not null && d.StartsWith(profile, StringComparison.OrdinalIgnoreCase))
            .Select(d => d!).Distinct().ToList();
    }

    /// <summary>Stricter variant: also drop the ALL APPLICATION PACKAGES group, so every system path must be granted.</summary>
    public bool UseLpac { get; init; }
}
