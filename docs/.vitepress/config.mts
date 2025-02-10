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
          text: 'References', link: 'references/main',
          items: [
            {text: 'Basalt', link: 'references/basalt'},
            {text: 'Frame', link: 'references/frame'},              
            ]
        }
      ]
    },


    socialLinks: [
      { icon: 'github', link: 'https://github.com/Pyroxenium/Basalt2' }
    ]
  }
})
