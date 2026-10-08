using System.IO.Compression;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using OoBDev.Plugins.Host;
using OoBDev.Plugins.Launchers.Plain;

namespace OoBDev.Plugins.Packaging.Tests;

/// <summary>
/// Every rejection test starts from a package that installs (the control in <see cref="Install"/>) and breaks exactly
/// one thing, so a rejection means that thing was caught, not that the package was already unusable.
/// </summary>
[TestClass]
public sealed class PackagingTests : IDisposable
{
    private const string Key = "test-key";
    private readonly string _root = Directory.CreateTempSubdirectory("ps-pkg-").FullName;
    private readonly ECDsa _signer = ECDsa.Create(ECCurve.NamedCurves.nistP256);
    private readonly string _platform = PlatformId.Current;

    private PackageOptions Options => new() { TrustedKeys = new Dictionary<string, byte[]> { [Key] = PackageSigning.PublicKey(_signer) } };
    private string InstallRoot => Path.Combine(_root, "installed");

    public void Dispose()
    {
        _signer.Dispose();
        try
        {
            foreach (var f in Directory.EnumerateFiles(_root, "*", SearchOption.AllDirectories)) File.SetAttributes(f, FileAttributes.Normal);
            if (!OperatingSystem.IsWindows())
                foreach (var d in Directory.EnumerateDirectories(_root, "*", SearchOption.AllDirectories))
                    File.SetUnixFileMode(d, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.UserExecute);
            Directory.Delete(_root, recursive: true);
        }
        catch { }
    }

    /// <summary>A source folder for a plugin "demo" that supports this platform plus one that never matches.</summary>
    private string Source(Action<Dictionary<string, object?>>? tweak = null, string content = "payload")
    {
        var dir = Directory.CreateDirectory(Path.Combine(_root, "src-" + Guid.NewGuid().ToString("N")[..6])).FullName;
        Directory.CreateDirectory(Path.Combine(dir, _platform));
        File.WriteAllText(Path.Combine(dir, _platform, "demo.bin"), content);
        File.WriteAllText(Path.Combine(dir, _platform, "data.txt"), "data");
        var manifest = new Dictionary<string, object?>
        {
            ["id"] = "demo", ["version"] = "1.0.0", ["protocol"] = "2.1",
            ["entry"] = new Dictionary<string, string> { [_platform] = _platform + "/demo.bin" },
            ["platforms"] = new[] { _platform },
            ["lifetime"] = "Bound",
            ["capabilities"] = new { data = "none", publish = new[] { "a.b" }, subscribe = Array.Empty<string>(), sendTo = Array.Empty<string>() },
        };
        tweak?.Invoke(manifest);
        File.WriteAllText(Path.Combine(dir, "manifest.json"), JsonSerializer.Serialize(manifest));
        return dir;
    }

    private string Build(string source, bool sign = true)
    {
        var zip = Path.Combine(_root, Guid.NewGuid().ToString("N")[..6] + ".plugin");
        PackageBuilder.Build(source, zip, sign ? _signer : null, Key);
        return zip;
    }

    /// <summary>Opens the zip, lets the test change entries, and leaves the signature as it was.</summary>
    private static void Edit(string zipPath, Action<ZipArchive> change)
    {
        using var zip = ZipFile.Open(zipPath, ZipArchiveMode.Update);
        change(zip);
    }

    private static void Replace(ZipArchive zip, string name, byte[] bytes)
    {
        zip.GetEntry(name)!.Delete();
        using var s = zip.CreateEntry(name).Open();
        s.Write(bytes);
    }

    private static PackageException Rejected(Action act) => Assert.ThrowsExactly<PackageException>(act);

    private void AssertNothingInstalled() => Assert.IsFalse(Directory.Exists(InstallRoot) && Directory.EnumerateFileSystemEntries(InstallRoot, "*", SearchOption.AllDirectories).Any(),
        "something was left in the install folder");

    // ---- control ----

    [TestMethod]
    public void Install()
    {
        var installed = PluginPackage.Install(Build(Source()), InstallRoot, Options);

        Assert.AreEqual("demo", installed.Spec.Id);
        Assert.AreEqual("1.0.0", installed.Spec.Version);
        Assert.AreEqual(Path.Combine(installed.Directory, _platform), installed.Spec.WorkingDirectory);   // only the platform folder is handed to the sandbox
        Assert.AreEqual("./demo.bin", installed.Spec.Command[0]);
        Assert.AreEqual("payload", File.ReadAllText(Path.Combine(installed.Spec.WorkingDirectory, "demo.bin")));
        Assert.AreSequenceEqual(["a.b"], installed.Spec.Policy.Publish);
        PluginPackage.VerifyInstalled(installed.Directory, Options);
        // installing the same package again reuses the verified folder
        Assert.AreEqual(installed.Directory, PluginPackage.Install(Build(Source()), InstallRoot, Options).Directory);
    }

