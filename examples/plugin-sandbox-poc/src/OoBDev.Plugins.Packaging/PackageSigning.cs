using System.Security.Cryptography;
using System.Text.Json;

namespace OoBDev.Plugins.Packaging;

/// <summary>
/// ECDSA P-256 over the exact bytes of <c>manifest.json</c>, stored beside it as <c>manifest.sig</c>
/// (<c>{"keyId":"...","alg":"ES256","sig":"base64"}</c>). Detached, so nothing has to be canonicalised;
/// the manifest's <c>files</c> table carries the file hashes, so signing the manifest signs every file.
/// </summary>
public static class PackageSigning
{
    public const string ManifestName = "manifest.json";
    public const string SignatureName = "manifest.sig";

    public static byte[] Sign(ECDsa key, string keyId, byte[] manifest)
    {
        var sig = key.SignData(manifest, HashAlgorithmName.SHA256, DSASignatureFormat.IeeeP1363FixedFieldConcatenation);
        return JsonSerializer.SerializeToUtf8Bytes(new { keyId, alg = "ES256", sig = Convert.ToBase64String(sig) });
    }

    public static byte[] PublicKey(ECDsa key) => key.ExportSubjectPublicKeyInfo();

    /// <summary>Checks a <c>manifest.sig</c> against the trusted keys. Throws a <see cref="PackageException"/> unless it verifies.</summary>
    public static void Verify(byte[] manifest, byte[] signature, IReadOnlyDictionary<string, byte[]> trusted)
    {
        string keyId, alg;
        byte[] sig;
        try
        {
            using var doc = JsonDocument.Parse(signature, new JsonDocumentOptions { MaxDepth = 4 });
            keyId = doc.RootElement.GetProperty("keyId").GetString() ?? "";
            alg = doc.RootElement.GetProperty("alg").GetString() ?? "";
            sig = Convert.FromBase64String(doc.RootElement.GetProperty("sig").GetString() ?? "");
        }
        catch (Exception ex) when (ex is JsonException or KeyNotFoundException or InvalidOperationException or FormatException)
        {
            throw new PackageException(PackageProblem.BadSignature, "manifest.sig is not a valid signature file");
        }
        if (alg != "ES256") throw new PackageException(PackageProblem.BadSignature, $"unsupported signature algorithm '{alg}'");
        if (!trusted.TryGetValue(keyId, out var spki))
            throw new PackageException(PackageProblem.UntrustedKey, $"the package is signed by '{keyId}', which is not a trusted key");
        using var key = ECDsa.Create();
        key.ImportSubjectPublicKeyInfo(spki, out _);
        if (!key.VerifyData(manifest, sig, HashAlgorithmName.SHA256, DSASignatureFormat.IeeeP1363FixedFieldConcatenation))
            throw new PackageException(PackageProblem.BadSignature, "the manifest does not match its signature");
    }
}
