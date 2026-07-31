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
    if (!port.value || isConnected.value) return
    error.value = ''
    try {
      await port.value.open({ baudRate })
      isConnected.value = true
      addLog(`Opened port at ${baudRate} baud`)
    } catch (err) {
      // A dev-mode hot-reload (or a stale reference from a previous session) can leave the
      // browser's underlying port handle open even though our own isConnected state was reset.
      // Treat "already open" as success instead of leaving the UI stuck with no way to close it.
      if (err.name === 'InvalidStateError' && /already open/i.test(err.message)) {
        isConnected.value = true
        addLog('Port was already open - reusing existing connection')
        return
      }
      error.value = err.message
    }
  }

  async function closePort() {
    if (!port.value) return
    error.value = ''
    try {
      await port.value.close()
      addLog('Closed port')
    } catch (err) {
      error.value = err.message
    } finally {
      // Reset regardless of how close() went - otherwise a failed close leaves the UI stuck
      // showing "Disconnect" with no way back to a fresh "Connect" (new requestPort() picker).
      isConnected.value = false
      port.value = null
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
