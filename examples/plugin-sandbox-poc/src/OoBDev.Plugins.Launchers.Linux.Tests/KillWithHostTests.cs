using System.Diagnostics;

namespace OoBDev.Plugins.Launchers.Linux.Tests;

/// <summary>Plugins must die with the host, however the host dies.</summary>
[TestClass]
public sealed class KillWithHostTests(TestContext output)
{
    private static string HostDll { get; } = FindHost();

    private static string FindHost()
    {
        var self = new DirectoryInfo(AppContext.BaseDirectory);   // .../Launchers.Linux.Tests/bin/Debug/net10.0
        var src = self.Parent!.Parent!.Parent!.Parent!;
        return Path.Combine(src.FullName, "OoBDev.Plugins.Launchers.Linux.TestHost", "bin", self.Parent.Name, self.Name,
            "OoBDev.Plugins.Launchers.Linux.TestHost.dll");
    }

    /// <summary>Host-side pids of every process running the escape plugin's script.</summary>
    private static int[] PluginPids() =>
        Directory.GetDirectories("/proc").Select(d => Path.GetFileName(d)).Where(n => int.TryParse(n, out _))
            .Where(n =>
            {
                try
                {
                    // bwrap/prlimit carry the plugin folder in their arguments; the sandboxed python runs "python plugin.py" from it
                    var cmd = File.ReadAllText($"/proc/{n}/cmdline");
                    return cmd.Contains("escape-python") ||
                           (cmd.Contains("plugin.py") && new FileInfo($"/proc/{n}/cwd").LinkTarget?.EndsWith("escape-python") == true);
                }
                catch { return false; }
            }).Select(int.Parse).ToArray();

    [TestMethod]

    [OSCondition(OperatingSystems.Linux)]
    public async Task Plugin_dies_when_the_host_is_killed()
    {
        Assert.IsTrue(File.Exists(HostDll), "build the TestHost project first: " + HostDll);
        var psi = new ProcessStartInfo("dotnet", $"\"{HostDll}\" \"{Paths.Escape}\"")
        { RedirectStandardInput = true, RedirectStandardOutput = true, UseShellExecute = false };
        using var host = Process.Start(psi)!;
        try
        {
            Assert.AreEqual("ready", await host.StandardOutput.ReadLineAsync());
            await host.StandardInput.WriteLineAsync("go");
            Assert.AreEqual("RUNNING", await host.StandardOutput.ReadLineAsync().WaitAsync(TimeSpan.FromSeconds(30)));
            var pids = PluginPids();
            output.WriteLine($"host {host.Id}, plugin pids {string.Join(",", pids)}");
            Assert.IsNotEmpty(pids);   // control: the plugin is alive before the host dies

            host.Kill();   // SIGKILL: no Dispose, no shutdown frame
            await host.WaitForExitAsync();

            var end = DateTime.UtcNow + TimeSpan.FromSeconds(10);
            while (PluginPids().Length > 0 && DateTime.UtcNow < end) await Task.Delay(100);
            Assert.IsEmpty(PluginPids());
        }
        finally { if (!host.HasExited) host.Kill(); }
    }
}
