// Measures the wire encoding (4-byte length + UTF-8 JSON) at 1 KB and 1 MB: codec cost and a real round trip
// through echo-python via the real host. Usage: dotnet run -c Release --project OoBDev.Plugins.Bench
using System.Diagnostics;
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Plain;
using OoBDev.Plugins.Protocol;

static double Ms(Stopwatch sw, int n) => sw.Elapsed.TotalMilliseconds / n;

var root = new DirectoryInfo(AppContext.BaseDirectory);
while (root is not null && !Directory.Exists(Path.Combine(root.FullName, "plugins", "echo-python"))) root = root.Parent;
var plugins = Path.Combine(root!.FullName, "plugins");

await using var manager = new PluginManager(new PlainProcessLauncher());
var plugin = manager.Register(PluginManifest.Load(Path.Combine(plugins, "echo-python")));
plugin.Start();
if (!await plugin.WaitForStateAsync(PluginState.Running, TimeSpan.FromSeconds(15))) { Console.WriteLine("echo-python did not start"); return 1; }

Console.WriteLine($"{"payload",-22}{"frame bytes",12}{"overhead",10}{"encode ms",11}{"decode ms",11}{"round trip ms (echo-python)",30}");
foreach (var (label, size, binary) in new[] { ("1 KB text", 1024, false), ("1 KB binary(base64)", 1024, true), ("~1 MB text", 900_000, false), ("~1 MB binary(base64)", 700_000, true) })
{
    var text = binary ? Convert.ToBase64String(Random.Shared.GetBytes(size)) : new string('x', size);
    var env = Envelope.Create(MessageType.Request, "echo", JsonSerializer.SerializeToElement(text));
    var reps = size > 100_000 ? 50 : 2000;

    for (var i = 0; i < 20; i++) FrameCodec.Encode(env, int.MaxValue);
    var sw = Stopwatch.StartNew();
    byte[] frame = [];
    for (var i = 0; i < reps; i++) frame = FrameCodec.Encode(env, int.MaxValue);
    sw.Stop(); var enc = Ms(sw, reps);

    sw.Restart();
    for (var i = 0; i < reps; i++) EnvelopeSerializer.TryParse(frame.AsSpan(4), out _, out _);
    sw.Stop(); var dec = Ms(sw, reps);

    var rt = size > 100_000 ? 20 : 300;
    for (var i = 0; i < 5; i++) await plugin.RequestAsync("echo", env.Payload, TimeSpan.FromSeconds(10));
    sw.Restart();
    for (var i = 0; i < rt; i++) await plugin.RequestAsync("echo", env.Payload, TimeSpan.FromSeconds(10));
    sw.Stop();

    Console.WriteLine($"{label,-22}{frame.Length,12}{(double)frame.Length / size,9:P0} {enc,11:F3}{dec,11:F3}{Ms(sw, rt),30:F3}");
}
return 0;
