// .vitepress/theme/emulator.js
export function initEmulator() {
  if (typeof window === 'undefined') return

  let globalComputerInstance = null
  let isGlobalLoading = false

  async function loadDependencies() {
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
    }

    return basalt
  }

  async function runCodeInEmulator(code, title = 'Code Demo') {
    console.log('runCodeInEmulator called with:', { code, title })

    if (isGlobalLoading || globalComputerInstance) {
      console.warn('Emulator already running')
      return
    }

    isGlobalLoading = true
    console.log('Starting emulator loading...')

    try {
      console.log('Loading dependencies...')
      const basalt = await loadDependencies()
      console.log('Dependencies loaded, basalt length:', basalt.length)

      const tempContainer = document.createElement('div')
      tempContainer.style.position = 'fixed'
      tempContainer.style.top = '-9999px'
      tempContainer.style.left = '-9999px'
      tempContainer.style.width = '650px'
      tempContainer.style.height = '480px'
      tempContainer.style.padding = '0'
      tempContainer.style.margin = '0'
      tempContainer.style.border = 'none'
      document.body.appendChild(tempContainer)
      window.require.config({ paths: { copycat: 'https://copy-cat.squiddev.cc/' } })

      window.require(['copycat/embed'], (setup) => {

        const setupPromise = setup(tempContainer, {
          hdFont: 'https://copy-cat.squiddev.cc/term_font_hd-0506b6efe5f7feae.png',
          files: {
            'startup.lua': code,
            'basalt.lua': basalt
          },
          label: title
        })

        console.log('Setup promise created:', setupPromise)

        if (setupPromise && typeof setupPromise.then === 'function') {
          setupPromise.then((computer) => {
            console.log('Computer instance resolved from promise:', computer)
            globalComputerInstance = computer

            if (computer && typeof computer.run === 'function') {
              computer.run()
              console.log('Computer started running')
            } else if (computer && typeof computer.start === 'function') {
              computer.start()
              console.log('Computer started with start()')
            } else {
              console.error('Computer does not have run or start method:', computer)
              console.log('Available methods:', Object.getOwnPropertyNames(computer || {}))
            }

            console.log('Showing terminal window...')
            showTerminalWindow(tempContainer, title)

            isGlobalLoading = false
            console.log('Emulator setup complete')
          }).catch((error) => {
            console.error('Error in setup promise:', error)
            isGlobalLoading = false
          })
        } else {
          console.log('Setup returned directly:', setupPromise)
          globalComputerInstance = setupPromise

          if (setupPromise && typeof setupPromise.run === 'function') {
            setupPromise.run()
            console.log('Computer started running (direct)')
          } else {
            console.error('Direct setup does not have run method:', setupPromise)
          }

          showTerminalWindow(tempContainer, title)
          isGlobalLoading = false
        }
      })

    } catch (error) {
      console.error('Error starting emulator:', error)
      isGlobalLoading = false
    }
  }

  function showTerminalWindow(container, title) {
    console.log('showTerminalWindow called with:', { container, title })

    const windowDiv = document.createElement('div')
    windowDiv.className = 'global-terminal-window'
    console.log('Terminal window div created')

    windowDiv.style.cssText = `
      position: fixed;
      width: 625px;
      height: 425px;
      background: #1a1a1a;
      border-radius: 8px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
      display: flex;
      flex-direction: column;
      z-index: 9999;
      border: 1px solid #333;
      top: 100px;
      left: 100px;
    `

    const header = document.createElement('div')
    header.className = 'terminal-header'
    header.style.cssText = `
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0.2rem 1rem;
      background: linear-gradient(180deg, #2a2a2a 0%, #222 100%);
      border-bottom: 1px solid #111;
      cursor: move;
      user-select: none;
      border-radius: 8px 8px 0 0;
    `

    const titleDiv = document.createElement('div')
    titleDiv.innerHTML = `<span style="color: #fff; font-size: 0.875rem; font-weight: 500;">💻 ${title}</span>`

    const controls = document.createElement('div')
    controls.innerHTML = `
      <button class="control-button close" style="width: 24px; height: 24px; border-radius: 50%; border: none; cursor: pointer; background: #ef4444; color: white; font-size: 12px;" onclick="closeGlobalEmulator()">✕</button>
    `

    header.appendChild(titleDiv)
    header.appendChild(controls)

    const body = document.createElement('div')
    body.style.cssText = `
      flex: 1;
      background: #000;
      border-radius: 0 0 8px 8px;
      overflow: hidden;
      padding: 0;
      margin: 0;
    `
    body.appendChild(container)
    container.style.position = 'static'
    container.style.top = 'auto'
    container.style.left = 'auto'
    container.style.width = '100%'
    container.style.height = '100%'
    container.style.padding = '0'
    container.style.margin = '0'

    windowDiv.appendChild(header)
    windowDiv.appendChild(body)

    document.body.appendChild(windowDiv)
    console.log('Terminal window added to body')

    let isDragging = false
    let offset = { x: 0, y: 0 }

    header.addEventListener('mousedown', (e) => {
      isDragging = true
      offset.x = e.clientX - windowDiv.offsetLeft
      offset.y = e.clientY - windowDiv.offsetTop
    })

    document.addEventListener('mousemove', (e) => {
      if (!isDragging) return

      const terminalWidth = windowDiv.offsetWidth
      const terminalHeight = windowDiv.offsetHeight

      let newX = e.clientX - offset.x
      let newY = e.clientY - offset.y

      const maxX = window.innerWidth - terminalWidth
      const maxY = window.innerHeight - terminalHeight

      newX = Math.max(0, Math.min(newX, maxX))
      newY = Math.max(0, Math.min(newY, maxY))

      windowDiv.style.left = newX + 'px'
      windowDiv.style.top = newY + 'px'
    })

    document.addEventListener('mouseup', () => {
      isDragging = false
    })
  }

  function closeGlobalEmulator() {
    if (globalComputerInstance) {
      try {
        globalComputerInstance.shutdown()
      } catch (e) {
        console.warn('Error shutting down:', e)
      }
      globalComputerInstance = null
    }

    const windowDiv = document.querySelector('.global-terminal-window')
    if (windowDiv) {
      document.body.removeChild(windowDiv)
    }
  }

  window.runCodeBlock = function(button) {
    const container = button.closest('.code-block-with-run')    
    const codeContent = container.querySelector('.code-content')    
    const dataCode = codeContent.getAttribute('data-code')    
    const code = atob(dataCode)    
    const languageBadge = container.querySelector('.language-badge')
    const language = languageBadge && languageBadge.textContent ? languageBadge.textContent : 'lua'
    runCodeInEmulator(code, `Code Demo (${language})`)
  }

  window.closeGlobalEmulator = closeGlobalEmulator
}