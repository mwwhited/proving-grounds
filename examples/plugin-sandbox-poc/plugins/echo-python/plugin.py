"""echo-python: the smallest conforming plugin. Needs only the Python standard library.

Handles `echo` and `add`, answers heartbeats, exits 0 on Shutdown.
Protocol: see ../../PROFILE.md. stdout is frames only; logs go to stderr.
"""
import json
import struct
import sys
import uuid

MAX_FRAME = 1024 * 1024
ID, VERSION = "echo-python", "0.1.0"
stdin, stdout = sys.stdin.buffer, sys.stdout.buffer


def read_frame():
    header = stdin.read(4)
    if len(header) < 4:
        return None                      # EOF: the host is gone
    (length,) = struct.unpack("<I", header)
    if length > MAX_FRAME:
        raise ValueError("frame too large")
    body = stdin.read(length)
    if len(body) < length:
        return None
    return json.loads(body.decode("utf-8"))


def write_frame(env):
    body = json.dumps(env, separators=(",", ":")).encode("utf-8")
    stdout.write(struct.pack("<I", len(body)) + body)
    stdout.flush()


def reply(request, type_="Response", payload=None):
    env = {"type": type_, "requestId": str(uuid.uuid4()),
           "correlationId": request["requestId"], "topic": request.get("topic")}
    if payload is not None:
        env["payload"] = payload
    write_frame(env)


def handle_request(req):
    topic, payload = req.get("topic"), req.get("payload")
    if topic == "echo":
        reply(req, payload=payload)
    elif topic == "add":
        try:
            reply(req, payload={"sum": payload["a"] + payload["b"]})
        except (KeyError, TypeError):
            reply(req, "Error", {"code": "bad-payload", "message": "expected {a, b} numbers"})
    else:
        reply(req, "Error", {"code": "unknown-topic", "message": f"no handler for {topic!r}"})


def main():
    write_frame({"type": "Event", "requestId": str(uuid.uuid4()), "topic": "lifecycle.ready",
                 "payload": {"id": ID, "version": VERSION}})
    while True:
        env = read_frame()
        if env is None or env.get("type") == "Shutdown":
            return 0                     # clean exit, nothing to flush
        kind = env.get("type")
        if kind == "Heartbeat":          # same loop as requests: a stuck handler stops this too
            write_frame({"type": "Heartbeat", "requestId": str(uuid.uuid4()),
                         "correlationId": env["requestId"]})
        elif kind == "Request":
            handle_request(env)
        else:
            print(f"ignoring {kind}", file=sys.stderr)


if __name__ == "__main__":
    sys.exit(main())
