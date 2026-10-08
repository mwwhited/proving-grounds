# echo-go

The same plugin as [`echo-python`](../echo-python/README.md), written in Go (standard library only, one file, no third-party modules). It builds to a single native executable, so the host launches it directly with no runtime.

## What it does

| Request topic | Payload | Reply |
|---|---|---|
| `echo` | any JSON | `Response` with the same payload, byte for byte |
| `add` | `{"a": n, "b": n}` | `Response` `{"sum": a+b}`; `Error` `bad-payload` if either is missing or not a number |
| anything else | | `Error` `unknown-topic` |

No publish, subscribe or sendTo rights.

## How it works

Same protocol behaviour as echo-python: `lifecycle.ready` first, one read loop answering `Heartbeat` and `Request`, exit 0 on `Shutdown` or EOF, frames only on stdout, 1 MiB frame cap, never sets `source`.

Go specifics: the payload is kept as `json.RawMessage`, so `echo` returns exactly what it received. Output goes through a buffered writer that is flushed after every frame. Message IDs are random v4 UUIDs from `crypto/rand`.

## Build and run

```
go build -o out/echo-go.exe .          # out/echo-go on Linux and macOS
python ../../host-sim/run_tests.py echo-go
dotnet test ../../src/OoBDev.Plugins.Conformance
```

`manifest.json` starts `out/echo-go`. The host resolves that path relative to this folder and adds `.exe` on Windows. If the binary is missing, its checks are skipped. `out/` is git-ignored.
