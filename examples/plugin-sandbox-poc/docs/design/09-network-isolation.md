# Network Isolation (proposed)

> Part of the plugin sandbox design (§12). Index and review status: [../design.md](../design.md). Diagrams: [../diagrams/](../diagrams/).

## 12. Network Isolation (proposed)

**Baseline: plugins use no host ports at all.** The channel is stdio, a socketpair or a pipe (§5.2), not TCP. Tunnels, files and plugin-to-plugin traffic all ride on it. The only ports consumed are the host's own ephemeral ports for approved outbound connections, bounded by `maxStreams` (§13).

| OS | Isolation | Notes |
|---|---|---|
| Linux | Add an **empty network namespace** per plugin (`CLONE_NEWNET`, usually with a user namespace) on top of seccomp and Landlock | Only a private loopback exists. Even a gap in the seccomp filter finds no interface to send on, and a plugin that wants an internal loopback gets its own `127.0.0.1`, so identical port numbers never collide. Unprivileged user namespaces are restricted on some distributions, so the shim may need a capability or configuration. |
| Windows | AppContainer with no capabilities. Loopback to other processes is blocked by default for AppContainers | AppContainer does not give a plugin its own IP address. A genuinely separate network stack means Windows containers via the Host Compute Network service, or Hyper-V isolation. These are heavier and conflict with the low-latency goal, so treat them as an optional backend. |
| macOS | Seatbelt `deny network*` | No network namespace equivalent. Deny-only. |

- **Docker/OCI containers** per plugin are an optional backend. `--network none` yields the same island and an internal network can give an IP. It adds a runtime dependency, so it is not the baseline.
- **Plugins reachable from outside** never get an externally reachable address. The host owns the listener and forwards (§11.1).
- **Optional source-address attribution:** if the machine has several addresses, the host may bind a distinct source address per plugin so firewall logs identify plugins.

### 12.1 Windows Firewall as a second layer (optional)

Windows Firewall and the Windows Filtering Platform can match an AppContainer by **package SID** (for example PowerShell's `New-NetFirewallRule -Package <SID>`, or the `ALE_PACKAGE_ID` condition in WFP). A host can give a plugin's SID a block-all rule, which backs up the "no capabilities" rule. Caveats:

- Creating rules needs elevation (installer or service), and rules are machine-wide state that can go stale. Reconcile on startup and remove on uninstall.
- Rules match addresses and ports, not hostnames.
- Windows only. Nothing equivalent exists on Linux or macOS.

Because the broker is the portable mechanism, the firewall rule is defense in depth, not a replacement.
