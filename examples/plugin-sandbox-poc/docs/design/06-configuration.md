# Per-Plugin Configuration

> Part of the plugin sandbox design (§9). Index and review status: [../design.md](../design.md). Diagrams: [../diagrams/](../diagrams/).

## 9. Per-Plugin Configuration

| Field | Purpose |
|---|---|
| `enabled` | Auto-start on host launch |
| `lifetime` | `Bound` or `Detached` |
| `entry`, `files`, `signature` | Platform artifacts and verification data |
| `capabilities` | Data access, publish, subscribe, sendTo |
| `permissions` *(proposed, §10)* | Requested external files, network endpoints, groups, listeners, each with a reason |
| `limits` | Memory, CPU, message rate, frame size; *(proposed, §13)* also tunnel and I/O limits |
| `heartbeatTimeout` | Hang detection |
| `restartPolicy` | Backoff and crash-loop window |
| `dependsOn` | Start/stop ordering |

The manifest is the plugin author's **request** and is signed with the package. The host's **approval** is stored separately and never inside the package (§10).
