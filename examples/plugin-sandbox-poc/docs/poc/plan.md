# Plan

Phases in order of risk, not of difficulty: prove the contract, then the supervisor, then the sandbox, which is the claim most likely to be wrong. Each phase has an exit test. A phase that fails its exit test changes the plan, not the test.

Follows the planning shell's build order (§17), reordered so the Windows launcher comes before Linux (it is the host platform available here) and so the sandbox is tested early.

## Phases

| Phase | Goal | Exit criteria | Status |
|:-:|:--|:--|:-:|
| 0 | Contract and examples | Plugins in 3 languages pass 36 checks under the stand-in host | **Done** |
| 1 | Real .NET host core | Same plugins, unmodified, pass the same checks against the real host. Crash, hang and flood handled per policy. Crash loop reaches `Failed` after 5 in 60 s. `Stop` during backoff does not restart | **Done** |
| 2 | Windows sandbox | Escape suite denied on Windows: network, process spawn, file read outside grant, fork bomb contained, memory cap enforced. Host killed (also inside a parent job) leaves no Bound plugin alive | **Mostly done** (Java unsupported in the AppContainer; CPU limit, fork-bomb loop and handle checks open; see findings) |
| 3 | Escape suite as a product | Escape plugins packaged as a runnable suite with a per-OS result table (held, failed, unverified) | Not started |
| 4 | Linux shim and launcher | Same escape suite denied on Linux. Go, Node and JVM plugins can still create threads under seccomp | **Started** (bubblewrap launcher and 22 escape tests pass in Docker; seccomp filter blocks new processes only) |
| 5 | Packaging | Platform selection, hash verification, signature check; tampered package rejected; "unavailable on this platform" before launch | Not started |
| 6 | Promotion to [dotex](https://github.com/OutOfBandDevelopment/dotex) | Protocol, Host, launcher and conformance projects build and test on their own; moved with dotex READMEs and coverage; POC runs against the packages | Not started |
| 7 | Detached mode, macOS | Detached survives host crash and reattaches by state file; macOS launcher with documented reduced guarantees | **Deferred** (decided after the Linux launcher: neither is needed to judge whether the base holds; revisit after phase 6) |

Not planned until the base is proven: permissions and approval (§10), brokered access (§11), network isolation (§12), resource-limit escalation (§13).

## Phase 1 work breakdown

1. Extract framing and envelope from the sketches into `Protocol`, with property tests (any byte sequence yields a frame, an error, or a disconnect; never a crash).
2. Supervisor from `reference/shared/ManagedPlugin.cs` in the planning shell, rewritten against a fake launcher; table-driven tests for every transition (`Stopped`, `Starting`, `Running`, `Backoff`, `Failed`, `Stopping`).
3. Router: stamp `Source`, default-deny publish/subscribe/sendTo, per-plugin bounded queue, priority lane for control frames.
4. A plain `Process` launcher (no sandbox) so phase 1 can run before phase 2.
5. Adapter so `run_tests.py` (or an equivalent .NET runner) targets the real host.
6. Decide the wire encoding, with measured cost for a 1 KB and a 1 MB payload.

## Phase 2 work breakdown

1. Port `reference/windows/AppContainerLauncher.cs` and `PluginJob.cs` (uncompiled sketches) and get them compiling.
2. Verify the open Windows claims in §18 first: handle inheritance with a handle list, a plugin that can read its own folder, execution from the AppContainer, stdio working at all.
3. One job object per plugin: `KILL_ON_JOB_CLOSE`, `ActiveProcessLimit = 1`, memory and CPU limits.
4. Write each escape plugin as the smallest program that tries one thing.
5. Run inside a parent job (as under CI or a debugger) to check the nested-job case.

## Escape tests (phase 2 and 4)

Each runs as a plugin in the sandbox and reports what it managed to do. The expected result is always "denied".

| Test | Attempts | Expected |
|:--|:--|:--|
| `net-connect` | TCP connect to a local listener the test starts | Denied |
| `net-dns` | Resolve a name | Denied |
| `spawn` | Start a child process | Denied |
| `read-outside` | Read a file in the user profile | Denied |
| `write-outside` | Write next to the plugin and elsewhere | Denied except the data directory |
| `read-package-dir` | Read its own executable's folder | Allowed (must still work) |
| `fork-bomb` | Spawn repeatedly | Contained by the job limit; host unaffected |
| `mem-hog` | Allocate until refused | Killed at the cap; other plugins unaffected |
| `cpu-spin` | Busy loop | Throttled or killed per policy |
| `outlive-host` | Keep running after the host is killed | Dies within a bounded time |
| `inherit-handles` | Enumerate its open handles | Only the channel handles |
| `peer-pipe` | Open another plugin's channel | Impossible |

## Risks

| Risk | Likelihood | Response |
|:--|:-:|:--|
| AppContainer breaks stdio inheritance, or needs ACL changes that leak | Medium | Test in phase 2 step 2 before building on it; fall back to named pipes with an ACL if needed |
| Language runtimes need syscalls or files the sandbox denies (Go, Node, JVM) | Medium | Include them as escape-suite plugins, not just C# and Python |
| The wire encoding choice hurts latency or SDK effort | Low | Measure in phase 1 before fixing it |
| Windows-only POC hides Linux and macOS problems | High | State it in every result; do not claim cross-platform until phase 4 |
| ACLs granted to the AppContainer persist after uninstall | Medium | Mitigated: grant ledger plus `AppContainerLauncher.Uninstall`, tested |
| Effort spills into the proposed layers (§10-13) | Medium | They are out of scope until phase 6 is done |

## Back-port to the planning shell

Things this POC found that the planning shell's settled decisions do not say yet (details in `findings.md`):

1. **Windows needs `LOCALAPPDATA` in an explicit environment block.** Without it the AppContainer process fails with error 203. The launcher must build the environment, not inherit it.
2. **Scrub the environment on every OS.** Windows passes an explicit block; bubblewrap uses `--clearenv`. Inheriting the host's environment leaks secrets.
3. **Per-user runtimes need a read grant.** A Python or Node install under the user profile is not readable by an AppContainer. The launcher grants it, and the grant is persistent state that uninstall must revoke (ledger plus `Uninstall`).
4. **Some runtimes need flags to start inside a sandbox.** Node needs `--preserve-symlinks --preserve-symlinks-main`, because it canonicalises paths through folders the container cannot list. Java has no such flag and does not start under the AppContainer launcher at all.
5. **Thread-counting limits cannot express "no child processes".** Windows job active-process limits and Linux `RLIMIT_NPROC` count threads and processes together. On Linux the answer is a seccomp filter that fails `fork`, `vfork` and `clone` without `CLONE_THREAD` (block process creation, not `execve`, since the target's own `execve` runs after the filter is installed).
6. **Linux needs unprivileged user namespaces.** bubblewrap fails on hosts that disable them, and Docker's default seccomp profile blocks them. Keep bubblewrap and document the requirement; there is no fallback.
7. **Each denied test needs a positive control**, and a test that quietly ran the unsandboxed launcher passes for the wrong reason. Check the launcher actually in use (a negative control caught this once).
8. **"Bound" needs a test that the host dies without cleanup** (`FailFast`), not just a clean shutdown, and a plugin that ignores EOF (`linger`) so only the OS can end it.

## Deferred

- **macOS launcher.** Not started. No Mac available; Seatbelt (`sandbox-exec`) is deprecated, so the reduced-guarantee wording needs its own research.
- **Detached lifetime.** Not implemented; Bound is the only mode proven.
- Untested: tuned timings, CPU limits on Linux, LPAC, a Windows fork-bomb loop, handle enumeration, DNS, arm64, bare-metal Linux, a general syscall allow-list.

## Working rules

- Every phase ends with a written findings entry: what held, what failed, what is still unverified. Failed claims are written back to the planning shell's decision log.
- Nothing is called "secure" without a passing escape test on that OS.
- The stand-in host stays as the executable specification and keeps passing.

## Checklist

- [x] Wire profile written
- [x] Example plugins in Python, C# and Node
- [x] Misbehaving fixture with 8 modes
- [x] Stand-in host and 36 checks
- [x] Use cases, journeys, design and plan documented
- [x] Phase 1: Protocol library
- [x] Phase 1: Supervisor with state-machine tests
- [x] Phase 1: Router and policy
- [x] Phase 1: Plain-process launcher and adapter to the shared checks
- [x] Phase 1: Wire encoding decided and measured
- [x] Phase 2: AppContainer launcher compiling
- [x] Phase 2: Open Windows claims verified
- [ ] Phase 2: Escape suite passing on Windows (21 pass; Java unsupported; DNS, fork-bomb loop, handle enumeration not covered)
- [x] Phase 2: Kill-with-host tests passing, including nested job
