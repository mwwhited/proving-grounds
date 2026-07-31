<script setup>
import { ref } from 'vue'
import BusylightPanel from './components/BusylightPanel.vue'
import K8055Panel from './components/K8055Panel.vue'
import RadexOnePanel from './components/RadexOnePanel.vue'
import HidPanel from './components/HidPanel.vue'
import UsbPanel from './components/UsbPanel.vue'
import SerialPanel from './components/SerialPanel.vue'
import BluetoothPanel from './components/BluetoothPanel.vue'
import WebcamPanel from './components/WebcamPanel.vue'
import BarcodeDetectorPanel from './components/BarcodeDetectorPanel.vue'

const isSecureContext = typeof window !== 'undefined' && window.isSecureContext
const tab = ref('devices')
</script>

<template>
  <main>
    <header>
      <h1>WebHID / WebUSB / Web Serial / Web Bluetooth Example</h1>
      <p>
        Minimal Vue 3 demo of the
        <a href="https://developer.mozilla.org/en-US/docs/Web/API/WebHID_API" target="_blank" rel="noreferrer"
          >WebHID</a
        >,
        <a href="https://developer.mozilla.org/en-US/docs/Web/API/WebUSB_API" target="_blank" rel="noreferrer"
          >WebUSB</a
        >,
        <a href="https://developer.mozilla.org/en-US/docs/Web/API/Web_Serial_API" target="_blank" rel="noreferrer"
          >Web Serial</a
        >, and
        <a href="https://developer.mozilla.org/en-US/docs/Web/API/Web_Bluetooth_API" target="_blank" rel="noreferrer"
          >Web Bluetooth</a
        >
        APIs. Requires Chrome/Edge and a secure context (HTTPS or localhost); the browser will prompt you to pick a
        device or port.
      </p>
      <p v-if="!isSecureContext" class="warning">
        This page is not running in a secure context, so WebHID/WebUSB/Web Serial/Web Bluetooth will be unavailable.
      </p>

      <nav class="tabs">
        <button :class="{ active: tab === 'devices' }" @click="tab = 'devices'">Devices</button>
        <button :class="{ active: tab === 'explorer' }" @click="tab = 'explorer'">Generic Explorer</button>
      </nav>
    </header>

    <div v-if="tab === 'devices'" class="panels">
      <BusylightPanel />
      <K8055Panel />
      <RadexOnePanel />
      <WebcamPanel />
      <BarcodeDetectorPanel />
    </div>

    <div v-else class="panels">
      <HidPanel />
      <UsbPanel />
      <SerialPanel />
      <BluetoothPanel />
    </div>
  </main>
</template>
