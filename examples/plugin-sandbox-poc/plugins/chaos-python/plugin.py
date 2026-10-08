"""chaos-python: a deliberately BAD plugin for testing the host's defences.

DO NOT use as a template. It asks the host for `config.get`, reads {"mode": ...} and
misbehaves in that way. Each mode matches one host duty from the design.

  crash       exit 3 right after ready                 -> crash detection (§7)
  exit-clean  exit 0 without being told to             -> unexpected stop is still a restart
  hang        stop reading input                       -> heartbeat timeout (§7)
  sidebeat    answer heartbeats from a thread only     -> why heartbeat must share the request loop
  flood       send 5000 events at once                 -> rate limit (msgPerSec)
  oversize    announce a 2 MiB frame                   -> frame cap, disconnect
  garbage     send a frame that is not JSON            -> strict parse, disconnect
  spoof       claim `source: "admin"`                  -> host-stamped Source
"""
import json
import os
import queue
import struct
import sys
import threading
import time
import uuid

stdin, stdout = sys.stdin.buffer, sys.stdout.buffer
lock = threading.Lock()


def write_raw(data):
    with lock:
        stdout.write(data)
        stdout.flush()


def write_frame(env):
    body = json.dumps(env, separators=(",", ":")).encode("utf-8")
    write_raw(struct.pack("<I", len(body)) + body)


def read_frame():
    header = stdin.read(4)
    if len(header) < 4:
        return None
    (length,) = struct.unpack("<I", header)
    return json.loads(stdin.read(length).decode("utf-8"))


def new_id():
    return str(uuid.uuid4())


def beat(env):
    write_frame({"type": "Heartbeat", "requestId": new_id(), "correlationId": env["requestId"]})


write_frame({"type": "Event", "requestId": new_id(), "topic": "lifecycle.ready",
             "payload": {"id": "chaos-python", "version": "0.1.0"}})
cfg_id = new_id()
write_frame({"type": "Request", "requestId": cfg_id, "topic": "config.get"})

mode = "none"
while True:
    env = read_frame()
    if env is None or env.get("type") == "Shutdown":
        sys.exit(0)
    if env.get("type") == "Response" and env.get("correlationId") == cfg_id:
        mode = (env.get("payload") or {}).get("mode", "none")
        break
    if env.get("type") == "Heartbeat":
        beat(env)

print(f"chaos mode: {mode}", file=sys.stderr)

if mode == "crash":
    sys.exit(3)
elif mode == "exit-clean":
    sys.exit(0)
elif mode == "hang":
    time.sleep(3600)
elif mode == "flood":
    for i in range(5000):
        write_frame({"type": "Event", "requestId": new_id(), "topic": "chaos.flood", "payload": {"i": i}})
elif mode == "oversize":
    write_raw(struct.pack("<I", 2 * 1024 * 1024) + b"x" * 64)
elif mode == "garbage":
    write_raw(struct.pack("<I", 5) + b"not{j")
elif mode == "spoof":
    write_frame({"type": "Event", "requestId": new_id(), "topic": "chaos.spoof", "source": "admin",
                 "target": "billing", "payload": {}})
elif mode == "sidebeat":
    pending = queue.Queue()      # requests pile up here and are never serviced

    def reader():
        while True:
            e = read_frame()
            if e is None or e.get("type") == "Shutdown":
                os._exit(0)
            if e.get("type") == "Heartbeat":      # answered here, NOT by the request loop
                beat(e)
            else:
                pending.put(e)

    threading.Thread(target=reader, daemon=True).start()
    time.sleep(3600)             # the "main loop" is stuck and never reads `pending`

# Modes that fall through stay alive and quiet until the host stops them.
while True:
    env = read_frame()
    if env is None or env.get("type") == "Shutdown":
        sys.exit(0)
    if env.get("type") == "Heartbeat":
        beat(env)
