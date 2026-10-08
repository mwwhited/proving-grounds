// An interactive shell for trying the POC by hand: start the sample plugins plain or sandboxed, call them, watch the
// bus, run the hostile escape probes with your own grants and limits, and build/install a signed package.
// Run:  dotnet run --project src/OoBDev.Plugins.Playground      (type "help")
using System.Security.Cryptography;
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Linux;
using OoBDev.Plugins.Launchers.Plain;
using OoBDev.Plugins.Launchers.Windows;
using OoBDev.Plugins.Packaging;

var root = new DirectoryInfo(AppContext.BaseDirectory);
while (root is not null && !Directory.Exists(Path.Combine(root.FullName, "plugins", "echo-python"))) root = root.Parent;
if (root is null) { Console.WriteLine("cannot find the plugins folder"); return 1; }
var pluginsDir = Path.Combine(root.FullName, "plugins");

var sandboxed = false;
var installRoot = Path.Combine(Path.GetTempPath(), "plugin-playground");
using var signer = ECDsa.Create(ECCurve.NamedCurves.nistP256);
var packageOptions = new PackageOptions { TrustedKeys = new Dictionary<string, byte[]> { ["playground"] = PackageSigning.PublicKey(signer) } };
var ids = new HashSet<string>();
PluginManager manager = NewManager();

IPluginLauncher NewLauncher()
{
    if (!sandboxed) return new PlainProcessLauncher();
    if (OperatingSystem.IsWindows())
        return new AppContainerLauncher(new WindowsLauncherOptions { RuntimeReadPaths = WindowsLauncherOptions.PerUserRuntimes("python", "node") });
    if (OperatingSystem.IsLinux()) return new BubblewrapLauncher();
    throw new PlatformNotSupportedException("no sandbox launcher for this OS");
}

PluginManager NewManager()
{
    var m = new PluginManager(NewLauncher(), new SupervisorOptions { MaxCrashesInWindow = 3 });
    m.Router.EventPublished += e => Console.WriteLine($"  [event] {e.Topic} {e.Payload}");
    m.Router.Denied += d => Console.WriteLine($"  [denied] {d.PluginId}: {d.Action} {d.Topic} - {d.Reason}");
    return m;
}

void Register(PluginSpec spec)
{
    var p = manager.Register(spec);
    p.StateChanged += (id, s) => Console.WriteLine($"  [{id}] {s}");
    p.LogLine += (id, line) => Console.WriteLine($"  [{id} stderr] {line}");
    ids.Add(spec.Id);
}

static JsonElement? ParseJson(string text) => string.IsNullOrWhiteSpace(text) ? null : JsonSerializer.Deserialize<JsonElement>(text);

static Dictionary<string, object> KeyValues(IEnumerable<string> tokens)
{
    var d = new Dictionary<string, object>();
    foreach (var t in tokens)
    {
        var i = t.IndexOf('=');
        if (i < 1) throw new FormatException($"expected key=value, got '{t}'");
        var k = t[..i]; var v = t[(i + 1)..];
        d[k] = long.TryParse(v, out var n) ? n : bool.TryParse(v, out var b) ? b : v;
    }
    return d;
}

