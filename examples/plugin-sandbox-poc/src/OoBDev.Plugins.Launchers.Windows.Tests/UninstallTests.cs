using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Windows;

namespace OoBDev.Plugins.Launchers.Windows.Tests;

/// <summary>Grants persist on disk, so uninstalling a plugin has to take them back.</summary>
[TestClass]
public sealed class UninstallTests(TestContext output) : IDisposable
{
    private const string Id = "escape-uninstall";
    private readonly string _root = Directory.CreateTempSubdirectory("ps-uninstall-").FullName;

    public void Dispose() { try { Directory.Delete(_root, recursive: true); } catch { } }

    /// <summary>Entries on this folder for any AppContainer other than the two well-known "all application packages" groups.</summary>
    private static string[] ContainerEntries(string path) =>
        new DirectoryInfo(path).GetAccessControl().GetAccessRules(true, false, typeof(System.Security.Principal.SecurityIdentifier))
            .Cast<System.Security.AccessControl.FileSystemAccessRule>().Select(r => r.IdentityReference.Value)
            .Where(v => v.StartsWith("S-1-15-2-") && v.Split('-').Length > 8).ToArray();

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Uninstall_removes_the_grants_and_the_container()
    {
        AppContainerLauncher.Uninstall(Id, WindowsLauncherOptions.PerUserRuntimes("python").Append(Paths.Escape));   // start clean
        var rw = Directory.CreateDirectory(Path.Combine(_root, "rw")).FullName;
        var python = WindowsLauncherOptions.PerUserRuntimes("python");
        var watched = python.Append(Paths.Escape).Append(rw).ToArray();

        // control: before uninstalling, the plugin ran, wrote into its grant, and the entries really are on disk
        var cfg = JsonSerializer.SerializeToElement(new { probe = "ok-write-file", path = Path.Combine(rw, "out.txt") });
        var spec = PluginManifest.Load(Paths.Escape, cfg) with { Id = Id, Grants = [new PathGrant(rw, Write: true)] };
        await using (var manager = new PluginManager(
            new AppContainerLauncher(new WindowsLauncherOptions { RuntimeReadPaths = python }),
            new SupervisorOptions { MaxCrashesInWindow = 1, BackoffInitial = TimeSpan.FromMinutes(5) }))
        {
            var got = new TaskCompletionSource<string>(TaskCreationOptions.RunContinuationsAsynchronously);
            manager.Router.EventPublished += e => { if (e.Topic == "escape.result") got.TrySetResult(e.Payload!.Value.GetProperty("outcome").GetString()!); };
            manager.Register(spec).Start();
            Assert.AreEqual("allowed", await got.Task.WaitAsync(TimeSpan.FromSeconds(30)));
        }
        Assert.AreEqual("escaped", File.ReadAllText(Path.Combine(rw, "out.txt")));
        foreach (var path in watched) Assert.IsNotEmpty(ContainerEntries(path));
        var sid = ContainerEntries(rw).Single();
        output.WriteLine($"container {sid} has entries on {watched.Length} folders before uninstall");

        var revoked = AppContainerLauncher.Uninstall(Id);   // from the ledger alone: no extra paths

        Assert.IsTrue(revoked >= watched.Length, $"revoked {revoked} of {watched.Length}");
        foreach (var path in watched) Assert.DoesNotContain(sid, ContainerEntries(path));
        Assert.AreEqual(0, AppContainerLauncher.Uninstall(Id));   // idempotent
    }
}
