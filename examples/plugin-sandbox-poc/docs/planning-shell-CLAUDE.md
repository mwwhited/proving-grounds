# Plugin Sandboxing & Lifecycle Management

This project was migrated from a claude.ai design conversation. It holds a completed design and reference code sketches. **No production code exists yet.** Start by reading `docs/design.md` (an index to the topic files in `docs/design/`; `§` numbers cited anywhere map to files through its section table), then `docs/decision-log.md` for the reasoning and the corrections made along the way.

## What we're building

A plugin system for the user's own .NET 10 application:

- Third-party plugins, **written in any language**, run as separate sandboxed child processes.
- Plugins get **no network** and **only host-selected files**.
- The host app manages each plugin's whole lifecycle: start, stop, restart, crash and hang recovery.
- Two lifetime policies per plugin: **Bound** (dies with the host, even on crash) and **Detached** (survives a host crash, e.g. telemetry collection).
- Windows, Linux and macOS, with one protocol, one manifest and one policy model.
- Hub-and-spoke communication: every plugin has exactly one channel, to the host. Plugin-to-plugin traffic is always routed (and policy-checked) by the host.
- Minimal latency: a one-time startup cost, nothing per call.

## Settled decisions (do not relitigate without a reason)

1. **Out-of-process only.** In-process sandboxing of native code isn't feasible, and .NET has no in-process security boundary (no CAS or AppDomain isolation).
2. **The protocol is the contract**, not a runtime or interface. Plugins are any-language executables that speak a framed protocol over stdio. Thin SDKs are optional conveniences.
3. **No cross-platform runtime exists for every language**, so there is no "compile once, run anywhere". Plugin packages contain **one executable per platform** (RID), and the host selects the match. WASM (Wasmtime) is an optional extra entry type, never a requirement.
4. **Sandbox is applied before the plugin's first instruction.** Windows uses AppContainer set at `CreateProcess`. Linux uses a small native shim (Landlock, seccomp, `NO_NEW_PRIVS`, pdeathsig) that then `execve`s the plugin. macOS uses Seatbelt (`sandbox_init`) via a shim.
5. **Fail closed**: if any sandbox step fails, the plugin does not run.
6. **Supervisor model = desired state vs actual state.** `Start`/`Stop` change intent, and one loop per plugin reconciles reality. Intentional stop never triggers a restart.
7. **Host stamps `Source`** on every frame from the channel it arrived on. Plugin-supplied sender values are ignored.
8. **Default-deny policy** declared per plugin in the manifest (publish, subscribe, sendTo, limits).
9. **Plugins must be idempotent and restartable** (killable at any instant), not "reentrant". The host owns committed state.
10. **Heartbeat must be answered by the same loop that handles requests**, so a deadlocked plugin can't keep beating from a side thread.

## Proposed additions (2026-10-08, awaiting review, not settled)

A follow-up discussion added a permission and brokering layer. Treat these as proposals until the user confirms them; do not code against them without asking. Details are in `docs/design.md` §10-13 and scenarios in `docs/use-cases.md`.

- Plugins **declare** external file and network needs in the manifest; the host operator **approves** them separately. Effective policy = requested ∩ approved ∩ host ceiling.
- Approved access is **brokered by the host** over the channel. The OS sandbox stays deny-all.
- Network access defaults to **blind tunnels** (no TLS termination). The host resolves DNS and refuses private, loopback and metadata addresses. Semantic brokers and protocol helpers (Mongo, FTP) are opt-in.
- Plugins use **no host ports**. Linux adds an empty network namespace. Windows Firewall package-SID rules are an optional second layer.
- Resource control is two-layer: OS hard limits plus host soft limits, with an escalation ladder ending in quarantine.
- Several OS-level claims in these sections are **unverified** (listed in `design.md` §18). Verify before relying on them.

## Corrections made during design (code in `reference/` already reflects these)

- **One job object per plugin**, not one shared static job. `ActiveProcessLimit = 1` is per job.
- **Windows handle inheritance:** the early sketch used `bInheritHandles = false`. With stdio channels the rule is now "inherit **only** the listed handles" via `PROC_THREAD_ATTRIBUTE_HANDLE_LIST` with `bInheritHandles = true`.
- **Linux seccomp is a deny-list**, allows thread creation (Go, Node and the JVM need it), and does **not** deny `execve` (the shim's own exec must succeed). Landlock's execute right controls what can run.
- **Landlock and seccomp must be applied by the shim before exec**, not from managed code after the runtime has started threads.
- **Detached plugins can't use inherited stdio**, since it dies with the host. They listen on a well-known endpoint (named pipe with ACL / Unix socket in a `chmod 700` dir) and the host reattaches using a state file (PID + start time + endpoint + token).

## Repository layout

```
CLAUDE.md                     this file
docs/design.md                design index: section map (§ numbers to files), review status, reading paths
docs/design/*.md              the design in 12 topic files (01 goals/architecture ... 12 open questions), with PlantUML
docs/decision-log.md          decisions, rationale, rejected options, open questions
docs/use-cases.md             scenarios the design should serve, with status and open items
docs/diagrams/src/*.puml      diagram sources (10-12 are proposed and not yet rendered)
docs/diagrams/svg/*.svg       rendered diagrams
reference/windows/            AppContainer launcher + per-plugin job object (C# sketches)
reference/shared/             ManagedPlugin supervisor + PluginManager (C# sketch)
```

The files in `reference/` are **design sketches, not compiled or tested**. Treat them as a starting point. They were written in conversation without a compiler.

## Suggested build order

1. Protocol + SDKs (.NET plus one more language), router, policy, supervisor
2. Package format, manifest, signature/hash verification, platform selection
3. Linux shim + launcher (Landlock, seccomp, pdeathsig)
4. Windows launcher (AppContainer, per-plugin job)
5. Conformance suite in CI (the real portability guarantee)
6. Detached mode + reconnect
7. macOS launcher (reduced guarantees)
8. Optional WASM entry, LPAC, cgroups, more SDKs

## Open questions (ask the user before assuming)

1. How strong must the macOS guarantee be? (No kernel kill-on-parent-death, weak resource limits.)
2. Is WASM worth building in v1 or after native packages are stable?
3. Should long-running telemetry plugins be Detached children, or OS services (Windows Service / systemd / launchd) with the host as a client?
4. Fat packages (all platforms in one file) or per-platform packages with a registry?
5. Which SDK languages ship first?
6-15. Approval timing, dual control, driver access to the broker, bulk-data path, which backends get semantic brokers, wildcard limits, Detached plugins with network needs, peer-to-peer, the Windows firewall layer, automatic quarantine. See `docs/design.md` §18.

## Conventions

- Target .NET 10 for the host. Keep OS-specific code behind `IPluginLauncher`. About 70-80% of the host should be shared.
- Never use type-name or polymorphic deserialization on protocol payloads. Use strict-schema serializers.
- Every host-side wait on a plugin needs a timeout.
- Render diagrams with: `java -jar plantuml.jar -tsvg -o ../svg docs/diagrams/src/*.puml` (needs Java and Graphviz).
