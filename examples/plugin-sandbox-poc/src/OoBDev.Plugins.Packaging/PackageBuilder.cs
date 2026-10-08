using System.IO.Compression;
using System.Security.Cryptography;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace OoBDev.Plugins.Packaging;

/// <summary>
/// Builds a <c>.plugin</c> zip from a folder holding <c>manifest.json</c> (without a <c>files</c> table) and the
/// platform folders. It computes the hashes, writes the final manifest and signs it.
/// </summary>
public static class PackageBuilder
{
    public static void Build(string sourceDirectory, string outputZip, ECDsa? signingKey, string keyId = "")
    {
        var root = Path.GetFullPath(sourceDirectory);
        var manifestPath = Path.Combine(root, PackageSigning.ManifestName);
        var manifest = JsonNode.Parse(File.ReadAllBytes(manifestPath))?.AsObject()
            ?? throw new PackageException(PackageProblem.BadManifest, "manifest.json is not an object");

        var files = Directory.EnumerateFiles(root, "*", SearchOption.AllDirectories)
            .Select(f => (Full: f, Rel: Path.GetRelativePath(root, f).Replace('\\', '/')))
            .Where(f => f.Rel is not (PackageSigning.ManifestName or PackageSigning.SignatureName))
            .OrderBy(f => f.Rel, StringComparer.Ordinal)
            .ToList();

        var table = new JsonObject();
        foreach (var (full, rel) in files)
            table[rel] = "sha256:" + Convert.ToHexStringLower(SHA256.HashData(File.ReadAllBytes(full)));
        manifest["files"] = table;
        manifest.Remove("signature");
        var manifestBytes = JsonSerializer.SerializeToUtf8Bytes(manifest, new JsonSerializerOptions { WriteIndented = true });

        if (File.Exists(outputZip)) File.Delete(outputZip);
        using var zip = ZipFile.Open(outputZip, ZipArchiveMode.Create);
        Add(zip, PackageSigning.ManifestName, manifestBytes);
        if (signingKey is not null) Add(zip, PackageSigning.SignatureName, PackageSigning.Sign(signingKey, keyId, manifestBytes));
        foreach (var (full, rel) in files)
        {
            var entry = zip.CreateEntry(rel, CompressionLevel.Optimal);
            // keep the execute bit for Unix extractors that honour it; the installer sets modes itself regardless
            entry.ExternalAttributes = (OperatingSystem.IsWindows() ? 0x1ED : (int)File.GetUnixFileMode(full)) << 16;
            using var s = entry.Open();
            using var f = File.OpenRead(full);
            f.CopyTo(s);
        }
    }

    static void Add(ZipArchive zip, string name, byte[] bytes)
    {
        using var s = zip.CreateEntry(name).Open();
        s.Write(bytes);
    }
}
