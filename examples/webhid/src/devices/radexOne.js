// Protocol ported from BinaryDataDecoders.Quarta.RadexOne (DevicePing.cs, ReadValuesRequest.cs,
// ReadValuesResponse.cs, ReadSerialNumberRequest.cs, ReadSerialNumberResponse.cs, RadexOneDecoder.cs).
//
// The RadexOne enumerates as a USB-to-serial (CDC/VCP) device at 9600 baud, not as a HID or WebUSB
// device - Windows binds a serial driver to the interface before WebUSB could claim it. It is reached
// with the Web Serial API instead; see useWebSerial.js.
//
// Every frame starts with a 12-byte header: Prefix(u16) Command(u16) ExtensionLength(u16) PacketNumber(u32)
// CheckSum0(u16), all little-endian. Requests with an extension additionally carry SubCommand(u16)
// Reserved1(u16) CheckSum1(u16). Responses are framed as: starts with byte 0x7a, total length = 12 +
// ExtensionLength (read from the header once the first 6 bytes have arrived).

const REQUEST_PREFIX = 0xff7b
const PING_COMMAND = 0x0020

function checksum(values) {
  const sum = values.reduce((acc, v) => acc + v, 0) % 65535
  return (0xffff - sum) & 0xffff
}

export function buildPing(packetNumber) {
  const buf = new Uint8Array(12)
  const view = new DataView(buf.buffer)
  const extLen = 0x0000
  view.setUint16(0, REQUEST_PREFIX, true)
  view.setUint16(2, PING_COMMAND, true)
  view.setUint16(4, extLen, true)
  view.setUint32(6, packetNumber, true)
  const hi = (packetNumber >>> 16) & 0xffff
  const lo = packetNumber & 0xffff
  view.setUint16(10, checksum([REQUEST_PREFIX, PING_COMMAND, extLen, hi, lo]), true)
  return buf
}

function buildExtendedRequest(packetNumber, subCommand, reserved1 = 0x000c) {
  const buf = new Uint8Array(18)
  const view = new DataView(buf.buffer)
  const extLen = 0x0006
  view.setUint16(0, REQUEST_PREFIX, true)
  view.setUint16(2, PING_COMMAND, true)
  view.setUint16(4, extLen, true)
  view.setUint32(6, packetNumber, true)
  const hi = (packetNumber >>> 16) & 0xffff
  const lo = packetNumber & 0xffff
  view.setUint16(10, checksum([REQUEST_PREFIX, PING_COMMAND, extLen, hi, lo]), true)
  view.setUint16(12, subCommand, true)
  view.setUint16(14, reserved1, true)
  view.setUint16(16, checksum([subCommand, reserved1]), true)
  return buf
}

export function buildReadValuesRequest(packetNumber) {
  return buildExtendedRequest(packetNumber, 0x0800)
}

export function buildReadSerialNumberRequest(packetNumber) {
  return buildExtendedRequest(packetNumber, 0x0001)
}

function pad(value, length) {
  return String(value).padStart(length, '0')
}

export function decode(bytes) {
  if (bytes.length < 12) return { type: 'unknown', raw: Array.from(bytes) }
  const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength)
  const extLen = view.getUint16(4, true)
  const packetNumber = view.getUint32(6, true)

  if (extLen === 0) {
    return { type: 'ping', packetNumber }
  }

  const subCommand = view.getUint16(12, true)
  switch (subCommand) {
    case 0x0800:
      return {
        type: 'values',
        packetNumber,
        ambient: view.getInt32(20, true) / 100,
        accumulated: view.getInt32(24, true) / 100,
        clicksPerMinute: view.getInt32(28, true),
      }
    case 0x0001:
      // Serial number sub-fields are packed at non-contiguous byte offsets on the wire - kept
      // as reverse-engineered in the reference decoder rather than re-derived here.
      return {
        type: 'serialNumber',
        packetNumber,
        serialNumber: `${pad(view.getUint8(31), 2)}${pad(view.getUint8(30), 2)}${pad(view.getUint8(28), 2)}-${pad(view.getUint16(34, true), 4)}-${pad(view.getUint32(24, true), 6)}`,
        version: `${view.getUint8(32)}.${view.getUint8(33)}`,
      }
    default:
      return { type: 'unknown', subCommand, packetNumber }
  }
}

function concatBytes(a, b) {
  const result = new Uint8Array(a.length + b.length)
  result.set(a, 0)
  result.set(b, a.length)
  return result
}

function withTimeout(promise, ms, message) {
  let timer
  const timeout = new Promise((_, reject) => {
    timer = setTimeout(() => reject(new Error(message)), ms)
  })
  return Promise.race([promise, timeout]).finally(() => clearTimeout(timer))
}

// Reads from the serial port until a full 0x7a-prefixed frame has arrived, using the
// ExtensionLength field to know the total frame length once the header is available.
export async function readFrame(reader, { timeoutMs = 3000 } = {}) {
  let buffer = new Uint8Array(0)
  const deadline = Date.now() + timeoutMs

  while (Date.now() < deadline) {
    const remaining = deadline - Date.now()
    const { value, done } = await withTimeout(reader.read(), remaining, 'Timed out waiting for RadexOne response')
    if (done) break
    if (value && value.length) {
      buffer = concatBytes(buffer, value)
    }

    const startIndex = buffer.indexOf(0x7a)
    if (startIndex === -1) continue
    if (buffer.length - startIndex < 6) continue

    const view = new DataView(buffer.buffer, buffer.byteOffset + startIndex)
    const extLen = view.getUint16(4, true)
    const frameLength = 12 + extLen
    if (buffer.length - startIndex >= frameLength) {
      return buffer.slice(startIndex, startIndex + frameLength)
    }
  }

  throw new Error('Timed out waiting for RadexOne response')
}
