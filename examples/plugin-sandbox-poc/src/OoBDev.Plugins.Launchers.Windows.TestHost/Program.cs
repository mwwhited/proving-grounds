// A throwaway "host application" for the kill-with-host test: it starts one escape plugin, tells the test the
// plugin's process id, and then dies without any cleanup so the test can check what happens to the plugin.
//
//   TestHost <plugin folder> <python dir>        reads "go" from stdin first, so the test can put this process in a job
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Windows;

var pluginDir = args[0];
Console.WriteLine("ready");
Console.In.ReadLine();   // "go"

var cfg = JsonSerializer.SerializeToElement(new { probe = "pid" });
var spec = PluginManifest.Load(pluginDir, cfg) with { Id = "escape-test" };
var manager = new PluginManager(new AppContainerLauncher(new WindowsLauncherOptions
{
    RuntimeReadPaths = WindowsLauncherOptions.PerUserRuntimes("python"),
}));
var got = new TaskCompletionSource<string>();
manager.Router.EventPublished += e =>
{
    if (e.Topic == "escape.result") got.TrySetResult(e.Payload!.Value.GetProperty("detail").GetString()!);
};
manager.Register(spec).Start();
var pid = await got.Task.WaitAsync(TimeSpan.FromSeconds(20));
Console.WriteLine("PID " + pid);
Console.Out.Flush();
Console.In.ReadLine();   // "die"
Environment.FailFast("host dying on purpose");   // no finally blocks, no Dispose, no shutdown frames
