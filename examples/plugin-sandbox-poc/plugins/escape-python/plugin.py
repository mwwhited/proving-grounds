"""escape-python: a deliberately HOSTILE plugin for testing the sandbox. Never ship, never use as a template.

The host sends {"probe": "<name>", ...args} in its config.get reply. The plugin attempts one thing a
sandboxed plugin must not be able to do (or, for the `ok-*` probes, one thing it MUST be able to do, so a
broken probe cannot make the sandbox look tighter than it is), then publishes `escape.result`:

    {"probe": name, "outcome": "allowed" | "denied", "detail": "..."}

and stays alive answering heartbeats. The tests decide which outcome is correct for each probe.
"""
import json
import os
import socket
import struct
import subprocess
import sys
import uuid

stdin, stdout = sys.stdin.buffer, sys.stdout.buffer


def write_frame(env):
    body = json.dumps(env, separators=(",", ":")).encode("utf-8")
    stdout.write(struct.pack("<I", len(body)) + body)
    stdout.flush()


def read_frame():
    header = stdin.read(4)
    if len(header) < 4:
        return None
    (length,) = struct.unpack("<I", header)
    return json.loads(stdin.read(length).decode("utf-8"))


def new_id():
    return str(uuid.uuid4())


def read_file(a):
    with open(a["path"], "rb") as f:
        return f.read(16).decode("latin1")


def write_file(a):
    with open(a["path"], "wb") as f:
        f.write(b"escaped")
    return a["path"]


def list_dir(a):
    return ",".join(os.listdir(a["path"])[:5])


def connect(a):
    with socket.create_connection((a["host"], int(a["port"])), timeout=3) as s:
        return "connected to %s:%s" % (a["host"], a["port"])


def resolve(a):
    addrs = sorted({x[4][0] for x in socket.getaddrinfo(a["host"], None)})
    return "resolved %s to %s" % (a["host"], ",".join(addrs))


def handles(a):
    # what does this process hold open? Windows: probe every handle value; Linux: read /proc/self/fd
    kinds = {}
    if os.name == "nt":
        import ctypes
        k32 = ctypes.WinDLL("kernel32", use_last_error=True)
        names = {1: "disk", 2: "char", 3: "pipe"}
        for h in range(4, 16384, 4):
            try:   # strict handle checks make a closed handle value raise instead of returning false
                if k32.GetHandleInformation(ctypes.c_void_p(h), ctypes.byref(ctypes.c_uint32())):
                    t = names.get(k32.GetFileType(ctypes.c_void_p(h)), "other")
                    kinds[t] = kinds.get(t, 0) + 1
            except OSError:
                pass
    else:
        for fd in os.listdir("/proc/self/fd"):
            try:
                target = os.readlink("/proc/self/fd/" + fd)
            except OSError:
                continue
            if target.startswith("/proc/"):
                continue   # the descriptor listdir itself opened
            t = "pipe" if target.startswith("pipe:") else "socket" if target.startswith("socket:") else "dir" if os.path.isdir(target) and fd not in "012" else "other"
            if target.startswith("/dev/null"):
                t = "null"
            kinds[t] = kinds.get(t, 0) + 1
            if t not in ("pipe", "null"):
                kinds["[" + fd + "->" + target + "]"] = 1
    return "handles " + " ".join("%s=%d" % kv for kv in sorted(kinds.items()))


def spawn(a):
    r = subprocess.run(a.get("cmd", ["cmd.exe", "/c", "echo", "child"] if os.name == "nt" else ["/bin/true"]), capture_output=True, timeout=5)
    return "child exited %s" % r.returncode


def spawnloop(a):
    # try to start `n` child processes in a row; denied only if none of them started
    n, ok = int(a.get("n", 100)), 0
    for _ in range(n):
        try:
            subprocess.run(["cmd.exe", "/c", "exit", "0"] if os.name == "nt" else ["/bin/true"], capture_output=True, timeout=5)
            ok += 1
        except Exception:
            pass
    if ok == 0:
        raise PermissionError("0 of %d child processes started" % n)
    return "%d of %d child processes started" % (ok, n)


def open_process(a):
    if os.name != "nt":      # Linux: can this process see the host process at all?
        with open("/proc/%d/environ" % int(a["pid"]), "rb") as f:
            return "read %d bytes of the host's environment" % len(f.read())
    import ctypes
    k32 = ctypes.WinDLL("kernel32", use_last_error=True)
    k32.OpenProcess.restype = ctypes.c_void_p
    h = k32.OpenProcess(0x0410, False, int(a["pid"]))   # PROCESS_QUERY_INFORMATION | PROCESS_VM_READ
    if not h:
        raise PermissionError("OpenProcess failed, error %d" % ctypes.get_last_error())
    k32.CloseHandle(ctypes.c_void_p(h))
    return "opened pid %s" % a["pid"]


def read_env(a):
    v = os.environ.get(a["name"])
    if v is None:
        raise KeyError("%s is not set" % a["name"])
    return "visible: %s" % v[:8]


