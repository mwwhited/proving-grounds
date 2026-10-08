namespace OoBDev.Plugins.Packaging;

public sealed record PackageOptions
{
    /// <summary>Key id to public key (SubjectPublicKeyInfo, ECDSA P-256). A signature from any other key is rejected.</summary>
    public IReadOnlyDictionary<string, byte[]> TrustedKeys { get; init; } = new Dictionary<string, byte[]>();

    /// <summary>When false an unsigned package is accepted (development only). A signature that is present must still verify.</summary>
    public bool RequireSignature { get; init; } = true;

    public string Platform { get; init; } = PlatformId.Current;
    public long MaxTotalBytes { get; init; } = 512L * 1024 * 1024;
    public int MaxEntries { get; init; } = 10_000;
}
