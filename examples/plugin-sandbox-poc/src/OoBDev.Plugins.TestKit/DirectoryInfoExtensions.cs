using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.TestKit;

public static class DirectoryInfoExtensions
{
    public static IEnumerable<DirectoryInfo> EnumerateParents(this DirectoryInfo dir)
    {
        for (var d = dir; d is not null; d = d.Parent) yield return d;
    }
}
