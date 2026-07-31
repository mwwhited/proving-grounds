<script setup>
import { ref } from 'vue'
import { useWebUsb } from '../composables/useWebUsb'

const {
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
} = useWebUsb()

const requestType = ref('vendor')
const recipient = ref('device')
const request = ref(1)
const value = ref(0)
const index = ref(0)
const inLength = ref(8)
const outBytes = ref('0, 0, 0, 0')

refreshDevices()

function parseBytes(text) {
  return text
    .split(',')
    .map((part) => part.trim())
    .filter((part) => part.length > 0)
    .map((part) => Number(part) & 0xff)
}

function currentSetup() {
  return {
    requestType: requestType.value,
    recipient: recipient.value,
    request: Number(request.value),
    value: Number(value.value),
    index: Number(index.value),
  }
}

function handleControlIn() {
  controlTransferIn(selectedDevice.value, currentSetup(), Number(inLength.value))
}

function handleControlOut() {
  controlTransferOut(selectedDevice.value, currentSetup(), parseBytes(outBytes.value))
}
</script>

<template>
  <section class="panel">
    <h2>WebUSB Explorer</h2>

    <p v-if="!isSupported" class="warning">
      navigator.usb is not available in this browser. Try Chrome or Edge over HTTPS or localhost.
    </p>

    <template v-else>
      <div class="actions">
        <button @click="requestDevice">Request USB Device…</button>
        <button @click="refreshDevices">Refresh Paired Devices</button>
      </div>

      <ul class="device-list">
        <li v-for="device in devices" :key="(device.serialNumber || '') + device.productId + '-' + device.vendorId">
          <span>{{ describeDevice(device) }}</span>
          <button v-if="!device.opened" @click="openDevice(device)">Open + Claim Interface 0</button>
          <button v-else @click="closeDevice(device)">Close</button>
        </li>
      </ul>

      <div v-if="selectedDevice" class="report-form">
        <h3>Control Transfer</h3>
        <div class="grid">
          <label>
            requestType
            <select v-model="requestType">
              <option value="standard">standard</option>
              <option value="class">class</option>
              <option value="vendor">vendor</option>
            </select>
          </label>
          <label>
            recipient
            <select v-model="recipient">
              <option value="device">device</option>
              <option value="interface">interface</option>
              <option value="endpoint">endpoint</option>
              <option value="other">other</option>
            </select>
          </label>
          <label>
            request
            <input v-model="request" type="number" />
          </label>
          <label>
            value
            <input v-model="value" type="number" />
          </label>
          <label>
            index
            <input v-model="index" type="number" />
          </label>
        </div>

        <div class="transfer-row">
          <label>
            IN length
            <input v-model="inLength" type="number" min="0" />
          </label>
          <button :disabled="!selectedDevice.opened" @click="handleControlIn">controlTransferIn</button>
        </div>

        <div class="transfer-row">
          <label>
            OUT bytes (comma separated)
            <input v-model="outBytes" type="text" />
          </label>
          <button :disabled="!selectedDevice.opened" @click="handleControlOut">controlTransferOut</button>
        </div>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
