# Use Cases

Scenarios the design should serve, collected from a follow-up discussion on 2026-10-08. Each one names the sections of `design.md` it relies on and what is still unresolved. Everything in the "proposed" sections of `design.md` (§10-13) is unreviewed; use this file to check the design against concrete needs.

Status key: **Covered** (existing design handles it), **Proposed** (handled by a proposed section), **Gap** (not yet handled).

| # | Use case | Status | Design sections |
|---|---|---|---|
| 1 | Default-deny plugin | Covered | §4 |
| 2 | Third-party plugin manages external data, with a separate approval | Proposed | §10, §11 |
| 3 | Plugin talks to an external MongoDB (blind tunnel) | Proposed | §11.2, §11.4 |
| 4 | Plugin transfers files over FTP or SFTP | Proposed | §11.1, §11.2, §11.4 |
| 5 | Plugin receives multicast or broadcast telemetry | Proposed | §11.1 |
| 6 | Plugin hosts a webhook or server (inbound) | Proposed | §11.1 |
| 7 | Peer-to-peer plugin | Proposed (deny by default) | §11.1 |
| 8 | Plugin reads external files | Proposed | §11.5 |
| 9 | Plugin tries to attack a third party through its tunnel | Proposed | §11.2, §13.2 |
| 10 | Plugin consumes too much CPU, memory, I/O or bandwidth | Proposed | §13 |
| 11 | Many plugins, no local port conflicts | Proposed | §12 |
| 12 | Defense in depth with Windows Firewall | Proposed (optional) | §12.1 |
| 13 | Detached telemetry plugin needs external network access | Gap | §6.2, §11.7 |
| 14 | Plugin upgrade asks for more permission | Proposed | §10.2 |
| 15 | Operator revokes a permission while the plugin runs | Proposed | §10.2, §11 |

---

## 1. Default-deny plugin

**Scenario.** A third-party plugin in any language runs with no network, no process spawning, and access only to its own folder (read) and a per-plugin data directory.

**How it works.** OS sandbox applied before the plugin's first instruction (AppContainer / Landlock + seccomp / Seatbelt). Fail closed.

**Open.** macOS guarantees are weaker (open question 1).

---

## 2. Third-party plugin manages external data, with a separate approval

**Scenario.** A plugin from another vendor needs to manage data that lives outside the hosted application: files in a user folder, a database, a remote service. The author says what it needs; the host operator or user separately decides whether to allow it.

**How it works.**
1. The manifest `permissions` section declares each need with a `reason` (§10.1). It is signed with the package.
2. At install or first use, the host shows the request, including warnings for risky combinations (§10.4), and records the decision against the package hash and signer (§10.2).
3. Effective policy = requested ∩ approved ∩ host ceiling (§10.3).
4. The plugin gets access only through the host broker (§11). The OS sandbox is unchanged.

**What the approver sees.** What, why, which endpoint or path, limits, and "this lets data leave the host" when file or data access is combined with any network permission.

**Open.** Approval timing, dual control (open questions 6 and 7).

---

## 3. Plugin talks to an external MongoDB

**Scenario.** A plugin reads and writes an external Mongo database over TLS. Replica sets and `mongodb+srv://` are common.

**Difficulty.** Drivers open several connections: they resolve SRV records, connect to a seed, learn the member list from the server, then connect to each member. Credentials normally live in the plugin.

**Options (from least to most host involvement).**
- **Blind tunnel** (default). The host relays TCP to the declared members and never terminates TLS. The manifest lists every member or an approved wildcard, and the plugin uses a host DNS lookup call for SRV/TXT. Enforces destination, volume and time; cannot enforce which operations run (§11.2).
- **Semantic broker.** The plugin calls `data.find(...)`; the host holds credentials and runs the query. Enables "read-only on these collections" (§11.4).
- **Protocol-aware proxy** that parses the wire protocol. Possible but fragile, so later.

**Manifest sketch.**
```json
{ "id": "orders-db", "transport": "tcp", "mode": "blind",
  "host": "mongo.example.com", "port": 27017,
  "secondary": [ { "host": "mongo2.example.com", "port": 27017 } ],
  "reason": "Read and write order records in the customer's MongoDB" }
```

**Open.** Whether the target driver accepts a custom transport (§11.6, open question 8); which backends get a semantic broker (open question 10).

---

## 4. Plugin transfers files over FTP or SFTP

**Scenario.** A plugin pulls or pushes files on a remote server.

**SFTP / SSH** uses one connection, so a blind tunnel is enough. **Prefer it.**

**FTP** opens a second data connection whose port appears inside the control stream. In passive mode the client connects out to that port; in active mode the server connects back in.
- Blind tunnel: only works if every possible data host and port is declared. Passive ports are typically a range, which must then be approved as a range.
- Protocol helper: an FTP gateway reads the passive reply, opens exactly that data connection to the same host, and closes it with the session. Active mode is refused (§11.4).
- FTPS encrypts the control channel, so a helper cannot read it. Use SFTP, declare ranges, or accept that the host would have to terminate TLS (which defeats blind mode).

