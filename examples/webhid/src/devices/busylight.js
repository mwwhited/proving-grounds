// Protocol ported from BinaryDataDecoders.Kuando.Busylight (Class1.cs, BusylightCommand.cs).
// Device: Kuando Busylight UC, vendorId 0x04d8, productId 0xf848.
// Each HID report is 8 bytes: [NextStep, Repeat, R, G, B, On, Off, Audio].
// Report id 0 (unnumbered reports) - sendReport(0, bytes) does not add an id byte on the wire.

export const BUSYLIGHT_FILTERS = [{ vendorId: 0x04d8, productId: 0xf848 }]

export function matchesBusylight(device) {
  return device.vendorId === 0x04d8 && device.productId === 0xf848
}

export const AUDIO_NONE = 0x80

export function encodeAudio(track, volume) {
  return 0x80 | ((track & 0x0f) << 3) | (volume & 0x07)
}

// NextStep 0x10 is the "immediate, no chained steps" flag used by the reference
// implementation for one-shot commands (as opposed to programming a multi-step sequence).
export function buildCommand({ color = [0, 0, 0], on = 0x01, off = 0x00, repeat = 0x01, audio = AUDIO_NONE }) {
  const [r, g, b] = color
  return new Uint8Array([0x10, repeat & 0xff, r & 0xff, g & 0xff, b & 0xff, on & 0xff, off & 0xff, audio & 0xff])
}

export function buildOffCommand() {
  return buildCommand({ color: [0, 0, 0], on: 0x00, off: 0x00, audio: AUDIO_NONE })
}
