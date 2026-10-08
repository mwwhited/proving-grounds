# chaos-python

> **Test fixture. Misbehaves on purpose. Never use it as a template and never ship it.**

A plugin written to break the rules in one chosen way, so the host's defences can be tested. It is the only plugin that is supposed to be killed, disconnected or restarted.

## How it works

It announces `lifecycle.ready`, asks the host for `config.get`, reads `{"mode": "..."}` from the reply, then misbehaves accordingly. The mode is set through the plugin config (the tests pass it per run). Modes that don't end the process stay quiet and answer heartbeats until stopped.

| Mode | What it does | What the host must do |
|---|---|---|
| `crash` | exits 3 right after ready | see an unexpected non-zero exit; restart after backoff |
| `exit-clean` | exits 0 without being told to | treat it as an unexpected stop too |
| `hang` | stops reading input | miss the heartbeat, declare it hung, kill it |
| `sidebeat` | answers heartbeats from a separate thread; never services requests | notice that requests time out even though heartbeats are fine |
| `flood` | sends 5000 events at once | apply the `msgPerSec` limit: drop the excess and count it |
| `oversize` | announces a 2 MiB frame | refuse it (1 MiB cap), record a violation, disconnect |
| `garbage` | sends a frame whose body is not JSON | strict parse fails: violation, disconnect |
| `spoof` | publishes with `"source": "admin"` | ignore the claim; stamp the real channel (`chaos-python`) as `Source` |

`manifest.json` allows publishing only `chaos.flood` and `chaos.spoof`, and uses a 1 s heartbeat timeout so hangs are detected quickly.

## Run it

Needs `python` on PATH.

```
python ../../host-sim/run_tests.py chaos
dotnet test ../../src/OoBDev.Plugins.Conformance
```

The nine chaos checks cover the eight modes (`sidebeat` has two). Supervisor behaviour for restarts, backoff and crash loops is covered separately in `src/OoBDev.Plugins.Host.Tests` with a fake launcher.
