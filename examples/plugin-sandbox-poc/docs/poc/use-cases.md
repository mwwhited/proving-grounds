# Use cases

Two lists: what the POC itself must do (P-cases), and how the planning shell's 15 use cases map onto the POC. The planning shell's cases are in [`../use-cases.md`](../use-cases.md).

Status key: **Done** (works and is tested today), **Next** (planned phase), **Later**, **Out** (deliberately not in the POC).

## Actors

| Actor | Who they are | Cares about |
|:--|:--|:--|
| Plugin author | Writes a plugin in any language, possibly a third party | A small contract, fast feedback, clear errors |
| App developer | Builds the .NET application that hosts plugins | A simple API, plugins that cannot hurt the app, lifecycle handled for them |
| Operator | Installs and approves plugins on a deployed host | Knowing what a plugin can do before allowing it, and being able to stop it |
| Security reviewer | Decides whether to trust the isolation claims | Evidence: tests that try to escape and fail |
| Maintainer | Owns the design and the POC | Finding out which design claims are wrong, cheaply and early |

## POC use cases

| # | Use case | Actor | Phase | Status |
|:-:|:--|:--|:-:|:-:|
| P1 | Write a conforming plugin in any language from the protocol alone | Author | 0 | **Done** (Python, C#, Node) |
| P2 | Check a plugin against the contract without a real host | Author | 0 | **Done** (`host-sim/run_tests.py`) |
| P3 | Know what the host will do to a misbehaving plugin | Author, reviewer | 0 | **Done** as simulator checks (8 chaos modes) |
| P4 | Load a plugin from a manifest and call it from .NET code | App dev | 1 | Next |
| P5 | Receive events a plugin publishes; send events to it | App dev | 1 | Next |
| P6 | Detect a crashed or hung plugin and restart it with backoff; stop crash loops | App dev | 1 | Next |
| P7 | Stop a plugin cleanly, and be sure an intentional stop is not restarted | App dev | 1 | Next |
| P8 | Run a plugin that cannot reach the network, spawn processes or read ungranted files | Reviewer | 2 | Next |
| P9 | Show that a Bound plugin dies when the host is killed | Reviewer | 2 | Next |
| P10 | Run the same plugin tests against the real host and the simulator | Maintainer | 1 | Next |
| P11 | Record, per OS, which design claims held and which did not | Maintainer | 2-4 | Next |
| P12 | Reject a tampered package (hash or signature mismatch) | Operator | 5 | Later |
| P13 | Move proven library code into dotex without a rewrite | Maintainer | 6 | Later |

## Mapping the planning shell's use cases

| Planning-shell case | In the POC? | Where |
|:--|:--|:--|
| 1. Default-deny plugin | **Yes, the core claim** | P8, phase 2 (Windows), phase 4 (Linux) |
| 2. Third-party plugin with separate approval | Out | Needs the permission model (§10), which is still a proposal |
| 3. External MongoDB (blind tunnel) | Out | Brokered access (§11) is proposed and unproven |
| 4. FTP/SFTP | Out | Same |
| 5. Multicast/broadcast telemetry | Out | Same |
| 6. Webhook/server (inbound) | Out | Same |
| 7. Peer-to-peer | Out | Denied by default |
| 8. Read external files | Later | Only if phase 2 shows handle passing is cheap |
| 9. Attack through a tunnel | Out | Needs a tunnel |
| 10. Resource abuse (CPU, memory, flood) | **Partly** | Flood detection is simulated today; job-object CPU/memory caps in phase 2 |
| 11. Many plugins, no port conflicts | Yes, for free | Plugins use the channel, so none open ports |
| 12. Windows Firewall defense in depth | Out | Optional second layer |
| 13. Detached plugin needs network | Out | An open gap in the design |
| 14. Upgrade asks for more permission | Out | Needs approvals |
| 15. Revoke permission at runtime | Out | Needs approvals |

The POC deliberately stops before the proposed layers (§10-13). Its job is to prove the base: the contract, the supervisor and the sandbox. If the base does not hold, the proposed layers are moot.

## Acceptance criteria for the POC as a whole

1. A plugin written in a language the host does not know, given only `PROFILE.md`, passes the conformance checks.
2. The real .NET host passes the same checks the simulator does, with the same plugins, unmodified.
3. On Windows, the escape tests (network, process spawn, file read outside the grant) are denied, and a fork bomb is contained.
4. Killing the host kills every Bound plugin, including when the host runs inside another job object.
5. Every design claim listed under "Claims to verify" (§18) that the POC touches is recorded as held, failed or unverified.
