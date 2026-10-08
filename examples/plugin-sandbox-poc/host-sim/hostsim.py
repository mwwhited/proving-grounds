"""Minimal stand-in for the plugin host's channel handling.

It is NOT the production host. It implements just enough of the protocol
(see ../PROFILE.md) to run example plugins and to show what the real host
must detect: crash, hang, rate abuse, oversize frames, bad JSON, spoofing.

No sandbox is applied: the plugin runs as a normal child process.
"""
import json
import queue
import struct
import subprocess
import threading
import time
import uuid

MAX_FRAME = 1024 * 1024


class Violation(Exception):
    pass


class Plugin:
    def __init__(self, plugin_id, command, cwd, config=None):
        self.id = plugin_id
        self.config = config or {}
        self.inbox = queue.Queue()          # frames received, source already stamped
        self.violations = []                # protocol violations seen
        self.raw_sources = []               # `source` values the plugin tried to set
        self.received = 0
        self.stderr_lines = []
        self.sent_shutdown = False
        self.proc = subprocess.Popen(
            command, cwd=cwd, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)
        threading.Thread(target=self._read_stdout, daemon=True).start()
        threading.Thread(target=self._read_stderr, daemon=True).start()

    # ---- receiving -------------------------------------------------------
    def _read_exact(self, n):
        buf = b""
        while len(buf) < n:
            chunk = self.proc.stdout.read(n - len(buf))
            if not chunk:
                return None
            buf += chunk
        return buf

    def _read_stdout(self):
        while True:
            hdr = self._read_exact(4)
            if hdr is None:
                return
            (length,) = struct.unpack("<I", hdr)
            if length > MAX_FRAME:
                self._violate(f"frame length {length} exceeds {MAX_FRAME}")
                return
            body = self._read_exact(length)
            if body is None:
                return
            try:
                env = json.loads(body.decode("utf-8"))
                if not isinstance(env, dict) or "type" not in env:
                    raise ValueError("not an envelope")
            except (ValueError, UnicodeDecodeError) as e:
                self._violate(f"bad frame body: {e}")
                return
            self.received += 1
            if "source" in env:
                self.raw_sources.append(env["source"])
            env["source"] = self.id         # the host stamps Source; plugin value is ignored
            # plugin-initiated config request is answered here, like the real host would
            if env["type"] == "Request" and env.get("topic") == "config.get":
                self.send("Response", topic="config.get", correlation=env["requestId"],
                          payload=self.config)
                continue
            self.inbox.put(env)

    def _read_stderr(self):
        for line in self.proc.stderr:
            self.stderr_lines.append(line.decode("utf-8", "replace").rstrip())

    def _violate(self, reason):
        self.violations.append(reason)
        self.kill()                         # the real host disconnects and kills

    def recv(self, timeout=2.0, where=None):
        """Next frame matching `where(env)`; None on timeout."""
        deadline = time.monotonic() + timeout
        stash = []
        try:
            while True:
                left = deadline - time.monotonic()
                if left <= 0:
                    return None
                try:
                    env = self.inbox.get(timeout=left)
                except queue.Empty:
                    return None
                if where is None or where(env):
                    return env
                stash.append(env)
        finally:
            for env in stash:               # keep non-matching frames for later
                self.inbox.put(env)

    # ---- sending ---------------------------------------------------------
    def send(self, type_, topic=None, payload=None, correlation=None, ttl_ms=None):
        env = {"type": type_, "requestId": str(uuid.uuid4())}
        if topic is not None:
            env["topic"] = topic
        if correlation is not None:
            env["correlationId"] = correlation
        if ttl_ms is not None:
            env["ttlMs"] = ttl_ms
        if payload is not None:
            env["payload"] = payload
        body = json.dumps(env, separators=(",", ":")).encode("utf-8")
        try:
            self.proc.stdin.write(struct.pack("<I", len(body)) + body)
            self.proc.stdin.flush()
        except (BrokenPipeError, OSError):
            pass
        return env["requestId"]

    def request(self, topic, payload=None, timeout=2.0):
        rid = self.send("Request", topic=topic, payload=payload, ttl_ms=int(timeout * 1000))
        return self.recv(timeout, where=lambda e: e.get("correlationId") == rid)

    def heartbeat(self, timeout=1.0):
        rid = self.send("Heartbeat")
        return self.recv(timeout, where=lambda e: e["type"] == "Heartbeat"
                         and e.get("correlationId") == rid)

    def wait_event(self, topic, timeout=5.0):
        return self.recv(timeout, where=lambda e: e["type"] == "Event" and e.get("topic") == topic)

    def shutdown(self, grace=5.0):
        """Ask for a clean stop. Returns the exit code, or None if it had to be killed."""
        self.sent_shutdown = True
        self.send("Shutdown")
        try:
            return self.proc.wait(timeout=grace)
        except subprocess.TimeoutExpired:
            self.kill()
            return None

    # ---- lifecycle -------------------------------------------------------
    def exited(self, timeout=0.0):
        try:
            return self.proc.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            return None

    def kill(self):
        if self.proc.poll() is None:
            self.proc.kill()

    def close(self):
        self.kill()
        try:
            self.proc.wait(timeout=2)
        except subprocess.TimeoutExpired:
            pass
