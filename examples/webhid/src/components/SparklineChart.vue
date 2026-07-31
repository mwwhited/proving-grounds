<script setup>
import { computed, ref } from 'vue'

const props = defineProps({
  title: { type: String, required: true },
  unit: { type: String, default: '' },
  points: { type: Array, default: () => [] }, // [{ t: Number, v: Number }]
  seriesIndex: { type: Number, default: 1 }, // 1, 2, or 3 -> --series-1/2/3
  decimals: { type: Number, default: 2 },
})

const width = 300
const height = 120
const paddingTop = 14
const paddingBottom = 18
const paddingX = 6

const bounds = computed(() => {
  if (!props.points.length) return { min: 0, max: 1 }
  const values = props.points.map((p) => p.v)
  const min = Math.min(...values)
  const max = Math.max(...values)
  return min === max ? { min: min - 1, max: max + 1 } : { min, max }
})

function xFor(index) {
  const count = props.points.length
  if (count <= 1) return paddingX
  return paddingX + (index / (count - 1)) * (width - paddingX * 2)
}

function yFor(value) {
  const { min, max } = bounds.value
  const t = (value - min) / (max - min)
  return height - paddingBottom - t * (height - paddingTop - paddingBottom)
}

const linePath = computed(() =>
  props.points.map((p, i) => `${i === 0 ? 'M' : 'L'} ${xFor(i).toFixed(1)} ${yFor(p.v).toFixed(1)}`).join(' '),
)

const latest = computed(() => props.points[props.points.length - 1] ?? null)

const svgEl = ref(null)
const hover = ref(null) // { x, y, point }

function handlePointerMove(event) {
  if (!props.points.length || !svgEl.value) return
  const rect = svgEl.value.getBoundingClientRect()
  const scaleX = width / rect.width
  const pointerX = (event.clientX - rect.left) * scaleX

  let closest = 0
  let closestDistance = Infinity
  props.points.forEach((_, index) => {
    const distance = Math.abs(xFor(index) - pointerX)
    if (distance < closestDistance) {
      closestDistance = distance
      closest = index
    }
  })

  const point = props.points[closest]
  hover.value = { x: xFor(closest), y: yFor(point.v), point }
}

function handlePointerLeave() {
  hover.value = null
}

function formatValue(value) {
  return Number(value).toFixed(props.decimals)
}

function formatTime(t) {
  return new Date(t).toLocaleTimeString()
}
</script>

<template>
  <div class="sparkline" :class="`series-${seriesIndex}`">
    <div class="sparkline-header">
      <span class="sparkline-title">{{ title }}</span>
      <span v-if="latest" class="sparkline-value">{{ formatValue(latest.v) }} {{ unit }}</span>
    </div>

    <div class="sparkline-body">
      <svg
        ref="svgEl"
        class="sparkline-svg"
        :viewBox="`0 0 ${width} ${height}`"
        preserveAspectRatio="none"
        @pointermove="handlePointerMove"
        @pointerleave="handlePointerLeave"
      >
        <line
          class="sparkline-gridline"
          :x1="paddingX"
          :x2="width - paddingX"
          :y1="yFor(bounds.max)"
          :y2="yFor(bounds.max)"
        />
        <line
          class="sparkline-gridline"
          :x1="paddingX"
          :x2="width - paddingX"
          :y1="yFor(bounds.min)"
          :y2="yFor(bounds.min)"
        />

        <path v-if="points.length > 1" class="sparkline-line" :d="linePath" fill="none" />

        <circle v-if="latest" class="sparkline-end-dot" :cx="xFor(points.length - 1)" :cy="yFor(latest.v)" r="4" />

        <template v-if="hover">
          <line
            class="sparkline-crosshair"
            :x1="hover.x"
            :x2="hover.x"
            :y1="paddingTop"
            :y2="height - paddingBottom"
          />
          <circle class="sparkline-hover-dot" :cx="hover.x" :cy="hover.y" r="4" />
        </template>
      </svg>

      <div class="sparkline-axis-labels">
        <span>{{ formatValue(bounds.max) }}</span>
        <span>{{ formatValue(bounds.min) }}</span>
      </div>

      <div v-if="hover" class="sparkline-tooltip" :style="{ left: `${(hover.x / width) * 100}%` }">
        <strong>{{ formatValue(hover.point.v) }} {{ unit }}</strong>
        <span>{{ formatTime(hover.point.t) }}</span>
      </div>
    </div>

    <p v-if="!points.length" class="sparkline-empty">No readings yet</p>
  </div>
</template>
