<script setup>
import { reactive } from 'vue'
import { useWebHid } from '../composables/useWebHid'
import SparklineChart from './SparklineChart.vue'
import {
  K8055_FILTERS,
  Commands,
  DIGITAL_OUTPUTS,
  DIGITAL_INPUTS,
  buildRequest,
  decodeResponse,
  matchesK8055,
} from '../devices/k8055'

const MAX_HISTORY = 120
// The board pushes an input report on every interrupt-endpoint poll (well under 100ms) -
// recording every one would flood the chart and the array copy on every reactive push.
// Throttle to one sample per window instead.
const RECORD_INTERVAL_MS = 250

const {
  isSupported,
  devices,
  log,
  error,
  refreshDevices,
  requestDevice,
  openDevice,
  closeDevice,
  describeDevice,
} = useWebHid({ match: matchesK8055 })

// Keyed by the HIDDevice instance itself, not vendorId/productId - two physical boards can
// share the same address (e.g. both left on the default jumper setting), so productId alone
// isn't unique. The browser hands back the same HIDDevice object for a given physical device
// across calls, so the object reference is a safe per-device identity.
const deviceStates = reactive(new Map())

function stateFor(device) {
  if (!deviceStates.has(device)) {
    deviceStates.set(
      device,
      reactive({
        outputs: new Set(),
        analog1: 0,
        analog2: 0,
        reading: null,
        analog1History: [],
        analog2History: [],
        lastRecordedAt: 0,
      }),
    )
  }
  return deviceStates.get(device)
}

// Boards sharing an address (same vendorId/productId) look identical via describeDevice(),
// so tag them #1, #2, ... in connection order to keep them visually distinguishable.
function deviceLabel(device) {
  const sameAddress = devices.value.filter((d) => d.vendorId === device.vendorId && d.productId === device.productId)
  const label = describeDevice(device)
  return sameAddress.length > 1 ? `${label} #${sameAddress.indexOf(device) + 1}` : label
}

refreshDevices()

function onInputReport(event) {
  const state = stateFor(event.target)
  state.reading = decodeResponse(new Uint8Array(event.data.buffer))

  const t = Date.now()
  if (t - state.lastRecordedAt >= RECORD_INTERVAL_MS) {
    state.lastRecordedAt = t
    state.analog1History = [...state.analog1History, { t, v: state.reading.analog1 }].slice(-MAX_HISTORY)
    state.analog2History = [...state.analog2History, { t, v: state.reading.analog2 }].slice(-MAX_HISTORY)
  }
}

async function open(device) {
  await openDevice(device)
  device.addEventListener('inputreport', onInputReport)
  stateFor(device)
}

async function close(device) {
  device.removeEventListener('inputreport', onInputReport)
  await closeDevice(device)
}

function outputsMask(state) {
  let mask = 0
  for (const bit of state.outputs) mask |= bit
  return mask
}

async function sendOutputs(device) {
  if (!device.opened) return
  const state = stateFor(device)
  await device.sendReport(
    0,
    buildRequest({
      command: Commands.SetAnalogDigital,
      outputsMask: outputsMask(state),
      analog1: Number(state.analog1),
      analog2: Number(state.analog2),
    }),
  )
}

function toggleOutput(device, bit) {
  const state = stateFor(device)
  if (state.outputs.has(bit)) state.outputs.delete(bit)
  else state.outputs.add(bit)
  sendOutputs(device)
}

async function resetCounter1(device) {
  if (!device.opened) return
  await device.sendReport(0, buildRequest({ command: Commands.ResetCounter1 }))
}

async function resetCounter2(device) {
  if (!device.opened) return
  await device.sendReport(0, buildRequest({ command: Commands.ResetCounter2 }))
}

function isInputActive(state, bit) {
  return state.reading ? (state.reading.digitalInputsMask & bit) !== 0 : false
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
        <li v-for="device in devices" :key="device">
          <span>{{ deviceLabel(device) }}</span>
          <button v-if="!device.opened" @click="open(device)">Open</button>
          <button v-else @click="close(device)">Close</button>
        </li>
      </ul>

      <div
        v-for="device in devices.filter((d) => d.opened)"
        :key="device"
        class="report-form"
      >
        <h3>{{ deviceLabel(device) }}</h3>

        <h4>Digital Outputs</h4>
        <div class="toggle-row">
          <button
            v-for="output in DIGITAL_OUTPUTS"
            :key="output.label"
            :class="{ active: stateFor(device).outputs.has(output.bit) }"
            @click="toggleOutput(device, output.bit)"
          >
            {{ output.label }}
          </button>
        </div>

        <h4>Analog Outputs</h4>
        <label>
          Analog 1 ({{ stateFor(device).analog1 }})
          <input v-model="stateFor(device).analog1" type="range" min="0" max="255" @change="sendOutputs(device)" />
        </label>
        <label>
          Analog 2 ({{ stateFor(device).analog2 }})
          <input v-model="stateFor(device).analog2" type="range" min="0" max="255" @change="sendOutputs(device)" />
        </label>

        <h4>Digital Inputs</h4>
        <div class="toggle-row">
          <span
            v-for="input in DIGITAL_INPUTS"
            :key="input.label"
            :class="['pill', { active: isInputActive(stateFor(device), input.bit) }]"
          >
            {{ input.label }}
          </span>
        </div>

        <h4>Counters</h4>
        <div class="readout-row">
          <span>Counter 1: {{ stateFor(device).reading?.counter1 ?? '—' }}</span>
          <button @click="resetCounter1(device)">Reset</button>
        </div>
        <div class="readout-row">
          <span>Counter 2: {{ stateFor(device).reading?.counter2 ?? '—' }}</span>
          <button @click="resetCounter2(device)">Reset</button>
        </div>

        <h4>Analog Inputs</h4>
        <div class="readout-row">
          <span>Analog 1: {{ stateFor(device).reading?.analog1 ?? '—' }}</span>
          <span>Analog 2: {{ stateFor(device).reading?.analog2 ?? '—' }}</span>
        </div>
        <div class="charts">
          <SparklineChart
            title="Analog 1"
            unit=""
            :points="stateFor(device).analog1History"
            :series-index="1"
            :decimals="0"
          />
          <SparklineChart
            title="Analog 2"
            unit=""
            :points="stateFor(device).analog2History"
            :series-index="2"
            :decimals="0"
          />
        </div>
      </div>

      <p v-if="error" class="error">{{ error }}</p>

      <pre class="log">{{ log.join('\n') }}</pre>
    </template>
  </section>
</template>