**Open.** Whether to ship an FTP helper at all, or declare FTP out of scope.

---

## 5. Plugin receives multicast or broadcast telemetry

**Scenario.** A plugin consumes a UDP multicast feed from instruments on the LAN (related to the synchronized-telemetry research elsewhere in this notebook).

**How it works.** The plugin declares a `groups` permission (group, port, direction, interface). The host joins the group on an approved interface and delivers datagrams to each plugin approved for that group, so fan-out stays hub-and-spoke (§11.1, §11.3). Rate and size limits apply (§13.2).

**Open.** Interface selection on multi-homed machines. Timing accuracy through the host hop if synchronization matters.

---

## 6. Plugin hosts a webhook or server (inbound)

**Scenario.** A plugin must accept inbound HTTP calls.

**How it works.** The **host** owns the listening socket with an approved port, bind interface and allowed source ranges. Accepted connections are passed to the plugin as streams (`Listen` / `Accepted`). The plugin never gets an externally reachable address (§11.1, §12). Review shows an explicit inbound warning.

---

## 7. Peer-to-peer plugin

**Scenario.** A plugin joins a mesh or file-sharing network where peers are not known in advance.

**How it works.** Per-peer allowlists are impossible, so policy is by class only: a port range, byte quotas and connection caps. Peer-to-peer is **denied by default** and gets the strongest review warning. Whether it is ever supported is open (question 13).

---

## 8. Plugin reads external files

**Scenario.** A plugin needs files outside its own folders, such as a user's export directory.

**How it works.** `files` permission with `delivery: handle`. The host opens the path, resolves symlinks and traversal itself, and hands over a read-only handle or a stream (§11.5). Limit: plugins that need real filesystem paths don't work through handles.

---

## 9. Plugin attacks a third party through its tunnel

**Scenario.** A malicious or buggy plugin floods the approved external service, or tries to reach other destinations through it.

**How it works.** The allowlist denies other destinations. DNS is resolved by the host, and loopback, private, link-local and metadata addresses are refused unless named (§11.2). Rate, byte, duration and stream limits protect the external service (§13.2). Every connection is logged.

**Not covered.** Abuse of the approved endpoint's own API, since blind tunnels cannot see operations.

---

## 10. Plugin consumes too much CPU, memory, I/O or bandwidth

**Scenario.** A plugin spins, leaks, floods the channel, or hogs bandwidth.

**How it works.** OS hard limits (job object, cgroup) stop runaway CPU, memory, processes and disk. Host soft limits (token buckets, bounded queues, stream caps) throttle channel and tunnel traffic. Escalation: allow burst → throttle → warn → kill and restart → quarantine (§13.3). Each plugin has its own service loop so a flood cannot stall others.

**Open.** Automatic quarantine versus warn-only (open question 15).

---

## 11. Many plugins, no local port conflicts

**Scenario.** Several plugins, possibly with their own internal services, run on one machine without competing for localhost ports.

**How it works.** Plugins use the host channel, not TCP, so they consume no host ports (§12). On Linux an empty network namespace per plugin gives each its own private loopback. On Windows, AppContainer has no network and no loopback to others; a separate IP per plugin needs Windows containers (optional). macOS: deny-only.

---

## 12. Defense in depth with Windows Firewall

**Scenario.** An operator wants a second, OS-level network block under the AppContainer rule.

**How it works.** A block-all firewall rule scoped to the plugin's package SID (§12.1). Needs elevation and cleanup; Windows only; address-based, not hostname-based. The broker remains the portable mechanism.

---

## 13. Detached telemetry plugin needs external network access (gap)

**Scenario.** A Detached telemetry plugin keeps collecting after the host crashes and needs to send data to an external service.

**Problem.** Brokered access dies with the host. A Detached plugin has no broker while the host is down (§11.7).

**Options.** Orphan mode: buffer to disk with a size and age cap until the host returns. Or run it as an OS service with its own narrowly scoped direct network access, outside this plugin model. Open question 12.

---

## 14. Plugin upgrade asks for more permission

**Scenario.** Version 1.3 of a plugin adds a new network endpoint.

**How it works.** Approvals are keyed to package hash and signer. A new version requesting anything not already approved, or a wider limit, needs re-approval; a version asking for a subset keeps its approvals (§10.2).

---

## 15. Operator revokes a permission while the plugin runs

**Scenario.** An operator decides a plugin should no longer reach the external database.

**How it works.** Revocation takes effect immediately for brokered access: open streams close and further opens are denied, with no restart. A change that affects the OS sandbox restarts the plugin (§10.2, §11).

---

## Cross-cutting requirements these cases share

- Everything outside the declared, approved and ceiling-allowed set is denied, and denials are logged.
- The host stamps the source of every request; plugins never name each other or choose their own identity.
- Every wait and every queue is bounded.
- Anything involving a data-leaves-the-host combination is surfaced to the approver in plain language.
