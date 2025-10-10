import { defineConfig } from 'vitepress'

function codeBlockRunPlugin(md) {
  const defaultFence = md.renderer.rules.fence

  md.renderer.rules.fence = (tokens, idx, options, env, self) => {
    const token = tokens[idx]
    const info = token.info.trim()
    const content = token.content

    if (info.includes('run')) {
      const cleanInfo = info.replace(/\s*run\s*/, '').trim()
      token.info = cleanInfo

      const codeHtml = defaultFence(tokens, idx, options, env, self)

      return `
        <div class="code-block-with-run">
          <div class="code-header">
            <button class="run-button" onclick="runCodeBlock(this)">
              <span class="play-icon">▶</span>
              <span class="button-text">Run</span>
            </button>
          </div>
          <div class="code-content" data-code="${btoa(content).replace(/"/g, '&quot;')}">
            ${codeHtml}
          </div>
        </div>
      `
    }

    return defaultFence(tokens, idx, options, env, self)
  }
}

export default defineConfig({
  title: "Basalt",
  description: "A UI Framework made for CC:Tweaked",
  lang: 'en-US',
  lastUpdated: true,

  markdown: {
    config: (md) => {
      md.use(codeBlockRunPlugin)
    }
  },

  themeConfig: {
    editLink: {
      pattern: 'https://github.com/Pyroxenium/Basalt2/tree/gh-pages/docs/:path'
    },
    search: {
      provider: 'local'
    },
    
    outline: 2,
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025 Robert Jelic'
    },
    nav: [
      { text: 'Home', link: '/home' },
      { text: 'References', link: '/references/main'},
      { text: 'Guides', link: '/guides/getting-started' },
    ],

    docFooter: {
      prev: false,
      next: false
    },

    sidebar: {
      '/guides/': [
        { text: 'Getting started', link: '/guides/getting-started' },
        { text: 'Download', link: '/guides/download' },
        { text: 'Annotations', link: '/guides/annotations' },
        { text: 'Animations', link: '/guides/animations' },
        { text: 'Benchmark', link: '/guides/benchmarks' },
        { text: 'Canvas', link: 'guides/canvas'},
        { text: 'Properties', link: '/guides/properties' },
        { text: 'States', link: '/guides/states' },
        { text: 'XML', link: '/guides/xml' },
        { text: 'FAQ', link: '/guides/faq' },
      ],

'/references/': [
    {
      text: 'Basalt',
      link: 'references/main',
      collapsed: true,
      items: [
        { text: 'ElementManager', link: 'references/elementManager' },
        { text: 'ErrorManager', link: 'references/errorManager' },
        { text: 'Log', link: 'references/log' },
        { text: 'PropertySystem', link: 'references/propertySystem' },
        { text: 'Render', link: 'references/render' },
      ],
    },
    {
      text: 'Element',
      link: 'references/elements/BaseElement',
      collapsed: false,
      items: [
        {
          text: 'VisualElement',
          link: 'references/elements/VisualElement',
          collapsed: false,
          items: [
            { text: 'BigFont', link: 'references/elements/BigFont' },
            { text: 'Button', link: 'references/elements/Button' },
            { text: 'CheckBox', link: 'references/elements/CheckBox' },
            {
              text: 'Container',
              link: 'references/elements/Container',
              collapsed: true,
              items: [
                { text: 'BaseFrame', link: 'references/elements/BaseFrame' },
                { text: 'Frame', link: 'references/elements/Frame' },
                { text: 'SideNav', link: 'references/elements/SideNav' },
                { text: 'TabControl', link: 'references/elements/TabControl' },
              ],
            },
            { text: 'Display', link: 'references/elements/Display' },
            {
              text: 'Graph',
              link: 'references/elements/Graph',
              collapsed: true,
              items: [
                { text: 'BarChart', link: 'references/elements/BarChart' },
                { text: 'LineChart', link: 'references/elements/LineChart' },
              ],
            },
            { text: 'Image', link: 'references/elements/Image' },
            { text: 'Input', link: 'references/elements/Input' },
            { text: 'Label', link: 'references/elements/Label' },
            {
              text: 'List',
              link: 'references/elements/List',
              collapsed: true,
              items: [
                { text: 'DropDown', link: 'references/elements/DropDown' },
                { text: 'Menu', link: 'references/elements/Menu' },
              ],
            },
            { text: 'ProgressBar', link: 'references/elements/ProgressBar' },
            { text: 'Program', link: 'references/elements/Program' },
            { text: 'ScrollBar', link: 'references/elements/ScrollBar' },
            { text: 'Slider', link: 'references/elements/Slider' },
            { text: 'Switch', link: 'references/elements/Switch' },
            { text: 'Table', link: 'references/elements/Table' },
            { text: 'TextBox', link: 'references/elements/TextBox' },
            { text: 'Tree', link: 'references/elements/Tree' },
          ],
        },
      ],
    },
    {
      text: 'plugins',
      link: 'references/plugins',
      collapsed: false,
      items: [
        { text: 'Animations', link: 'references/plugins/animation' },
        { text: 'Benchmark', link: 'references/plugins/benchmark' },
        { text: 'Debug', link: 'references/plugins/debug' },
        { text: 'Reactive', link: 'references/plugins/reactive' },
        { text: 'State', link: 'references/plugins/state' },
        { text: 'Text Wrapping', link: 'references/plugins/textWrapping' },
        { text: 'Theme', link: 'references/plugins/theme' },
        { text: 'Xml', link: 'references/plugins/xml' },
      ],
    },
  ],
},


    socialLinks: [
      { icon: 'github', link: 'https://github.com/Pyroxenium/Basalt2' }
    ]
  }
})
