using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Windows;

namespace OoBDev.Plugins.Launchers.Windows.Tests;

/// <summary>
/// Escape tests for the AppContainer launcher. Each test runs <c>plugins/escape-python</c> with one hostile probe
/// and checks what the OS let it do. Every "denied" test has a positive control (an "ok-" probe or the whoami
/// probe) so a broken probe cannot make the sandbox look tighter than it is.
/// </summary>
[TestClass]
public sealed class EscapeTests(TestContext output) : IDisposable
{
    private const string PluginId = "escape-test";
    private const string HostSecretName = "PLUGIN_ESCAPE_SECRET";

    private readonly string _root = Directory.CreateTempSubdirectory("ps-escape-").FullName;

    public void Dispose()
    {
        try { Directory.Delete(_root, recursive: true); } catch { }
    }

    private string Dir(string name, string? file = null, string content = "hello")
    {
        var d = Directory.CreateDirectory(Path.Combine(_root, name)).FullName;
        if (file is not null) File.WriteAllText(Path.Combine(d, file), content);
        return d;
    }

    private async Task<ProbeResult> RunAsync(object probe, IReadOnlyList<PathGrant>? grants = null, PluginLimits? limits = null,
        TimeSpan? timeout = null, string? id = null, bool unsandboxed = false)
    {
        var cfg = JsonSerializer.SerializeToElement(probe);
        var spec = PluginManifest.Load(Paths.Escape, cfg) with
        {
            Id = id ?? PluginId,
            Grants = grants ?? [],
            Limits = limits ?? new PluginLimits(),
        };
        // a short restart backoff would hide a killed plugin behind a second launch; one attempt is what we want to see
        await using var manager = new PluginManager(
            unsandboxed ? new OoBDev.Plugins.Launchers.Plain.PlainProcessLauncher()
                : new AppContainerLauncher(new WindowsLauncherOptions { RuntimeReadPaths = WindowsLauncherOptions.PerUserRuntimes("python") }),
            new SupervisorOptions { MaxCrashesInWindow = 1, BackoffInitial = TimeSpan.FromMinutes(5) });
        var got = new TaskCompletionSource<JsonElement>(TaskCreationOptions.RunContinuationsAsynchronously);
        manager.Router.EventPublished += e => { if (e.Topic == "escape.result") got.TrySetResult(e.Payload!.Value.Clone()); };
        var plugin = manager.Register(spec);
        plugin.Start();

        var wait = timeout ?? TimeSpan.FromSeconds(20);
        var done = await Task.WhenAny(got.Task, Task.Delay(wait));
        if (done == got.Task)
        {
            var p = got.Task.Result;
            var result = new ProbeResult(p.GetProperty("outcome").GetString()!, p.GetProperty("detail").GetString()!, null);
            output.WriteLine($"{p.GetProperty("probe").GetString()}: {result.Outcome}  {result.Detail}");
            return result;
        }
        // no result: the plugin was killed (or never started); report how it ended
        var end = DateTime.UtcNow + TimeSpan.FromSeconds(3);
        while (plugin.Exits.Count == 0 && DateTime.UtcNow < end) await Task.Delay(50);
        var exit = plugin.Exits.FirstOrDefault();
        output.WriteLine($"no result; exit: {exit}");
        return new ProbeResult("none", "", exit, plugin.History.Contains(PluginState.Running));
    }

    private static void Denied(ProbeResult r) => Assert.IsTrue(r is { Outcome: "denied" }, $"expected denied, got {r.Outcome} {r.Detail} {r.Exit}");
    private static void Allowed(ProbeResult r) => Assert.IsTrue(r is { Outcome: "allowed" }, $"expected allowed, got {r.Outcome} {r.Detail} {r.Exit}");

    // ---- the token really is an AppContainer ----

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_the_plugin_runs_in_an_appcontainer()
    {
        var r = await RunAsync(new { probe = "whoami" });
        Allowed(r);
        Assert.AreEqual("appcontainer", r.Detail);
    }

