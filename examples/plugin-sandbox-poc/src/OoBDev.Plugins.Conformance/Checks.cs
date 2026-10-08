
namespace OoBDev.Plugins.Conformance;

/// <summary>Collects named PASS/FAIL checks the way <c>run_tests.py</c> prints them.</summary>
internal sealed class Checks(TestContext output)
{
    private readonly List<(string Name, bool Ok, string Detail)> _all = [];

    public int Count => _all.Count;

    public void Check(string name, bool ok, string detail = "")
    {
        _all.Add((name, ok, detail));
        output.WriteLine($"  {(ok ? "PASS" : "FAIL")}  {name}" + (!ok && detail.Length > 0 ? $"  ({detail})" : ""));
    }

    public void AssertAllPassed()
    {
        var failed = _all.Where(c => !c.Ok).Select(c => $"{c.Name} ({c.Detail})").ToList();
        Assert.IsTrue(failed.Count == 0, $"{failed.Count}/{_all.Count} checks failed: " + string.Join("; ", failed));
    }
}
