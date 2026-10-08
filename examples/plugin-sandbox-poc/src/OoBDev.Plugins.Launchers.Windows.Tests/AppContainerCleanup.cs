namespace OoBDev.Plugins.Launchers.Windows.Tests;

/// <summary>
/// The tests share one container per plugin id and run sequentially so nobody revokes a grant that another test
/// is using. When they are all done, revoke what they granted (including entries left by runs before the ledger existed).
/// </summary>
[TestClass]
public static class AppContainerCleanup
{
    [AssemblyCleanup]
    public static void RevokeGrants()
    {
        if (OperatingSystem.IsWindows())
            AppContainerLauncher.Uninstall("escape-test", WindowsLauncherOptions.PerUserRuntimes("python").Append(Paths.Escape));
    }
}
