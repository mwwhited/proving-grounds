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

## Linux run of phase 1 (plain launcher, no sandbox)

Run in Docker (`linux-test/`: .NET 10 SDK image plus Python, Go, a JDK, Node, bubblewrap; `docker build -t plugin-poc-linux linux-test`, then run `linux-test/run.sh` with the POC mounted at `/src`). WSL was checked too: it has no native toolchains and needs a sudo password, so Docker is the route.

- The stand-in host checks (46 with the Go and Java plugins built) and the real host's conformance suite (echo-go, echo-java, echo-dotnet, echo-python, ticker-node, chaos) all pass, plus the 33 host tests and 35 protocol tests. No plugin or host change was needed.
- Needed only environment changes: a `python` command (manifests say `python`; Debian ships `python3`, so the image installs `python-is-python3`) and the Go binary path without `.exe`.
- This says nothing about isolation. The plain launcher is not a sandbox, and there is no Linux sandbox launcher yet (phase 4). Docker's own seccomp and user-namespace limits will need to be accounted for when one is built.

## Phase 4 (part): Linux sandbox with bubblewrap

Code: `src/OoBDev.Plugins.Launchers.Linux` (`BubblewrapLauncher`: wraps the plugin command in `bwrap` and `prlimit`, then reuses the plain launcher for stdio and exit handling). Tests: `src/OoBDev.Plugins.Launchers.Linux.Tests`, 18 tests mirroring the Windows suite against `plugins/escape-python`. Run with `sh linux-test/run-docker.sh`. One machine: Docker Desktop on WSL2, kernel 6.6, unprivileged user (uid 1000).

**The container had to be relaxed to run this.** Docker's default seccomp profile blocks `unshare`/`clone` with new namespaces, so bubblewrap fails with "No permissions to create new namespace". The run uses `--security-opt seccomp=unconfined --security-opt apparmor=unconfined`. That is a property of the test container. A host with unprivileged user namespaces enabled would not need it; one with them disabled (hardened distros, some CI) cannot use this launcher at all. Not tested on bare metal Linux or macOS.

What the sandbox is: new user, pid, ipc, uts, cgroup and network namespaces (`--unshare-all`), a mount namespace containing only `/usr` (read-only), a few `/etc` entries, the plugin folder (read-only), granted folders, and a private `/tmp`; an empty environment; `--die-with-parent`; `RLIMIT_DATA` for the memory cap and `RLIMIT_NPROC` for a task cap.

### Results (all 18 pass)

| Claim | Result |
|:--|:--|
| Runs in a PID namespace | Held (control) |
| Granted folders readable, listable, writable (read-only grant not writable) | Held (control) and denied as expected |
| Folders outside every grant, the user's home, `/etc/passwd`, `/etc/shadow` | Denied |
| Plugin cannot modify its own folder | Denied |
| Loopback and internet connections | Denied (loopback listener saw nothing; positive control passes) |
| Host process not visible (`/proc/<host pid>/environ` is `FileNotFoundError`) | Denied |
| Host environment variables | Not inherited |
| Memory cap | 300 MB allocation succeeds without a limit and fails with a 150 MB `RLIMIT_DATA` |
| Child process | Allowed by default (control); denied with `MaxTasks = 1` |
| Host killed with SIGKILL | Plugin and `bwrap` gone within 10 s. The plugin is told to ignore a closed channel (`linger`), so this is the sandbox, not the plugin exiting on EOF |
| Conformance suite through the sandbox (`PLUGIN_LAUNCHER=bubblewrap`) | 6 of 6 pass: Go, Java, Node, .NET, Python and the chaos modes all run inside it. Negative control: with Docker's default seccomp profile (bubblewrap cannot start) the same run fails all 6 after 15 s each, so the pass is not the plain launcher in disguise. The Java failure seen on Windows does not occur here |

### Weaker than the Windows launcher

- **No "no child processes" rule.** `RLIMIT_NPROC` counts threads too, so a Go, JVM or Node plugin needs a high limit (default 512). That contains a fork bomb but does not stop spawning. The spawn is only blocked with a limit of 1, which works for single-threaded Python. A real "no exec" rule needs a seccomp filter, which was not written. It also has to let the first `execve` through.
- **No seccomp filter at all**, so the plugin has the full syscall surface of an unprivileged process (inside the namespaces). Phase 4's "threads still work under seccomp" claim is untested.
- **No CPU limit, no cgroup limits** (cgroup v2 needs delegation).
- `RLIMIT_DATA` is not exactly RSS: it counts private writable mappings, not file-backed memory or shared memory.
- The pid namespace plus `--die-with-parent` killed the plugin when the host was `SIGKILL`ed. `PR_SET_PDEATHSIG` is tied to the parent *thread*; it held in this test, but a launch from a short-lived thread-pool thread could, in principle, kill the plugin early. Not seen.
- Runtime locations are a fixed list (`/usr`, a few `/etc`). Java needs `/etc/java-*`; a runtime installed elsewhere needs `ReadOnlyPaths`.
- Detached lifetime is not implemented.

### Not yet done

- seccomp filter (and a thread-creation test for Go, Java, Node under it), CPU/cgroup limits, macOS.
