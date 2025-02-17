import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Basalt",
  description: "A UI Framework made for CC:Tweaked",
  lang: 'en-US',
  lastUpdated: true,
  base: "/Basalt2/",

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
      { text: 'References', link: '/references/main' },
    ],

    docFooter: {
      prev: false,
      next: false
    },

    sidebar: {
      '/guides/': [

      ],

'/references/':[
        {
          text: 'Core', link: 'references/main',
          collapsed: false,
          items: [
            {text: 'Basalt', link: 'references/main'},
            {text: 'PropertySystem', link: 'references/propertySystem'},
            {text: 'Render', link: 'references/render'},
            {text: 'Log', link: 'references/log'},
            {text: 'ElementManager', link: 'references/elementManager'},
            {text: 'ErrorManager', link: 'references/errorManager'},
            ],
        },
        {
          text: 'elements', link: 'references/elements/BaseElement',
          collapsed: false,
          items: [
            {text: 'Element', link: 'references/elements/BaseElement', collapsed: false, items: [
              {text: 'VisualElement', link: 'references/elements/VisualElement', collapsed: false, items: [
                {text: 'Container', link: 'references/elements/Container', collapsed: true, items: [
                  {text: 'BaseFrame', link: 'references/elements/BaseFrame'},
                  {text: 'Frame', link: 'references/elements/Frame'},
                ]},
                {text: 'Button', link: 'references/elements/Button'},
                {text: 'Label', link: 'references/elements/Label'},  
                {text: 'Input', link: 'references/elements/Input'},
                {text: 'Checkbox', link: 'references/elements/Checkbox'},
                {text: 'List', link: 'references/elements/List', collapsed: true},
              ]},
            ]}
          ]
        },
        {
          text: 'plugins', link: 'references/plugins/animations',
          collapsed: false,
          items: [
            {text: 'Animations', link: 'references/plugins/animation'},
            {text: 'Benchmark', link: 'references/plugins/benchmark'},
            {text: 'Debug', link: 'references/plugins/debug'},
            {text: 'Reactive', link: 'references/plugins/reactive'},
            {text: 'State', link: 'references/plugins/state'},
            {text: 'Theme', link: 'references/plugins/theme'},
            {text: 'Xml', link: 'references/plugins/xml'},
          ]
        },
      ]
    },


    socialLinks: [
      { icon: 'github', link: 'https://github.com/Pyroxenium/Basalt2' }
    ]
  }
})
