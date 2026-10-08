# Findings

## Phase 1: real host core

**Result:** the same four plugins, unmodified, pass the same 36 checks against the real host (`src/OoBDev.Plugins.Conformance`: echo-python 10, echo-dotnet 10, ticker-node 7, chaos-python 9). `python host-sim/run_tests.py` still passes 36/36. Also: 35 protocol tests (incl. seeded property tests) and 33 host tests (supervisor transitions, router policy).

Nothing is sandboxed. `Launchers.Plain` is an ordinary child process.

### What held

- The wire profile (4-byte LE length, UTF-8 JSON, 1 MiB cap) was enough for the host, the router and all four plugins with no changes.
- Crash, hang, flood, oversize, garbage, spoof: each is detected and handled per policy. A crash loop reaches `Failed` after 5 crashes in the window and stops launching. `Stop` during `Backoff` does not restart. `Start` during `Stopping` never runs two processes.
- Hub-and-spoke relay with host-stamped `Source` works, including reply mapping under a fresh request id.

### Differences from the stand-in (check adaptations)

The stand-in only observed; the real host acts, so some checks assert the action:
- hang: first `ExitRecord` is `Hung` (host killed it) rather than "heartbeat unanswered".
- flood: `Received > 200 && Dropped > 0`.
- oversize/garbage: first session has the violation and the first exit is `Violation`.
- exit-clean / crash: read from `ManagedPlugin.Exits[0]`, because the supervisor restarts the plugin before a test could look.
- Chaos checks run the supervisor with the default options and a fresh host per mode.

### Found while building (fixed)

- `Utf8JsonReader` validates UTF-8 lazily, so invalid bytes inside a skipped field parsed "successfully". The property test caught it. The parser now checks `Utf8.IsValid` first.
- `Enum.TryParse` accepts numbers and `"Request,Event"`. Message type is now an exact-name lookup.
- Plugins could publish any `lifecycle.*` topic to the host. Now only `lifecycle.ready` is accepted from a plugin.
- Backoff was doubled before use, so the first retry waited 1 s, not 500 ms.
- A request timeout alone must not reset the failure counter; only a matched reply does. Otherwise `sidebeat` hides forever.

### Wire encoding decision: keep UTF-8 JSON

Measured on this machine (Release, `src/OoBDev.Plugins.Bench`), codec cost and a full request round trip through the real host to echo-python:

| payload | frame | encode | decode | round trip |
|---|---|---|---|---|
| 1 KB text | 1,125 B | 0.006 ms | 0.007 ms | 0.07 ms |
| 1 KB binary (base64) | 1,604 B | 0.005 ms | 0.005 ms | 0.07 ms |
| ~1 MB text | 900 KB | 0.49 ms | 0.37 ms | 4.1 ms |
| ~1 MB binary (base64) | 1.0 MB | 2.5 ms | 1.4 ms | 6.6 ms |

The codec is not the bottleneck: a 1 MB round trip is dominated by the plugin's own JSON handling and the pipe. Binary costs +33% size and a few ms at 1 MB. That is acceptable for control-plane messages. **Decision: keep JSON for the POC.** Revisit only if a use case needs bulk binary, in which case add a side channel (file or shared memory handed by the broker) rather than changing the framing.

### Still unverified

- Everything about isolation (phase 2+). Nothing here says the plugin is contained.
- Linux/macOS process behaviour (the run was on Windows; `Kill(entireProcessTree)` semantics differ).
- The default timings (10 s ready timeout, 1 s heartbeat) were not tuned; the tests use 20-500 ms values.

### Back-port to the planning shell

- Only `lifecycle.ready` may come from a plugin; all other `lifecycle.*` are host-only.
- Say explicitly that consecutive request timeouts (3) are a hang signal in addition to heartbeat timeout.
- Record the wire-encoding decision and measurements above.
