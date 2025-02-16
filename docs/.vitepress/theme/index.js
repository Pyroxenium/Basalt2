import CopyButton from 'vitepress-copy-helper';
import 'vitepress-copy-helper/style.css'
import DefaultTheme from 'vitepress/theme'

/** @type {import('vitepress').Theme} */
export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('C', CopyButton)
  }
}