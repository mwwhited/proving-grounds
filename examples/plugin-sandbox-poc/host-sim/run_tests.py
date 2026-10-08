"""Run the example plugins against the stand-in host.

    python host-sim/run_tests.py              # everything that can run here
    python host-sim/run_tests.py echo-python  # one target
    python host-sim/run_tests.py chaos        # misbehaviour fixtures

Targets: echo-python, echo-dotnet (build first), ticker-node, chaos.
Exit code is non-zero if any check fails.
"""
import os
import shutil
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from hostsim import Plugin  # noqa: E402

PLUGINS = os.path.join(HERE, "..", "plugins")
results = []


def check(name, ok, detail=""):
    results.append(ok)
    print(f"  {'PASS' if ok else 'FAIL'}  {name}" + (f"  ({detail})" if detail and not ok else ""))


def start(plugin_dir, command, config=None):
    cwd = os.path.join(PLUGINS, plugin_dir)
    return Plugin(plugin_dir, command, cwd, config)


# ---- well-behaved plugins ---------------------------------------------------
def conformance_common(p, expect_id):
    ready = p.wait_event("lifecycle.ready", 10)
    check("announces lifecycle.ready", ready is not None and ready["payload"]["id"] == expect_id)
    check("answers a heartbeat", p.heartbeat() is not None)
    unknown = p.request("no.such.topic")
    check("unknown topic returns Error unknown-topic",
          unknown is not None and unknown["type"] == "Error" and unknown["payload"]["code"] == "unknown-topic")


def suite_echo(plugin_dir, command):
    print(f"[{plugin_dir}]")
    p = start(plugin_dir, command)
    try:
        conformance_common(p, plugin_dir)
        r = p.request("echo", {"hello": ["wörld", 1, None]})
        check("echo returns the payload unchanged", r is not None and r["payload"] == {"hello": ["wörld", 1, None]})
        r = p.request("add", {"a": 2, "b": 40})
        check("add returns the sum", r is not None and r["payload"] == {"sum": 42})
        r = p.request("add", {"a": "x"})
        check("add with a bad payload returns Error bad-payload",
              r is not None and r["type"] == "Error" and r["payload"]["code"] == "bad-payload")
        big = p.request("echo", "x" * 200_000, timeout=5)
        check("handles a 200 KB payload", big is not None and len(big["payload"]) == 200_000)
        code = p.shutdown()
        check("exits 0 after Shutdown", code == 0, f"exit={code}")
        check("sent nothing but valid frames", not p.violations, "; ".join(p.violations))
        check("never set a source field", not p.raw_sources, str(p.raw_sources))
    finally:
        p.close()


def suite_ticker():
    print("[ticker-node]")
    p = start("ticker-node", ["node", "plugin.js"], {"intervalMs": 50})
    try:
        conformance_common(p, "ticker-node")
        ticks = [p.wait_event("demo.tick", 2) for _ in range(3)]
        check("publishes demo.tick at the configured interval (3 ticks)", all(ticks),)
        check("ticks count up", [t["payload"]["n"] for t in ticks if t] == [1, 2, 3])
        code = p.shutdown()
        check("exits 0 after Shutdown", code == 0, f"exit={code}")
        check("sent nothing but valid frames", not p.violations, "; ".join(p.violations))
    finally:
        p.close()


# ---- misbehaving plugin: what the host must detect --------------------------
def chaos(mode):
    p = start("chaos-python", [sys.executable, "plugin.py"], {"mode": mode})
    p.wait_event("lifecycle.ready", 10)
    return p


def suite_chaos():
    print("[chaos-python] each mode must be detected by the host")

    p = chaos("crash")
    code = p.exited(5)
    check("crash: unexpected nonzero exit is observable", code == 3 and not p.sent_shutdown, f"exit={code}")
    p.close()

    p = chaos("exit-clean")
    code = p.exited(5)
    check("exit-clean: exit 0 without Shutdown is still an unexpected stop",
          code == 0 and not p.sent_shutdown, f"exit={code}")
    p.close()

    p = chaos("hang")
    time.sleep(0.3)
    check("hang: heartbeat goes unanswered (host declares hung)", p.heartbeat(timeout=1.0) is None)
    p.close()

    p = chaos("sidebeat")
    time.sleep(0.3)
    beat = p.heartbeat(timeout=1.0)
    req = p.request("echo", 1, timeout=1.0)
    check("sidebeat: heartbeat alone looks healthy", beat is not None)
    check("sidebeat: the unanswered request still exposes the stuck loop (TTL expires)", req is None)
    p.close()

    p = chaos("flood")
    start_t = time.monotonic()
    time.sleep(1.0)
    rate = p.received / max(time.monotonic() - start_t, 0.001)
    check("flood: observed rate exceeds the 200 msg/s limit (host throttles or drops)",
          p.received > 200, f"received={p.received}")
    p.close()

    p = chaos("oversize")
    p.exited(3)
    check("oversize: a 2 MiB frame is a violation and the plugin is disconnected",
          len(p.violations) == 1 and "exceeds" in p.violations[0], str(p.violations))
    p.close()

    p = chaos("garbage")
    p.exited(3)
    check("garbage: an invalid body is a violation and the plugin is disconnected",
          len(p.violations) == 1 and "bad frame" in p.violations[0], str(p.violations))
    p.close()

    p = chaos("spoof")
    ev = p.wait_event("chaos.spoof", 3)
    check("spoof: plugin claimed source 'admin' but the host stamped the real channel",
          ev is not None and p.raw_sources == ["admin"] and ev["source"] == "chaos-python",
          f"raw={p.raw_sources}")
    p.close()


def main():
    want = sys.argv[1:] or ["echo-python", "echo-dotnet", "ticker-node", "chaos"]
    for target in want:
        if target == "echo-python":
            suite_echo("echo-python", [sys.executable, "plugin.py"])
        elif target == "echo-dotnet":
            dll = os.path.join(PLUGINS, "echo-dotnet", "out", "EchoPlugin.dll")
            if not os.path.exists(dll) or not shutil.which("dotnet"):
                print("[echo-dotnet] SKIP (run: dotnet publish -c Release -o out in plugins/echo-dotnet)")
                continue
            suite_echo("echo-dotnet", ["dotnet", "out/EchoPlugin.dll"])
        elif target == "ticker-node":
            if not shutil.which("node"):
                print("[ticker-node] SKIP (node not found)")
                continue
            suite_ticker()
        elif target == "chaos":
            suite_chaos()
        else:
            sys.exit(f"unknown target {target}")
    passed, total = sum(results), len(results)
    print(f"\n{passed}/{total} checks passed")
    sys.exit(0 if passed == total else 1)


if __name__ == "__main__":
    main()
