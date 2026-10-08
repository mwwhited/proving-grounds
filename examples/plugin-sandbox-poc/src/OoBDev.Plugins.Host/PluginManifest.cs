using System.Globalization;
using System.Text.Json;

namespace OoBDev.Plugins.Host;

/// <summary>
/// The parts of <c>manifest.json</c> the host reads in phase 1 (design §3). Strict shape, unknown keys ignored.
/// <c>entry.dev</c> is a dev-only command line; release packages will carry per-platform executables.
/// </summary>
public static class PluginManifest
{
    public static PluginSpec Load(string pluginDirectory, JsonElement? config = null, string manifestName = "manifest.json")
    {
        var path = Path.Combine(pluginDirectory, manifestName);
        using var doc = JsonDocument.Parse(File.ReadAllBytes(path), new JsonDocumentOptions { MaxDepth = 16 });
        return Parse(doc.RootElement, pluginDirectory, config);
    }

    /// <param name="commandOverride">The command to run, already chosen by a package loader. Without it the manifest must have <c>entry.dev</c>.</param>
    public static PluginSpec Parse(JsonElement root, string pluginDirectory, JsonElement? config = null, string[]? commandOverride = null)
    {
        if (root.ValueKind != JsonValueKind.Object) throw new FormatException("manifest must be a JSON object");

        var id = RequiredString(root, "id");
        string[] command;
        if (commandOverride is { Length: > 0 }) command = commandOverride;
        else
        {
            var entry = Property(root, "entry", JsonValueKind.Object)
                ?? throw new FormatException("manifest has no 'entry'");
            var dev = Property(entry, "dev", JsonValueKind.Array)
                ?? throw new FormatException("manifest has no 'entry.dev' (load a .plugin package with OoBDev.Plugins.Packaging)");
            command = dev.EnumerateArray().Select(a => a.ValueKind == JsonValueKind.String
                ? a.GetString()! : throw new FormatException("'entry.dev' must be strings")).ToArray();
            if (command.Length == 0) throw new FormatException("'entry.dev' is empty");
        }

        var lifetime = OptionalString(root, "lifetime") is { } l
            ? Enum.TryParse<Lifetime>(l, ignoreCase: false, out var parsed) && Enum.IsDefined(parsed)
                ? parsed : throw new FormatException($"unknown lifetime '{l}'")
            : Lifetime.Bound;

        var caps = Property(root, "capabilities", JsonValueKind.Object);
        var policy = caps is null ? PluginPolicy.DenyAll : new PluginPolicy(
            Strings(caps.Value, "publish"), Strings(caps.Value, "subscribe"), Strings(caps.Value, "sendTo"));

        var limits = new PluginLimits();
        if (Property(root, "limits", JsonValueKind.Object) is { } lim)
            limits = limits with
            {
                MsgPerSec = PositiveInt(lim, "msgPerSec") ?? limits.MsgPerSec,
                MaxFrameBytes = PositiveInt(lim, "maxFrameBytes") ?? limits.MaxFrameBytes,
            };

        var spec = new PluginSpec(id, command, pluginDirectory)
        {
            Version = OptionalString(root, "version") ?? "0.0.0",
            Lifetime = lifetime,
            Policy = policy,
            Limits = limits,
            Config = config,
        };
        return OptionalString(root, "heartbeatTimeout") is { } hb ? spec with { HeartbeatTimeout = ParseDuration(hb) } : spec;
    }

    /// <summary>Accepts <c>500ms</c>, <c>5s</c>, <c>2m</c>.</summary>
    public static TimeSpan ParseDuration(string text)
    {
        var t = text.Trim();
        (string suffix, Func<double, TimeSpan> make)[] units =
        [
            ("ms", TimeSpan.FromMilliseconds), ("s", TimeSpan.FromSeconds), ("m", TimeSpan.FromMinutes),
        ];
        foreach (var (suffix, make) in units)
            if (t.EndsWith(suffix, StringComparison.Ordinal)
                && double.TryParse(t[..^suffix.Length], NumberStyles.Float, CultureInfo.InvariantCulture, out var n) && n > 0)
                return make(n);
        throw new FormatException($"bad duration '{text}' (use 500ms, 5s or 2m)");
    }

    private static JsonElement? Property(JsonElement obj, string name, JsonValueKind kind)
    {
        if (!obj.TryGetProperty(name, out var el) || el.ValueKind == JsonValueKind.Null) return null;
        return el.ValueKind == kind ? el : throw new FormatException($"'{name}' must be a {kind.ToString().ToLowerInvariant()}");
    }

    private static string RequiredString(JsonElement obj, string name)
        => OptionalString(obj, name) is { Length: > 0 } s ? s : throw new FormatException($"manifest has no '{name}'");

    private static string? OptionalString(JsonElement obj, string name)
        => Property(obj, name, JsonValueKind.String)?.GetString();

    private static int? PositiveInt(JsonElement obj, string name)
    {
        if (!obj.TryGetProperty(name, out var el) || el.ValueKind == JsonValueKind.Null) return null;
        return el.ValueKind == JsonValueKind.Number && el.TryGetInt32(out var n) && n > 0
            ? n : throw new FormatException($"'{name}' must be a positive integer");
    }

    private static string[] Strings(JsonElement obj, string name)
        => Property(obj, name, JsonValueKind.Array) is { } arr
            ? [.. arr.EnumerateArray().Select(a => a.ValueKind == JsonValueKind.String
                ? a.GetString()! : throw new FormatException($"'{name}' must be strings"))]
            : [];
}
