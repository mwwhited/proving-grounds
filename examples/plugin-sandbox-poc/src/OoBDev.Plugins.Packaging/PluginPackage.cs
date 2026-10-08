using System.IO.Compression;
using System.Security.Cryptography;
using System.Text.Json;
using OoBDev.Plugins.Host;

namespace OoBDev.Plugins.Packaging;

/// <summary>A verified, extracted package: the spec to launch and where it lives.</summary>
public sealed record InstalledPlugin(PluginSpec Spec, string Directory, string Platform);

/// <summary>
/// Installs a <c>.plugin</c> zip (design §3). Order matters: the signature is checked first, then the platform is
/// selected from the manifest (so "unavailable on this platform" is reported with nothing extracted), then every file is
/// hashed as it is written to a temporary folder, and only a fully verified tree is moved into place and made read-only.
/// </summary>
public static class PluginPackage
{
    const int MaxManifestBytes = 1024 * 1024;

    public static InstalledPlugin Install(string packagePath, string installRoot, PackageOptions options, JsonElement? config = null)
    {
        using var zip = ZipFile.OpenRead(packagePath);
        var entries = Catalogue(zip, options);

        // 1. signature over the exact manifest bytes
        var manifestBytes = ReadSmall(entries, PackageSigning.ManifestName)
            ?? throw new PackageException(PackageProblem.BadManifest, "the package has no manifest.json");
        var signatureBytes = ReadSmall(entries, PackageSigning.SignatureName);
        if (signatureBytes is not null) PackageSigning.Verify(manifestBytes, signatureBytes, options.TrustedKeys);
        else if (options.RequireSignature) throw new PackageException(PackageProblem.Unsigned, "the package is not signed");

        // 2. manifest and platform, before anything is written
        using var doc = ParseManifest(manifestBytes);
        var root = doc.RootElement;
        var id = Name(root, "id");
        var version = Name(root, "version");
        var platform = options.Platform;
        var entryPath = SelectEntry(root, platform);
        var files = FileTable(root);

        // 3. the zip and the table must describe the same files
        foreach (var path in entries.Keys)
            if (path is not (PackageSigning.ManifestName or PackageSigning.SignatureName) && !files.ContainsKey(path))
                throw new PackageException(PackageProblem.UnlistedFile, $"'{path}' is in the package but not in the manifest's file table");
        foreach (var path in files.Keys)
            if (!entries.ContainsKey(path))
                throw new PackageException(PackageProblem.MissingFile, $"'{path}' is in the file table but not in the package");
        if (!files.ContainsKey(entryPath))
            throw new PackageException(PackageProblem.BadManifest, $"the entry '{entryPath}' is not in the file table");

        // 4. extract into a temporary folder, hashing as we go; move into place only when everything matched
        var parent = Path.Combine(Path.GetFullPath(installRoot), id);
        var final = Path.Combine(parent, $"{version}-{Convert.ToHexStringLower(SHA256.HashData(manifestBytes))[..12]}");
        if (Directory.Exists(final))
        {
            try
            {
                VerifyInstalled(final);
                if (!File.ReadAllBytes(Path.Combine(final, PackageSigning.ManifestName)).AsSpan().SequenceEqual(manifestBytes))
                    throw new PackageException(PackageProblem.TamperedInstall, "the installed manifest is not the one being installed");
            }
            catch (PackageException) { Remove(final); }
        }
        if (!Directory.Exists(final))
        {
            Directory.CreateDirectory(parent);
            var temp = final + ".tmp-" + Guid.NewGuid().ToString("N")[..8];
            try
            {
                Extract(entries, files, manifestBytes, signatureBytes, temp, options.MaxTotalBytes);
                Lock(temp, entryPath);
                Directory.Move(temp, final);
            }
            catch
            {
                Remove(temp);
                if (!Directory.EnumerateFileSystemEntries(parent).Any()) Directory.Delete(parent);   // do not leave an empty id folder behind
                throw;
            }
        }

        // 5. the sandbox gets the platform folder only, not the whole package
        var platformDir = Path.Combine(final, platform);
        var command = new[] { "./" + entryPath[(platform.Length + 1)..] };
        var spec = PluginManifest.Parse(root, platformDir, config, command);
        return new InstalledPlugin(spec, final, platform);
    }

