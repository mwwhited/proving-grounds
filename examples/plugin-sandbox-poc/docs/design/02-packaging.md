# Packaging and Platform Support

> Part of the plugin sandbox design (§3). Index and review status: [../design.md](../design.md). Diagrams: [../diagrams/](../diagrams/).

## 3. Packaging and Platform Support

The contract is **the protocol, not a runtime**. No cross-platform runtime exists for every language, so a plugin is a package containing one executable per platform, and the host selects the match.

```
telemetry-1.2.0.plugin   (zip)
├─ manifest.json
├─ win-x64/telemetry.exe
├─ win-arm64/telemetry.exe
├─ linux-x64/telemetry
├─ linux-arm64/telemetry
├─ osx-universal/telemetry
└─ plugin.wasm            (optional, portable)
```

```json
{
  "id": "telemetry",
  "version": "1.2.0",
  "protocol": "2.1",
  "entry": {
    "wasm": "plugin.wasm",
    "win-x64": "win-x64/telemetry.exe",
    "linux-x64": "linux-x64/telemetry",
    "linux-arm64": "linux-arm64/telemetry",
    "osx-universal": "osx-universal/telemetry"
  },
  "platforms": ["win-x64", "linux-x64", "linux-arm64", "osx-universal"],
  "lifetime": "Bound",
  "capabilities": {
    "data": "rw",
    "publish": ["device.readings"],
    "subscribe": ["config.updated"],
    "sendTo": ["analytics"]
  },
  "files": { "win-x64/telemetry.exe": "sha256:...", "linux-x64/telemetry": "sha256:..." },
  "signature": "..."
}
```

**Support tiers**

| Tier | Languages | Packaging |
|---|---|---|
| 1 | .NET, Rust, Go, C/C++ | Native binary per platform, or WASM |
| 2 | Python, Node, Java | Runtime bundled into each platform folder |
| 3 | Anything else | Author supplies per-platform executables that pass conformance |

**Host responsibilities**
- **Select by platform:** detect OS and architecture and pick the entry. If none matches, report "unavailable on this platform" before launch. Emulation (Rosetta, x64-on-ARM64) is opt-in.
- **Verify, then extract:** check the signature and per-file hashes, extract to a host-owned read-only location, and never run from a writable folder. Set the execute bit on Unix.
- **Grant only the selected platform folder** to the sandbox, not the whole package.
- **Linux libc:** require static or musl builds, or treat `linux-musl-x64` as its own platform.
- **macOS:** Apple Silicon requires at least an ad-hoc signature. Either strip quarantine on files you verified yourself or require signed and notarized binaries.
- **Interpreted languages:** bundle the runtime. This keeps sandbox grants minimal and the version predictable.
- **Platform support is earned:** a platform is listed in `platforms` only after the plugin passes the conformance suite on that OS.

**WASM (optional)**
- Hosted with Wasmtime (NuGet), ideally in a small sandboxed host process.
- It's the only single-file portable format and has the strongest default sandbox (no files or network unless granted).
- Use epoch interruption for CPU caps and memory limits for RAM. Expect roughly 1.1-2x native on compute-heavy code, and near native for I/O-bound work. Cache precompiled modules.
- Language support, threads, and sockets are limited, so it's an option and never a requirement.
