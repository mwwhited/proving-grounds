# echo-python

The smallest conforming plugin, in Python (standard library only, one file). It is the reference the other `echo-*` plugins copy. Use it as a template.

## What it does

| Request topic | Payload | Reply |
|---|---|---|
| `echo` | any JSON | `Response` with the same payload |
| `add` | `{"a": n, "b": n}` | `Response` `{"sum": a+b}`; `Error` `bad-payload` if `a` or `b` is missing or not a number |
| anything else | | `Error` `unknown-topic` |

It publishes and subscribes to nothing, and asks the host for nothing. Capabilities are all empty (default deny).

## How it works

1. Writes `lifecycle.ready` (`{id, version}`) as its first frame. The host waits for this before calling the plugin `Running`.
2. Loops reading frames: 4-byte little-endian length, then a UTF-8 JSON envelope (see `PROFILE.md`).
3. `Heartbeat` is answered in the **same loop** as requests. A stuck handler therefore stops heartbeats too, which is how the host detects a hang.
4. `Shutdown`, or EOF on stdin (the host is gone), ends the loop and exits 0. There is nothing to flush; plugins must be killable at any instant.
5. `stdout` carries frames only. Logs go to `stderr`.
6. Frames over 1 MiB are refused. It never sets `source`; the host stamps it.

## Run it

Needs `python` on PATH. No build.

```
python ../../host-sim/run_tests.py echo-python      # stand-in host
dotnet test ../../src/OoBDev.Plugins.Conformance     # real host
```

`manifest.json` starts it with `python plugin.py`.
