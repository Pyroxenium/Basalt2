<!-- .vitepress/theme/components/BasaltDemo.vue -->
<script setup>
import { ref, reactive, onMounted, useSlots } from 'vue'

const showDemo = ref(false)
const container = ref(null)
const position = reactive({ x: 100, y: 100 })
let offset = { x: 0, y: 0 }
let isDragging = false

const slots = useSlots()
let luaCode = ''

onMounted(() => {
  if (typeof window === 'undefined') return
  
  luaCode = (slots.default?.() || [])
    .map(vnode => typeof vnode.children === 'string' ? vnode.children : '')
    .join('\n')
})

async function startDemo() {
  if (typeof window === 'undefined' || typeof document === 'undefined') return
  
  showDemo.value = true

  const basalt = await fetch(
    'https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/release/basalt.lua'
  ).then(res => res.text())

  const script = document.createElement('script')
  script.src = 'https://copy-cat.squiddev.cc/require.js'
  script.onload = () => {
    window.require.config({ paths: { copycat: 'https://copy-cat.squiddev.cc/' } })
    window.require(['copycat/embed'], (setup) => {
      const computer = setup(container.value, {
        hdFont: 'https://copy-cat.squiddev.cc/term_font_hd-0506b6efe5f7feae.png',
        files: { 
          'startup.lua': luaCode,
          'basalt.lua': basalt
        },
        label: 'Basalt Demo'
      })
      computer.run()
    })
  }
  document.body.appendChild(script)
}

function closeDemo() {
  showDemo.value = false
}

function startDrag(e) {
  if (typeof document === 'undefined') return
  
  isDragging = true
  offset.x = e.clientX - position.x
  offset.y = e.clientY - position.y
  document.addEventListener('mousemove', onDrag)
  document.addEventListener('mouseup', stopDrag)
}

function onDrag(e) {
  if (!isDragging || typeof window === 'undefined') return
  
  const containerEl = container.value?.parentElement
  const contW = containerEl?.offsetWidth || 0
  const contH = containerEl?.offsetHeight || 0

  const maxX = window.innerWidth - contW
  const maxY = window.innerHeight - contH

  let newX = e.clientX - offset.x
  let newY = e.clientY - offset.y

  if (newX < 0) newX = 0
  if (newY < 0) newY = 0
  if (newX > maxX) newX = maxX
  if (newY > maxY) newY = maxY

  position.x = newX
  position.y = newY
}

function stopDrag() {
  if (typeof document === 'undefined') return
  
  isDragging = false
  document.removeEventListener('mousemove', onDrag)
  document.removeEventListener('mouseup', stopDrag)
}
</script>

<template>
  <div>
    <button
      @click="startDemo"
      :disabled="showDemo"
      :style="{ pointerEvents: showDemo ? 'none' : 'auto' }"
    >
      ▶ Run
    </button>

    <div
      v-if="showDemo"
      :style="{
        position: 'fixed',
        top: position.y + 'px',
        left: position.x + 'px',
        width: '625px',
        height: '425px',
        background: '#1a1a1a',
        borderRadius: '8px',
        boxShadow: '0 10px 40px rgba(0, 0, 0, 0.5)',
        display: 'flex',
        flexDirection: 'column',
        zIndex: 9999,
        border: '1px solid #333'
      }"
    >
      <!-- Header -->
      <div
        @mousedown="startDrag"
        style="
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 0.5rem 1rem;
          background: linear-gradient(180deg, #2a2a2a 0%, #222 100%);
          border-bottom: 1px solid #111;
          cursor: move;
          user-select: none;
          border-radius: 8px 8px 0 0;
        "
      >
        <div style="display: flex; align-items: center; gap: 0.5rem; color: #fff; font-size: 0.875rem; font-weight: 500;">
          <span>💻</span>
          <span>Basalt Demo</span>
        </div>
        <div style="display: flex; gap: 0.5rem;">
          <button
            @click="closeDemo"
            style="
              width: 24px;
              height: 24px;
              border-radius: 50%;
              border: none;
              cursor: pointer;
              background: #ef4444;
              color: white;
              font-size: 12px;
              transition: all 0.2s ease;
            "
            title="Close (ESC)"
          >
            ✕
          </button>
        </div>
      </div>

      <!-- Body -->
      <div
        ref="container"
        style="
          flex: 1;
          background: #000;
          border-radius: 0 0 8px 8px;
          overflow: hidden;
          position: relative;
        "
      ></div>
    </div>
  </div>
</template>

<style scoped>
:deep(canvas) {
  image-rendering: pixelated;
  top: 0;
  left: 0;
}
</style>