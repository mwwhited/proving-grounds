# Escape results

Generated 2026-10-08 by `tools/escape_report.py` from `escape-matrix.json`. Do not edit by hand.

HELD means every denial test passed and so did its control. Read the notes at the bottom before quoting it.

| Capability | Windows (AppContainer + job object) | Linux (bubblewrap + seccomp + prlimit) |
|:--|:-:|:-:|
| Connect to a service on the host machine | HELD | HELD |
| Connect to the internet | HELD | HELD |
| Resolve a name | HELD | HELD |
| Start a child process | HELD | HELD |
| Fork without limit | HELD | HELD |
| Read files or list folders outside its grants | HELD | HELD |
| Write to a read-only grant or to its own folder | HELD | HELD |
| Open or see the host process | HELD | HELD |
| Read the host's environment variables | HELD | HELD |
| Write the user's registry hive (Windows only) | HELD | n/a |
| Exceed its memory limit | HELD | HELD |
| Exceed its CPU limit | HELD | UNVERIFIED |
| Keep running after the host is killed | HELD | HELD |
| Leave access grants behind after uninstall | HELD | n/a |
| Inherit pipes or sockets beyond its own channel | HELD | HELD |
| Open another plugin's channel | UNVERIFIED | UNVERIFIED |

Held: windows 15/16, linux 12/14

## Not held or not verified

- **Exceed its CPU limit** on linux: UNVERIFIED (no test)
- **Open another plugin's channel** on windows: UNVERIFIED (no test)
- **Open another plugin's channel** on linux: UNVERIFIED (no test)

## Read this before quoting the table

- One machine per OS. Linux ran in Docker on a Windows host with the container's seccomp and AppArmor relaxed so bubblewrap can create namespaces (see `findings.md`).
- Linux has a filter against creating processes only, not a general syscall allow-list.
- A HELD row is as strong as its tests, which the matrix lists. An attack the tests did not think of is not covered.
- macOS has no launcher, so it has no column.
