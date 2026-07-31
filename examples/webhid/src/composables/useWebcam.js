import { ref, shallowRef } from 'vue'

export function useWebcam() {
  const isSupported = typeof navigator !== 'undefined' && !!navigator.mediaDevices?.getUserMedia
  const stream = shallowRef(null)
  const devices = shallowRef([])
  const isActive = ref(false)
  const error = ref('')

  async function refreshDevices() {
    if (!isSupported) return
    const all = await navigator.mediaDevices.enumerateDevices()
    devices.value = all.filter((d) => d.kind === 'videoinput')
  }

  async function start(deviceId) {
    if (!isSupported) return
    error.value = ''
    stop()
    try {
      stream.value = await navigator.mediaDevices.getUserMedia({
        video: deviceId ? { deviceId: { exact: deviceId } } : true,
      })
      isActive.value = true
      // Device labels are only populated once permission has been granted.
      await refreshDevices()
    } catch (err) {
      error.value = err.message
    }
  }

  function stop() {
    if (stream.value) {
      stream.value.getTracks().forEach((track) => track.stop())
      stream.value = null
    }
    isActive.value = false
  }

  return {
    isSupported,
    stream,
    devices,
    isActive,
    error,
    refreshDevices,
    start,
    stop,
  }
}