async Task Probe(string[] a)
{
    if (a.Length < 1) { Console.WriteLine("usage: probe <name> [key=value ...] [ro=PATH] [rw=PATH] [mem=MB] [cpu=PCT]"); return; }
    var kv = KeyValues(a.Skip(1));
    var grants = new List<PathGrant>();
    PluginLimits limits = new();
    foreach (var (k, v) in kv.ToList())
    {
        switch (k)
        {
            case "ro": grants.Add(new PathGrant(Path.GetFullPath((string)v))); kv.Remove(k); break;
            case "rw": grants.Add(new PathGrant(Path.GetFullPath((string)v), Write: true)); kv.Remove(k); break;
            case "mem": limits = limits with { MemoryBytes = (long)v * 1024 * 1024 }; kv.Remove(k); break;
            case "cpu": limits = limits with { CpuPercent = (int)(long)v }; kv.Remove(k); break;
        }
    }
    kv["probe"] = a[0];
    var spec = PluginManifest.Load(Path.Combine(pluginsDir, "escape-python"), JsonSerializer.SerializeToElement(kv)) with
    { Id = "escape-test", Grants = grants, Limits = limits };

    await using var m = new PluginManager(NewLauncher(), new SupervisorOptions { MaxCrashesInWindow = 1, BackoffInitial = TimeSpan.FromMinutes(5) });
    var got = new TaskCompletionSource<JsonElement>(TaskCreationOptions.RunContinuationsAsynchronously);
    m.Router.EventPublished += e => { if (e.Topic == "escape.result") got.TrySetResult(e.Payload!.Value.Clone()); };
    var plugin = m.Register(spec);
    plugin.Start();
    var done = await Task.WhenAny(got.Task, Task.Delay(TimeSpan.FromSeconds(20)));
    if (done == got.Task)
    {
        var r = got.Task.Result;
        Console.WriteLine($"  {(sandboxed ? "SANDBOXED" : "PLAIN (no sandbox)")}  {a[0]}: {r.GetProperty("outcome").GetString()}  {r.GetProperty("detail").GetString()}");
        return;
    }
    var end = DateTime.UtcNow.AddSeconds(3);
    while (plugin.Exits.Count == 0 && DateTime.UtcNow < end) await Task.Delay(50);
    Console.WriteLine($"  no result. exit: {plugin.Exits.FirstOrDefault()?.ToString() ?? "(still running or never started)"}");
}

void Help() => Console.WriteLine("""
  mode plain|sandbox         choose the launcher (sandbox = AppContainer on Windows, bubblewrap on Linux). Resets registered plugins.
  list                       the sample plugins and what is registered
  start <name|id>            register (from plugins/<name>) and start
  stop|restart <id>
  status
  call <id> <topic> [json]   request/response, e.g.  call echo-python echo {"hi":1}   or   call echo-python add {"a":2,"b":3}
  publish <topic> [json]     put an event on the bus
  probe <name> [k=v ...]     run a hostile escape probe once. Names: read-file, list-dir, write-file, connect, resolve, spawn,
                             spawnloop, open-process, read-env, allocate, spin, handles, ok-read-file, ok-list-dir, ok-write-file
                             extras: ro=PATH rw=PATH (grants) mem=MB cpu=PCT (limits)
                             e.g.  probe read-file path=<a file in your Documents>      probe allocate mb=500 mem=100      probe connect host=1.1.1.1 port=443
                             (note: on Windows a sandboxed plugin CAN read C:\Windows; only user files are denied)
  pack <srcdir> <zip>        build a signed package (srcdir has manifest.json + <platform>/ folders) with this session's key
  install <zip>              verify, extract and register it (then: start <id>)
  tamper <zip>               write a copy of the package with one byte flipped, so you can watch install reject it
  cleanup                    Windows: revoke ACL grants and remove the AppContainers this session created
  quit
""");

