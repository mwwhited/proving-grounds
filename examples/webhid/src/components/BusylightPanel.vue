<script setup>
import { ref } from 'vue'
import { useWebHid } from '../composables/useWebHid'
import { BUSYLIGHT_FILTERS, buildCommand, buildOffCommand } from '../devices/busylight'

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
  describeDevice,
} = useWebHid()

const color = ref('#ff0000')
const onSteps = ref(5)
const offSteps = ref(0)

refreshDevices()

function hexToRgb(hex) {
  const value = hex.replace('#', '')
  return [parseInt(value.slice(0, 2), 16), parseInt(value.slice(2, 4), 16), parseInt(value.slice(4, 6), 16)]
}

async function setColor() {
  if (!selectedDevice.value?.opened) return
  await selectedDevice.value.sendReport(
    0,
    buildCommand({ color: hexToRgb(color.value), on: Number(onSteps.value), off: Number(offSteps.value) }),
  )
}

async function turnOff() {
  if (!selectedDevice.value?.opened) return
  await selectedDevice.value.sendReport(0, buildOffCommand())
}
</script>

<template>
  <section class="panel">
    <h2>Kuando Busylight</h2>
    <p class="hint">USB HID, vendorId 0x04d8, productId 0xf848. Sends an 8-byte output report per command.</p>

    <p v-if="!isSupported" class="warning">
      navigator.hid is not available in this browser. Try Chrome or Edge over HTTPS or localhost.
    </p>

    <template v-else>
      <div class="actions">
        <button @click="requestDevice(BUSYLIGHT_FILTERS)">Pair Busylight…</button>
        <button @click="refreshDevices">Refresh Paired Devices</button>
      </div>

      <ul class="device-list">
        <li v-for="device in devices" :key="device.productId + '-' + device.vendorId">
          <span>{{ describeDevice(device) }}</span>
          <button v-if="!device.opened" @click="openDevice(device)">Open</button>
          <button v-else @click="closeDevice(device)">Close</button>
        </li>
      </ul>

      <div v-if="selectedDevice?.opened" class="report-form">
        <h3>Set Color</h3>
        <label>
          Color
          <input v-model="color" type="color" />
        </label>
        <label>
          On steps (~100ms each)
          <input v-model="onSteps" type="number" min="0" max="255" />
        </label>
        <label>
          Off steps (~100ms each, 0 = solid)
          <input v-model="offSteps" type="number" min="0" max="255" />
        </label>
        <div class="actions">
          <button @click="setColor">Send Color</button>
          <button @click="turnOff">Turn Off</button>
        </div>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
