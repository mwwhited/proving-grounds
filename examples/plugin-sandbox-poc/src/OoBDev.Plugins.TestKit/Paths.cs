using OoBDev.Plugins.Host;
namespace OoBDev.Plugins.TestKit;

/// <summary>Where the example plugins live (<c>plugin-sandbox-poc/plugins</c>).</summary>
public static class Paths
{
    public static string Escape => Of("escape-python");

    public static string Plugins { get; } = FindPlugins();

    private static string FindPlugins()
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
