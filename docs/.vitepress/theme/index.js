import CopyButton from 'vitepress-copy-helper';
import 'vitepress-copy-helper/style.css'
import DefaultTheme from 'vitepress/theme'
import './styles.css'

/** @type {import('vitepress').Theme} */
export default {
  extends: DefaultTheme,
  enhanceApp({ app, router, siteData }) {
    app.component('C', CopyButton)
    
    if (typeof window !== 'undefined') {
      import('./components/BasaltDemo.vue').then((module) => {
        app.component('BasaltDemo', module.default)
      })
      import('./components/BasaltDemoWithCode.vue').then((module) => {
        app.component('BasaltDemoWithCode', module.default)
      })
    }
  },
  setup() {
    if (typeof window !== 'undefined') {
      window.runCodeBlock = function(button) {
        const container = button.closest('.code-block-with-run')    
        const codeContent = container.querySelector('.code-content')    
        const dataCode = codeContent.getAttribute('data-code')    
        const code = atob(dataCode)    
        const languageBadge = container.querySelector('.language-badge')
        const language = languageBadge && languageBadge.textContent ? languageBadge.textContent : 'lua'
        
        if (!window.runCodeInEmulator) {
          import('./emulator.js').then(({ initEmulator }) => {
            initEmulator()
            setTimeout(() => window.runCodeBlock(button), 100)
          })
        } else {
          window.runCodeInEmulator(code, `Code Demo (${language})`)
        }
      }

      import('vue').then(({ onMounted }) => {
        onMounted(() => {
          import('./emulator.js').then(({ initEmulator }) => {
            initEmulator()
          })
        })
      })
    }
  }
}