    [TestMethod]
    public void Installed_files_are_read_only()
    {
        var installed = PluginPackage.Install(Build(Source()), InstallRoot, Options);
        var file = Path.Combine(installed.Spec.WorkingDirectory, "demo.bin");
        Assert.Throws<Exception>(() => File.WriteAllText(file, "changed"));
        if (!OperatingSystem.IsWindows())
        {
            Assert.IsTrue(File.GetUnixFileMode(file).HasFlag(UnixFileMode.UserExecute), "the entry must be executable");
            Assert.IsFalse(File.GetUnixFileMode(Path.Combine(installed.Spec.WorkingDirectory, "data.txt")).HasFlag(UnixFileMode.UserExecute));
        }
    }

    // ---- platform ----

    [TestMethod]
    public void A_package_without_this_platform_is_unavailable_and_nothing_is_extracted()
    {
        var zip = Build(Source());
        var ex = Rejected(() => PluginPackage.Install(zip, InstallRoot, Options with { Platform = "linux-arm64" }));
        Assert.AreEqual(PackageProblem.PlatformUnavailable, ex.Problem);
        Assert.Contains("unavailable on linux-arm64", ex.Message);
        AssertNothingInstalled();
    }

    [TestMethod]
    public void A_platform_missing_from_the_platforms_list_is_unavailable_even_if_an_entry_exists()
    {
        var zip = Build(Source(m => m["platforms"] = new[] { "somewhere-else" }));
        Assert.AreEqual(PackageProblem.PlatformUnavailable, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        AssertNothingInstalled();
    }

    [TestMethod]
    public void An_entry_outside_its_platform_folder_is_rejected()
    {
        var src = Source(m => m["entry"] = new Dictionary<string, string> { [_platform] = "manifest.json" });
        Assert.AreEqual(PackageProblem.BadManifest, Rejected(() => PluginPackage.Install(Build(src), InstallRoot, Options)).Problem);
    }

    // ---- hashes ----

    [TestMethod]
    public void A_file_changed_after_signing_is_rejected_and_leaves_nothing_behind()
    {
        var zip = Build(Source());
        Edit(zip, z => Replace(z, $"{_platform}/demo.bin", Encoding.UTF8.GetBytes("evil!!!")));
        var ex = Rejected(() => PluginPackage.Install(zip, InstallRoot, Options));
        Assert.AreEqual(PackageProblem.HashMismatch, ex.Problem);
        AssertNothingInstalled();
    }

    [TestMethod]
    public void A_file_added_to_the_zip_is_rejected()
    {
        var zip = Build(Source());
        Edit(zip, z => { using var s = z.CreateEntry($"{_platform}/extra.dll").Open(); s.Write("x"u8); });
        Assert.AreEqual(PackageProblem.UnlistedFile, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        AssertNothingInstalled();
    }

    [TestMethod]
    public void A_file_removed_from_the_zip_is_rejected()
    {
        var zip = Build(Source());
        Edit(zip, z => z.GetEntry($"{_platform}/data.txt")!.Delete());
        Assert.AreEqual(PackageProblem.MissingFile, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        AssertNothingInstalled();
    }

    // ---- signature ----

    [TestMethod]
    public void An_unsigned_package_is_rejected_unless_unsigned_is_allowed()
    {
        var zip = Build(Source(), sign: false);
        Assert.AreEqual(PackageProblem.Unsigned, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        AssertNothingInstalled();
        // control: the same package is fine once the development switch is on
        Assert.AreEqual("demo", PluginPackage.Install(zip, InstallRoot, Options with { RequireSignature = false }).Spec.Id);
    }

    [TestMethod]
    public void A_manifest_edited_after_signing_is_rejected()
    {
        var zip = Build(Source());
        Edit(zip, z =>
        {
            using var s = z.GetEntry("manifest.json")!.Open();
            using var r = new StreamReader(s);
            var text = r.ReadToEnd().Replace("\"a.b\"", "\"a.b\", \"admin.everything\"");
            s.SetLength(0);
            s.Write(Encoding.UTF8.GetBytes(text));
        });
        Assert.AreEqual(PackageProblem.BadSignature, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        AssertNothingInstalled();
    }

    [TestMethod]
    public void A_signature_from_an_untrusted_key_is_rejected()
    {
        using var other = ECDsa.Create(ECCurve.NamedCurves.nistP256);
        var zip = Path.Combine(_root, "other.plugin");
        PackageBuilder.Build(Source(), zip, other, "someone-else");
        Assert.AreEqual(PackageProblem.UntrustedKey, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        AssertNothingInstalled();
    }

    [TestMethod]
    public void A_signature_from_another_key_under_a_trusted_name_is_rejected()
    {
        using var other = ECDsa.Create(ECCurve.NamedCurves.nistP256);
        var zip = Path.Combine(_root, "forged.plugin");
        PackageBuilder.Build(Source(), zip, other, Key);   // claims to be the trusted key id, signed by a different key
        Assert.AreEqual(PackageProblem.BadSignature, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
    }

    [TestMethod]
    public void An_invalid_signature_is_not_ignored_when_signatures_are_optional()
    {
        var zip = Build(Source());
        Edit(zip, z => Replace(z, "manifest.sig", "{}"u8.ToArray()));
        Assert.AreEqual(PackageProblem.BadSignature, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options with { RequireSignature = false })).Problem);
    }

    // ---- paths and size ----

    [TestMethod]
    [DataRow("../escape.txt")]
    [DataRow("/abs.txt")]
    [DataRow("a/../../escape.txt")]
    [DataRow("a\\b.txt")]
    [DataRow("C:evil.txt")]
    public void Paths_that_could_leave_the_install_folder_are_rejected(string name)
    {
        var zip = Build(Source());
        Edit(zip, z => { using var s = z.CreateEntry(name).Open(); s.Write("x"u8); });
        Assert.AreEqual(PackageProblem.UnsafePath, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
        Assert.IsFalse(File.Exists(Path.Combine(_root, "escape.txt")));
        AssertNothingInstalled();
    }

    [TestMethod]
    public void Two_entries_differing_only_by_case_are_rejected()
    {
        var zip = Build(Source());
        Edit(zip, z => { using var s = z.CreateEntry($"{_platform}/DEMO.BIN").Open(); s.Write("x"u8); });
        Assert.AreEqual(PackageProblem.UnsafePath, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options)).Problem);
    }

    [TestMethod]
    public void A_package_that_expands_beyond_the_limit_is_rejected()
    {
        var zip = Build(Source(content: new string('a', 200_000)));
        Assert.AreEqual(PackageProblem.TooLarge, Rejected(() => PluginPackage.Install(zip, InstallRoot, Options with { MaxTotalBytes = 100_000 })).Problem);
        AssertNothingInstalled();
        // control: the same package installs under the default limit
        Assert.AreEqual("demo", PluginPackage.Install(zip, InstallRoot, Options).Spec.Id);
    }

    [TestMethod]
    [DataRow("../x")]
    [DataRow("a/b")]
    [DataRow("")]
    [DataRow(".hidden")]
    public void An_id_that_is_not_a_plain_name_is_rejected(string id)
    {
        var src = Source(m => m["id"] = id);
        Assert.AreEqual(PackageProblem.BadManifest, Rejected(() => PluginPackage.Install(Build(src), InstallRoot, Options)).Problem);
        AssertNothingInstalled();
    }

    // ---- after installation ----

    [TestMethod]
    public void A_file_changed_in_the_install_folder_is_caught_by_the_next_check_and_the_next_install_repairs_it()
    {
        var zip = Build(Source());
        var installed = PluginPackage.Install(zip, InstallRoot, Options);
        var file = Path.Combine(installed.Spec.WorkingDirectory, "demo.bin");
        File.SetAttributes(file, FileAttributes.Normal);
        if (!OperatingSystem.IsWindows()) File.SetUnixFileMode(file, UnixFileMode.UserRead | UnixFileMode.UserWrite);
        File.WriteAllText(file, "tampered");

        Assert.AreEqual(PackageProblem.TamperedInstall, Rejected(() => PluginPackage.VerifyInstalled(installed.Directory, Options)).Problem);

        var again = PluginPackage.Install(zip, InstallRoot, Options);   // reinstall replaces the damaged folder
        Assert.AreEqual("payload", File.ReadAllText(Path.Combine(again.Spec.WorkingDirectory, "demo.bin")));
        PluginPackage.VerifyInstalled(again.Directory, Options);
    }

    [TestMethod]
    public void A_file_added_to_the_install_folder_is_caught()
    {
        var installed = PluginPackage.Install(Build(Source()), InstallRoot, Options);
        if (!OperatingSystem.IsWindows()) File.SetUnixFileMode(installed.Spec.WorkingDirectory, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.UserExecute);
        File.WriteAllText(Path.Combine(installed.Spec.WorkingDirectory, "planted.dll"), "x");
        Assert.AreEqual(PackageProblem.TamperedInstall, Rejected(() => PluginPackage.VerifyInstalled(installed.Directory)).Problem);
    }

    // ---- the whole path ----

    [TestMethod]
    public async Task A_real_plugin_runs_from_an_installed_package()
    {
        var ran = false;
        var plugins = new DirectoryInfo(AppContext.BaseDirectory).EnumerateParents().Select(d => Path.Combine(d.FullName, "plugins"))
            .First(p => Directory.Exists(Path.Combine(p, "echo-python")));
        var exe = Path.Combine(plugins, "echo-go", OperatingSystem.IsWindows() ? "out/echo-go.exe" : "out/echo-go");
        if (!File.Exists(exe)) return;   // not built: see README (go build)
        ran = true;

        var src = Source(m => m["id"] = "echo-go");
        File.Copy(exe, Path.Combine(src, _platform, "demo.bin"), overwrite: true);
        var installed = PluginPackage.Install(Build(src), InstallRoot, Options);

        await using var manager = new PluginManager(new PlainProcessLauncher());
        var plugin = manager.Register(installed.Spec);
        plugin.Start();
        Assert.IsTrue(await plugin.WaitForStateAsync(PluginState.Running, TimeSpan.FromSeconds(10)), "the packaged plugin never became ready");
        await plugin.StopAsync();
        Assert.IsTrue(ran);
    }
}
