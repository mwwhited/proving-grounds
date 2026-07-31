// Protocol ported from BinaryDataDecoders.Velleman.K8055 (K8055Request.cs, K8055Response.cs, Commands.cs,
// DigitalOutputs.cs, DigitalInputs.cs).
// Device: Velleman K8055, vendorId 0x10cf, productId 0x5500-0x5503 (selected by the board's address jumpers).
// Each HID report is 8 bytes with report id 0 (the C# structs include a leading pad byte for the raw
// Windows HID API - WebHID's sendReport(0, bytes)/inputreport already strip that byte).

export const K8055_FILTERS = [
  { vendorId: 0x10cf, productId: 0x5500 },
  { vendorId: 0x10cf, productId: 0x5501 },
  { vendorId: 0x10cf, productId: 0x5502 },
  { vendorId: 0x10cf, productId: 0x5503 },
]

export function matchesK8055(device) {
  return device.vendorId === 0x10cf && device.productId >= 0x5500 && device.productId <= 0x5503
}

export const Commands = {
  None: 0x00,
  ResetCounter1: 0x03,
  ResetCounter2: 0x04,
  SetAnalogDigital: 0x05,
}

export const DIGITAL_OUTPUTS = [
  { label: 'O1', bit: 0x01 },
  { label: 'O2', bit: 0x02 },
  { label: 'O3', bit: 0x04 },
  { label: 'O4', bit: 0x08 },
  { label: 'O5', bit: 0x10 },
  { label: 'O6', bit: 0x20 },
  { label: 'O7', bit: 0x40 },
  { label: 'O8', bit: 0x80 },
]

// Bit order is not sequential on the real hardware - kept as-is to match the device.
export const DIGITAL_INPUTS = [
  { label: 'I1', bit: 0x10 },
  { label: 'I2', bit: 0x20 },
  { label: 'I3', bit: 0x01 },
  { label: 'I4', bit: 0x40 },
  { label: 'I5', bit: 0x80 },
]

export function buildRequest({
  command = Commands.SetAnalogDigital,
  outputsMask = 0,
  analog1 = 0,
  analog2 = 0,
  debounce1 = 0,
  debounce2 = 0,
} = {}) {
  return new Uint8Array([
    command & 0xff,
    outputsMask & 0xff,
    analog1 & 0xff,
    analog2 & 0xff,
    0,
    0,
    debounce1 & 0xff,
    debounce2 & 0xff,
  ])
}

export function decodeResponse(bytes) {
  const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength)
  return {
    digitalInputsMask: view.getUint8(0),
    analog1: view.getUint8(2),
    analog2: view.getUint8(3),
    counter1: view.getUint16(4, true),
    counter2: view.getUint16(6, true),
  }
}
