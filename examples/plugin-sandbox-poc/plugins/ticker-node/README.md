# ticker-node

A Node.js plugin that **publishes events** on a timer. It shows the other directions of the protocol that the echo plugins skip: plugin to host events, and a plugin asking the host for its configuration. Node standard library only.

## What it does

- Publishes `demo.tick` with payload `{"n": 1}`, `{"n": 2}`, ... at a fixed interval.
- The interval comes from the host: it sends `config.get` and reads `intervalMs` from the reply (default 1000 ms; values below 10 ms or non-integers fall back to the default).
- Any request it receives gets `Error` `unknown-topic`; it serves no topics.

Capabilities in `manifest.json`: `publish: ["demo.tick"]`, nothing else. Without that grant the router would deny the ticks (default deny).

## How it works

1. Writes `lifecycle.ready`, then immediately sends `config.get` as a `Request` to the host.
2. Ticking starts only when the matching `Response` arrives (matched by `correlationId`).
3. `Heartbeat` is answered in the same event handler as everything else.
4. `Shutdown` clears the timer and exits 0; stdin ending (host gone) also exits.
5. Input is parsed from a buffer so frames split across chunks, or several in one chunk, are handled. Frames over 1 MiB exit the plugin.

## Run it

Needs `node` on PATH. No build.

The manifest starts `node --preserve-symlinks --preserve-symlinks-main plugin.js`. Without those flags Node resolves the real path of the script by calling `lstat` on every parent folder up to the drive root, which a Windows AppContainer may not do (`EPERM, lstat 'C:\'`). The flags skip that step and change nothing else.

```
python ../../host-sim/run_tests.py ticker-node
dotnet test ../../src/OoBDev.Plugins.Conformance
```

The tests pass `{"intervalMs": 50}` as config and check three ticks count 1, 2, 3.
