<script setup>
import { onUnmounted, ref, watch } from 'vue'
import { useWebcam } from '../composables/useWebcam'

const isBarcodeDetectorSupported = typeof window !== 'undefined' && 'BarcodeDetector' in window

const { isSupported: isCameraSupported, stream, devices, isActive, error, refreshDevices, start, stop } = useWebcam()

const videoEl = ref(null)
const canvasEl = ref(null)
const selectedDeviceId = ref('')
const supportedFormats = ref([])
const isScanning = ref(false)
const detections = ref([])
let detector = null
let scanHandle = null

refreshDevices()

if (isBarcodeDetectorSupported) {
  window.BarcodeDetector.getSupportedFormats().then((formats) => {
    supportedFormats.value = formats
  })
}

watch(stream, (value) => {
  if (videoEl.value) videoEl.value.srcObject = value
})

async function startCamera() {
  await start(selectedDeviceId.value || undefined)
}

function stopCamera() {
  stopScanning()
  stop()
}

function startScanning() {
  if (!isBarcodeDetectorSupported || !stream.value || isScanning.value) return
  detector = new window.BarcodeDetector()
  isScanning.value = true
  scanLoop()
}

function stopScanning() {
  isScanning.value = false
  if (scanHandle) {
    clearTimeout(scanHandle)
    scanHandle = null
  }
  const ctx = canvasEl.value?.getContext('2d')
  if (ctx) ctx.clearRect(0, 0, canvasEl.value.width, canvasEl.value.height)
}

async function scanLoop() {
  if (!isScanning.value) return
  try {
    const barcodes = await detector.detect(videoEl.value)
    drawOverlay(barcodes)
    recordDetections(barcodes)
  } catch (err) {
    error.value = err.message
  }
  if (isScanning.value) {
    scanHandle = setTimeout(scanLoop, 200)
  }
}

function recordDetections(barcodes) {
  const t = Date.now()
  for (const barcode of barcodes) {
    const key = `${barcode.format}:${barcode.rawValue}`
    detections.value = [
      { key, format: barcode.format, rawValue: barcode.rawValue, t },
      ...detections.value.filter((d) => d.key !== key),
    ].slice(0, 20)
  }
}

function drawOverlay(barcodes) {
  const canvas = canvasEl.value
  const video = videoEl.value
  if (!canvas || !video || !video.videoWidth) return
  canvas.width = video.videoWidth
  canvas.height = video.videoHeight
  const ctx = canvas.getContext('2d')
  ctx.clearRect(0, 0, canvas.width, canvas.height)
  ctx.strokeStyle = '#2a78d6'
  ctx.lineWidth = 3
  ctx.font = '16px sans-serif'
  ctx.fillStyle = '#2a78d6'
  for (const barcode of barcodes) {
    const points = barcode.cornerPoints
    ctx.beginPath()
    points.forEach((point, index) => {
      if (index === 0) ctx.moveTo(point.x, point.y)
      else ctx.lineTo(point.x, point.y)
    })
    ctx.closePath()
    ctx.stroke()
    ctx.fillText(barcode.rawValue, points[0].x, Math.max(points[0].y - 8, 12))
  }
}

onUnmounted(() => {
  stopScanning()
  stop()
})
</script>

<template>
  <section class="panel">
    <h2>BarcodeDetector</h2>
    <p class="hint">
      Shape Detection API - scans QR codes and barcodes from the live camera feed entirely
      on-device; no image ever leaves the page. Chromium only ships a native backend for this on
      macOS, ChromeOS, and Android - it's not implemented on Windows or Linux desktop.
    </p>

    <p v-if="!isCameraSupported" class="warning">
      navigator.mediaDevices.getUserMedia is not available in this browser.
    </p>
    <p v-else-if="!isBarcodeDetectorSupported" class="warning">
      BarcodeDetector isn't available in this browser/platform.
    </p>

    <template v-if="isCameraSupported && isBarcodeDetectorSupported">
      <p v-if="supportedFormats.length" class="hint">Supported formats: {{ supportedFormats.join(', ') }}</p>

      <div class="actions">
        <label>
          Camera
          <select v-model="selectedDeviceId">
            <option value="">Default</option>
            <option v-for="d in devices" :key="d.deviceId" :value="d.deviceId">{{ d.label || d.deviceId }}</option>
          </select>
        </label>
        <button v-if="!isActive" @click="startCamera">Start Camera</button>
        <button v-else @click="stopCamera">Stop Camera</button>
      </div>

      <div v-if="isActive" class="actions">
        <button v-if="!isScanning" @click="startScanning">Start Scanning</button>
        <button v-else @click="stopScanning">Stop Scanning</button>
      </div>

      <div class="webcam-viewport">
        <video ref="videoEl" autoplay playsinline muted></video>
        <canvas ref="canvasEl"></canvas>
      </div>

      <ul v-if="detections.length" class="device-list">
        <li v-for="d in detections" :key="d.key">
          <span>{{ d.format }}: {{ d.rawValue }}</span>
        </li>
      </ul>

      <p v-if="error" class="error">{{ error }}</p>
    </template>
  </section>
</template>
