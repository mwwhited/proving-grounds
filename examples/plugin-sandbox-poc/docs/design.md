# Plugin Sandboxing, Communication, and Lifecycle: Design

The design is split into topic files under [`design/`](design/). This page is the index: read it first, then open only the parts you need. Section numbers (`§4`, `§11.2`) are stable across the split, and other docs cite them, so the table below maps each number to its file.

Diagram sources are in [`diagrams/src/`](diagrams/src/) and rendered SVGs in [`diagrams/svg/`](diagrams/svg/). The PlantUML blocks in the topic files are the same diagrams inline.

> **Review status (2026-10-08).** Sections 1-9 and 14-18 are the migrated design, extended where noted. Sections **10-13** (permissions and approval, brokered external access, network isolation, resource limits and abuse handling) are **proposed additions** from a follow-up discussion. They are not yet settled decisions. See [`decision-log.md`](decision-log.md) (decisions 17-26 and the open questions added 6-15) and [`use-cases.md`](use-cases.md) for the scenarios they are meant to serve. Diagrams 10-12 have PlantUML sources only and are not yet rendered to SVG. OS-specific claims in the proposed sections were written from general knowledge and are listed in §18 under "Claims to verify".

## In one paragraph

The host is a .NET 10 application. Each third-party plugin, in any language, runs as a separate sandboxed process that speaks one framed protocol over a single channel to the host. The OS sandbox is deny-all (no network, no process spawning, only granted files) and is applied before the plugin's first instruction. The host owns the plugin's whole lifecycle (start, stop, crash and hang recovery) and routes all traffic, so policy, logging and limits live in one place. The proposed additions let a plugin declare extra external access, let the operator approve it separately, and serve it through a host broker instead of loosening the sandbox.

## Section map

| § | Topic | File | Status |
|---|---|---|---|
| 1-2 | Goals, non-goals, architecture, core types | [design/01-goals-and-architecture.md](design/01-goals-and-architecture.md) | Migrated |
| 3 | Packaging, platform support, WASM | [design/02-packaging.md](design/02-packaging.md) | Migrated |
| 4 | Sandbox design per OS | [design/03-sandbox.md](design/03-sandbox.md) | Migrated |
| 5 | Communication: hub and spoke, envelope, policy | [design/04-communication.md](design/04-communication.md) | Migrated |
| 6-8 | Bound/Detached lifetime, supervisor, crash safety | [design/05-lifetime-and-lifecycle.md](design/05-lifetime-and-lifecycle.md) | Migrated |
| 9 | Per-plugin configuration | [design/06-configuration.md](design/06-configuration.md) | Migrated, extended |
| 10 | Permissions and approval | [design/07-permissions-and-approval.md](design/07-permissions-and-approval.md) | **Proposed** |
| 11 | Brokered external access: tunnels, connection models, files | [design/08-brokered-access.md](design/08-brokered-access.md) | **Proposed** |
| 12 | Network isolation | [design/09-network-isolation.md](design/09-network-isolation.md) | **Proposed** |
| 13 | Resource limits and abuse handling | [design/10-resource-limits.md](design/10-resource-limits.md) | **Proposed** |
| 14-17 | Conformance, security checklist, testing, build order | [design/11-quality-and-roadmap.md](design/11-quality-and-roadmap.md) | Migrated, extended |
| 18 | Open questions and claims to verify | [design/12-open-questions.md](design/12-open-questions.md) | Migrated, extended |

## Suggested reading paths

- **New to the project:** this page, then 01, 03, 04.
- **Reviewing the proposed additions:** [`use-cases.md`](use-cases.md), then 07, 08, 09, 10, then 12 for open questions.
- **Starting to build:** 11 (build order), then 03 and 05 for the launchers and supervisor, plus the `reference/` C# sketches (not compiled).
- **Why was X decided:** [`decision-log.md`](decision-log.md).

## Related documents

- [`decision-log.md`](decision-log.md): decisions, corrections, rejected options, open questions.
- [`use-cases.md`](use-cases.md): scenarios the design should serve, with status per use case.
- [`diagrams/`](diagrams/): PlantUML sources (12) and rendered SVGs (1-9).
