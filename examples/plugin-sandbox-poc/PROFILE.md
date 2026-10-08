# Example wire profile

> **Status: example only.** The design (§5.3) leaves the wire encoding open ("protobuf, or JSON-RPC with a published schema"). The examples need something concrete, so this page fixes the simplest thing that works in every language. It is **not a settled decision**; the real encoding may differ. Keep the envelope fields and the rules below, and expect the encoding to change.

## Framing

Each message is one frame on the plugin's stdin (host to plugin) or stdout (plugin to host):

```
+----------------------+-----------------------------+
| length: uint32, LE   | body: UTF-8 JSON object     |
| (4 bytes)            | (exactly `length` bytes)    |
+----------------------+-----------------------------+
```

- `length` is the byte length of the body only. Maximum **1 048 576** (1 MiB). A larger value is a protocol violation and the host disconnects the plugin.
- **stdout carries frames only.** Anything else on stdout (a stray `print`, a banner) corrupts the stream and is a violation. Logs go to **stderr**.
- EOF on stdin means the host is gone or is closing the channel. Exit.
- Do not enable newline translation on stdout. On Windows use the binary stream (`sys.stdout.buffer`, `Console.OpenStandardOutput()`).

## Envelope (JSON)

| Field | Type | Notes |
|:--|:--|:--|
| `type` | string | `Request`, `Response`, `Event`, `Heartbeat`, `Shutdown`, `Error` (the design also lists `ResourceRequest`/`ResourceGrant`; not used here) |
| `requestId` | string (GUID) | New for every message you send |
| `correlationId` | string (GUID), optional | On a `Response`, `Error` or `Heartbeat` reply: the `requestId` it answers |
| `topic` | string, optional | What the message is about |
| `target` | string, optional | Logical name. Never a PID or pipe |
| `source` | string | **Stamped by the host.** A plugin may omit it. If it sets one, the host ignores it |
| `ttlMs` | int, optional | Request deadline |
| `hops` | int, optional | Relay counter |
| `payload` | any JSON, optional | Topic-specific. Treat as hostile in both directions |

Plugins parse into a **concrete schema** and ignore unknown fields. No type-name or polymorphic deserialization.

## Rules every plugin follows

1. **Announce readiness.** After startup, send `Event` topic `lifecycle.ready` with payload `{"id": "...", "version": "..."}`.
2. **Answer heartbeats from the same loop that handles requests.** On `Heartbeat`, send `Heartbeat` with `correlationId` set to the heartbeat's `requestId`. Never answer from a side thread (design decision 10).
3. **Answer every `Request`** with a `Response` (same `topic`, `correlationId` = the request's `requestId`) or an `Error` with payload `{"code": "...", "message": "..."}`. Unknown topics get `Error` code `unknown-topic`.
4. **On `Shutdown`, finish and exit 0** within the grace period (the simulator allows 5 s). Be killable at any instant; the host owns committed state.
5. **Ask for configuration, don't read it from disk.** Send `Request` topic `config.get` and wait for the `Response`. Until the response arrives, keep answering heartbeats and `Shutdown`.
6. **Never use stdout for anything but frames; never read anything but stdin.**

## Topics used by the examples

| Direction | Type | Topic | Payload |
|:--|:--|:--|:--|
| plugin to host | Event | `lifecycle.ready` | `{id, version}` |
| plugin to host | Request | `config.get` | none. Response: a JSON object of settings |
| host to plugin | Request | `echo` | any. Response: the same payload |
| host to plugin | Request | `add` | `{a, b}`. Response: `{sum}` |
| plugin to host | Event | `demo.tick` | `{n}` (ticker plugin) |

## Manifest in the examples

Manifests follow the shape in design §3, plus one **dev-only** key, `entry.dev`: the command line the simulator runs. Real packages carry one executable per platform and, for interpreted languages, a bundled runtime (§3 "Tier 2"). The examples use the system interpreter to stay small, so they are **not valid release packages**.
