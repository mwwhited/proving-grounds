# Proof-of-concept documentation

Concept-level documentation for the proof of concept (POC): what it must prove, who it is for, how it is built and in what order. This project stays a **planning shell**; the POC code lives elsewhere (see below).

| Doc | Answers |
|:--|:--|
| [use-cases.md](use-cases.md) | What the POC must do, and which of the 15 use cases in [`../use-cases.md`](../use-cases.md) it covers |
| [user-journeys.md](user-journeys.md) | Step-by-step journeys for each kind of user, with what works today and what is planned |
| [design.md](design.md) | POC architecture, project split, stand-in host, promotion to dotex |
| [plan.md](plan.md) | Phases, exit criteria, escape tests, risks, status checklist |

## Where the code is

`examples/plugin-sandbox-poc/` in the [`proving-grounds`](https://github.com/mwwhited/proving-grounds) repo (local checkout `C:\repo\mine\proving-grounds`). As of 2026-10-08 it is **not yet committed or pushed there**, so the GitHub path will 404 until it is. It holds:

- `PROFILE.md`: the example wire profile (framing, envelope, the six plugin rules). An example encoding, not a settled decision.
- `plugins/`: example plugins in Python, C# and Node, plus a deliberately misbehaving `chaos-python` fixture.
- `host-sim/`: a stand-in host and `run_tests.py` (36 checks, all passing when written).
- `README.md`: build, run and test instructions.

Implementation continues there. This folder is the concept the code is built against.

## Repositories

| Role | Repository | Notes |
|:--|:--|:--|
| Concept and design (this folder) | [mwwhited-notes/shared](https://github.com/mwwhited-notes/shared) (`projects/plugin-sandbox-project`) | Public. Local: `C:\repo\notes\shared` |
| POC implementation | [mwwhited/proving-grounds](https://github.com/mwwhited/proving-grounds) (`examples/plugin-sandbox-poc`) | Local: `C:\repo\mine\proving-grounds` |
| Promotion target (phase 6) | [OutOfBandDevelopment/dotex](https://github.com/OutOfBandDevelopment/dotex) | Local: `C:\repo\oobdev\dotex`. Read its README and layering/coverage rules before moving code |
| Wrapper | [mwwhited-notes/all](https://github.com/mwwhited-notes/all) | Tracks `shared` by submodule pointer |

## Relationship to the rest of the project

The design is in [`../design.md`](../design.md) (index) and [`../design/`](../design/); reasoning is in [`../decision-log.md`](../decision-log.md). `§N` cites that design. Where this folder and the design disagree, the design wins for *intent*, and the POC's own findings win for *what was built and measured*. Anything the POC learns that changes the design is written back to the decision log.

## Status (2026-10-08)

| Area | State (see [plan.md](plan.md)) |
|:--|:--|
| Protocol contract, example plugins, stand-in host, 36 checks | **Done** (in proving-grounds, uncommitted there) |
| Real .NET host (supervisor, router, policy) | Not started |
| Windows sandbox (AppContainer, per-plugin job) | Not started |
| Linux shim, packaging, Detached mode, broker | Not started |
