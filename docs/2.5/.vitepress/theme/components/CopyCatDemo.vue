<script setup lang="ts">
import {
  computed,
  nextTick,
  onBeforeUnmount,
  onMounted,
  ref,
} from 'vue'
import { withBase } from 'vitepress'
import {
  mountCopyCat,
  nextCopyCatZIndex,
  type CopyCatSession,
} from '../copy-cat'

const props = withDefaults(
  defineProps<{
    code: string
    height?: number
    language?: string
    title?: string
    width?: number
  }>(),
  {
    height: 19,
    language: 'lua',
    title: 'Basalt demo',
    width: 51,
  },
)

let generation = 0
let session: CopyCatSession | undefined
let activeHost: HTMLElement | undefined
let codeResizeObserver: ResizeObserver | undefined
let dragging:
  | {
      pointerId: number
      startX: number
      startY: number
      windowX: number
      windowY: number
    }
  | undefined

const visible = ref(false)
const codeExpanded = ref(false)
const codeCollapsible = ref(false)
const status = ref<'idle' | 'loading' | 'running' | 'error'>('idle')
const errorMessage = ref('')
const codePanel = ref<HTMLElement>()
const terminal = ref<HTMLElement>()
const dialog = ref<HTMLElement>()
const position = ref({ x: 0, y: 72 })
const positioned = ref(false)
const zIndex = ref(nextCopyCatZIndex())
const collapsedCodeHeight = 320

const statusText = computed(() => {
  if (status.value === 'loading') return 'Starting CC:Tweaked…'
  if (status.value === 'running') return 'Running'
  if (status.value === 'error') return 'Could not start'
  return 'Ready'
})

function decodeCode(value: string) {
  const binary = atob(value)
  const bytes = Uint8Array.from(binary, (character) => character.charCodeAt(0))
  return new TextDecoder().decode(bytes)
}

function bringToFront() {
  zIndex.value = nextCopyCatZIndex()
}

function measureCode() {
  const panel = codePanel.value
  if (!panel) return

  codeCollapsible.value = panel.scrollHeight > collapsedCodeHeight + 1
  if (!codeCollapsible.value) codeExpanded.value = false
}

function toggleCode() {
  codeExpanded.value = !codeExpanded.value
}

function clampPosition(x: number, y: number) {
  const width = dialog.value?.offsetWidth ?? 650
  const height = dialog.value?.offsetHeight ?? 478
  const margin = 12
  const maxX = Math.max(margin, window.innerWidth - width - margin)
  const maxY = Math.max(margin, window.innerHeight - height - margin)

  return {
    x: Math.min(Math.max(margin, x), maxX),
    y: Math.min(Math.max(margin, y), maxY),
  }
}

async function centerDialog() {
  await nextTick()
  const width = dialog.value?.offsetWidth ?? 650
  const height = dialog.value?.offsetHeight ?? 478
  position.value = clampPosition(
    (window.innerWidth - width) / 2,
    Math.max(24, (window.innerHeight - height) / 2),
  )
  positioned.value = true
}

function disposeSession() {
  session?.dispose()
  session = undefined
  activeHost?.remove()
  activeHost = undefined
}

async function start() {
  const currentGeneration = ++generation
  disposeSession()
  status.value = 'loading'
  errorMessage.value = ''

  await nextTick()
  if (!terminal.value || !visible.value) return

  const host = document.createElement('div')
  host.className = 'copy-cat-dialog__host'
  // cc-web-term calculates its integer canvas scale from the direct
  // mount parent. An auto-sized host collapses to the unscaled terminal.
  host.style.width = '100%'
  host.style.height = '100%'
  terminal.value.replaceChildren(host)
  activeHost = host

  try {
    const created = await mountCopyCat(host, {
      code: decodeCode(props.code),
      height: props.height,
      runtimeUrl: withBase('/runtime/basalt.lua'),
      title: props.title,
      width: props.width,
    })

    if (generation !== currentGeneration || !visible.value) {
      created.dispose()
      host.remove()
      return
    }

    session = created
    status.value = 'running'
  } catch (error) {
    if (generation !== currentGeneration || !visible.value) return
    status.value = 'error'
    errorMessage.value =
      error instanceof Error ? error.message : 'An unknown error occurred.'
  }
}

async function open() {
  visible.value = true
  bringToFront()
  if (!positioned.value) await centerDialog()
  await start()
}

