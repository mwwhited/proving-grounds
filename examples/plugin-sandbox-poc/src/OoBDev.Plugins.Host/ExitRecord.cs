
namespace OoBDev.Plugins.Host;

public sealed record ExitRecord(ExitReason Reason, int? ExitCode, string? Detail, DateTimeOffset At);
