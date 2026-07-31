# WebHID / WebUSB / Web Serial / Web Bluetooth Example

Vue 3 + Vite demo of talking to real HID/USB/Bluetooth hardware from the browser, with a generic
explorer plus device-specific panels for three devices whose protocols were ported from the
C# decoders in `BinaryDataDecoders`:

| Device | Browser API | Why |
| --- | --- | --- |
| Kuando Busylight (vid 0x04d8, pid 0xf848) | WebHID | Plain HID device, 8-byte reports |
| Velleman K8055 (vid 0x10cf, pid 0x5500-0x5503) | WebHID | Plain HID device, 8-byte reports |
| Quarta RadexOne | Web Serial | Enumerates as a USB-to-serial (COM) port - Windows binds a serial driver to it before WebUSB could claim the interface |

The "Devices" tab also has two camera-based demos that don't need any specific hardware: a plain
webcam preview/snapshot (`getUserMedia`), and a live QR/barcode scanner using the Shape
Detection API's `BarcodeDetector`. Chromium only ships a native backend for this on macOS,
ChromeOS, and Android - it isn't implemented on Windows or Linux desktop.

A generic "Explorer" tab is also included to poke at any other WebHID/WebUSB device, any serial
port, or any Bluetooth LE (GATT) device, without needing a specific protocol.

## Requirements

- Chrome or Edge (these APIs aren't implemented in Firefox/Safari)
- A secure context - `http://localhost` counts, so the default `npm run dev` server works
- The actual hardware, if you want to exercise the device-specific panels; each pairing action
  opens the browser's native device/port picker

## Run it

```
npm install
npm run dev
```

Then open the printed `http://localhost:...` URL in Chrome or Edge.

## Layout

- `src/composables/useWebHid.js`, `useWebUsb.js`, `useWebSerial.js`, `useWebBluetooth.js`,
  `useWebcam.js` - thin reactive wrappers around `navigator.hid` / `navigator.usb` /
  `navigator.serial` / `navigator.bluetooth` / `navigator.mediaDevices`
- `src/devices/busylight.js`, `k8055.js`, `radexOne.js` - pure encode/decode functions for each
  device's wire protocol (no browser APIs), ported from the corresponding C# structs
- `src/components/BusylightPanel.vue`, `K8055Panel.vue`, `RadexOnePanel.vue` - device-specific
  UI built on top of the composables + device modules
- `src/components/WebcamPanel.vue`, `BarcodeDetectorPanel.vue` - camera preview/snapshot, and a
  live barcode/QR scanner built on the Shape Detection API
- `src/components/HidPanel.vue`, `UsbPanel.vue`, `SerialPanel.vue`, `BluetoothPanel.vue` -
  generic request/open/send-report, control-transfer, read/write-bytes, and GATT
  service/characteristic explorers
