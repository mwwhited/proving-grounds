// A throwaway "host application" for the kill-with-host test: it starts one escape plugin, tells the test it is
// running, and then dies without any cleanup so the test can check what happens to the plugin.
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Linux;

var pluginDir = args[0];
Console.WriteLine("ready");
Console.In.ReadLine();   // "go"

var cfg = JsonSerializer.SerializeToElement(new { probe = "pid", linger = true });
var spec = PluginManifest.Load(pluginDir, cfg) with { Id = "escape-test" };
var manager = new PluginManager(new BubblewrapLauncher());
var got = new TaskCompletionSource<string>();
manager.Router.EventPublished += e =>
{
    if (e.Topic == "escape.result") got.TrySetResult(e.Payload!.Value.GetProperty("detail").GetString()!);
};
manager.Register(spec).Start();
await got.Task.WaitAsync(TimeSpan.FromSeconds(20));
Console.WriteLine("RUNNING");
Console.Out.Flush();
Console.In.ReadLine();   // "die"
Environment.FailFast("host dying on purpose");   // no finally blocks, no Dispose, no shutdown frames
