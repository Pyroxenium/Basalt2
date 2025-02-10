import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Basalt",
  description: "A CC:Tweaked UI Framework",
  lang: 'en-US',
  lastUpdated: true,
  base: "/basalt-docs/",

  head: [
    //[
    //  'link',
    //  { rel: 'stylesheet', href: '../css/computer.css', type: 'text/css' }
    //],
    //[
    //  'script',
    //  { async: '', src: 'https://copy-cat.squiddev.cc/require.js' }
    //],
    //[
    //  'script',
    //  {},
    //  `require.config({ paths: { copycat: "https://copy-cat.squiddev.cc/" } });
    //  require(["copycat/embed"], setup => setup(document.getElementById("embed-computer")));`
    //],
    //[
    //  'script',
    //  {src: '../js/computer.js' },
    //],

    //HTML for this:
    //<button onclick="toggleComputer('computer-1')">Click Me</button>
    //<div id="computer-1" class="computer">
    //  <div id="embed-computer"></div>
    //</div>
  ],

  themeConfig: {
    editLink: {
      pattern: 'https://github.com/Pyroxenium/Basalt/tree/master/docs/:path'
    },
    search: {
      provider: 'local'
    },
    
    outline: 2,
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2024 Robert Jelic'
    },
    nav: [
      { text: 'Home', link: '/home' },
      { text: 'Guides', link: '/guides/getting-started' },
      { text: 'References', link: '/references/main' },
    ],

    docFooter: {
      prev: false,
      next: false
    },

    sidebar: {
      '/guides/': [
        {
          text: 'Getting Started',link: 'guides/getting-started',
          items: [
            { text: 'Download', link: '/guides/download' },
            { text: 'Properties', link: '/guides/properties' },
          ]
        }
      ],

      '/references/':[
        {
          text: 'References', link: 'references/main',
          items: [
            {text: 'Basalt', link: 'references/basalt'},
            {text: 'Element', link: 'references/element',
            items: [
              {text: 'VisualElement', link: 'references/visualelement',    
              items: [
                {text: 'Container', link: 'references/container',
                items: [
                  {text: 'Baseframe', link: 'references/baseframe'},
                  {text: 'Frame', link: 'references/frame'},
                  {text: 'Monitor', link: 'references/monitor'},
                  {text: 'BigMonitor', link: 'references/bigmonitor'},
                ]},
                {text: 'Button', link: 'references/button'},
                {text: 'Checkbox', link: 'references/checkbox'},
                {text: 'Input', link: 'references/input'},
                {text: 'Label', link: 'references/label'},
                {text: 'List', link: 'references/list',
                items: [
                  {text: 'Dropdown', link: 'references/dropdown'},
                  {text: 'Menubar', link: 'references/menubar'},
                ]},
                {text: 'Program', link: 'references/program'},
                {text: 'Progressbar', link: 'references/progressbar'},
                {text: 'Slider', link: 'references/slider'},
                {text: 'Textfield', link: 'references/textfield'},
              ]
              },
              
            ]
            },
            {text: 'Extensions', link: 'references/extensions',
            items: [
              {text: 'Dynamic Values', link: 'references/dynamicvalues'},
              {text: 'Template', link: 'references/template'},
              {text: 'Animations', link: 'references/animations'},
              {text: 'Borders', link: 'references/borders'},
              {text: 'Better Backgrounds', link: 'references/betterbackgrounds'},
              {text: 'Shadows', link: 'references/shadows'},
              {text: 'Debug', link: 'references/debug'},
              {text: 'XML', link: 'references/xml'},
            ]
            },
        ]
        },
      ],
      },


    socialLinks: [
      { icon: 'github', link: 'https://github.com/Pyroxenium/Basalt' }
    ]
  }
})