Console.WriteLine($"plugin playground. plugins in {pluginsDir}. launcher: PLAIN. type help.");
while (true)
{
    Console.Write(sandboxed ? "sandbox> " : "plain> ");
    var line = Console.ReadLine();
    if (line is null) break;
    var parts = line.Trim().Split(' ', 2, StringSplitOptions.RemoveEmptyEntries);
    if (parts.Length == 0) continue;
    var rest = parts.Length > 1 ? parts[1] : "";
    var argv = rest.Split(' ', StringSplitOptions.RemoveEmptyEntries);
    try
    {
        switch (parts[0])
        {
            case "help": Help(); break;
            case "quit" or "exit": goto done;
            case "mode":
                sandboxed = argv.FirstOrDefault() == "sandbox";
                await manager.DisposeAsync(); ids.Clear(); manager = NewManager();
                Console.WriteLine($"  launcher: {(sandboxed ? "SANDBOX" : "PLAIN")}");
                break;
            case "list":
                foreach (var d in Directory.GetDirectories(pluginsDir).Where(d => File.Exists(Path.Combine(d, "manifest.json"))))
                    Console.WriteLine($"  {Path.GetFileName(d)}");
                foreach (var p in manager.Plugins) Console.WriteLine($"  registered: {p.Id} {p.State}");
                break;
            case "start":
                {
                    var name = argv[0];
                    if (!ids.Contains(name)) Register(PluginManifest.Load(Path.Combine(pluginsDir, name)));
                    manager.Start(name);
                    var p = manager.Get(name);
                    var ok = await p.WaitForStateAsync(PluginState.Running, TimeSpan.FromSeconds(20));
                    Console.WriteLine(ok ? $"  {name} is running" : $"  {name} did not become ready: {p.State}; {p.Exits.LastOrDefault()}");
                    break;
                }
            case "stop": await manager.StopAsync(argv[0]); break;
            case "restart": await manager.RestartAsync(argv[0]); break;
            case "status":
                foreach (var p in manager.Plugins)
                    Console.WriteLine($"  {p.Id}: {p.State}  history={string.Join(">", p.History)}  exits={p.Exits.Count}{(p.Exits.Count > 0 ? " last=" + p.Exits[^1] : "")}");
                break;
            case "call":
                {
                    var payloadText = string.Join(' ', rest.Split(' ', 3, StringSplitOptions.RemoveEmptyEntries).Skip(2));
                    var reply = await manager.Get(argv[0]).RequestAsync(argv[1], ParseJson(payloadText), TimeSpan.FromSeconds(10));
                    Console.WriteLine($"  -> {reply.Type} {reply.Payload}");
                    break;
                }
            case "publish":
                manager.Router.Publish(argv[0], ParseJson(string.Join(' ', rest.Split(' ', 2, StringSplitOptions.RemoveEmptyEntries).Skip(1))));
                break;
            case "probe": await Probe(argv); break;
            case "pack":
                PackageBuilder.Build(argv[0], argv[1], signer, "playground");
                Console.WriteLine($"  built {argv[1]} (signed with this session's key; only this session trusts it)");
                break;
            case "install":
                {
                    var installed = PluginPackage.Install(argv[0], installRoot, packageOptions);
                    Register(installed.Spec);
                    Console.WriteLine($"  installed {installed.Spec.Id} {installed.Spec.Version} for {installed.Platform} at {installed.Directory}; try: start {installed.Spec.Id}");
                    break;
                }
            case "tamper":
                {
                    var copy = argv[0] + ".tampered";
                    File.Copy(argv[0], copy, overwrite: true);
                    using (var fs = new FileStream(copy, FileMode.Open, FileAccess.ReadWrite))
                    {
                        fs.Position = fs.Length / 2;
                        var b = fs.ReadByte(); fs.Position = fs.Length / 2; fs.WriteByte((byte)(b ^ 0xFF));
                    }
                    Console.WriteLine($"  wrote {copy}; try: install {copy}");
                    break;
                }
            case "cleanup":
                if (OperatingSystem.IsWindows())
                {
                    foreach (var id in ids.Append("escape-test"))
                    {
                        try { AppContainerLauncher.Uninstall(id); Console.WriteLine($"  removed {id}"); }
                        catch (Exception e) { Console.WriteLine($"  {id}: {e.Message}"); }
                    }
                }
                else Console.WriteLine("  nothing to clean on this OS");
                break;
            default: Console.WriteLine("  unknown command; try help"); break;
        }
    }
    catch (PackageException e) { Console.WriteLine($"  REJECTED ({e.Problem}): {e.Message}"); }
    catch (Exception e) { Console.WriteLine($"  {e.GetType().Name}: {e.Message}"); }
}
done:
await manager.DisposeAsync();
return 0;
