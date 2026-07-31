import { ref, shallowRef } from 'vue'

export function useWebBluetooth() {
  const isSupported = typeof navigator !== 'undefined' && 'bluetooth' in navigator
  const device = shallowRef(null)
  const server = shallowRef(null)
  const services = shallowRef([])
  const isConnected = ref(false)
  const log = ref([])
  const error = ref('')

  function addLog(message) {
    const time = new Date().toLocaleTimeString()
    log.value = [...log.value, `[${time}] ${message}`].slice(-200)
  }

  function describeDevice(target) {
    return target?.name || target?.id || 'Unknown device'
  }

  function onDisconnected() {
    isConnected.value = false
    server.value = null
    services.value = []
    addLog(`disconnected: ${describeDevice(device.value)}`)
  }

  async function requestDevice({ filters = [], optionalServices = [] } = {}) {
    if (!isSupported) return
    error.value = ''
    try {
      const options = filters.length ? { filters, optionalServices } : { acceptAllDevices: true, optionalServices }
      const picked = await navigator.bluetooth.requestDevice(options)
      device.value?.removeEventListener('gattserverdisconnected', onDisconnected)
      device.value = picked
      device.value.addEventListener('gattserverdisconnected', onDisconnected)
      addLog(`Selected device: ${describeDevice(picked)}`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function connect() {
    if (!device.value) return
    error.value = ''
    try {
      server.value = await device.value.gatt.connect()
      isConnected.value = true
      addLog(`Connected GATT server on ${describeDevice(device.value)}`)
    } catch (err) {
      error.value = err.message
    }
  }

  function disconnect() {
    if (!device.value?.gatt) return
    device.value.gatt.disconnect()
  }

  async function discoverServices() {
    if (!server.value) return
    error.value = ''
    try {
      const primaryServices = await server.value.getPrimaryServices()
      services.value = await Promise.all(
        primaryServices.map(async (service) => ({
          service,
          characteristics: await service.getCharacteristics(),
        })),
      )
      addLog(`Discovered ${primaryServices.length} service(s)`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function readCharacteristic(characteristic) {
    error.value = ''
    try {
      const value = await characteristic.readValue()
      const bytes = Array.from(new Uint8Array(value.buffer))
      addLog(`read ${characteristic.uuid}: [${bytes.join(', ')}]`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function writeCharacteristic(characteristic, bytes) {
    error.value = ''
    try {
      await characteristic.writeValue(new Uint8Array(bytes))
      addLog(`wrote ${characteristic.uuid}: [${bytes.join(', ')}]`)
    } catch (err) {
      error.value = err.message
    }
  }

  function onCharacteristicValueChanged(event) {
    const bytes = Array.from(new Uint8Array(event.target.value.buffer))
    addLog(`notify ${event.target.uuid}: [${bytes.join(', ')}]`)
  }

  async function startNotifications(characteristic) {
    error.value = ''
    try {
      await characteristic.startNotifications()
      characteristic.addEventListener('characteristicvaluechanged', onCharacteristicValueChanged)
      addLog(`subscribed to notifications on ${characteristic.uuid}`)
    } catch (err) {
      error.value = err.message
    }
  }

  async function stopNotifications(characteristic) {
    error.value = ''
    try {
      await characteristic.stopNotifications()
      characteristic.removeEventListener('characteristicvaluechanged', onCharacteristicValueChanged)
      addLog(`unsubscribed from notifications on ${characteristic.uuid}`)
    } catch (err) {
      error.value = err.message
    }
  }

  return {
    isSupported,
    device,
    server,
    services,
    isConnected,
    log,
    error,
    addLog,
    describeDevice,
    requestDevice,
    connect,
    disconnect,
    discoverServices,
    readCharacteristic,
    writeCharacteristic,
    startNotifications,
    stopNotifications,
  }
}
