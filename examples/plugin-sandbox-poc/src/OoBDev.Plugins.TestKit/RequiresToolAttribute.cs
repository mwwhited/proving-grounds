namespace OoBDev.Plugins.TestKit;

/// <summary>Skips the test when a tool or a built plugin file it needs is missing, or on a known AppContainer gap.</summary>
[AttributeUsage(AttributeTargets.Method | AttributeTargets.Class)]
public sealed class RequiresToolAttribute : ConditionBaseAttribute
{
    private readonly string? _reason;

    public RequiresToolAttribute(string? tool = null, string? file = null, string? appContainerGap = null)
        : base(ConditionMode.Include)
    {
        if (appContainerGap is not null && Environment.GetEnvironmentVariable("PLUGIN_LAUNCHER") == "appcontainer") _reason = "known AppContainer gap: " + appContainerGap;
        else if (tool is not null && !Paths.OnPath(tool)) _reason = $"{tool} not found on PATH";
        else if (file is not null && !File.Exists(Path.Combine(Paths.Plugins, OperatingSystem.IsWindows() ? file : file.Replace(".exe", ""))))
            _reason = $"{file} not built (dotnet publish -c Release -o out in plugins/echo-dotnet)";
        IgnoreMessage = _reason;
    }

    public override string GroupName => "RequiresTool";

    public override bool IsConditionMet => _reason is null;
}
