namespace OoBDev.Plugins.Packaging;

public enum PackageProblem
{
    /// <summary>The package has no build for this platform. Reported before anything is extracted.</summary>
    PlatformUnavailable,
    BadManifest,
    Unsigned,
    UntrustedKey,
    BadSignature,
    HashMismatch,
    MissingFile,
    UnlistedFile,
    UnsafePath,
    TooLarge,
    TamperedInstall,
}
