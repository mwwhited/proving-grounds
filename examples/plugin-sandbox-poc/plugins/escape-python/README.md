# escape-python

> **Test fixture. Attacks the sandbox on purpose. Never use it as a template and never ship it.**

A plugin that tries to do things a sandboxed plugin must not be able to do, and reports whether it managed. It is the evidence behind any claim that the Windows launcher isolates anything.

## How it works

It announces `lifecycle.ready`, asks for `config.get`, reads `{"probe": "<name>", ...args}` from the reply, makes that one attempt, and publishes `escape.result` with `{probe, outcome: "allowed" | "denied", detail}`. Then it idles and answers heartbeats. Any exception counts as `denied`; the detail carries the reason.

| Probe | Arguments | Expected in the AppContainer |
|---|---|---|
| `whoami` | | `allowed`, detail `appcontainer` (proves the token really is one) |
| `read-file` / `list-dir` | `path` outside every grant | `denied` |
| `write-file` | `path` outside every grant, or inside the plugin's own read-only folder | `denied` |
| `connect` | `host`, `port` (loopback listener the test owns; an external address) | `denied` |
| `spawn` | optional `cmd` | `denied` (job allows one process) |
| `open-process` | `pid` of the host | `denied` |
| `read-env` | `name` of a host environment variable | `denied` (not set) |
| `registry-write` | | `denied` |
| `allocate` | `mb` | the plugin is killed at the job's memory limit |
| `pid` | | the plugin's process id, for the kill-with-host test |
| `ok-read-file`, `ok-write-file`, `ok-list-dir` | `path` inside a granted folder | `allowed` (**positive controls**: they stop a broken probe from looking like a tight sandbox) |

## Run it

Needs `python` on PATH and Windows 10 or newer.

```
dotnet test ../../src/OoBDev.Plugins.Launchers.Windows.Tests
```
