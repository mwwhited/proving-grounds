# echo-java

The same plugin as [`echo-python`](../echo-python/README.md), written in Java (JDK only, one file, no build tool or dependencies).

## What it does

| Request topic | Payload | Reply |
|---|---|---|
| `echo` | any JSON | `Response` with the same payload |
| `add` | `{"a": n, "b": n}` | `Response` `{"sum": a+b}`; `Error` `bad-payload` if either is missing or not a number |
| anything else | | `Error` `unknown-topic` |

No publish, subscribe or sendTo rights.

## How it works

Same protocol behaviour as echo-python: `lifecycle.ready` first, one read loop answering `Heartbeat` and `Request`, exit 0 on `Shutdown` or EOF, frames only on stdout, 1 MiB frame cap, never sets `source`.

Java specifics: the JDK has no JSON parser, so the file contains a small strict one (objects, arrays, strings, numbers, booleans, null). Numbers are kept as `BigDecimal` so they survive an echo exactly. The length prefix is read and written little-endian by hand, because `DataInputStream` is big-endian. It is a teaching-size parser, not a hardened one; a real plugin would use a JSON library.

## Build and run

Needs a JDK (17 or newer; tested on 25).

```
javac -d out EchoPlugin.java
python ../../host-sim/run_tests.py echo-java
dotnet test ../../src/OoBDev.Plugins.Conformance
```

`manifest.json` starts `java -cp out EchoPlugin`. If `java` or the compiled class is missing, its checks are skipped. `out/` is git-ignored.
