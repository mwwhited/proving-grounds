namespace OoBDev.Plugins.Packaging;

public sealed class PackageException(PackageProblem problem, string message) : Exception(message)
{
    public PackageProblem Problem { get; } = problem;
}
