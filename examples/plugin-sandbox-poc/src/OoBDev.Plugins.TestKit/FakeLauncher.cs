using OoBDev.Plugins.Host;
using System.IO.Pipelines;

namespace OoBDev.Plugins.TestKit;

/// <summary>Launches scripts chosen per attempt (1-based). Counts launches and live processes.</summary>
public sealed class FakeLauncher(Func<int, PluginScript?> scriptFor) : IPluginLauncher
{
    private int _launches;
    private int _live;
    private int _maxLive;
    private readonly List<FakeProcess> _processes = [];

    public FakeLauncher(PluginScript script) : this(_ => script) { }

    public int Launches => Volatile.Read(ref _launches);
    public int MaxConcurrent => Volatile.Read(ref _maxLive);
    public IReadOnlyList<FakeProcess> Processes { get { lock (_processes) return [.. _processes]; } }

    public ValueTask<IPluginProcess> LaunchAsync(PluginSpec spec, CancellationToken ct)
    {
        var attempt = Interlocked.Increment(ref _launches);
        var script = scriptFor(attempt) ?? throw new InvalidOperationException($"launch #{attempt} failed (test)");
        var live = Interlocked.Increment(ref _live);
        int seen;
        while ((seen = Volatile.Read(ref _maxLive)) < live && Interlocked.CompareExchange(ref _maxLive, live, seen) != seen) { }

        var process = new FakeProcess(async channel =>
        {
            try { return await script(channel); }
            finally { Interlocked.Decrement(ref _live); }
        });
        lock (_processes) _processes.Add(process);
        return ValueTask.FromResult<IPluginProcess>(process);
    }
}
