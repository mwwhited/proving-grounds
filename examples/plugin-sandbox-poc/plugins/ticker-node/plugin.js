// ticker-node: publishes `demo.tick` events at a configured interval.
// Shows plugin -> host events and the plugin -> host `config.get` request.
// Node standard library only. Protocol: see ../../PROFILE.md.
'use strict';
const { randomUUID } = require('node:crypto');

const MAX_FRAME = 1024 * 1024;
const ID = 'ticker-node', VERSION = '0.1.0';
let buf = Buffer.alloc(0);
let timer = null;
let n = 0;
let configRequestId = null;

function write(env) {
  const body = Buffer.from(JSON.stringify(env), 'utf8');
  const header = Buffer.alloc(4);
  header.writeUInt32LE(body.length, 0);
  process.stdout.write(Buffer.concat([header, body]));
}

function startTicking(intervalMs) {
  if (timer) return;
  timer = setInterval(() => {
    write({ type: 'Event', requestId: randomUUID(), topic: 'demo.tick', payload: { n: ++n } });
  }, intervalMs);
}

function handle(env) {
  switch (env.type) {
    case 'Shutdown':
      if (timer) clearInterval(timer);
      process.exit(0);
      break;
    case 'Heartbeat': // same loop as everything else
      write({ type: 'Heartbeat', requestId: randomUUID(), correlationId: env.requestId });
      break;
    case 'Response':
      if (env.correlationId === configRequestId) {
        const cfg = env.payload || {};
        startTicking(Number.isInteger(cfg.intervalMs) && cfg.intervalMs >= 10 ? cfg.intervalMs : 1000);
      }
      break;
    case 'Request':
      write({ type: 'Error', requestId: randomUUID(), correlationId: env.requestId, topic: env.topic,
              payload: { code: 'unknown-topic', message: `no handler for ${env.topic}` } });
      break;
    default:
      console.error(`ignoring ${env.type}`);
  }
}

process.stdin.on('data', (chunk) => {
  buf = Buffer.concat([buf, chunk]);
  while (buf.length >= 4) {
    const len = buf.readUInt32LE(0);
    if (len > MAX_FRAME) { console.error('frame too large'); process.exit(1); }
    if (buf.length < 4 + len) break;
    const env = JSON.parse(buf.subarray(4, 4 + len).toString('utf8'));
    buf = buf.subarray(4 + len);
    handle(env);
  }
});
process.stdin.on('end', () => process.exit(0)); // EOF: the host is gone

write({ type: 'Event', requestId: randomUUID(), topic: 'lifecycle.ready', payload: { id: ID, version: VERSION } });
configRequestId = randomUUID();
write({ type: 'Request', requestId: configRequestId, topic: 'config.get' });
