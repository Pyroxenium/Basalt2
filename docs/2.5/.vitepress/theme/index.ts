import DefaultTheme from 'vitepress/theme'
import CopyCatDemo from './components/CopyCatDemo.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('CopyCatDemo', CopyCatDemo)
  },
}
