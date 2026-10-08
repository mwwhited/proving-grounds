# Open Questions

> Part of the plugin sandbox design (§18). Index and review status: [../design.md](../design.md). Diagrams: [../diagrams/](../diagrams/).

## 18. Open Questions

1. How strong must the macOS guarantee be, given no kill-on-parent-death primitive and weak resource limits?
2. Is the optional WASM path worth building in v1, or after native packages are stable?
3. Should long-running telemetry plugins be Detached children or OS services with the host as a client?
4. Fat packages (all platforms in one file) or per-platform packages with a registry?
5. Which SDK languages ship first?

**Added 2026-10-08 (proposed sections 10-13):**

6. Approval timing: install time, first use, per use, or a mix? Which permission kinds always prompt?
7. Should any permission require **two approvers** (dual control), and who is the "second" party (an admin, or the owner of the external data)?
8. How do plugins use standard drivers with no custom transport? SDK stream API only, or a local SOCKS5/`CONNECT` endpoint over a Unix socket or named pipe (which relaxes "plugins cannot create sockets")?
9. Data-plane performance: is channel-multiplexed streaming with credit-based flow control fast enough for bulk data, or should bulk data use passed handles or a separate pipe?
10. Which backends, if any, get a semantic broker or protocol helper (Mongo, FTP), versus blind tunnels only?
11. How are wildcard host approvals constrained (allowed suffixes, DNS-based checks, review wording)?
12. Detached plugins and brokered access: orphan-mode buffering, or run needy plugins as OS services with their own scoped network access? (§11.7)
13. Is peer-to-peer ever supported, or always denied?
14. Is the optional Windows firewall layer (§12.1) worth the elevation and cleanup cost?
15. Should plugins that exceed limits be quarantined automatically, or only warned until an operator acts?

**Claims to verify before building** (written from general knowledge, not checked against current documentation):

- Windows Firewall and WFP matching on AppContainer package SID (`New-NetFirewallRule -Package`, `ALE_PACKAGE_ID`), and whether FQDN rules are available outside managed scenarios.
- AppContainer loopback behavior, including whether a plugin can connect to its own listener.
- Job object CPU hard-cap and memory-limit options, and what disk I/O limits exist on Windows.
- Linux unprivileged user and network namespaces, including distribution restrictions, and cgroup v2 delegation to an unprivileged supervisor.
- Landlock network rules cover TCP ports only (not hostnames), and from which kernel version.
- Whether the .NET MongoDB driver (and other target drivers) accept a custom stream or transport factory.
- Handle passing: `DuplicateHandle` into an AppContainer process, `WSADuplicateSocket`, fd passing over `AF_UNIX`, and whether the sandbox rules allow them.
- macOS options for resource limiting and network scoping beyond Seatbelt.
