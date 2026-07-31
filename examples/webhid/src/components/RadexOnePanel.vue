<script setup>
import { onUnmounted, ref } from 'vue'
import { useWebSerial } from '../composables/useWebSerial'
import SparklineChart from './SparklineChart.vue'
import {
  buildPing,
  buildReadValuesRequest,
  buildReadSerialNumberRequest,
  decode,
  readFrame,
} from '../devices/radexOne'

const MAX_HISTORY = 120

const { isSupported, port, isConnected, log, error, addLog, requestPort, openPort, closePort } = useWebSerial()

const packetNumber = ref(1)
const lastValues = ref(null)
const lastSerialNumber = ref(null)
const busy = ref(false)

const ambientHistory = ref([])
const clicksHistory = ref([])
const accumulatedHistory = ref([])

const isPolling = ref(false)
const pollIntervalMs = ref(3000)
let pollHandle = null

async function connect() {
  await requestPort()
  if (port.value) {
    await openPort(9600)
    ambientHistory.value = []
    clicksHistory.value = []
    accumulatedHistory.value = []
  }
}

async function disconnect() {
  stopPolling()
  await closePort()
}

// Closes the underlying port when this panel goes away (dev-mode hot-reload included) - without
// this, the browser's serial handle stays open with nothing left in the UI able to close it, and
// the next "Connect" fails with "The port is already open".
onUnmounted(() => {
  stopPolling()
  if (port.value) {
    port.value.close().catch(() => {})
  }
})

function recordValues(result) {
  const t = Date.now()
  ambientHistory.value = [...ambientHistory.value, { t, v: result.ambient }].slice(-MAX_HISTORY)
  clicksHistory.value = [...clicksHistory.value, { t, v: result.clicksPerMinute }].slice(-MAX_HISTORY)
  accumulatedHistory.value = [...accumulatedHistory.value, { t, v: result.accumulated }].slice(-MAX_HISTORY)
}

async function pollTick() {
  if (!isPolling.value) return
  await readValues()
  if (isPolling.value) {
    pollHandle = setTimeout(pollTick, Number(pollIntervalMs.value))
  }
}

function startPolling() {
  if (isPolling.value || !isConnected.value) return
  isPolling.value = true
  pollTick()
}

function stopPolling() {
  isPolling.value = false
  if (pollHandle) {
    clearTimeout(pollHandle)
    pollHandle = null
  }
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
  if (result?.type === 'values') {
    lastValues.value = result
    recordValues(result)
  }
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
        <button v-if="!port" @click="connect">Connect (select port, 9600 baud)</button>
        <button v-else @click="disconnect">Disconnect</button>
      </div>

      <div v-if="isConnected" class="actions">
        <button :disabled="busy" @click="ping">Ping</button>
        <button :disabled="busy" @click="readSerialNumber">Read Serial Number</button>
        <button :disabled="busy" @click="readValues">Read Values</button>
      </div>

      <div v-if="isConnected" class="actions">
        <label>
          Poll interval (ms)
          <input v-model="pollIntervalMs" type="number" min="500" step="500" :disabled="isPolling" />
        </label>
        <button v-if="!isPolling" @click="startPolling">Start Polling</button>
        <button v-else @click="stopPolling">Stop Polling</button>
      </div>

      <div v-if="ambientHistory.length" class="charts">
        <SparklineChart title="Ambient" unit="µSv/h" :points="ambientHistory" :series-index="1" :decimals="2" />
        <SparklineChart title="Clicks / min" unit="cpm" :points="clicksHistory" :series-index="2" :decimals="0" />
        <SparklineChart
          title="Accumulated"
          unit="µSv"
          :points="accumulatedHistory"
          :series-index="3"
          :decimals="2"
        />
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
