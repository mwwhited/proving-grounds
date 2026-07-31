<script setup>
import { ref } from 'vue'
import { useWebSerial } from '../composables/useWebSerial'
import {
  buildPing,
  buildReadValuesRequest,
  buildReadSerialNumberRequest,
  decode,
  readFrame,
} from '../devices/radexOne'

const { isSupported, port, isConnected, log, error, addLog, requestPort, openPort, closePort } = useWebSerial()

const packetNumber = ref(1)
const lastValues = ref(null)
const lastSerialNumber = ref(null)
const busy = ref(false)

async function connect() {
  await requestPort()
  if (port.value) {
    await openPort(9600)
  }
}

async function disconnect() {
  await closePort()
}

async function sendAndReceive(buildRequest) {
  if (!port.value || !isConnected.value || busy.value) return
  busy.value = true
  const writer = port.value.writable.getWriter()
  const reader = port.value.readable.getReader()
  try {
    const request = buildRequest(packetNumber.value)
    await writer.write(request)
    addLog(`sent ${request.length} bytes (packet #${packetNumber.value})`)
    const frame = await readFrame(reader)
    const result = decode(frame)
    addLog(`received: ${JSON.stringify(result)}`)
    packetNumber.value++
    return result
  } catch (err) {
    error.value = err.message
    addLog(`error: ${err.message}`)
  } finally {
    reader.releaseLock()
    writer.releaseLock()
    busy.value = false
  }
}

async function ping() {
  await sendAndReceive(buildPing)
}

async function readValues() {
  const result = await sendAndReceive(buildReadValuesRequest)
  if (result?.type === 'values') lastValues.value = result
}

async function readSerialNumber() {
  const result = await sendAndReceive(buildReadSerialNumberRequest)
  if (result?.type === 'serialNumber') lastSerialNumber.value = result
}
</script>

<template>
  <section class="panel">
    <h2>Quarta RadexOne</h2>
    <p class="hint">
      RadexOne enumerates as a USB-to-serial (COM) device, so it's reached with the
      <a href="https://developer.mozilla.org/en-US/docs/Web/API/Web_Serial_API" target="_blank" rel="noreferrer"
        >Web Serial API</a
      >
      rather than WebHID/WebUSB - Windows binds a serial driver to the interface before WebUSB could claim it.
    </p>

    <p v-if="!isSupported" class="warning">navigator.serial is not available in this browser. Try Chrome or Edge.</p>

    <template v-else>
      <div class="actions">
        <button v-if="!isConnected" @click="connect">Connect (select port, 9600 baud)</button>
        <button v-else @click="disconnect">Disconnect</button>
      </div>

      <div v-if="isConnected" class="actions">
        <button :disabled="busy" @click="ping">Ping</button>
        <button :disabled="busy" @click="readSerialNumber">Read Serial Number</button>
        <button :disabled="busy" @click="readValues">Read Values</button>
      </div>

      <dl v-if="lastValues" class="readout">
        <div>
          <dt>Ambient</dt>
          <dd>{{ lastValues.ambient }} µSv/h</dd>
        </div>
        <div>
          <dt>Accumulated</dt>
          <dd>{{ lastValues.accumulated }} µSv</dd>
        </div>
        <div>
          <dt>Clicks/min</dt>
          <dd>{{ lastValues.clicksPerMinute }}</dd>
        </div>
      </dl>

      <dl v-if="lastSerialNumber" class="readout">
        <div>
          <dt>Serial Number</dt>
          <dd>{{ lastSerialNumber.serialNumber }}</dd>
        </div>
        <div>
          <dt>Firmware</dt>
          <dd>{{ lastSerialNumber.version }}</dd>
        </div>
      </dl>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
