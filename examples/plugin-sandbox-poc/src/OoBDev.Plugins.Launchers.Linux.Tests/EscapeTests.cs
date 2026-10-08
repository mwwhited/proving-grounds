using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Linux;
using Xunit;
using Xunit.Abstractions;

namespace OoBDev.Plugins.Launchers.Linux.Tests;

static class Paths
{
    public static string Escape { get; } = Find("escape-python");

    static string Find(string plugin)
    {
        for (var dir = new DirectoryInfo(AppContext.BaseDirectory); dir is not null; dir = dir.Parent)
        {
            var candidate = Path.Combine(dir.FullName, "plugins", plugin);
            if (Directory.Exists(candidate)) return candidate;
        }
        throw new DirectoryNotFoundException(plugin);
    }
}

public sealed record ProbeResult(string Outcome, string Detail, ExitRecord? Exit, bool Started = true);

/// <summary>
/// Escape tests for the bubblewrap launcher: <c>plugins/escape-python</c> runs one hostile probe per test and the
/// test checks what the OS let it do. Every "denied" test has a positive control. The Windows suite's registry
/// probe has no Linux equivalent; the host-process probe reads /proc/&lt;host pid&gt;/environ instead.
/// Needs unprivileged user namespaces (Docker: run with <c>--security-opt seccomp=unconfined</c>).
/// </summary>
public sealed class EscapeTests(ITestOutputHelper output) : IDisposable
{
    const string HostSecretName = "PLUGIN_ESCAPE_SECRET";
    readonly string _root = Directory.CreateTempSubdirectory("ps-escape-").FullName;

    public void Dispose() { try { Directory.Delete(_root, recursive: true); } catch { } }

    string Dir(string name, string? file = null, string content = "hello")
    {
        var d = Directory.CreateDirectory(Path.Combine(_root, name)).FullName;
        if (file is not null) File.WriteAllText(Path.Combine(d, file), content);
        return d;
    }

    async Task<ProbeResult> RunAsync(object probe, IReadOnlyList<PathGrant>? grants = null, PluginLimits? limits = null,
        LinuxLauncherOptions? options = null, bool unsandboxed = false)
    {
        var cfg = JsonSerializer.SerializeToElement(probe);
        var spec = PluginManifest.Load(Paths.Escape, cfg) with
        {
            Id = "escape-test", Grants = grants ?? [], Limits = limits ?? new PluginLimits(),
        };
        await using var manager = new PluginManager(unsandboxed ? new OoBDev.Plugins.Launchers.Plain.PlainProcessLauncher() : new BubblewrapLauncher(options),
            new SupervisorOptions { MaxCrashesInWindow = 1, BackoffInitial = TimeSpan.FromMinutes(5) });
        var got = new TaskCompletionSource<JsonElement>(TaskCreationOptions.RunContinuationsAsynchronously);
        manager.Router.EventPublished += e => { if (e.Topic == "escape.result") got.TrySetResult(e.Payload!.Value.Clone()); };
        var plugin = manager.Register(spec);
        plugin.Start();

        var done = await Task.WhenAny(got.Task, Task.Delay(TimeSpan.FromSeconds(20)));
        if (done == got.Task)
        {
            var p = got.Task.Result;
            var result = new ProbeResult(p.GetProperty("outcome").GetString()!, p.GetProperty("detail").GetString()!, null);
            output.WriteLine($"{p.GetProperty("probe").GetString()}: {result.Outcome}  {result.Detail}");
            return result;
        }
        var end = DateTime.UtcNow + TimeSpan.FromSeconds(3);
        while (plugin.Exits.Count == 0 && DateTime.UtcNow < end) await Task.Delay(50);
        var exit = plugin.Exits.FirstOrDefault();
        output.WriteLine($"no result; exit: {exit}");
        return new ProbeResult("none", "", exit, plugin.History.Contains(PluginState.Running));
    }

    static void Denied(ProbeResult r) => Assert.True(r is { Outcome: "denied" }, $"expected denied, got {r.Outcome} {r.Detail} {r.Exit}");
    static void Allowed(ProbeResult r) => Assert.True(r is { Outcome: "allowed" }, $"expected allowed, got {r.Outcome} {r.Detail} {r.Exit}");