    /// <summary>
    /// Re-hashes an installed package against its own signed manifest. Call it before each launch if the install folder
    /// could have been written to since; there is still a window between the check and the launch.
    /// </summary>
    public static void VerifyInstalled(string installDirectory, PackageOptions? options = null)
    {
        var manifestBytes = ReadFile(installDirectory, PackageSigning.ManifestName);
        if (options is not null)
        {
            var sig = ReadFile(installDirectory, PackageSigning.SignatureName);
            if (sig is not null) PackageSigning.Verify(manifestBytes!, sig, options.TrustedKeys);
            else if (options.RequireSignature) throw new PackageException(PackageProblem.Unsigned, "the installed package is not signed");
        }
        using var doc = ParseManifest(manifestBytes ?? throw new PackageException(PackageProblem.TamperedInstall, "manifest.json is gone"));
        var files = FileTable(doc.RootElement);
        var present = Directory.EnumerateFiles(installDirectory, "*", SearchOption.AllDirectories)
            .Select(f => Path.GetRelativePath(installDirectory, f).Replace('\\', '/'))
            .Where(f => f is not (PackageSigning.ManifestName or PackageSigning.SignatureName)).ToHashSet();
        foreach (var extra in present.Except(files.Keys))
            throw new PackageException(PackageProblem.TamperedInstall, $"'{extra}' was added to the installed package");
        foreach (var (path, expected) in files)
        {
            var full = Path.Combine(installDirectory, path);
            if (!File.Exists(full)) throw new PackageException(PackageProblem.TamperedInstall, $"'{path}' is gone from the installed package");
            using var s = File.OpenRead(full);
            if (!Matches(SHA256.HashData(s), expected))
                throw new PackageException(PackageProblem.TamperedInstall, $"'{path}' changed after installation");
        }
    }

    // ---- reading the zip ------------------------------------------------------------------------

    static Dictionary<string, ZipArchiveEntry> Catalogue(ZipArchive zip, PackageOptions options)
    {
        if (zip.Entries.Count > options.MaxEntries)
            throw new PackageException(PackageProblem.TooLarge, $"the package has {zip.Entries.Count} entries (limit {options.MaxEntries})");
        var map = new Dictionary<string, ZipArchiveEntry>(StringComparer.Ordinal);
        var seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        long total = 0;
        foreach (var e in zip.Entries)
        {
            var name = e.FullName;
            if (name.EndsWith('/')) continue;   // directory entry: folders are created from file paths
            CheckPath(name);
            if (!seen.Add(name)) throw new PackageException(PackageProblem.UnsafePath, $"'{name}' appears twice (or differs only by case)");
            if (IsSymlink(e)) throw new PackageException(PackageProblem.UnsafePath, $"'{name}' is a symbolic link");
            total += e.Length;
            if (total > options.MaxTotalBytes)
                throw new PackageException(PackageProblem.TooLarge, $"the package expands to more than {options.MaxTotalBytes} bytes");
            map[name] = e;
        }
        return map;
    }

    static void CheckPath(string name)
    {
        var bad = name.Length == 0 || name.Length > 260 || name[0] == '/' || name.Contains('\\') || name.Contains(':') || name.Contains('\0')
            || name.Split('/').Any(p => p is "" or "." or ".." || p.EndsWith(' ') || p.EndsWith('.'));
        if (bad) throw new PackageException(PackageProblem.UnsafePath, $"unsafe path in package: '{name}'");
    }

    static bool IsSymlink(ZipArchiveEntry e)
    {
        var unixMode = (e.ExternalAttributes >> 16) & 0xF000;
        return unixMode == 0xA000;
    }

    static byte[]? ReadSmall(Dictionary<string, ZipArchiveEntry> entries, string name)
    {
        if (!entries.TryGetValue(name, out var e)) return null;
        if (e.Length > MaxManifestBytes) throw new PackageException(PackageProblem.TooLarge, $"{name} is larger than {MaxManifestBytes} bytes");
        using var s = e.Open();
        using var ms = new MemoryStream();
        s.CopyTo(ms);
        if (ms.Length > MaxManifestBytes) throw new PackageException(PackageProblem.TooLarge, $"{name} is larger than {MaxManifestBytes} bytes");
        return ms.ToArray();
    }

    static byte[]? ReadFile(string dir, string name)
    {
        var p = Path.Combine(dir, name);
        return File.Exists(p) ? File.ReadAllBytes(p) : null;
    }

    // ---- the manifest ---------------------------------------------------------------------------

    static JsonDocument ParseManifest(byte[] bytes)
    {
        try { return JsonDocument.Parse(bytes, new JsonDocumentOptions { MaxDepth = 16 }); }
        catch (JsonException ex) { throw new PackageException(PackageProblem.BadManifest, "manifest.json is not valid JSON: " + ex.Message); }
    }

    /// <summary>Ids and versions become folder names, so they get a strict alphabet.</summary>
    static string Name(JsonElement root, string property)
    {
        var value = root.ValueKind == JsonValueKind.Object && root.TryGetProperty(property, out var el) && el.ValueKind == JsonValueKind.String
            ? el.GetString() : null;
        if (string.IsNullOrEmpty(value) || value.Length > 64 || !value.All(c => char.IsAsciiLetterOrDigit(c) || c is '.' or '-' or '_') || value.StartsWith('.'))
            throw new PackageException(PackageProblem.BadManifest, $"manifest '{property}' is missing or has characters other than letters, digits, '.', '-' and '_'");
        return value;
    }