    // ---- files ----

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_a_granted_folder_can_be_read_listed_and_written()
    {
        var ro = Dir("ro", "hello.txt", "granted-content");
        var rw = Dir("rw");
        var grants = new PathGrant[] { new(ro), new(rw, Write: true) };
        var read = await RunAsync(new { probe = "ok-read-file", path = Path.Combine(ro, "hello.txt") }, grants);
        Allowed(read);
        Assert.StartsWith("granted-content", read.Detail);
        Allowed(await RunAsync(new { probe = "ok-list-dir", path = ro }, grants));
        var target = Path.Combine(rw, "out.txt");
        Allowed(await RunAsync(new { probe = "ok-write-file", path = target }, grants));
        Assert.AreEqual("escaped", File.ReadAllText(target));   // written by the plugin to the one place it was given
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_file_outside_every_grant_cannot_be_read()
    {
        var secret = Dir("secret", "secret.txt", "top-secret");
        Dir("ro", "hello.txt");
        Denied(await RunAsync(new { probe = "read-file", path = Path.Combine(secret, "secret.txt") }, [new PathGrant(Path.Combine(_root, "ro"))]));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_folder_outside_every_grant_cannot_be_listed()
    {
        var secret = Dir("secret", "secret.txt");
        Denied(await RunAsync(new { probe = "list-dir", path = secret }));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task The_users_own_files_cannot_be_read()
    {
        var docs = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        Denied(await RunAsync(new { probe = "list-dir", path = docs }));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_read_only_grant_cannot_be_written()
    {
        var ro = Dir("ro", "hello.txt");
        var target = Path.Combine(ro, "evil.txt");
        Denied(await RunAsync(new { probe = "write-file", path = target }, [new PathGrant(ro)]));
        Assert.IsFalse(File.Exists(target));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task The_plugins_own_folder_cannot_be_modified()
    {
        // the launcher grants the plugin folder read+execute only; a plugin must not be able to rewrite its own code
        var target = Path.Combine(Paths.Escape, "planted.txt");
        try
        {
            Denied(await RunAsync(new { probe = "write-file", path = target }));
            Assert.IsFalse(File.Exists(target));
        }
        finally { if (File.Exists(target)) File.Delete(target); }
    }

    // ---- network ----

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_loopback_is_reachable_without_the_sandbox()
    {
        // the positive control for the two network tests: the listener works and a plain process can reach it
        using var listener = new TcpListener(IPAddress.Loopback, 0);
        listener.Start();
        using var c = new TcpClient();
        await c.ConnectAsync(IPAddress.Loopback, ((IPEndPoint)listener.LocalEndpoint).Port);
        Assert.IsTrue(c.Connected);
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Loopback_services_on_the_host_machine_cannot_be_reached()
    {
        using var listener = new TcpListener(IPAddress.Loopback, 0);
        listener.Start();
        int port = ((IPEndPoint)listener.LocalEndpoint).Port;
        var accepted = listener.AcceptTcpClientAsync();
        Denied(await RunAsync(new { probe = "connect", host = "127.0.0.1", port }));
        Assert.IsFalse(accepted.IsCompleted, "the listener saw a connection from the plugin");
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task The_internet_cannot_be_reached()
    {
        Denied(await RunAsync(new { probe = "connect", host = "1.1.1.1", port = 443 }));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_names_resolve_without_the_sandbox()
    {
        Assert.IsNotEmpty(await Dns.GetHostAddressesAsync("example.com"));   // so a failed lookup below is the sandbox, not a dead network
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Names_cannot_be_resolved()
    {
        Denied(await RunAsync(new { probe = "resolve", host = "example.com" }));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task The_plugin_holds_only_its_three_channel_pipes()
    {
        var r = await RunAsync(new { probe = "handles" });
        Allowed(r);
        output.WriteLine(r.Detail);
        // stdin, stdout, stderr: its own channel and no pipe of the host or a peer plugin. Disk and other handles are the
        // runtime's own (script, DLLs, events) and cannot be told from inherited ones by counting, so they are not asserted.
        Assert.Contains("pipe=3", r.Detail);
    }

    // ---- a peer plugin ----

    /// <summary>Runs a victim plugin and a second plugin together; returns the victim's real pid and what the second one saw.</summary>
    private async Task<(int VictimPid, ProbeResult Peer)> RunWithPeerAsync()
    {
        await using var manager = new PluginManager(
            new AppContainerLauncher(new WindowsLauncherOptions { RuntimeReadPaths = WindowsLauncherOptions.PerUserRuntimes("python") }),
            new SupervisorOptions { MaxCrashesInWindow = 1, BackoffInitial = TimeSpan.FromMinutes(5) });
        var results = new System.Collections.Concurrent.ConcurrentDictionary<string, TaskCompletionSource<JsonElement>>();
        TaskCompletionSource<JsonElement> Slot(string probe) => results.GetOrAdd(probe, _ => new(TaskCreationOptions.RunContinuationsAsynchronously));
        manager.Router.EventPublished += e => { if (e.Topic == "escape.result") Slot(e.Payload!.Value.GetProperty("probe").GetString()!).TrySetResult(e.Payload!.Value.Clone()); };

        PluginSpec Spec(string id, object probe) => PluginManifest.Load(Paths.Escape, JsonSerializer.SerializeToElement(probe)) with { Id = id };
        manager.Register(Spec("victim", new { probe = "pid" })).Start();
        var v = await Slot("pid").Task.WaitAsync(TimeSpan.FromSeconds(20));
        var pid = int.Parse(v.GetProperty("detail").GetString()!);

        manager.Register(Spec("peer", new { probe = "open-process", pid })).Start();
        var p = await Slot("open-process").Task.WaitAsync(TimeSpan.FromSeconds(20));
        var peer = new ProbeResult(p.GetProperty("outcome").GetString()!, p.GetProperty("detail").GetString()!, null);
        output.WriteLine($"victim pid {pid}; peer: {peer.Outcome} {peer.Detail}");
        // the victim must still be alive for the denial to mean anything
        Assert.IsFalse(Process.GetProcessById(pid).HasExited);
        Assert.IsTrue(Process.GetProcessById(pid).StartTime > DateTime.MinValue);   // control: the host can open that pid
        return (pid, peer);
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_plugin_cannot_open_another_running_plugins_process()
    {
        var (_, peer) = await RunWithPeerAsync();
        Denied(peer);
    }

    // ---- processes ----

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_plugin_cannot_start_a_child_process()
    {
        Denied(await RunAsync(new { probe = "spawn" }));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_without_the_sandbox_a_plugin_can_start_many_children()
    {
        var r = await RunAsync(new { probe = "spawnloop", n = 20 }, unsandboxed: true, timeout: TimeSpan.FromSeconds(60));
        Allowed(r);
        Assert.StartsWith("20 of 20", r.Detail);
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_plugin_cannot_start_children_in_a_loop()
    {
        var r = await RunAsync(new { probe = "spawnloop", n = 200 }, timeout: TimeSpan.FromSeconds(60));
        Denied(r);
        Assert.Contains("0 of 200", r.Detail);
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task The_host_process_cannot_be_opened()
    {
        Denied(await RunAsync(new { probe = "open-process", pid = Environment.ProcessId }));
    }

    // ---- environment and registry ----

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Host_environment_variables_are_not_inherited()
    {
        Environment.SetEnvironmentVariable(HostSecretName, "s3cret-from-host");
        try { Denied(await RunAsync(new { probe = "read-env", name = HostSecretName })); }
        finally { Environment.SetEnvironmentVariable(HostSecretName, null); }
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task The_users_registry_hive_cannot_be_written()
    {
        try { Denied(await RunAsync(new { probe = "registry-write" })); }
        finally
        {
            using var k = Microsoft.Win32.Registry.CurrentUser.OpenSubKey(@"Software\OoBDevEscapeProbe");
            if (k is not null) Microsoft.Win32.Registry.CurrentUser.DeleteSubKeyTree(@"Software\OoBDevEscapeProbe");
        }
    }

    // ---- resources ----

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_a_plugin_without_a_memory_limit_can_allocate_300_MB()
    {
        Allowed(await RunAsync(new { probe = "allocate", mb = 300 }));
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_memory_limit_kills_a_plugin_that_exceeds_it()
    {
        var r = await RunAsync(new { probe = "allocate", mb = 300 }, limits: new PluginLimits { MemoryBytes = 150L * 1024 * 1024 });
        // python raises MemoryError (reported as denied) or the OS ends the process (no result): never "allowed"
        Assert.AreNotEqual("allowed", r.Outcome);
        Assert.IsTrue(r.Started, "the plugin never started, so this proved nothing: " + r.Exit);
    }

    private static double Share(ProbeResult r) => double.Parse(r.Detail.Split(' ').Last(), System.Globalization.CultureInfo.InvariantCulture);

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task Control_a_plugin_without_a_cpu_cap_gets_most_of_a_core()
    {
        var r = await RunAsync(new { probe = "spin", seconds = 3 });
        Allowed(r);
        Assert.IsTrue(Share(r) > 0.7, r.Detail);
    }

    [TestMethod]

    [OSCondition(OperatingSystems.Windows)]
    public async Task A_cpu_cap_limits_a_busy_plugin()
    {
        // 5% of the whole machine is well under one core on any machine with 8 or fewer logical processors
        var r = await RunAsync(new { probe = "spin", seconds = 3 }, limits: new PluginLimits { CpuPercent = Math.Max(1, 100 / Environment.ProcessorCount / 4) },
            timeout: TimeSpan.FromSeconds(30));
        Allowed(r);
        Assert.IsTrue(Share(r) < 0.5, r.Detail);
    }
}
