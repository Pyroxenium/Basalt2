import CopyButton from 'vitepress-copy-helper';
import 'vitepress-copy-helper/style.css'
import DefaultTheme from 'vitepress/theme'
import BasaltDemo from './components/BasaltDemo.vue'
import BasaltDemoWithCode from './components/BasaltDemoWithCode.vue'
import './emulator.js'
import './styles.css'

/** @type {import('vitepress').Theme} */
export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('C', CopyButton)
    app.component('BasaltDemo', BasaltDemo)
    app.component('BasaltDemoWithCode', BasaltDemoWithCode)
  }
}