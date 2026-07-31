<script setup>
import { onUnmounted, ref } from 'vue'
import { useWebSerial } from '../composables/useWebSerial'

const { isSupported, port, isConnected, log, error, addLog, requestPort, openPort, closePort } = useWebSerial()

const baudRate = ref(9600)
const writeMode = ref('text')
const writeText = ref('')
const isReading = ref(false)
let reader = null

async function connect() {
  await requestPort()
  if (port.value) {
    await openPort(Number(baudRate.value))
  }
}

async function disconnect() {
  await stopReading()
  await closePort()
}

onUnmounted(() => {
  stopReading()
  if (port.value) {
    port.value.close().catch(() => {})
  }
})

function parseBytes(text) {
  return text
    .split(',')
    .map((part) => part.trim())
    .filter((part) => part.length > 0)
    .map((part) => Number(part) & 0xff)
}

async function send() {
  if (!port.value || !isConnected.value) return
  const writer = port.value.writable.getWriter()
  try {
    const bytes =
      writeMode.value === 'text' ? new TextEncoder().encode(writeText.value) : new Uint8Array(parseBytes(writeText.value))
    await writer.write(bytes)
    addLog(`wrote ${bytes.length} bytes`)
  } catch (err) {
    error.value = err.message
  } finally {
    writer.releaseLock()
  }
}

async function readLoop() {
  try {
    while (isReading.value) {
      const { value, done } = await reader.read()
      if (done) break
      if (value?.length) {
        const hex = Array.from(value)
          .map((b) => b.toString(16).padStart(2, '0'))
          .join(' ')
        const text = new TextDecoder().decode(value).replace(/[\r\n]/g, '\\n')
        addLog(`read ${value.length} bytes: [${hex}] "${text}"`)
      }
    }
  } catch (err) {
    error.value = err.message
  } finally {
    reader?.releaseLock()
    reader = null
    isReading.value = false
  }
}

function startReading() {
  if (!port.value || !isConnected.value || isReading.value) return
  isReading.value = true
  reader = port.value.readable.getReader()
  readLoop()
}

async function stopReading() {
  isReading.value = false
  if (reader) {
    try {
      await reader.cancel()
    } catch {
      // reader may already have been released by readLoop's own cleanup
    }
  }
}
</script>

<template>
  <section class="panel">
    <h2>Web Serial Explorer</h2>

    <p v-if="!isSupported" class="warning">navigator.serial is not available in this browser. Try Chrome or Edge.</p>

    <template v-else>
      <div class="actions">
        <label>
          Baud rate
          <input v-model="baudRate" type="number" min="1" :disabled="!!port" />
        </label>
        <button v-if="!port" @click="connect">Request Port…</button>
        <button v-else @click="disconnect">Disconnect</button>
      </div>

      <div v-if="isConnected" class="report-form">
        <h3>Write</h3>
        <label>
          Mode
          <select v-model="writeMode">
            <option value="text">Text</option>
            <option value="bytes">Bytes (comma separated)</option>
          </select>
        </label>
        <label>
          {{ writeMode === 'text' ? 'Text to send' : 'Bytes to send' }}
          <input v-model="writeText" type="text" />
        </label>
        <button @click="send">Write</button>

        <h3>Read</h3>
        <button v-if="!isReading" @click="startReading">Start Reading</button>
        <button v-else @click="stopReading">Stop Reading</button>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
