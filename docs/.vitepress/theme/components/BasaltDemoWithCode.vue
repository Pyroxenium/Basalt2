<!-- .vitepress/theme/components/BasaltDemoWithCode.vue -->
<script setup>
import { ref, reactive, computed, useSlots, onMounted, onUnmounted, nextTick } from 'vue'

const props = defineProps({
  language: {
    type: String,
    default: 'lua'
  },
  title: {
    type: String,
    default: 'Basalt Demo'
  }
})

const showDemo = ref(false)
const container = ref(null)
const wrapperRef = ref(null)
const position = reactive({ x: 100, y: 100 })
const isLoading = ref(false)
let offset = { x: 0, y: 0 }
let isDragging = false
let computerInstance = null

const slots = useSlots()
function extractText(nodes) {
  return (nodes || [])
    .map((node) => {
      if (!node) return ''
      if (typeof node === 'string') return node
      if (typeof node.children === 'string') return node.children
      if (Array.isArray(node.children)) return extractText(node.children)
      return ''
    })
    .join('\n')
    .replace(/\r\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim()
}

const luaCode = computed(() => extractText(slots.default?.() ?? []))


const highlightedCode = computed(() => {
  let code = luaCode.value
  
  const keywords = ['local', 'function', 'if', 'then', 'else', 'elseif', 'end', 'for', 'while', 'do', 'repeat', 'until', 'return', 'break', 'true', 'false', 'nil', 'and', 'or', 'not', 'require']
  const keywordRegex = new RegExp(`\\b(${keywords.join('|')})\\b`, 'g')
  
  code = code.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
  
  code = code.replace(keywordRegex, '<span class="keyword">$1</span>')
  code = code.replace(/"([^"]*)"/g, '<span class="string">"$1"</span>')
  code = code.replace(/'([^']*)'/g, '<span class="string">\'$1\'</span>')
  code = code.replace(/--(.*)$/gm, '<span class="comment">--$1</span>')
  code = code.replace(/\b(\d+)\b/g, '<span class="number">$1</span>')
  code = code.replace(/\b(basalt|main)\b/g, '<span class="variable">$1</span>')
  code = code.replace(/(:?\w+)\(/g, '<span class="function">$1</span>(')
  
  return code
})

async function startDemo() {
  if (isLoading.value || showDemo.value) return
  
  isLoading.value = true
  
  try {
    const basalt = await fetch(
      'https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/release/basalt.lua'
    ).then(res => res.text())

    if (!window.require) {
      await new Promise((resolve, reject) => {
        const script = document.createElement('script')
        script.src = 'https://copy-cat.squiddev.cc/require.js'
        script.onload = resolve
        script.onerror = reject
        document.body.appendChild(script)
      })
      window.require.config({ paths: { copycat: 'https://copy-cat.squiddev.cc/' } })
    }

    showDemo.value = true
    centerWindow()
    
    await nextTick()
    
    await new Promise(resolve => setTimeout(resolve, 200))

    window.require(['copycat/embed'], (setup) => {
      if (!container.value) {
        console.error('Container not found')
        isLoading.value = false
        return
      }
      
      computerInstance = setup(container.value, {
        hdFont: 'https://copy-cat.squiddev.cc/term_font_hd-0506b6efe5f7feae.png',
        files: {
          'startup.lua': luaCode.value,
          'basalt.lua': basalt
        },
        label: props.title
      })
      
      computerInstance.run()
      
      setTimeout(() => {
        isLoading.value = false
      }, 500)
    })
    
  } catch (error) {
    console.error('Error starting demo:', error)
    isLoading.value = false
    showDemo.value = false
  }
}

function closeDemo() {
  if (computerInstance) {
    try {
      computerInstance.shutdown()
    } catch (e) {
      console.warn('Error shutting down:', e)
    }
    computerInstance = null
  }
  
  showDemo.value = false
  isLoading.value = false
}

function centerWindow() {
  const windowWidth = window.innerWidth
  const windowHeight = window.innerHeight
  position.x = Math.max(0, (windowWidth - 650) / 2)
  position.y = Math.max(0, (windowHeight - 480) / 2)
}

function startDrag(e) {
  if (e.target.closest('button')) return
  isDragging = true
  offset.x = e.clientX - position.x
  offset.y = e.clientY - position.y
  document.addEventListener('mousemove', onDrag)
  document.addEventListener('mouseup', stopDrag)
  e.preventDefault()
}

function onDrag(e) {
  if (!isDragging) return
  const maxX = window.innerWidth - 650
  const maxY = window.innerHeight - 480
  
  position.x = Math.max(0, Math.min(e.clientX - offset.x, maxX))
  position.y = Math.max(0, Math.min(e.clientY - offset.y, maxY))
}

function stopDrag() {
  isDragging = false
  document.removeEventListener('mousemove', onDrag)
  document.removeEventListener('mouseup', stopDrag)
}

function handleKeydown(e) {
  if (e.key === 'Escape' && showDemo.value) {
    closeDemo()
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeydown)
  closeDemo()
})
</script>

