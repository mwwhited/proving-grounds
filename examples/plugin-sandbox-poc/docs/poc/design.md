# POC design

The full design is in [`../design.md`](../design.md). This page covers only what the POC builds: what exists, what is next, and how the pieces relate. `§N` cites that design. Paths such as `host-sim/` and `PROFILE.md` are in the POC code folder (`proving-grounds/examples/plugin-sandbox-poc/`), see [README.md](README.md).

## What the POC proves, in order of risk

1. **The contract works across languages** (framing, envelope, heartbeat, shutdown, config). Proven by the examples.
2. **The supervisor model works** (desired state versus actual state, backoff, crash-loop limit, intentional stop not restarted). §7.
3. **The OS sandbox holds** and is applied before the plugin's first instruction. §4. This is the riskiest and least proven claim.
4. **Bound plugins die with the host.** §6.1.

Everything after that (packaging, Detached mode, brokered access, approvals) depends on these four.

## Components

```
                     ┌───────────────────────────────┐
  your app ────────▶ │  Host (.NET)                  │
                     │   PluginManager               │
                     │    ├─ Supervisor (per plugin) │  desired vs actual state, backoff
                     │    ├─ Router + Policy         │  stamps Source, default-deny
                     │    └─ IPluginLauncher         │  one per OS
                     └──────────────┬────────────────┘
                                    │ framed JSON over stdin/stdout (one channel per plugin)
                     ┌──────────────▼────────────────┐
                     │  Sandbox boundary (per OS)    │  AppContainer + job object / Landlock + seccomp
                     │   Plugin process, any language│
                     └───────────────────────────────┘
```

| Component | Status | Notes |
|:--|:--|:--|
| Wire profile (`PROFILE.md`) | **Done** | Example encoding; not a settled decision |
| Example plugins | **Done** | Python, C#, Node, plus the `chaos` fixture |
| Stand-in host (`host-sim/`) | **Done** | Frame I/O, `Source` stamping, `config.get`, kill on violation. No sandbox |
| Protocol library | Next | Framing and envelope as a reusable .NET library |
| Supervisor | Next | The §7 state machine |
| Router and policy | Next | Default-deny publish/subscribe/sendTo, rate limits |
| `IPluginLauncher` + Windows launcher | Next | AppContainer, per-plugin job, handle list |
| Linux shim and launcher | Later | Native shim: Landlock, seccomp, pdeathsig, then `execve` |
| Package loader | Later | Platform selection, hash and signature checks |

## The stand-in host

`host-sim/hostsim.py` exists so plugins can be tested before the real host does. It is a **specification by example**, not a throwaway:

- It implements the duties a real host has toward the wire: bounded frames, strict parsing, host-stamped `Source`, answering `config.get`, killing on a violation.
- The 36 checks in `run_tests.py` are written against *behaviour*, so in phase 1 the same checks should run against the real host through a thin adapter, with the plugins untouched (P10).
- It deliberately does **no** sandboxing. A passing run says nothing about isolation.

## Proposed project split (for later promotion)

Names are suggestions, chosen so the move into dotex is a rename, not a rewrite.

| Project | Contents | Depends on | Destined for |
|:--|:--|:--|:--|
| `OoBDev.Plugins.Protocol` | Envelope, framing, strict serializer, limits | nothing | dotex (Framework layer if shared) |
| `OoBDev.Plugins.Host` | Manager, supervisor, router, policy, manifest types | Protocol | dotex (Extensions) |
| `OoBDev.Plugins.Launchers.Windows` | AppContainer and job-object launcher | Host | dotex, as a package |
| `OoBDev.Plugins.Launchers.Linux` | Launcher plus the native shim as a RID asset | Host | dotex, as a package |
| `OoBDev.Plugins.Conformance` | Test plugins and runner | Protocol | dotex test package |
| Non-.NET SDKs | Python, Go, Rust and so on | the profile | Their own ecosystems' registries |

Rules that keep the move cheap:

- The Protocol and Host projects take no dependency on the POC or on any launcher.
- OS-specific code stays behind `IPluginLauncher`. About 70-80% of the host should be shared (planning shell CLAUDE.md).
- Each project has its own tests from day one, with a README, to meet dotex's build rules later.

## Key decisions the POC inherits (do not relitigate)

Out-of-process only; the protocol is the contract; one executable per platform; sandbox applied before the first instruction; fail closed; desired-versus-actual supervisor; host stamps `Source`; default-deny policy; idempotent, restartable plugins; heartbeat answered by the request loop. See planning shell CLAUDE.md, "Settled decisions".

## Decisions the POC must make

| Question | Why it matters | When |
|:--|:--|:--|
| Final wire encoding (JSON frames, protobuf, JSON-RPC) | Affects every SDK and the performance budget | Before phase 1 exits |
| Plugin client API shape in the host | The thing app developers touch | Phase 1 |
| Whether `IPluginLauncher` can hide the OS differences cleanly | Decides the 70-80% shared-code target | Phase 2 |
| macOS guarantee level (§18, question 1) | No kernel kill-on-parent-death | Before phase 7 |

## Known limits of the current code

- No isolation of any kind. Plugins run as ordinary child processes.
- No supervisor restarts, no router, no packaging.
- The flood check counts frames in one second; it is not a rate limiter.
- Examples use the system interpreter, which real packages must not (§3).
