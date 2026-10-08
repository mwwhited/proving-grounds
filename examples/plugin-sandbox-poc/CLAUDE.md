# CLAUDE.md

Proof of concept for a sandboxed, any-language plugin system hosted by a .NET 10 application. This folder is self-contained: the design is snapshotted under `docs/` (see `docs/SNAPSHOT.md`).

## Read first

1. `docs/poc/plan.md`: phases, exit criteria, checklist. **Phase 1 (real .NET host core) is done; phase 2 (Windows sandbox) is mostly done (see `docs/poc/findings.md` for what is open).**
2. `docs/planning-shell-CLAUDE.md`: settled decisions, corrections, conventions, open questions. Treat the settled decisions as fixed.
3. `docs/design.md`: index to the design topic files in `docs/design/` (section numbers `§N` map to files there).
4. `docs/poc/design.md`, `use-cases.md`, `user-journeys.md`: POC scope, actors and journeys.
5. `PROFILE.md`: the example wire profile (an example, not a settled decision).

## What exists

- `PROFILE.md`, `plugins/` (Python, C#, Go, Java, Node, and a `chaos-python` misbehaviour fixture; each has a README and `.gitignore`), `host-sim/` (stand-in host and 36 checks). Run `python host-sim/run_tests.py`; build the compiled plugins first (see `README.md`: dotnet, go, javac). See `README.md`.
- `reference/`: uncompiled C# sketches. Treat as a starting point.
- `src/PluginSandbox.slnx`: the real host core (phase 1). `Protocol`, `Host` (supervisor, router, session), `Launchers.Plain` (a plain process, NOT a sandbox), `Bench`, and three test projects including `Conformance`, which runs the same 36 checks against the real host. `dotnet test src/PluginSandbox.slnx`.
- `src/OoBDev.Plugins.Launchers.Windows`: AppContainer + per-plugin job object launcher. `Launchers.Windows.Tests` holds 23 escape and kill-with-host tests using `plugins/escape-python` and the `TestHost` helper. `PLUGIN_LAUNCHER=appcontainer dotnet test src/OoBDev.Plugins.Conformance` re-runs the conformance checks inside the sandbox (Java is skipped: it does not start under the AppContainer).
- `src/OoBDev.Plugins.Packaging`: signed `.plugin` zip builder and installer (platform selection, hashes, ECDSA signature, safe extraction); `Packaging.Tests` has 27 tests.
- `src/OoBDev.Plugins.Launchers.Linux`: bubblewrap + prlimit launcher; `Launchers.Linux.Tests` has 22 escape and kill-with-host tests. Run on Linux with `sh linux-test/run-docker.sh` (needs Docker; relaxes its seccomp profile). Seccomp filter only blocks creating processes. No macOS launcher.
- `tools/escape_report.py` + `docs/poc/escape-matrix.json` build `docs/poc/escape-results.md` (per-OS table: HELD / FAILED / CONTROL FAILED / UNVERIFIED). Add new escape tests to the matrix, with a control.

## Rules

- **Do not commit or push unless asked in that turn.**
- The stand-in host is the executable specification. Keep its 36 checks passing; phase 1's real host must pass the same checks with the same plugins, unmodified.
- Do not edit the copied design files to change the design (see `docs/SNAPSHOT.md`). Record findings in `docs/poc/findings.md` and tell the user what should be back-ported to the planning shell.
- Nothing is called secure without a passing escape test on that OS.
- Out of scope until phase 6 is done: permissions and approval (§10), brokered access (§11), network isolation (§12), resource-limit escalation (§13).
- Target .NET 10. Keep OS-specific code behind `IPluginLauncher`. Strict-schema serialization only, no type-name or polymorphic deserialization. Every host-side wait on a plugin needs a timeout.
- Keep projects splittable for later promotion into dotex (names and rules in `docs/poc/design.md`): Protocol and Host take no dependency on the POC or on a launcher.

## Related repositories

- Planning shell: https://github.com/mwwhited-notes/shared (`projects/plugin-sandbox-project`)
- This repo: https://github.com/mwwhited/proving-grounds
- Promotion target: https://github.com/OutOfBandDevelopment/dotex (read its README and layering/coverage rules first)
