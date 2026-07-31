import { ref, shallowRef } from 'vue'

export function useWebHid({ match } = {}) {
  const isSupported = typeof navigator !== 'undefined' && 'hid' in navigator
  const devices = shallowRef([])
  const selectedDevice = shallowRef(null)
  const log = ref([])
  const error = ref('')

  function addLog(message) {
    const time = new Date().toLocaleTimeString()
    log.value = [...log.value, `[${time}] ${message}`].slice(-200)
  }

  function describeDevice(device) {
    const vendor = device.vendorId.toString(16).padStart(4, '0')
    const product = device.productId.toString(16).padStart(4, '0')
    return `${device.productName || 'Unknown device'} (vid=0x${vendor}, pid=0x${product})`
  }

  async function refreshDevices() {
    if (!isSupported) return
    const all = await navigator.hid.getDevices()
    devices.value = match ? all.filter(match) : all
  }

  async function requestDevice(filters = []) {
    if (!isSupported) return
    error.value = ''
    try {
      const picked = await navigator.hid.requestDevice({ filters })
      if (picked.length) {
        selectedDevice.value = picked[0]
        addLog(`Selected device: ${describeDevice(picked[0])}`)
      }
      await refreshDevices()
    } catch (err) {
      error.value = err.message
    }
  }

  function onInputReport(event) {
    const bytes = Array.from(new Uint8Array(event.data.buffer))
    addLog(`inputreport id=${event.reportId} bytes=[${bytes.join(', ')}]`)
  }

  async function openDevice(device) {
    if (!device) return
    error.value = ''
    try {
      await device.open()
      device.addEventListener('inputreport', onInputReport)
      selectedDevice.value = device
      addLog(`Opened ${describeDevice(device)}`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function closeDevice(device) {
    if (!device) return
    error.value = ''
    try {
      device.removeEventListener('inputreport', onInputReport)
      await device.close()
      addLog(`Closed ${describeDevice(device)}`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function sendReport(device, reportId, bytes) {
    if (!device) return
    error.value = ''
    try {
      await device.sendReport(reportId, new Uint8Array(bytes))
      addLog(`sendReport id=${reportId} bytes=[${bytes.join(', ')}]`)
    } catch (err) {
      error.value = err.message
    }
  }

  if (isSupported) {
    navigator.hid.addEventListener('connect', ({ device }) => {
      addLog(`connect event: ${describeDevice(device)}`)
      refreshDevices()
    })
    navigator.hid.addEventListener('disconnect', ({ device }) => {
      addLog(`disconnect event: ${describeDevice(device)}`)
      refreshDevices()
    })
  }

  return {
    isSupported,
    devices,
    selectedDevice,
    log,
    error,
    refreshDevices,
    requestDevice,
    openDevice,
    closeDevice,
    sendReport,
    describeDevice,
  }
}
