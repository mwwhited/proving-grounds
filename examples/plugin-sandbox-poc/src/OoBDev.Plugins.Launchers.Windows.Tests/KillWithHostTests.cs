using System.Diagnostics;
using System.Runtime.InteropServices;

namespace OoBDev.Plugins.Launchers.Windows.Tests;

/// <summary>Plugins must die with the host, however the host dies, including when the host is itself inside a job.</summary>
[TestClass]
public sealed class KillWithHostTests(TestContext output)
{
    private static string HostExe { get; } = FindHost();

    private static string FindHost()
    {
        var self = new DirectoryInfo(AppContext.BaseDirectory);   // .../OoBDev.Plugins.Launchers.Windows.Tests/bin/Debug/net10.0
        var config = self.Parent!.Name;
        var src = self.Parent.Parent!.Parent!.Parent!;
        return Path.Combine(src.FullName, "OoBDev.Plugins.Launchers.Windows.TestHost", "bin", config, self.Name,
            "OoBDev.Plugins.Launchers.Windows.TestHost.exe");
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public Task Plugin_dies_when_the_host_is_killed() => RunAsync(nestedJob: false);

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public Task Plugin_dies_when_the_host_is_killed_inside_a_parent_job() => RunAsync(nestedJob: true);

    private async Task RunAsync(bool nestedJob)
    {
        Assert.IsTrue(File.Exists(HostExe), "build the TestHost project first: " + HostExe);
        var psi = new ProcessStartInfo(HostExe, $"\"{Paths.Escape}\"")
        {
            RedirectStandardInput = true, RedirectStandardOutput = true, UseShellExecute = false, CreateNoWindow = true,
        };
        using var host = Process.Start(psi)!;
        IntPtr job = 0;
        try
        {
            Assert.AreEqual("ready", await host.StandardOutput.ReadLineAsync());
            if (nestedJob)
            {
                // an outer job (as a CI runner or a service manager would have) around the host before it starts the plugin
                job = CreateJobObjectW(IntPtr.Zero, null);
                Assert.AreNotEqual(IntPtr.Zero, job);
                Assert.IsTrue(AssignProcessToJobObject(job, host.Handle), "could not put the host in a job: " + Marshal.GetLastWin32Error());
            }
            await host.StandardInput.WriteLineAsync("go");
            var line = await host.StandardOutput.ReadLineAsync().WaitAsync(TimeSpan.FromSeconds(30));
            Assert.StartsWith("PID ", line);
            int pluginPid = int.Parse(line![4..]);
            output.WriteLine($"host {host.Id}, plugin {pluginPid}, nested job: {nestedJob}");

            using var plugin = Process.GetProcessById(pluginPid);   // control: the plugin is alive before the host dies
            Assert.IsFalse(plugin.HasExited);

            host.Kill();   // abrupt: no Dispose, no shutdown frame
            await host.WaitForExitAsync();

            Assert.IsTrue(await WaitGoneAsync(pluginPid, TimeSpan.FromSeconds(10)), "the plugin outlived its host");
        }
        finally
        {
            if (!host.HasExited) host.Kill();
            if (job != 0) CloseHandle(job);
        }
    }

    private static async Task<bool> WaitGoneAsync(int pid, TimeSpan timeout)
    {
        var end = DateTime.UtcNow + timeout;
        while (DateTime.UtcNow < end)
        {
            try { using var p = Process.GetProcessById(pid); if (p.HasExited) return true; }
            catch (ArgumentException) { return true; }
            await Task.Delay(100);
        }
        return false;
    }

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)] private static extern IntPtr CreateJobObjectW(IntPtr attrs, string? name);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool AssignProcessToJobObject(IntPtr job, IntPtr proc);
    [DllImport("kernel32.dll")] private static extern bool CloseHandle(IntPtr h);
}
