import { existsSync, readdirSync } from 'node:fs'
import { basename, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
import { defineConfig } from 'vitepress'

const docsRoot = fileURLToPath(new URL('..', import.meta.url))
const apiRoot = resolve(docsRoot, 'api')

function apiItems(folder: string) {
  const directory = resolve(apiRoot, folder)
  if (!existsSync(directory)) return []

  return readdirSync(directory)
    .filter((file) => file.endsWith('.md'))
    .sort((left, right) => left.localeCompare(right))
    .map((file) => ({
      text: basename(file, '.md'),
      link: `/api/${folder}/${basename(file, '.md')}`,
    }))
}

export default defineConfig({
  title: 'Basalt',
  description: 'Basalt API documentation for CC:Tweaked',
  lang: 'en-US',
  base: '/2.5/',
  lastUpdated: true,
  cacheDir: '../../.vitepress/cache-2.5',

  themeConfig: {
    siteTitle: 'Basalt',
    search: {
      provider: 'local',
    },
    nav: [
      { text: 'Overview', link: '/' },
      { text: 'API Reference', link: '/api/' },
      {
        text: 'Basalt 2 Docs',
        link: 'https://basalt.madefor.cc/2.0/',
      },
    ],
    sidebar: {
      '/api/': [
        {
          text: 'API Reference',
          link: '/api/',
        },
        {
          text: 'Runtime',
          items: [
            { text: 'main', link: '/api/main' },
          ],
        },
        {
          text: 'Core',
          collapsed: false,
          items: apiItems('core'),
        },
        {
          text: 'Elements',
          collapsed: false,
          items: apiItems('elements'),
        },
        {
          text: 'Modules',
          collapsed: false,
          items: apiItems('modules'),
        },
      ],
    },
    outline: [2, 3],
    docFooter: {
      prev: false,
      next: false,
    },
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025 Robert Jelic',
    },
    socialLinks: [
      {
        icon: 'github',
        link: 'https://github.com/Pyroxenium/Basalt2/tree/basalt2.5',
      },
    ],
  },
})

