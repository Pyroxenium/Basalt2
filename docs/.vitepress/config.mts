import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Basalt",
  description: "A UI Framework made for CC:Tweaked",
  lang: 'en-US',
  lastUpdated: true,

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
      { text: 'References', link: '/references/main'},
      { text: 'Guides', link: '/guides/getting-started' },
    ],

    docFooter: {
      prev: false,
      next: false
    },

    sidebar: {
      '/guides/': [
        { text: 'General', link: '/guides/getting-started', items: [
          { text: 'Getting started', link: '/guides/getting-started' },
          { text: 'Download', link: '/guides/download' },
          { text: 'Annotations', link: '/guides/annotations' },          
          { text: 'FAQ', link: '/guides/faq' },
        ]},
        { text: 'Plugins', link: '/guides/animations', items: [
          { text: 'Animations', link: '/guides/animations' },
          { text: 'Benchmark', link: '/guides/benchmarks' },
          { text: 'Properties', link: '/guides/properties' },
          { text: 'States', link: '/guides/states' },
          { text: 'XML', link: '/guides/xml' },
        ]},
      ],

      '/references/':[
        {
          text: 'Basalt', link: 'references/main',
          collapsed: true,
          items: [
            {text: 'PropertySystem', link: 'references/propertySystem'},
            {text: 'Render', link: 'references/render'},
            {text: 'Log', link: 'references/log'},
            {text: 'ElementManager', link: 'references/elementManager'},
            {text: 'ErrorManager', link: 'references/errorManager'},
            ],
        },
        {
          text: 'Element', link: 'references/elements/BaseElement',
          collapsed: false,
          items: [
              {text: 'VisualElement', link: 'references/elements/VisualElement', collapsed: false, items: [
                {text: 'BigFont', link: 'references/elements/BigFont'},
                {text: 'Button', link: 'references/elements/Button'},
                {text: 'Checkbox', link: 'references/elements/Checkbox'},
                {text: 'Container', link: 'references/elements/Container', collapsed: true, items: [
                  {text: 'BaseFrame', link: 'references/elements/BaseFrame'},
                  {text: 'Flexbox', link: 'references/elements/Flexbox'},
                  {text: 'Frame', link: 'references/elements/Frame'},
                ]},
                {text: 'Display', link: 'references/elements/Display'},
                {text: 'Graph', link: 'references/elements/Graph', collapsed: true, items: [
                  {text: 'BarChart', link: 'references/elements/BarChart'},
                  {text: 'LineChart', link: 'references/elements/LineChart'},
                ]},
                {text: 'Image', link: 'references/elements/Image'},
                {text: 'Input', link: 'references/elements/Input'},
                {text: 'Label', link: 'references/elements/Label'},
                {text: 'List', link: 'references/elements/List', collapsed: true, items: [
                  {text: 'Dropdown', link: 'references/elements/Dropdown'},
                  {text: 'Menu', link: 'references/elements/Menu'},
                ]},
                {text: 'ProgressBar', link: 'references/elements/ProgressBar'},
                {text: 'Program', link: 'references/elements/Program'},
                {text: 'Scrollbar', link: 'references/elements/Scrollbar'},
                {text: 'Slider', link: 'references/elements/Slider'},
                {text: 'Table', link: 'references/elements/Table'},
                {text: 'TextBox', link: 'references/elements/TextBox'},
                {text: 'Tree', link: 'references/elements/Tree'},
              ]},
          ]
        },
        {
          text: 'plugins', link: 'references/plugins/animations',
          collapsed: false,
          items: [
            {text: 'Animations', link: 'references/plugins/animation', collapsed: true,
              items: [
                {text: 'Animation Instance', link: 'references/plugins/animation_AnimationInstance'},
                {text: 'VisualElement', link: 'references/plugins/animation_VisualElement'},
              ]
            },
            {text: 'Benchmark', link: 'references/plugins/benchmark', collapsed: true,
              items: [
                {text: 'BaseElement', link: 'references/plugins/benchmark_BaseElement'},
                {text: 'Container', link: 'references/plugins/benchmark_Container'},
              ]
            },
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
