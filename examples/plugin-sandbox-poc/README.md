# Example plugins and test harness

Example plugins for the sandboxed plugin system, in three languages, plus a stand-in host that runs them. Written against the design in `plugin-sandbox-project/docs/design/`.

**What this is not:** a sandbox. There is no host, launcher, permission model or isolation here. Plugins run as ordinary child processes. What the examples prove is the *protocol contract*: framing, heartbeat, lifecycle, config, and what the host must detect when a plugin misbehaves. The wire encoding is an **example profile**, not a settled decision (see `PROFILE.md`).

## Contents

| Path | What |
|:--|:--|
| `CLAUDE.md` | Instructions for working on the POC: read order, rules, scope |
| `docs/` | Snapshot of the design (index, 12 topic files, decision log, use cases, diagrams) and the POC docs in `docs/poc/` (use cases, journeys, design, plan). See `docs/SNAPSHOT.md` |
| `reference/` | Uncompiled C# sketches: Windows launcher, per-plugin job, supervisor. Starting points, not tested |
| `PROFILE.md` | The wire profile: framing, envelope, the six rules every plugin follows |
| `plugins/echo-python/` | Smallest conforming plugin (stdlib only). `echo`, `add` |
| `plugins/echo-dotnet/` | Same behaviour in C# (.NET 10, stdlib only) |
| `plugins/ticker-node/` | Publishes `demo.tick` events; asks the host for config (`config.get`) |
| `plugins/chaos-python/` | **Test fixture.** Misbehaves on purpose (8 modes). Never a template |
| `host-sim/hostsim.py` | Stand-in host: frame I/O, `Source` stamping, `config.get`, kill on violation |
| `host-sim/run_tests.py` | Conformance checks for the good plugins, detection checks for the chaos one |

## Requirements

Python 3.10+, Node 18+ (for `ticker-node`), .NET 10 SDK (for `echo-dotnet`). Missing tools make that target skip, not fail.

## Build

Only the .NET plugin needs a build:

```bash
cd plugins/echo-dotnet
dotnet publish -c Release -o out
```

## Run by hand

A plugin is just a process that talks frames on stdin/stdout, so you can start one directly, but it will wait for a host. Use the simulator from a Python prompt:

```python
import sys; sys.path.insert(0, "host-sim")
from hostsim import Plugin

p = Plugin("echo-python", ["python", "plugin.py"], "plugins/echo-python")
p.wait_event("lifecycle.ready")
print(p.request("add", {"a": 2, "b": 40}))     # -> Response, payload {"sum": 42}
print(p.heartbeat())                            # -> Heartbeat reply
print(p.shutdown())                             # -> 0
p.close()
```

Swap the command for `["dotnet", "out/EchoPlugin.dll"]` or `["node", "plugin.js"]` (with `{"intervalMs": 100}` as the fourth argument for the ticker).

## Test

```bash
python host-sim/run_tests.py                 # all targets
python host-sim/run_tests.py echo-python     # one target: echo-python | echo-dotnet | ticker-node | chaos
```

Expected: `36/36 checks passed`.

**Good plugins** are checked for: ready event, heartbeat reply, `echo`/`add` correctness, `Error` on unknown topic and bad payload, a 200 KB payload, exit 0 on `Shutdown`, no stray stdout, and never setting `source`.

**`chaos-python`** is checked the other way round: each mode must be *detectable* by a host.

| Mode | Misbehaviour | What the host must do |
|:--|:--|:--|
| `crash` | exits 3 | Notice an unexpected exit and apply restart policy |
| `exit-clean` | exits 0 unasked | Treat as an unexpected stop, not a requested one |
| `hang` | stops reading | Declare hung when the heartbeat goes unanswered |
| `sidebeat` | heartbeats from a thread, requests ignored | Heartbeat alone is not proof of health; request TTLs catch it |
| `flood` | 5000 events at once | Enforce `msgPerSec` |
| `oversize` | announces a 2 MiB frame | Disconnect on the frame cap |
| `garbage` | non-JSON body | Disconnect on a strict-parse failure |
| `spoof` | claims `source: "admin"` | Stamp `Source` from the channel and ignore the claim |

The simulator implements these checks itself, so they double as a spec for the real host.

## Write your own plugin

1. Copy `echo-python/` (or the .NET one) and change `ID`, `manifest.json` and the handlers.
2. Follow the six rules in `PROFILE.md`. The easy ones to break: printing to stdout, answering heartbeats from a different thread than the request loop, and blocking before you start reading input.
3. Add a target to `run_tests.py` (copy `suite_echo`) and run it.
4. For a release package you would add per-platform executables, a bundled runtime for interpreted languages, file hashes and a signature (design §3). Not implemented here; the `entry.dev` key in the manifests is a dev shortcut.

## Known limits

- No sandbox, no policy router, no supervisor restart logic, no packaging or signing.
- `flood` is checked by counting what arrived in one second, not by a real rate limiter.
- Windows and Linux/macOS behave the same here only because nothing OS-specific runs.

## Real host (phase 1)

`src/` holds the .NET 10 host core: `dotnet test src/PluginSandbox.slnx`. The `Conformance` project runs the same 36 checks as `host-sim/run_tests.py` against the real supervisor, router and session, using these plugins unmodified (build `echo-dotnet` first or its check is skipped). `Launchers.Plain` starts plugins as ordinary processes. It is **not a sandbox**. See `docs/poc/findings.md`.