    [LinuxFact]
    public async Task Control_the_plugin_runs_in_a_pid_namespace()
    {
        var r = await RunAsync(new { probe = "whoami" });
        Allowed(r);
        Assert.Equal("pidns", r.Detail);
    }

    [LinuxFact]
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
        Assert.Equal("escaped", File.ReadAllText(target));
    }

    [LinuxFact]
    public async Task A_file_outside_every_grant_cannot_be_read()
    {
        var secret = Dir("secret", "secret.txt", "top-secret");
        Denied(await RunAsync(new { probe = "read-file", path = Path.Combine(secret, "secret.txt") }, [new PathGrant(Dir("ro", "hello.txt"))]));
    }

    [LinuxFact]
    public async Task A_folder_outside_every_grant_cannot_be_listed() =>
        Denied(await RunAsync(new { probe = "list-dir", path = Dir("secret", "secret.txt") }));

    [LinuxFact]
    public async Task The_users_own_files_cannot_be_read()
    {
        var home = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        Directory.CreateDirectory(home);
        Denied(await RunAsync(new { probe = "list-dir", path = home }));
    }

    [LinuxFact]
    public async Task Etc_passwd_and_shadow_are_not_visible()
    {
        Denied(await RunAsync(new { probe = "read-file", path = "/etc/passwd" }));
        Denied(await RunAsync(new { probe = "read-file", path = "/etc/shadow" }));
    }

    [LinuxFact]
    public async Task A_read_only_grant_cannot_be_written()
    {
        var ro = Dir("ro", "hello.txt");
        var target = Path.Combine(ro, "evil.txt");
        Denied(await RunAsync(new { probe = "write-file", path = target }, [new PathGrant(ro)]));
        Assert.False(File.Exists(target));
    }

    [LinuxFact]
    public async Task The_plugins_own_folder_cannot_be_modified()
    {
        var target = Path.Combine(Paths.Escape, "planted.txt");
        try
        {
            Denied(await RunAsync(new { probe = "write-file", path = target }));
            Assert.False(File.Exists(target));
        }
        finally { if (File.Exists(target)) File.Delete(target); }
    }

    [LinuxFact]
    public async Task Control_loopback_is_reachable_without_the_sandbox()
    {
        using var listener = new TcpListener(IPAddress.Loopback, 0);
        listener.Start();
        using var c = new TcpClient();
        await c.ConnectAsync(IPAddress.Loopback, ((IPEndPoint)listener.LocalEndpoint).Port);
        Assert.True(c.Connected);
    }

    [LinuxFact]
    public async Task Loopback_services_on_the_host_machine_cannot_be_reached()
    {
        using var listener = new TcpListener(IPAddress.Loopback, 0);
        listener.Start();
        var accepted = listener.AcceptTcpClientAsync();
        Denied(await RunAsync(new { probe = "connect", host = "127.0.0.1", port = ((IPEndPoint)listener.LocalEndpoint).Port }));
        Assert.False(accepted.IsCompleted, "the listener saw a connection from the plugin");
    }

    [LinuxFact]
    public async Task The_internet_cannot_be_reached() =>
        Denied(await RunAsync(new { probe = "connect", host = "1.1.1.1", port = 443 }));

    [LinuxFact]
    public async Task Control_names_resolve_without_the_sandbox() =>
        Assert.NotEmpty(await Dns.GetHostAddressesAsync("example.com"));   // so a failed lookup below is the sandbox, not a dead network

    [LinuxFact]
    public async Task Names_cannot_be_resolved() =>
        Denied(await RunAsync(new { probe = "resolve", host = "example.com" }));

    [LinuxFact]
    public async Task The_plugin_holds_only_its_three_channel_pipes_and_nothing_else()
    {
        var r = await RunAsync(new { probe = "handles" });
        Allowed(r);
        output.WriteLine(r.Detail);
        Assert.Contains("pipe=3", r.Detail);
        Assert.DoesNotContain("socket=", r.Detail);
        Assert.DoesNotContain("other=", r.Detail);
    }

    // ---- a peer plugin ----

    [LinuxFact]
    public async Task A_plugin_cannot_see_another_running_plugins_process()
    {
        await using var manager = new PluginManager(new BubblewrapLauncher(),
            new SupervisorOptions { MaxCrashesInWindow = 1, BackoffInitial = TimeSpan.FromMinutes(5) });
        var results = new System.Collections.Concurrent.ConcurrentDictionary<string, TaskCompletionSource<JsonElement>>();
        TaskCompletionSource<JsonElement> Slot(string probe) => results.GetOrAdd(probe, _ => new(TaskCreationOptions.RunContinuationsAsynchronously));
        manager.Router.EventPublished += e => { if (e.Topic == "escape.result") Slot(e.Payload!.Value.GetProperty("probe").GetString()!).TrySetResult(e.Payload!.Value.Clone()); };

        PluginSpec Spec(string id, object probe) => PluginManifest.Load(Paths.Escape, JsonSerializer.SerializeToElement(probe)) with { Id = id };
        manager.Register(Spec("victim", new { probe = "pid" })).Start();
        await Slot("pid").Task.WaitAsync(TimeSpan.FromSeconds(20));

        // the victim's pid in the host's /proc: its python process, found by command line
        var victims = Directory.EnumerateDirectories("/proc").Select(d => Path.GetFileName(d)).Where(n => int.TryParse(n, out _))
            .Where(n => { try { return File.ReadAllText($"/proc/{n}/cmdline").Contains("escape-python") && File.ReadAllText($"/proc/{n}/cmdline").Contains("plugin.py"); } catch { return false; } })
            .Select(int.Parse).ToList();
        Assert.NotEmpty(victims);
        // control: the host (same user, no namespace) can read the victim's environment
        Assert.All(victims, p => Assert.NotNull(File.ReadAllBytes($"/proc/{p}/environ")));

        manager.Register(Spec("peer", new { probe = "open-process", pid = victims[0] })).Start();
        var r = await Slot("open-process").Task.WaitAsync(TimeSpan.FromSeconds(20));
        output.WriteLine($"victim pids {string.Join(',', victims)}; peer: {r.GetProperty("outcome").GetString()} {r.GetProperty("detail").GetString()}");
        Assert.Equal("denied", r.GetProperty("outcome").GetString());
    }

    [System.Runtime.InteropServices.DllImport("libc", SetLastError = true)] static extern int dup(int fd);
    [System.Runtime.InteropServices.DllImport("libc", SetLastError = true)] static extern int close(int fd);

    /// <summary>Leaks a descriptor the way a library that opens files without close-on-exec does (dup clears the flag).</summary>
    async Task<ProbeResult> RunWithLeakedFdAsync(bool unsandboxed)
    {
        using var f = File.OpenRead("/etc/hostname");
        var leaked = dup((int)f.SafeFileHandle.DangerousGetHandle());
        Assert.True(leaked > 2);
        try { return await RunAsync(new { probe = "handles" }, unsandboxed: unsandboxed); }
        finally { close(leaked); }
    }

    [LinuxFact]
    public async Task Control_a_descriptor_the_host_leaks_reaches_an_unsandboxed_plugin()
    {
        var r = await RunWithLeakedFdAsync(unsandboxed: true);
        Allowed(r);
        Assert.Contains("hostname", r.Detail);
    }

    [LinuxFact]
    public async Task A_descriptor_the_host_leaks_does_not_reach_the_plugin()
    {
        var r = await RunWithLeakedFdAsync(unsandboxed: false);
        Allowed(r);
        Assert.DoesNotContain("hostname", r.Detail);
        Assert.Contains("pipe=3", r.Detail);
    }

    // ---- processes: threads yes, new processes no ----

    [LinuxFact]
    public async Task Control_threads_still_work_under_the_filter()
    {
        var r = await RunAsync(new { probe = "threads", n = 16 });
        Allowed(r);
        Assert.Equal("ran 16 threads", r.Detail);
    }

    [LinuxFact]
    public async Task Control_a_plugin_that_is_allowed_children_can_start_one() =>
        Allowed(await RunAsync(new { probe = "spawn" }, options: new LinuxLauncherOptions { AllowChildProcesses = true }));

    [LinuxFact]
    public async Task By_default_a_plugin_cannot_start_a_child_process() =>
        Denied(await RunAsync(new { probe = "spawn" }));

    [LinuxFact]
    public async Task By_default_a_plugin_cannot_fork()
    {
        var r = await RunAsync(new { probe = "forkbomb" });
        Denied(r);
        Assert.Contains("PermissionError", r.Detail);
    }

    [LinuxFact]
    public async Task A_task_limit_contains_a_fork_bomb_when_children_are_allowed()
    {
        var r = await RunAsync(new { probe = "forkbomb", max = 300 },
            options: new LinuxLauncherOptions { AllowChildProcesses = true, MaxTasks = 40 });
        Allowed(r);                                       // control: forking works at all...
        var forked = int.Parse(r.Detail.Split(' ')[1]);
        Assert.InRange(forked, 5, 40);                    // ...and stops at the cap, far short of the 300 attempted
        Assert.DoesNotContain("reached max", r.Detail);
    }

    [LinuxFact]
    public async Task A_task_limit_of_one_stops_a_plugin_starting_a_child_process() =>
        Denied(await RunAsync(new { probe = "spawn" }, options: new LinuxLauncherOptions { AllowChildProcesses = true, MaxTasks = 1 }));

    [LinuxFact]
    public async Task The_host_process_cannot_be_seen()
    {
        var r = await RunAsync(new { probe = "open-process", pid = Environment.ProcessId });
        Denied(r);
        Assert.Contains("FileNotFoundError", r.Detail);   // not even listed in the plugin's /proc
    }

    [LinuxFact]
    public async Task Host_environment_variables_are_not_inherited()
    {
        Environment.SetEnvironmentVariable(HostSecretName, "s3cret-from-host");
        try { Denied(await RunAsync(new { probe = "read-env", name = HostSecretName })); }
        finally { Environment.SetEnvironmentVariable(HostSecretName, null); }
    }

    [LinuxFact]
    public async Task Control_a_plugin_without_a_memory_limit_can_allocate_300_MB() =>
        Allowed(await RunAsync(new { probe = "allocate", mb = 300 }));

    [LinuxFact]
    public async Task A_memory_limit_stops_a_plugin_that_exceeds_it()
    {
        var r = await RunAsync(new { probe = "allocate", mb = 300 }, limits: new PluginLimits { MemoryBytes = 150L * 1024 * 1024 });
        Assert.NotEqual("allowed", r.Outcome);
        Assert.True(r.Started, "the plugin never started, so this proved nothing: " + r.Exit);
    }
}

