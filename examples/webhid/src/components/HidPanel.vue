<script setup>
import { ref } from 'vue'
import { useWebHid } from '../composables/useWebHid'

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
  sendReport,
  describeDevice,
} = useWebHid()

const reportId = ref(0)
const outputBytes = ref('0, 0, 0, 0, 0, 0, 0, 0')

refreshDevices()

function parseBytes(text) {
  return text
    .split(',')
    .map((part) => part.trim())
    .filter((part) => part.length > 0)
    .map((part) => Number(part) & 0xff)
}

function handleSend() {
  sendReport(selectedDevice.value, Number(reportId.value), parseBytes(outputBytes.value))
}
</script>

<template>
  <section class="panel">
    <h2>WebHID Explorer</h2>

    <p v-if="!isSupported" class="warning">
      navigator.hid is not available in this browser. Try Chrome or Edge over HTTPS or localhost.
    </p>

    <template v-else>
      <div class="actions">
        <button @click="requestDevice()">Request HID Device…</button>
        <button @click="refreshDevices">Refresh Paired Devices</button>
      </div>

      <ul class="device-list">
        <li v-for="device in devices" :key="device.productId + '-' + device.vendorId">
          <span>{{ describeDevice(device) }}</span>
          <button v-if="!device.opened" @click="openDevice(device)">Open</button>
          <button v-else @click="closeDevice(device)">Close</button>
        </li>
      </ul>

      <div v-if="selectedDevice" class="report-form">
        <h3>Send Output Report</h3>
        <label>
          Report ID
          <input v-model="reportId" type="number" min="0" />
        </label>
        <label>
          Bytes (comma separated)
          <input v-model="outputBytes" type="text" />
        </label>
        <button :disabled="!selectedDevice.opened" @click="handleSend">Send Report</button>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
