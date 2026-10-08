# Example plugins and test harness

Example plugins for the sandboxed plugin system, in five languages (Python, C#, Node, Go, Java), a stand-in host that runs them, and a real .NET 10 host core (`src/`). Written against the design in `plugin-sandbox-project/docs/design/`.

**What this is not:** a sandbox yet. There is a real host (supervisor, router, protocol) but no isolation or permission model. Plugins run as ordinary child processes. What the examples prove is the *protocol contract*: framing, heartbeat, lifecycle, config, and what the host must detect when a plugin misbehaves. The wire encoding is an **example profile**, not a settled decision (see `PROFILE.md`).

## Contents

| Path | What |
|:--|:--|
| `CLAUDE.md` | Instructions for working on the POC: read order, rules, scope |
| `docs/` | Snapshot of the design (index, 12 topic files, decision log, use cases, diagrams) and the POC docs in `docs/poc/` (use cases, journeys, design, plan). See `docs/SNAPSHOT.md` |
| `reference/` | Uncompiled C# sketches: Windows launcher, per-plugin job, supervisor. Starting points, not tested |
| `PROFILE.md` | The wire profile: framing, envelope, the six rules every plugin follows |
| `src/` | The real .NET 10 host core (phase 1): Protocol, Host, plain launcher, tests, conformance, bench. `src/PluginSandbox.slnx` |
| `plugins/echo-python/` | Smallest conforming plugin (stdlib only). `echo`, `add` |
| `plugins/echo-dotnet/` | Same behaviour in C# (.NET 10, stdlib only) |
| `plugins/echo-go/` | Same behaviour in Go (stdlib only, native binary) |
| `plugins/echo-java/` | Same behaviour in Java (JDK only) |
| `plugins/escape-python/` | Hostile test fixture that attacks the Windows sandbox (see its README) |
| `plugins/ticker-node/` | Publishes `demo.tick` events; asks the host for config (`config.get`) |
| `plugins/chaos-python/` | **Test fixture.** Misbehaves on purpose (8 modes). Never a template |
| `host-sim/hostsim.py` | Stand-in host: frame I/O, `Source` stamping, `config.get`, kill on violation |
| `host-sim/run_tests.py` | Conformance checks for the good plugins, detection checks for the chaos one |

## Requirements

Python 3.10+, Node 18+ (`ticker-node`), .NET 10 SDK (`echo-dotnet` and the host), Go 1.22+ (`echo-go`), a JDK 17+ (`echo-java`). Missing tools make that target skip, not fail. Each plugin folder has its own README.

## Build

Three plugins need a build step (outputs go to a git-ignored `out/`):

```bash
(cd plugins/echo-dotnet && dotnet publish -c Release -o out)
(cd plugins/echo-go && go build -o out/echo-go.exe .)   # out/echo-go on Linux/macOS
(cd plugins/echo-java && javac -d out EchoPlugin.java)
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
python host-sim/run_tests.py echo-python     # one target: echo-python | echo-dotnet | echo-go | echo-java | ticker-node | chaos
```

Expected with everything built: `56/56 checks passed` (the original three languages plus chaos are the 36 the real host must also pass; Go and Java add 20). Real host: `dotnet test src/PluginSandbox.slnx`.

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

## Windows sandbox (phase 2)

`src/OoBDev.Plugins.Launchers.Windows` starts a plugin in an AppContainer (no network, no user files) inside its own job object (one process, optional memory cap, killed when the host dies). `dotnet test src/OoBDev.Plugins.Launchers.Windows.Tests` runs 23 escape, CPU, uninstall and kill-with-host tests against `plugins/escape-python`. `PLUGIN_LAUNCHER=appcontainer dotnet test src/OoBDev.Plugins.Conformance` runs the normal conformance checks inside the sandbox (Java is skipped, since it does not start under the AppContainer; see `docs/poc/findings.md` for that and the other open items). Windows only, tested on one machine.

## Linux sandbox (phase 4, started)

`src/OoBDev.Plugins.Launchers.Linux` runs a plugin inside bubblewrap (namespaces, a minimal read-only filesystem, no network, rlimits). `sh linux-test/run-docker.sh` builds a Docker image, builds the compiled plugins and runs everything on Linux, including 22 escape tests. Docker's default seccomp profile has to be relaxed for it (see `docs/poc/findings.md`). `PLUGIN_LAUNCHER=bubblewrap` runs the conformance checks inside it (all pass). A seccomp filter blocks creating processes (threads still work); it is not a general syscall filter.

## Known limits

- No sandbox and no packaging or signing. The stand-in host has no router or restart logic; the real host in `src/` does.
- In the stand-in, `flood` is checked by counting what arrived in one second; the real host drops and counts the excess.
- Windows and Linux/macOS behave the same here only because nothing OS-specific runs.

## Real host (phase 1)

`src/` holds the .NET 10 host core: `dotnet test src/PluginSandbox.slnx`. The `Conformance` project runs the same checks as `host-sim/run_tests.py` against the real supervisor, router and session, using these plugins unmodified plus echo-go and echo-java (build them first or their checks are skipped). `Launchers.Plain` starts plugins as ordinary processes. It is **not a sandbox**. See `docs/poc/findings.md`.

### Escape results table

`docs/poc/escape-results.md` is generated: `sh linux-test/run-docker.sh` (writes `linux-test/out/linux.trx`), then `python tools/escape_report.py --run-windows --trx linux=linux-test/out/linux.trx`. Which tests count for which capability is in `docs/poc/escape-matrix.json`; a row is HELD only if its denial tests and its controls all pass, and rows without a test say UNVERIFIED.

### Packages

`src/OoBDev.Plugins.Packaging` builds and installs signed `.plugin` zips (`PackageBuilder.Build`, `PluginPackage.Install`); see `docs/poc/findings.md` (Phase 5) for what is and is not verified. `dotnet test src/OoBDev.Plugins.Packaging.Tests`.
