using System.Collections.Concurrent;
using System.Diagnostics;
using System.Text.Json;
using System.Text.Json.Nodes;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Plain;
using OoBDev.Plugins.Protocol;
using Xunit;
using Xunit.Abstractions;

namespace OoBDev.Plugins.Conformance;

/// <summary>Where the example plugins live (<c>plugin-sandbox-poc/plugins</c>).</summary>
static class Paths
{
    public static string Plugins { get; } = FindPlugins();

    static string FindPlugins()
    {
        for (var dir = new DirectoryInfo(AppContext.BaseDirectory); dir is not null; dir = dir.Parent)
        {
            var candidate = Path.Combine(dir.FullName, "plugins");
            if (Directory.Exists(Path.Combine(candidate, "echo-python"))) return candidate;
        }
        throw new DirectoryNotFoundException("could not find the plugins folder above " + AppContext.BaseDirectory);
    }

    public static string Of(string plugin) => Path.Combine(Plugins, plugin);

    public static bool OnPath(string tool)
    {
        var exts = OperatingSystem.IsWindows() ? new[] { ".exe", ".cmd", ".bat", "" } : new[] { "" };
        return (Environment.GetEnvironmentVariable("PATH") ?? "").Split(Path.PathSeparator)
            .Any(d => d.Length > 0 && exts.Any(e => File.Exists(Path.Combine(d, tool + e))));
    }
}

/// <summary>A [Fact] that reports itself skipped when a tool the plugin needs is missing.</summary>
public sealed class FactRequiresAttribute : FactAttribute
{
    public FactRequiresAttribute(string? tool = null, string? file = null)
    {
        if (tool is not null && !Paths.OnPath(tool)) Skip = $"{tool} not found on PATH";
        else if (file is not null && !File.Exists(Path.Combine(Paths.Plugins, file)))
            Skip = $"{file} not built (dotnet publish -c Release -o out in plugins/echo-dotnet)";
    }
}

/// <summary>
/// The test-side stand-in for an application using the host: a <see cref="PluginManager"/> running one plugin
/// from <c>plugins/&lt;name&gt;</c> through the plain (unsandboxed) launcher, with every event and session recorded.
/// </summary>
sealed class Harness : IAsyncDisposable
{
    readonly PluginManager _manager;
    readonly List<Envelope> _events = [];
    readonly ConcurrentQueue<PluginSession> _sessions = new();

    public ManagedPlugin Plugin { get; }

    public Harness(string pluginName, object? config = null, SupervisorOptions? options = null)
    {
        JsonElement? cfg = config is null ? null : JsonSerializer.SerializeToElement(config);
        var spec = PluginManifest.Load(Paths.Of(pluginName), cfg);
        _manager = new PluginManager(new PlainProcessLauncher(), options);
        _manager.Router.EventPublished += e => { lock (_events) _events.Add(e); };
        Plugin = _manager.Register(spec);
        Plugin.SessionCreated += _sessions.Enqueue;
    }

    public Router Router => _manager.Router;

    /// <summary>First session ever launched, even if it has already died.</summary>
    public PluginSession FirstSession
    {
        get
        {
            Until(() => !_sessions.IsEmpty, TimeSpan.FromSeconds(10));
            return _sessions.First();
        }
    }

    public async Task<bool> StartAndWaitRunningAsync(TimeSpan? timeout = null)
    {
        Plugin.Start();
        return await Plugin.WaitForStateAsync(PluginState.Running, timeout ?? TimeSpan.FromSeconds(15));
    }

    public Envelope? WaitEvent(string topic, TimeSpan timeout)
    {
        Envelope? found = null;
        Until(() =>
        {
            lock (_events) found = _events.FirstOrDefault(e => e.Topic == topic);
            return found is not null;
        }, timeout);
        return found;
    }

    public List<Envelope> Events(string topic)
    {
        lock (_events) return _events.Where(e => e.Topic == topic).ToList();
    }

    public static bool Until(Func<bool> condition, TimeSpan timeout)
    {
        var sw = Stopwatch.StartNew();
        while (sw.Elapsed < timeout)
        {
            if (condition()) return true;
            Thread.Sleep(10);
        }
        return condition();
    }

    public ValueTask DisposeAsync() => _manager.DisposeAsync();
}

/// <summary>Collects named PASS/FAIL checks the way <c>run_tests.py</c> prints them.</summary>
sealed class Checks(ITestOutputHelper output)
{
    readonly List<(string Name, bool Ok, string Detail)> _all = [];

    public int Count => _all.Count;

    public void Check(string name, bool ok, string detail = "")
    {
        _all.Add((name, ok, detail));
        output.WriteLine($"  {(ok ? "PASS" : "FAIL")}  {name}" + (!ok && detail.Length > 0 ? $"  ({detail})" : ""));
    }

    public void AssertAllPassed()
    {
        var failed = _all.Where(c => !c.Ok).Select(c => $"{c.Name} ({c.Detail})").ToList();
        Assert.True(failed.Count == 0, $"{failed.Count}/{_all.Count} checks failed: " + string.Join("; ", failed));
    }
}

static class Json
{
    public static JsonElement Of(object? value) => JsonSerializer.SerializeToElement(value);

    public static bool Equal(JsonElement? actual, object? expected)
        => actual is { } a && JsonNode.DeepEquals(JsonNode.Parse(a.GetRawText()), JsonSerializer.SerializeToNode(expected));
}
