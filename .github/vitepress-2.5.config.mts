import { existsSync, readdirSync } from 'node:fs'
import { basename, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
import { defineConfig } from 'vitepress'
import { copyCatFencePlugin } from './markdown/copyCatFence'

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

  markdown: {
    config(md) {
      md.use(copyCatFencePlugin)
    },
  },

  themeConfig: {
    siteTitle: 'Basalt',
    search: {
      provider: 'local',
    },
    nav: [
      { text: 'Home', link: '/home' },
      { text: 'Guides', link: '/guides/' },
      { text: 'API Reference', link: '/api/' },
      {
        text: 'Basalt 2 Docs',
        link: 'https://basalt.madefor.cc/2.0/',
      },
    ],
    sidebar: {
      '/guides/': [
        {
          text: 'Start Here',
          items: [
            { text: 'Guide Overview', link: '/guides/' },
            {
              text: 'Getting Started',
              link: '/guides/getting-started',
            },
            {
              text: 'Migration Quickstart',
              link: '/guides/migration-quickstart',
            },
            {
              text: 'Migration Reference',
              link: '/guides/migrating-from-basalt-2',
            },
          ],
        },
        {
          text: 'Foundations',
          items: [
            {
              text: 'Installation',
              link: '/guides/foundations/installation',
            },
            {
              text: 'How Basalt Works',
              link: '/guides/foundations/mental-model',
            },
            {
              text: 'Elements and Properties',
              link: '/guides/foundations/elements-and-properties',
            },
            {
              text: 'Events and Focus',
              link: '/guides/foundations/events-and-focus',
            },
            {
              text: 'Layout Basics',
              link: '/guides/foundations/layout-basics',
            },
            {
              text: 'Flex Layouts',
              link: '/guides/foundations/flex-layouts',
            },
            {
              text: 'Reactive State',
              link: '/guides/foundations/reactive-state',
            },
            {
              text: 'Styling, States, and Themes',
              link: '/guides/foundations/styling-states-and-themes',
            },
          ],
        },
        {
          text: 'Building Interfaces',
          items: [
            {
              text: 'Text Inputs',
              link: '/guides/building-interfaces/text-inputs',
            },
            {
              text: 'Form Controls and Validation',
              link: '/guides/building-interfaces/form-controls-and-validation',
            },
            {
              text: 'Lists and Selection',
              link: '/guides/building-interfaces/lists-and-selection',
            },
            {
              text: 'Dropdowns and Suggestions',
              link: '/guides/building-interfaces/dropdowns-and-suggestions',
            },
            {
              text: 'Tables and Trees',
              link: '/guides/building-interfaces/tables-and-trees',
            },
            {
              text: 'Page Navigation',
              link: '/guides/building-interfaces/page-navigation',
            },
            {
              text: 'Tabs',
              link: '/guides/building-interfaces/tabs',
            },
            {
              text: 'Feedback and Progress',
              link: '/guides/building-interfaces/feedback-and-progress',
            },
            {
              text: 'Dialogs and Context Menus',
              link: '/guides/building-interfaces/dialogs',
            },
            {
              text: 'Canvas',
              link: '/guides/building-interfaces/canvas',
            },
            {
              text: 'Hosted Programs',
              link: '/guides/building-interfaces/hosted-programs',
            },
            {
              text: 'Multiple Roots and Monitors',
              link: '/guides/building-interfaces/multiple-roots-and-monitors',
            },
          ],
        },
        {
          text: 'Optional Modules',
          items: [
            {
              text: 'Using Optional Modules',
              link: '/guides/modules/',
            },
            {
              text: 'Animation and Responsive',
              link: '/guides/modules/animation-and-responsive',
            },
            {
              text: 'Charts, Images, and BigFont',
              link: '/guides/modules/charts-images-and-bigfont',
            },
          ],
        },
        {
          text: 'Application Recipes',
          items: [
            {
              text: 'Control Room Dashboard',
              link: '/guides/recipes/control-room-dashboard',
            },
          ],
        },
        {
          text: 'XML',
          items: [
            {
              text: 'XML Interfaces',
              link: '/guides/xml/',
            },
            {
              text: 'Building with XML',
              link: '/guides/xml/building-with-xml',
            },
          ],
        },
        {
          text: 'Development',
          items: [
            {
              text: 'Interactive Examples',
              link: '/guides/development/interactive-examples',
            },
            {
              text: 'Debugging',
              link: '/guides/development/debugging',
            },
            {
              text: 'Testing',
              link: '/guides/development/testing',
            },
            {
              text: 'Performance Tuning',
              link: '/guides/development/performance-tuning',
            },
          ],
        },
      ],
      '/api/': [
        {
          text: 'API Reference',
          link: '/api/',
        },
        {
          text: 'Runtime',
          items: [
            { text: 'basalt', link: '/api/basalt' },
          ],
        },
        {
          text: 'Core',
          collapsed: true,
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