<template>
  <div class="basalt-demo-wrapper">
    <!-- Code Block with Run Button -->
    <div class="code-block-container">
      <div class="code-header">
        <span class="language-badge">{{ language }}</span>
        <button 
          class="run-button" 
          @click="startDemo"
          :disabled="isLoading || showDemo"
        >
          <span v-if="!isLoading" class="play-icon">▶</span>
          <span v-else class="loading-icon">⟳</span>
          <span class="button-text">{{ isLoading ? 'Loading...' : 'Run' }}</span>
        </button>
      </div>
      
      <!-- Code Block with Syntax Highlighting -->
      <div class="code-block">
        <pre><code v-html="highlightedCode"></code></pre>
      </div>
    </div>

    <Teleport to="body">
      <div
        v-if="showDemo"
        ref="wrapperRef"
        class="terminal-window"
        :style="{
          top: position.y + 'px',
          left: position.x + 'px'
        }"
      >
        <div class="terminal-header" @mousedown="startDrag">
          <div class="terminal-title">
            <span class="terminal-icon">💻</span>
            <span>{{ title }}</span>
          </div>
          <div class="terminal-controls">
            <button 
              class="control-button minimize" 
              @click="centerWindow"
              title="Center"
            >
              ⊡
            </button>
            <button 
              class="control-button close" 
              @click="closeDemo"
              title="Close (ESC)"
            >
              ✕
            </button>
          </div>
        </div>
        
        <div class="terminal-body">
          <Transition name="fade">
            <div v-if="isLoading" class="loading-overlay">
              <div class="spinner"></div>
              <p>Loading emulator...</p>
            </div>
          </Transition>
          
          <div 
            ref="container" 
            class="terminal-container"
            :style="{ opacity: isLoading ? 0 : 1 }"
          ></div>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<style scoped>
.basalt-demo-wrapper {
  position: relative;
  margin: 1rem 0;
}

.code-block-container {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  background: var(--vp-code-block-bg, #1e1e1e);
  border: 1px solid var(--vp-c-divider, #333);
}

.code-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5rem 1rem;
  background: rgba(0, 0, 0, 0.2);
  border-bottom: 1px solid var(--vp-c-divider, #333);
}

.language-badge {
  font-size: 0.75rem;
  font-weight: 500;
  color: #888;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.run-button {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  padding: 0.25rem 0.75rem;
  background: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.run-button:hover:not(:disabled) {
  background: #45a049;
  transform: translateY(-1px);
}

.run-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.loading-icon {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* Code Block */
.code-block {
  overflow: auto;
  max-height: 500px;
}

.code-block pre {
  margin: 0;
  padding: 1rem;
  background: transparent;
  font-family: 'Courier New', Consolas, monospace;
  font-size: 14px;
  line-height: 1.5;
  color: #d4d4d4;
  white-space: pre;
  overflow-x: auto;
}

.code-block code {
  font-family: inherit;
}

.code-block :deep(.keyword) {
  color: #C586C0;
  font-weight: bold;
}

.code-block :deep(.string) {
  color: #CE9178;
}

.code-block :deep(.comment) {
  color: #6A9955;
  font-style: italic;
}

.code-block :deep(.number) {
  color: #B5CEA8;
}

.code-block :deep(.function) {
  color: #DCDCAA;
}

.code-block :deep(.variable) {
  color: #9CDCFE;
}

.terminal-window {
  position: fixed;
  width: 650px;
  height: 480px;
  background: #1a1a1a;
  border-radius: 8px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  z-index: 9999;
  border: 1px solid #333;
}

.terminal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1rem;
  background: linear-gradient(180deg, #2a2a2a 0%, #222 100%);
  border-bottom: 1px solid #111;
  cursor: move;
  user-select: none;
  border-radius: 8px 8px 0 0;
}

.terminal-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #fff;
  font-size: 0.875rem;
  font-weight: 500;
}

.terminal-controls {
  display: flex;
  gap: 0.5rem;
}

.control-button {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  transition: all 0.2s ease;
}

.control-button.minimize {
  background: #fbbf24;
  color: #92400e;
}

.control-button.minimize:hover {
  background: #f59e0b;
}

.control-button.close {
  background: #ef4444;
  color: white;
}

.control-button.close:hover {
  background: #dc2626;
}

.terminal-body {
  flex: 1;
  position: relative;
  background: #000;
  border-radius: 0 0 8px 8px;
  overflow: hidden;
  height: calc(480px - 50px);
}

.terminal-container {
  width: 100%;
  height: 100%;
  transition: opacity 0.3s ease;
}

.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.9);
  color: white;
  z-index: 10;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-top-color: white;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
  margin-bottom: 1rem;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-from {
  opacity: 0;
}

.dark .code-block-container {
  background: #1e1e1e;
}

html:not(.dark) .code-block-container {
  background: #f6f6f6;
  border-color: #e0e0e0;
}

html:not(.dark) .code-block pre {
  color: #333;
}

html:not(.dark) .code-header {
  background: rgba(0, 0, 0, 0.05);
  border-bottom-color: #e0e0e0;
}

html:not(.dark) .language-badge {
  color: #666;
}

@media (max-width: 768px) {
  .terminal-window {
    width: 90vw !important;
    max-width: 650px;
    height: 70vh !important;
    max-height: 480px;
    left: 5vw !important;
    top: 15vh !important;
  }
}
</style>