function close() {
  generation += 1
  visible.value = false
  status.value = 'idle'
  endDrag()
  disposeSession()
}

function restart() {
  bringToFront()
  void start()
}

function beginDrag(event: PointerEvent) {
  if (event.button !== 0) return
  event.preventDefault()
  bringToFront()
  dragging = {
    pointerId: event.pointerId,
    startX: event.clientX,
    startY: event.clientY,
    windowX: position.value.x,
    windowY: position.value.y,
  }
  window.addEventListener('pointermove', drag)
  window.addEventListener('pointerup', endDrag)
  window.addEventListener('pointercancel', endDrag)
}

function drag(event: PointerEvent) {
  if (!dragging || event.pointerId !== dragging.pointerId) return
  position.value = clampPosition(
    dragging.windowX + event.clientX - dragging.startX,
    dragging.windowY + event.clientY - dragging.startY,
  )
}

function endDrag() {
  dragging = undefined
  window.removeEventListener('pointermove', drag)
  window.removeEventListener('pointerup', endDrag)
  window.removeEventListener('pointercancel', endDrag)
}

function keepInViewport() {
  if (positioned.value) {
    position.value = clampPosition(position.value.x, position.value.y)
  }
}

onMounted(() => {
  window.addEventListener('resize', keepInViewport)

  void nextTick().then(() => {
    measureCode()
    if (codePanel.value && 'ResizeObserver' in window) {
      codeResizeObserver = new ResizeObserver(measureCode)
      codeResizeObserver.observe(codePanel.value)
    }
  })
})
onBeforeUnmount(() => {
  window.removeEventListener('resize', keepInViewport)
  codeResizeObserver?.disconnect()
  close()
})
</script>

<template>
  <div class="copy-cat-example">
    <div class="copy-cat-example__bar">
      <span class="copy-cat-example__language">{{ language }}</span>
      <button class="copy-cat-example__run" type="button" @click="open">
        <span aria-hidden="true">▶</span>
        Run in CC:Tweaked
      </button>
    </div>
    <div
      ref="codePanel"
      class="copy-cat-example__code"
      :class="{
        'copy-cat-example__code--collapsed':
          codeCollapsible && !codeExpanded,
      }"
    >
      <slot />
      <div
        v-if="codeCollapsible && !codeExpanded"
        class="copy-cat-example__fade"
        aria-hidden="true"
      />
    </div>
    <button
      v-if="codeCollapsible"
      class="copy-cat-example__expand"
      type="button"
      :aria-expanded="codeExpanded"
      @click="toggleCode"
    >
      <span>{{ codeExpanded ? 'Collapse code' : 'Show full code' }}</span>
      <span aria-hidden="true">{{ codeExpanded ? '▲' : '▼' }}</span>
    </button>
  </div>

  <Teleport to="body">
    <section
      v-if="visible"
      ref="dialog"
      class="copy-cat-dialog"
      role="dialog"
      :aria-label="title"
      :style="{
        left: `${position.x}px`,
        top: `${position.y}px`,
        zIndex,
      }"
      @pointerdown="bringToFront"
    >
      <header class="copy-cat-dialog__header" @pointerdown="beginDrag">
        <div class="copy-cat-dialog__heading">
          <strong>{{ title }}</strong>
          <span>{{ statusText }}</span>
        </div>
        <div class="copy-cat-dialog__actions" @pointerdown.stop>
          <button type="button" title="Center window" @click="centerDialog">
            Center
          </button>
          <button type="button" title="Restart computer" @click="restart">
            Restart
          </button>
          <button
            class="copy-cat-dialog__close"
            type="button"
            title="Close"
            aria-label="Close emulator"
            @click="close"
          >
            ×
          </button>
        </div>
      </header>

      <div class="copy-cat-dialog__body">
        <div ref="terminal" class="copy-cat-dialog__terminal" />

        <div
          v-if="status === 'loading'"
          class="copy-cat-dialog__message"
          role="status"
        >
          Loading Copy Cat and Basalt 2.5…
        </div>

        <div
          v-else-if="status === 'error'"
          class="copy-cat-dialog__message copy-cat-dialog__message--error"
          role="alert"
        >
          <strong>Could not start the emulator.</strong>
          <span>{{ errorMessage }}</span>
          <button type="button" @click="restart">Try again</button>
        </div>
      </div>
    </section>
  </Teleport>
