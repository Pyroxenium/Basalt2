return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Mar 14 02:59:05 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Display"] = {
          ["description"] = "",
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2846,
          ["default"] = false,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5845,
          ["default"] = false,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9164,
          ["default"] = true,
        },
        ["Slider"] = {
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4676,
          ["default"] = true,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["size"] = 2634,
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 8911,
          ["default"] = true,
        },
        ["Button"] = {
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
          ["default"] = true,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8645,
          ["default"] = true,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4435,
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
          ["default"] = true,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7997,
          ["default"] = true,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["size"] = 5940,
          ["default"] = false,
        },
        ["Tree"] = {
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7885,
          ["default"] = true,
        },
        ["Table"] = {
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7586,
          ["default"] = true,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20670,
          ["default"] = false,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17146,
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4657,
          ["default"] = true,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3069,
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 5868,
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["size"] = 2707,
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["default"] = true,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 13487,
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2272,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10904,
          ["default"] = false,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 23195,
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12496,
          ["default"] = true,
        },
        ["theme"] = {
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 5901,
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 14116,
          ["default"] = true,
        },
        ["state"] = {
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["requires"] = {
          },
          ["size"] = 5867,
          ["default"] = true,
        },
        ["reactive"] = {
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 6962,
          ["default"] = true,
        },
        ["xml"] = {
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 8669,
          ["default"] = true,
        },
        ["debug"] = {
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6175,
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
        },
        ["expect"] = {
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
        },
        ["utils"] = {
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["description"] = "",
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 519,
          ["default"] = true,
        },
        ["main"] = {
          ["description"] = "",
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 9007,
          ["default"] = true,
        },
        ["log"] = {
          ["description"] = "",
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
        },
        ["render"] = {
          ["description"] = "",
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 11100,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 15224,
          ["default"] = true,
        },
      },
    },
  },
}