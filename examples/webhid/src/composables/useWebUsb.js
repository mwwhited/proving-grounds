import { ref, shallowRef } from 'vue'

export function useWebUsb() {
  const isSupported = typeof navigator !== 'undefined' && 'usb' in navigator
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
    devices.value = await navigator.usb.getDevices()
  }

  async function requestDevice() {
    if (!isSupported) return
    error.value = ''
    try {
      const device = await navigator.usb.requestDevice({ filters: [] })
      selectedDevice.value = device
      addLog(`Selected device: ${describeDevice(device)}`)
      await refreshDevices()
    } catch (err) {
      error.value = err.message
    }
  }

  async function openDevice(device) {
    if (!device) return
    error.value = ''
    try {
      await device.open()
      if (device.configuration === null) {
        await device.selectConfiguration(1)
      }
      await device.claimInterface(0)
      selectedDevice.value = device
      addLog(`Opened ${describeDevice(device)}, claimed interface 0`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function closeDevice(device) {
    if (!device) return
    error.value = ''
    try {
      await device.releaseInterface(0)
      await device.close()
      addLog(`Closed ${describeDevice(device)}`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function controlTransferIn(device, setup, length) {
    if (!device) return
    error.value = ''
    try {
      const result = await device.controlTransferIn(setup, length)
      const bytes = result.data ? Array.from(new Uint8Array(result.data.buffer)) : []
      addLog(`controlTransferIn status=${result.status} bytes=[${bytes.join(', ')}]`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function controlTransferOut(device, setup, bytes) {
    if (!device) return
    error.value = ''
    try {
      const result = await device.controlTransferOut(setup, new Uint8Array(bytes))
      addLog(`controlTransferOut status=${result.status} bytesWritten=${result.bytesWritten}`)
    } catch (err) {
      error.value = err.message
    }
  }

  if (isSupported) {
    navigator.usb.addEventListener('connect', ({ device }) => {
      addLog(`connect event: ${describeDevice(device)}`)
      refreshDevices()
    })
    navigator.usb.addEventListener('disconnect', ({ device }) => {
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
    controlTransferIn,
    controlTransferOut,
    describeDevice,
  }
}
