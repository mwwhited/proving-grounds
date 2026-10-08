# Findings

## Phase 1: real host core

**Result:** the same four plugins, unmodified, pass the same 36 checks against the real host (`src/OoBDev.Plugins.Conformance`: echo-python 10, echo-dotnet 10, ticker-node 7, chaos-python 9). `python host-sim/run_tests.py` still passes those 36.

Afterwards two more languages were added as external plugins with the same 10 checks each: **echo-go** (stdlib only, native binary) and **echo-java** (JDK only). Both pass on the stand-in and the real host, so the stand-in now has 56 checks. `echo-dotnet` was already a separate program outside the solution; it is launched as `dotnet out/EchoPlugin.dll`. Also: 35 protocol tests (incl. seeded property tests) and 33 host tests (supervisor transitions, router policy).

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
- The plain launcher resolved only bare command names. A manifest command like `out/echo-go` is now resolved against the plugin folder (with `.exe` added on Windows).
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

## Phase 2: Windows sandbox (AppContainer + job object)

Code: `src/OoBDev.Plugins.Launchers.Windows` (`AppContainerLauncher`, `PluginJob`). Tests: `src/OoBDev.Plugins.Launchers.Windows.Tests` (18, against the hostile fixture `plugins/escape-python`), plus the existing conformance suite re-run inside the sandbox with `PLUGIN_LAUNCHER=appcontainer`. Run on Windows 11 build 26200, one machine, a non-admin user. Nothing here has been run on another Windows version.

### Open claims (design §18) now verified

| Claim | Result |
|:--|:--|
| Only the stdio pipe ends can be inherited (handle list with `bInheritHandles = true`) | Held. The plugin starts and talks over three pipes (stdin, stdout, stderr). Not yet checked from the plugin side by enumerating its handles |
| A plugin can read and execute from its own folder | Held, after the launcher grants the container read+execute on it |
| Executing a runtime from inside the AppContainer | Held for Go, Python, .NET and Node. Per-user installs (Python under `AppData\Local\Programs`) need an explicit read grant (`WindowsLauncherOptions.PerUserRuntimes`); system installs under Program Files work with none |
| stdio works as the channel | Held. The echo, ticker and chaos plugins pass the same checks as under the plain launcher |

### What the escape tests showed (all denied, each with a passing positive control)

The token is an AppContainer (`whoami` probe). A folder outside every grant cannot be read or listed; the user's profile cannot be listed; a read-only grant cannot be written; the plugin's own folder cannot be modified. Loopback and internet connections fail (the loopback listener saw nothing). A child process cannot be started (job `ActiveProcessLimit = 1`, error 1816). The host process cannot be opened. HKCU cannot be written. The host's environment variables are not visible. A memory limit makes allocation fail while the same allocation without a limit succeeds.

Kill-with-host: killing the host abruptly (`Environment.FailFast`, no cleanup) ends the plugin within the test's 10 s bound, also when the host was placed inside an outer job object first (nested jobs). Both pass.

### Found while building (fixed)

- **The host's environment leaked into the plugin.** A hostile plugin read a secret variable set in the host. The launcher now passes a minimal environment block (`SystemRoot`, `PATH`=System32, etc.).
- **`LOCALAPPDATA` is required.** With an explicit environment that lacks it, `CreateProcess` fails with error 203 ("environment option not found") for an AppContainer. The launcher sets it, and `TEMP`/`TMP`, to the container's own folder (`GetAppContainerFolderPath`), not the user's.
- **Re-applying ACLs on every launch is slow** (the Python tree) and made the first restart time out in a chaos check. The launcher now skips a grant that is already present.
- **Node fails in an AppContainer** (`EPERM: lstat 'C:\'`) because it resolves the script's real path by `lstat`-ing every parent folder. `ticker-node` now starts with `--preserve-symlinks --preserve-symlinks-main`.

### Not working / not done

- **Java does not start in the AppContainer.** `java.nio.file.AccessDeniedException` on `conf\security\java.security`, although the file's ACL grants ALL APPLICATION PACKAGES read. Cause not found. The Java conformance check is skipped in sandbox mode with this reason. A fix needs a grant on the JDK folder (which requires admin) or more digging.
- **Not tested:** DNS lookups (the connect tests resolve nothing), a fork bomb loop (only a single spawn), CPU limits (not implemented in `PluginJob`), a plugin enumerating its own handles, a plugin opening another plugin's pipe, other plugins being unaffected by a memory hog, `UseLpac` (written, never run), `Detached` (not implemented; the launcher refuses it).
- **ACL cleanup is missing.** Grants persist on disk after the plugin stops. The profile can be removed (`RemoveProfile`) but the granted ACEs stay (the test runs left entries for a deleted container SID on the Python folder). Needs a revoke step in uninstall.
- **Host-side pipe reads are blocking** (non-overlapped handles). Cancellation works only because killing the plugin closes the pipe.
- **Plugin stdout/stderr are 3 separate pipes**; the conformance checks only read stdout and a stderr log line.

So: the phase 2 exit criteria are met for network, process spawn, file reads outside grants, memory cap and kill-with-host (both forms), for Python, Go, Node and .NET plugins. They are not met for Java, CPU limits, or the fork-bomb and handle-enumeration cases. Do not describe the Windows sandbox as secure beyond the cases listed under "What the escape tests showed".

### Back-port to the planning shell

- An AppContainer launched with an explicit environment block needs `LOCALAPPDATA`; scrub the host environment (it leaks otherwise).
- Node needs `--preserve-symlinks-main` under an AppContainer; the JVM may not start at all (open).
- Per-user language runtimes need an explicit read grant; Program Files installs do not.