/// <summary>Plugins must die with the host, however the host dies.</summary>
public sealed class KillWithHostTests(ITestOutputHelper output)
{
    static string HostDll { get; } = FindHost();

    static string FindHost()
    {
        var self = new DirectoryInfo(AppContext.BaseDirectory);   // .../Launchers.Linux.Tests/bin/Debug/net10.0
        var src = self.Parent!.Parent!.Parent!.Parent!;
        return Path.Combine(src.FullName, "OoBDev.Plugins.Launchers.Linux.TestHost", "bin", self.Parent.Name, self.Name,
            "OoBDev.Plugins.Launchers.Linux.TestHost.dll");
    }

    /// <summary>Host-side pids of every process running the escape plugin's script.</summary>
    static int[] PluginPids() =>
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

    [LinuxFact]
    public async Task Plugin_dies_when_the_host_is_killed()
    {
        Assert.True(File.Exists(HostDll), "build the TestHost project first: " + HostDll);
        var psi = new ProcessStartInfo("dotnet", $"\"{HostDll}\" \"{Paths.Escape}\"")
        { RedirectStandardInput = true, RedirectStandardOutput = true, UseShellExecute = false };
        using var host = Process.Start(psi)!;
        try
        {
            Assert.Equal("ready", await host.StandardOutput.ReadLineAsync());
            await host.StandardInput.WriteLineAsync("go");
            Assert.Equal("RUNNING", await host.StandardOutput.ReadLineAsync().WaitAsync(TimeSpan.FromSeconds(30)));
            var pids = PluginPids();
            output.WriteLine($"host {host.Id}, plugin pids {string.Join(",", pids)}");
            Assert.NotEmpty(pids);   // control: the plugin is alive before the host dies

            host.Kill();   // SIGKILL: no Dispose, no shutdown frame
            await host.WaitForExitAsync();

            var end = DateTime.UtcNow + TimeSpan.FromSeconds(10);
            while (PluginPids().Length > 0 && DateTime.UtcNow < end) await Task.Delay(100);
            Assert.Empty(PluginPids());
        }
        finally { if (!host.HasExited) host.Kill(); }
    }
}
