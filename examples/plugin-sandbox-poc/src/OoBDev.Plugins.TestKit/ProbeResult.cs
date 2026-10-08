using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.TestKit;

public sealed record ProbeResult(string Outcome, string Detail, ExitRecord? Exit, bool Started = true);
