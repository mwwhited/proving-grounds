// echo-go: the smallest conforming plugin in Go. Standard library only.
//
// Handles `echo` and `add`, answers heartbeats, exits 0 on Shutdown.
// Protocol: see ../../PROFILE.md. stdout is frames only; logs go to stderr.
//
// Build: go build -o out/echo-go .   (out/echo-go.exe on Windows)
package main

import (
	"bufio"
	"crypto/rand"
	"encoding/binary"
	"encoding/json"
	"fmt"
	"io"
	"os"
)

const (
	maxFrame = 1024 * 1024
	id       = "echo-go"
	version  = "0.1.0"
)

type envelope struct {
	Type          string          `json:"type"`
	RequestID     string          `json:"requestId"`
	CorrelationID string          `json:"correlationId,omitempty"`
	Topic         string          `json:"topic,omitempty"`
	Payload       json.RawMessage `json:"payload,omitempty"`
}

var (
	in  = bufio.NewReader(os.Stdin)
	out = bufio.NewWriter(os.Stdout)
)

func newID() string {
	b := make([]byte, 16)
	_, _ = rand.Read(b)
	b[6] = b[6]&0x0f | 0x40
	b[8] = b[8]&0x3f | 0x80
	return fmt.Sprintf("%x-%x-%x-%x-%x", b[0:4], b[4:6], b[6:8], b[8:10], b[10:])
}

// readFrame returns nil at EOF: the host is gone.
func readFrame() (*envelope, error) {
	var header [4]byte
	if _, err := io.ReadFull(in, header[:]); err != nil {
		return nil, nil
	}
	length := binary.LittleEndian.Uint32(header[:])
	if length > maxFrame {
		return nil, fmt.Errorf("frame too large")
	}
	body := make([]byte, length)
	if _, err := io.ReadFull(in, body); err != nil {
		return nil, nil
	}
	var env envelope
	if err := json.Unmarshal(body, &env); err != nil {
		return nil, err
	}
	return &env, nil
}

func writeFrame(env envelope) {
	body, _ := json.Marshal(env) // json.RawMessage payloads are written as they were read
	var header [4]byte
	binary.LittleEndian.PutUint32(header[:], uint32(len(body)))
	out.Write(header[:])
	out.Write(body)
	out.Flush()
}

func reply(req *envelope, typ string, payload any) {
	env := envelope{Type: typ, RequestID: newID(), CorrelationID: req.RequestID, Topic: req.Topic}
	if raw, ok := payload.(json.RawMessage); ok {
		env.Payload = raw
	} else if payload != nil {
		env.Payload, _ = json.Marshal(payload)
	}
	writeFrame(env)
}

func handleRequest(req *envelope) {
	switch req.Topic {
	case "echo":
		reply(req, "Response", req.Payload)
	case "add":
		var p struct {
			A *float64 `json:"a"`
			B *float64 `json:"b"`
		}
		if err := json.Unmarshal(req.Payload, &p); err != nil || p.A == nil || p.B == nil {
			reply(req, "Error", map[string]string{"code": "bad-payload", "message": "expected {a, b} numbers"})
			return
		}
		reply(req, "Response", map[string]float64{"sum": *p.A + *p.B})
	default:
		reply(req, "Error", map[string]string{"code": "unknown-topic", "message": fmt.Sprintf("no handler for %q", req.Topic)})
	}
}

func main() {
	ready, _ := json.Marshal(map[string]string{"id": id, "version": version})
	writeFrame(envelope{Type: "Event", RequestID: newID(), Topic: "lifecycle.ready", Payload: ready})
	for {
		env, err := readFrame()
		if err != nil {
			fmt.Fprintln(os.Stderr, "bad frame:", err)
			os.Exit(1)
		}
		if env == nil || env.Type == "Shutdown" {
			return // clean exit, nothing to flush
		}
		switch env.Type {
		case "Heartbeat": // same loop as requests: a stuck handler stops this too
			writeFrame(envelope{Type: "Heartbeat", RequestID: newID(), CorrelationID: env.RequestID})
		case "Request":
			handleRequest(env)
		default:
			fmt.Fprintln(os.Stderr, "ignoring", env.Type)
		}
	}
}
