<script setup>
import { onUnmounted, ref, watch } from 'vue'
import { useWebcam } from '../composables/useWebcam'

const { isSupported, stream, devices, isActive, error, refreshDevices, start, stop } = useWebcam()

const videoEl = ref(null)
const selectedDeviceId = ref('')
const snapshotUrl = ref('')

refreshDevices()

watch(stream, (value) => {
  if (videoEl.value) videoEl.value.srcObject = value
})

async function startCamera() {
  await start(selectedDeviceId.value || undefined)
}

function stopCamera() {
  snapshotUrl.value = ''
  stop()
}

function takeSnapshot() {
  const video = videoEl.value
  if (!video || !video.videoWidth) return
  const canvas = document.createElement('canvas')
  canvas.width = video.videoWidth
  canvas.height = video.videoHeight
  canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height)
  snapshotUrl.value = canvas.toDataURL('image/png')
}

onUnmounted(stop)
</script>

<template>
  <section class="panel">
    <h2>Webcam</h2>
    <p class="hint">getUserMedia camera preview and still-frame capture.</p>

    <p v-if="!isSupported" class="warning">navigator.mediaDevices.getUserMedia is not available in this browser.</p>

    <template v-else>
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

      <div class="webcam-viewport">
        <video ref="videoEl" autoplay playsinline muted></video>
      </div>

      <div v-if="isActive" class="actions">
        <button @click="takeSnapshot">Take Snapshot</button>
        <button v-if="snapshotUrl" @click="snapshotUrl = ''">Clear Snapshot</button>
      </div>

      <img v-if="snapshotUrl" :src="snapshotUrl" class="webcam-snapshot" alt="Snapshot" />

      <p v-if="error" class="error">{{ error }}</p>
    </template>
  </section>
</template>
