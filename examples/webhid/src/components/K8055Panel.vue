<script setup>
import { reactive, ref } from 'vue'
import { useWebHid } from '../composables/useWebHid'
import { K8055_FILTERS, Commands, DIGITAL_OUTPUTS, DIGITAL_INPUTS, buildRequest, decodeResponse } from '../devices/k8055'

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

const outputs = reactive(new Set())
const analog1 = ref(0)
const analog2 = ref(0)
const reading = ref(null)

refreshDevices()

function onInputReport(event) {
  reading.value = decodeResponse(new Uint8Array(event.data.buffer))
}

async function open(device) {
  await openDevice(device)
  device.addEventListener('inputreport', onInputReport)
}

async function close(device) {
  device.removeEventListener('inputreport', onInputReport)
  await closeDevice(device)
}

function outputsMask() {
  let mask = 0
  for (const bit of outputs) mask |= bit
  return mask
}

async function sendOutputs() {
  if (!selectedDevice.value?.opened) return
  await selectedDevice.value.sendReport(
    0,
    buildRequest({
      command: Commands.SetAnalogDigital,
      outputsMask: outputsMask(),
      analog1: Number(analog1.value),
      analog2: Number(analog2.value),
    }),
  )
}

function toggleOutput(bit) {
  if (outputs.has(bit)) outputs.delete(bit)
  else outputs.add(bit)
  sendOutputs()
}

async function resetCounter1() {
  if (!selectedDevice.value?.opened) return
  await selectedDevice.value.sendReport(0, buildRequest({ command: Commands.ResetCounter1 }))
}

async function resetCounter2() {
  if (!selectedDevice.value?.opened) return
  await selectedDevice.value.sendReport(0, buildRequest({ command: Commands.ResetCounter2 }))
}

function isInputActive(bit) {
  return reading.value ? (reading.value.digitalInputsMask & bit) !== 0 : false
}
</script>

<template>
  <section class="panel">
    <h2>Velleman K8055</h2>
    <p class="hint">
      USB HID, vendorId 0x10cf, productId 0x5500-0x5503 (address jumpers). 8-byte input/output reports.
    </p>

    <p v-if="!isSupported" class="warning">
      navigator.hid is not available in this browser. Try Chrome or Edge over HTTPS or localhost.
    </p>

    <template v-else>
      <div class="actions">
        <button @click="requestDevice(K8055_FILTERS)">Pair K8055…</button>
        <button @click="refreshDevices">Refresh Paired Devices</button>
      </div>

      <ul class="device-list">
        <li v-for="device in devices" :key="device.productId + '-' + device.vendorId">
          <span>{{ describeDevice(device) }}</span>
          <button v-if="!device.opened" @click="open(device)">Open</button>
          <button v-else @click="close(device)">Close</button>
        </li>
      </ul>

      <div v-if="selectedDevice?.opened" class="report-form">
        <h3>Digital Outputs</h3>
        <div class="toggle-row">
          <button
            v-for="output in DIGITAL_OUTPUTS"
            :key="output.label"
            :class="{ active: outputs.has(output.bit) }"
            @click="toggleOutput(output.bit)"
          >
            {{ output.label }}
          </button>
        </div>

        <h3>Analog Outputs</h3>
        <label>
          Analog 1 ({{ analog1 }})
          <input v-model="analog1" type="range" min="0" max="255" @change="sendOutputs" />
        </label>
        <label>
          Analog 2 ({{ analog2 }})
          <input v-model="analog2" type="range" min="0" max="255" @change="sendOutputs" />
        </label>

        <h3>Digital Inputs</h3>
        <div class="toggle-row">
          <span
            v-for="input in DIGITAL_INPUTS"
            :key="input.label"
            :class="['pill', { active: isInputActive(input.bit) }]"
          >
            {{ input.label }}
          </span>
        </div>

        <h3>Counters</h3>
        <div class="readout-row">
          <span>Counter 1: {{ reading?.counter1 ?? '—' }}</span>
          <button @click="resetCounter1">Reset</button>
        </div>
        <div class="readout-row">
          <span>Counter 2: {{ reading?.counter2 ?? '—' }}</span>
          <button @click="resetCounter2">Reset</button>
        </div>

        <h3>Analog Inputs</h3>
        <div class="readout-row">
          <span>Analog 1: {{ reading?.analog1 ?? '—' }}</span>
          <span>Analog 2: {{ reading?.analog2 ?? '—' }}</span>
        </div>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