def registry_write(a):
    import winreg
    k = winreg.CreateKey(winreg.HKEY_CURRENT_USER, r"Software\OoBDevEscapeProbe")
    winreg.SetValueEx(k, "x", 0, winreg.REG_SZ, "escaped")
    return "wrote HKCU"


def allocate(a):
    block = bytearray(int(a["mb"]) * 1024 * 1024)
    for i in range(0, len(block), 4096):      # touch every page so it is really committed
        block[i] = 1
    return "allocated %s MB" % a["mb"]


def spin(a):
    # busy-loop for `seconds` of wall time and report the share of one core it got
    import time
    wall0, cpu0 = time.perf_counter(), time.process_time()
    while time.perf_counter() - wall0 < float(a.get("seconds", 3)):
        pass
    share = (time.process_time() - cpu0) / (time.perf_counter() - wall0)
    return "cpu share %.2f" % share


def threads(a):
    import threading
    n = int(a.get("n", 8))
    done = []
    ts = [threading.Thread(target=lambda: done.append(1)) for _ in range(n)]
    for t in ts:
        t.start()
    for t in ts:
        t.join()
    return "ran %d threads" % len(done)


def forkbomb(a):
    # fork as many children as the OS allows (up to max), then clean them up; "denied" if the very first fork fails
    kids = []
    try:
        for _ in range(int(a.get("max", 300))):
            p = os.fork()
            if p == 0:
                import time
                time.sleep(30)
                os._exit(0)
            kids.append(p)
    except OSError as ex:
        if not kids:
            raise
        err = type(ex).__name__
    else:
        err = "reached max"
    for p in kids:
        try:
            os.kill(p, 9)
            os.waitpid(p, 0)
        except OSError:
            pass
    return "forked %d children (%s)" % (len(kids), err)


def pid(a):
    return str(os.getpid())


def whoami(a):
    if os.name != "nt":      # Linux: inside a PID namespace this process is one of the first few
        return "pidns" if os.getpid() < 50 else "NOT in a pid namespace (pid %d)" % os.getpid()
    import ctypes
    tok = ctypes.c_void_p()
    adv = ctypes.WinDLL("advapi32", use_last_error=True)
    k32 = ctypes.WinDLL("kernel32")
    k32.GetCurrentProcess.restype = ctypes.c_void_p
    if not adv.OpenProcessToken(ctypes.c_void_p(k32.GetCurrentProcess()), 8, ctypes.byref(tok)):   # TOKEN_QUERY
        raise OSError("OpenProcessToken failed")
    flag = ctypes.c_ulong(0)
    size = ctypes.c_ulong(0)
    adv.GetTokenInformation(tok, 29, ctypes.byref(flag), 4, ctypes.byref(size))   # TokenIsAppContainer
    return "appcontainer" if flag.value else "NOT an appcontainer"


PROBES = {
    "read-file": read_file, "write-file": write_file, "list-dir": list_dir, "connect": connect,
    "spawn": spawn, "resolve": resolve, "handles": handles, "spawnloop": spawnloop, "open-process": open_process, "read-env": read_env, "registry-write": registry_write,
    "allocate": allocate, "pid": pid, "spin": spin, "threads": threads, "forkbomb": forkbomb, "whoami": whoami,
    # positive controls: the same operations against places the host granted
    "ok-read-file": read_file, "ok-write-file": write_file, "ok-list-dir": list_dir,
}

write_frame({"type": "Event", "requestId": new_id(), "topic": "lifecycle.ready",
             "payload": {"id": "escape-python", "version": "0.1.0"}})
cfg_id = new_id()
write_frame({"type": "Request", "requestId": cfg_id, "topic": "config.get"})

cfg = {}
while True:
    env = read_frame()
    if env is None or env.get("type") == "Shutdown":
        sys.exit(0)
    if env.get("type") == "Response" and env.get("correlationId") == cfg_id:
        cfg = env.get("payload") or {}
        break
    if env.get("type") == "Heartbeat":
        write_frame({"type": "Heartbeat", "requestId": new_id(), "correlationId": env["requestId"]})

name = cfg.get("probe", "none")
try:
    detail = PROBES[name](cfg)
    outcome = "allowed"
except Exception as ex:          # any failure to do the thing counts as denied; the detail says why
    outcome, detail = "denied", "%s: %s" % (type(ex).__name__, ex)
write_frame({"type": "Event", "requestId": new_id(), "topic": "escape.result",
             "payload": {"probe": name, "outcome": outcome, "detail": detail}})

while True:
    env = read_frame()
    if env is None and cfg.get("linger"):      # ignore a closed channel: only the OS can end this plugin
        import time
        while True:
            time.sleep(60)
    if env is None or env.get("type") == "Shutdown":
        sys.exit(0)
    if env.get("type") == "Heartbeat":
        write_frame({"type": "Heartbeat", "requestId": new_id(), "correlationId": env["requestId"]})
