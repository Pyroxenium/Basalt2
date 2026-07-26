import { defineConfig } from 'vitepress'
import baseConfig from './config.base.mts'

const config = baseConfig as any
const themeConfig = config.themeConfig ?? {}

export default defineConfig({
  ...config,
  title: 'Basalt 2',
  base: '/2.0/',
  srcExclude: [
    ...(config.srcExclude ?? []),
    '2.5/**',
  ],
  themeConfig: {
    ...themeConfig,
    siteTitle: 'Basalt 2',
    nav: [
      ...(themeConfig.nav ?? []),
      {
        text: 'Basalt 2.5',
        link: 'https://basalt.madefor.cc/2.5/',
      },
    ],
  },
})
