<script setup>
import { onUnmounted, reactive, ref } from 'vue'
import { useWebBluetooth } from '../composables/useWebBluetooth'

const {
  isSupported,
  device,
  services,
  isConnected,
  log,
  error,
  describeDevice,
  requestDevice,
  connect,
  disconnect,
  discoverServices,
  readCharacteristic,
  writeCharacteristic,
  startNotifications,
  stopNotifications,
} = useWebBluetooth()

const namePrefix = ref('')
const optionalServicesText = ref('battery_service, generic_access')

// Keyed by the characteristic instance itself, same reasoning as the per-device Maps in the
// K8055 panel - each characteristic needs its own pending write text and subscription state.
const charStates = reactive(new Map())

function stateFor(characteristic) {
  if (!charStates.has(characteristic)) {
    charStates.set(characteristic, reactive({ writeText: '0', subscribed: false }))
  }
  return charStates.get(characteristic)
}

onUnmounted(() => {
  disconnect()
})

function parseList(text) {
  return text
    .split(',')
    .map((part) => part.trim())
    .filter((part) => part.length > 0)
}

function parseBytes(text) {
  return parseList(text).map((part) => Number(part) & 0xff)
}

async function pick() {
  const filters = namePrefix.value ? [{ namePrefix: namePrefix.value }] : []
  await requestDevice({ filters, optionalServices: parseList(optionalServicesText.value) })
}

async function submitWrite(characteristic) {
  const state = stateFor(characteristic)
  await writeCharacteristic(characteristic, parseBytes(state.writeText))
}

async function toggleNotifications(characteristic) {
  const state = stateFor(characteristic)
  if (state.subscribed) {
    await stopNotifications(characteristic)
    state.subscribed = false
  } else {
    await startNotifications(characteristic)
    state.subscribed = true
  }
}

function hasProperty(characteristic, name) {
  return Boolean(characteristic.properties?.[name])
}
</script>

<template>
  <section class="panel">
    <h2>Web Bluetooth Explorer</h2>
    <p class="hint">
      GATT services you want to use after connecting must be declared as "optional services" up
      front - Web Bluetooth won't let you discover services you didn't ask for.
    </p>

    <p v-if="!isSupported" class="warning">
      navigator.bluetooth is not available in this browser. Try Chrome or Edge over HTTPS or localhost.
    </p>

    <template v-else>
      <div class="report-form">
        <label>
          Device name prefix (blank = accept all devices)
          <input v-model="namePrefix" type="text" />
        </label>
        <label>
          Optional GATT services (comma separated - short names like battery_service, or a full UUID)
          <input v-model="optionalServicesText" type="text" />
        </label>
        <div class="actions">
          <button @click="pick">Request Device…</button>
        </div>
      </div>

      <ul v-if="device" class="device-list">
        <li>
          <span>{{ describeDevice(device) }}</span>
          <button v-if="!isConnected" @click="connect">Connect GATT</button>
          <button v-else @click="disconnect">Disconnect</button>
        </li>
      </ul>

      <div v-if="isConnected" class="actions">
        <button @click="discoverServices">Discover Services</button>
      </div>

      <div v-for="{ service, characteristics } in services" :key="service.uuid" class="report-form">
        <h3>Service {{ service.uuid }}</h3>

        <div v-for="characteristic in characteristics" :key="characteristic.uuid" class="readout-row">
          <span>{{ characteristic.uuid }}</span>
          <span v-if="hasProperty(characteristic, 'read')" class="pill active">read</span>
          <span
            v-if="hasProperty(characteristic, 'write') || hasProperty(characteristic, 'writeWithoutResponse')"
            class="pill active"
            >write</span
          >
          <span
            v-if="hasProperty(characteristic, 'notify') || hasProperty(characteristic, 'indicate')"
            class="pill active"
            >notify</span
          >

          <button v-if="hasProperty(characteristic, 'read')" @click="readCharacteristic(characteristic)">Read</button>

          <template v-if="hasProperty(characteristic, 'write') || hasProperty(characteristic, 'writeWithoutResponse')">
            <input v-model="stateFor(characteristic).writeText" type="text" placeholder="bytes, e.g. 1, 0, 255" />
            <button @click="submitWrite(characteristic)">Write</button>
          </template>

          <button
            v-if="hasProperty(characteristic, 'notify') || hasProperty(characteristic, 'indicate')"
            @click="toggleNotifications(characteristic)"
          >
            {{ stateFor(characteristic).subscribed ? 'Unsubscribe' : 'Subscribe' }}
          </button>
        </div>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