    /// <summary>Returns the entry path for <paramref name="platform"/>, or throws PlatformUnavailable.</summary>
    static string SelectEntry(JsonElement root, string platform)
    {
        var listed = root.TryGetProperty("platforms", out var p) && p.ValueKind == JsonValueKind.Array
            && p.EnumerateArray().Any(x => x.ValueKind == JsonValueKind.String && x.GetString() == platform);
        if (!root.TryGetProperty("entry", out var entry) || entry.ValueKind != JsonValueKind.Object)
            throw new PackageException(PackageProblem.BadManifest, "manifest has no 'entry'");
        if (!listed || !entry.TryGetProperty(platform, out var path) || path.ValueKind != JsonValueKind.String)
            throw new PackageException(PackageProblem.PlatformUnavailable, $"this plugin is unavailable on {platform}");
        var text = path.GetString()!;
        CheckPath(text);
        if (!text.StartsWith(platform + "/", StringComparison.Ordinal) || text.Length == platform.Length + 1)
            throw new PackageException(PackageProblem.BadManifest, $"the {platform} entry '{text}' is not inside the {platform} folder");
        return text;
    }

    static Dictionary<string, string> FileTable(JsonElement root)
    {
        if (!root.TryGetProperty("files", out var f) || f.ValueKind != JsonValueKind.Object)
            throw new PackageException(PackageProblem.BadManifest, "manifest has no 'files' table");
        var table = new Dictionary<string, string>(StringComparer.Ordinal);
        foreach (var p in f.EnumerateObject())
        {
            CheckPath(p.Name);
            if (p.Name is PackageSigning.ManifestName or PackageSigning.SignatureName)
                throw new PackageException(PackageProblem.BadManifest, $"'{p.Name}' cannot be listed in its own file table");
            if (p.Value.ValueKind != JsonValueKind.String || !p.Value.GetString()!.StartsWith("sha256:", StringComparison.Ordinal))
                throw new PackageException(PackageProblem.BadManifest, $"'{p.Name}' needs a 'sha256:' hash");
            table[p.Name] = p.Value.GetString()!;
        }
        return table;
    }

    static bool Matches(byte[] hash, string expected)
        => string.Equals("sha256:" + Convert.ToHexStringLower(hash), expected, StringComparison.OrdinalIgnoreCase);

    // ---- writing --------------------------------------------------------------------------------

    static void Extract(Dictionary<string, ZipArchiveEntry> entries, Dictionary<string, string> files,
        byte[] manifest, byte[]? signature, string temp, long maxTotal)
    {
        Directory.CreateDirectory(temp);
        File.WriteAllBytes(Path.Combine(temp, PackageSigning.ManifestName), manifest);
        if (signature is not null) File.WriteAllBytes(Path.Combine(temp, PackageSigning.SignatureName), signature);
        long written = 0;
        foreach (var (path, expected) in files)
        {
            var target = Path.GetFullPath(Path.Combine(temp, path));
            if (!target.StartsWith(Path.GetFullPath(temp) + Path.DirectorySeparatorChar, StringComparison.Ordinal))
                throw new PackageException(PackageProblem.UnsafePath, $"'{path}' would be written outside the install folder");
            Directory.CreateDirectory(Path.GetDirectoryName(target)!);
            using var hash = IncrementalHash.CreateHash(HashAlgorithmName.SHA256);
            using (var input = entries[path].Open())
            using (var output = new FileStream(target, FileMode.CreateNew, FileAccess.Write, FileShare.None))
            {
                var buffer = new byte[81920];
                int n;
                while ((n = input.Read(buffer)) > 0)
                {
                    written += n;
                    if (written > maxTotal) throw new PackageException(PackageProblem.TooLarge, $"the package expands to more than {maxTotal} bytes");
                    hash.AppendData(buffer, 0, n);
                    output.Write(buffer, 0, n);
                }
            }
            if (!Matches(hash.GetHashAndReset(), expected))
                throw new PackageException(PackageProblem.HashMismatch, $"'{path}' does not match the hash in the manifest");
        }
    }

    /// <summary>Read-only everywhere; on Unix also the execute bit for the entry and no write bits on folders.</summary>
    static void Lock(string dir, string entryPath)
    {
        foreach (var file in Directory.EnumerateFiles(dir, "*", SearchOption.AllDirectories))
        {
            if (OperatingSystem.IsWindows()) File.SetAttributes(file, FileAttributes.ReadOnly);
            else
            {
                var isEntry = string.Equals(Path.GetRelativePath(dir, file).Replace('\\', '/'), entryPath, StringComparison.Ordinal);
                File.SetUnixFileMode(file, isEntry ? UnixFileMode.UserRead | UnixFileMode.UserExecute : UnixFileMode.UserRead);
            }
        }
        if (!OperatingSystem.IsWindows())
            foreach (var d in Directory.EnumerateDirectories(dir, "*", SearchOption.AllDirectories).Reverse().Append(dir))
                File.SetUnixFileMode(d, UnixFileMode.UserRead | UnixFileMode.UserExecute);
    }

    static void Remove(string dir)
    {
        if (!Directory.Exists(dir)) return;
        foreach (var d in Directory.EnumerateDirectories(dir, "*", SearchOption.AllDirectories).Append(dir))
            if (!OperatingSystem.IsWindows()) File.SetUnixFileMode(d, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.UserExecute);
        foreach (var f in Directory.EnumerateFiles(dir, "*", SearchOption.AllDirectories))
            File.SetAttributes(f, FileAttributes.Normal);
        Directory.Delete(dir, recursive: true);
    }
}
