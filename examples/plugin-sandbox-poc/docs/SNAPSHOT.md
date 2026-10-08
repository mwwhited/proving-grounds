# Design snapshot

Everything under `docs/` (except this file) and all of `reference/` is a **copy** of the planning shell, so the POC can be worked on in isolation.

| | |
|:--|:--|
| Source | [mwwhited-notes/shared](https://github.com/mwwhited-notes/shared), `projects/plugin-sandbox-project` |
| Source commit | `e456314` (2026-10-08) |
| Source of truth | The planning shell, for design intent. This POC, for what was built and measured |

## Rules

- **Do not edit the copied design files here** to change the design. Change the planning shell, then refresh this snapshot. Edits here are lost on refresh.
- **Do record findings here.** Write what the POC proved or disproved in `docs/poc/findings.md` (create it when the first result exists). Back-port anything that changes the design to the planning shell's `docs/decision-log.md`.
- `docs/poc/` is also copied from the planning shell. If the plan changes (phases, exit criteria, checklist), update both, or update the planning shell and refresh.
- `docs/planning-shell-CLAUDE.md` is the planning shell's own `CLAUDE.md`: settled decisions, corrections, conventions and open questions. Its "no production code exists" statement describes the planning shell, not this folder.
- `reference/` holds the uncompiled C# sketches (Windows launcher, per-plugin job, supervisor). They are a starting point, not tested code.

## Refreshing

From a checkout of `shared`:

```bash
cp -r projects/plugin-sandbox-project/docs/. <this folder>/docs/
cp -r projects/plugin-sandbox-project/reference/. <this folder>/reference/
cp projects/plugin-sandbox-project/CLAUDE.md <this folder>/docs/planning-shell-CLAUDE.md
```

Then update the source commit above and re-check that `docs/SNAPSHOT.md` still exists (the copy does not touch it).
