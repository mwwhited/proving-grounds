# echo-dotnet

The same plugin as [`echo-python`](../echo-python/README.md), written in C# (.NET 10, standard library only). It is a **separate, external program**: its own project, not part of `src/PluginSandbox.slnx`, and it shares no code with the host. The host starts it as `dotnet out/EchoPlugin.dll` like any other process.

## What it does

| Request topic | Payload | Reply |
|---|---|---|
| `echo` | any JSON | `Response` with the same payload |
| `add` | `{"a": n, "b": n}` | `Response` `{"sum": a+b}`; `Error` `bad-payload` on missing or non-numeric values |
| anything else | | `Error` `unknown-topic` |

No publish, subscribe or sendTo rights.

## How it works

Same protocol behaviour as echo-python: `lifecycle.ready` first, one read loop that answers `Heartbeat` and `Request`, exit 0 on `Shutdown` or EOF, frames only on stdout, 1 MiB frame cap, never sets `source`.

C# specifics: frames are read with `Console.OpenStandardInput()` and a little-endian length via `BinaryPrimitives`. Envelopes deserialize into a concrete record (no type-name or polymorphic handling), and unknown fields are ignored.

## Build and run

```
dotnet publish -c Release -o out
python ../../host-sim/run_tests.py echo-dotnet
dotnet test ../../src/OoBDev.Plugins.Conformance
```

If `out/EchoPlugin.dll` is missing, its checks are skipped, not failed. `bin/`, `obj/` and `out/` are git-ignored.
