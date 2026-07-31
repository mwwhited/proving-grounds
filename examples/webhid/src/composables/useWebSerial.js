import { ref, shallowRef } from 'vue'

export function useWebSerial() {
  const isSupported = typeof navigator !== 'undefined' && 'serial' in navigator
  const port = shallowRef(null)
  const isConnected = ref(false)
  const log = ref([])
  const error = ref('')

  function addLog(message) {
    const time = new Date().toLocaleTimeString()
    log.value = [...log.value, `[${time}] ${message}`].slice(-200)
  }

  async function requestPort(filters = []) {
    if (!isSupported) return
    error.value = ''
    try {
      port.value = await navigator.serial.requestPort({ filters })
      addLog('Serial port selected')
    } catch (err) {
      error.value = err.message
    }
  }

  async function openPort(baudRate = 9600) {
    if (!port.value) return
    error.value = ''
    try {
      await port.value.open({ baudRate })
      isConnected.value = true
      addLog(`Opened port at ${baudRate} baud`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function closePort() {
    if (!port.value) return
    error.value = ''
    try {
      await port.value.close()
      isConnected.value = false
      addLog('Closed port')
    } catch (err) {
      error.value = err.message
    }
  }

  return {
    isSupported,
    port,
    isConnected,
    log,
    error,
    addLog,
    requestPort,
    openPort,
    closePort,
  }
}