</template>

<style scoped>
.copy-cat-example {
  margin: 16px 0;
  overflow: hidden;
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
}

.copy-cat-example__bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 42px;
  padding: 6px 8px 6px 14px;
  background: var(--vp-c-bg-soft);
  border-bottom: 1px solid var(--vp-c-divider);
}

.copy-cat-example__language {
  color: var(--vp-c-text-2);
  font-family: var(--vp-font-family-mono);
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
}

.copy-cat-example__run,
.copy-cat-dialog button {
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  color: var(--vp-c-text-1);
  background: var(--vp-c-bg);
  cursor: pointer;
  font: inherit;
}

.copy-cat-example__run {
  display: inline-flex;
  gap: 7px;
  align-items: center;
  padding: 6px 10px;
  color: var(--vp-c-brand-1);
  font-size: 13px;
  font-weight: 600;
}

.copy-cat-example__run:hover,
.copy-cat-example__expand:hover,
.copy-cat-dialog button:hover {
  border-color: var(--vp-c-brand-1);
}

.copy-cat-example__code {
  position: relative;
}

.copy-cat-example__code--collapsed {
  max-height: 320px;
  overflow: hidden;
}

.copy-cat-example__fade {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  height: 72px;
  background: linear-gradient(
    to bottom,
    transparent,
    var(--vp-code-block-bg)
  );
  pointer-events: none;
}

.copy-cat-example__expand {
  display: flex;
  gap: 8px;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: 9px 12px;
  border: 0;
  border-top: 1px solid var(--vp-c-divider);
  color: var(--vp-c-brand-1);
  background: var(--vp-c-bg-soft);
  cursor: pointer;
  font: inherit;
  font-size: 13px;
  font-weight: 600;
}

.copy-cat-example :deep(div[class*='language-']) {
  margin: 0;
  border-radius: 0;
}

.copy-cat-dialog {
  position: fixed;
  width: min(650px, calc(100vw - 24px));
  overflow: hidden;
  border: 1px solid color-mix(in srgb, var(--vp-c-brand-1) 55%, transparent);
  border-radius: 10px;
  background: #090b0f;
  box-shadow: 0 18px 55px rgb(0 0 0 / 45%);
}

.copy-cat-dialog__header {
  display: flex;
  gap: 16px;
  align-items: center;
  justify-content: space-between;
  min-height: 48px;
  padding: 7px 8px 7px 14px;
  color: var(--vp-c-text-1);
  background: var(--vp-c-bg-elv);
  border-bottom: 1px solid var(--vp-c-divider);
  cursor: grab;
  touch-action: none;
  user-select: none;
}

.copy-cat-dialog__header:active {
  cursor: grabbing;
}

.copy-cat-dialog__heading {
  display: flex;
  min-width: 0;
  flex-direction: column;
}

.copy-cat-dialog__heading strong {
  overflow: hidden;
  font-size: 14px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.copy-cat-dialog__heading span {
  color: var(--vp-c-text-2);
  font-size: 11px;
}

.copy-cat-dialog__actions {
  display: flex;
  flex: 0 0 auto;
  gap: 6px;
}

.copy-cat-dialog__actions button,
.copy-cat-dialog__message button {
  padding: 5px 9px;
  font-size: 12px;
}

.copy-cat-dialog__actions .copy-cat-dialog__close {
  width: 30px;
  padding: 3px;
  font-size: 20px;
  line-height: 1;
}

.copy-cat-dialog__body {
  position: relative;
  height: min(430px, calc(100vh - 72px));
  min-height: 240px;
  overflow: auto;
  background: #000;
}

.copy-cat-dialog__terminal {
  width: 100%;
  height: 100%;
}

.copy-cat-dialog__terminal :deep(canvas) {
  image-rendering: pixelated;
}

.copy-cat-dialog__message {
  position: absolute;
  inset: 0;
  display: flex;
  gap: 8px;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 24px;
  color: #d7dce5;
  background: #090b0f;
  text-align: center;
}

.copy-cat-dialog__message--error {
  color: #ffb4ad;
}

@media (max-width: 640px) {
  .copy-cat-dialog__actions button:not(.copy-cat-dialog__close) {
    display: none;
  }

  .copy-cat-dialog__body {
    min-height: 220px;
  }
}
</style>
