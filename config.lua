return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["state"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["size"] = 8669,
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["size"] = 5901,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12496,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 8645,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 23195,
        },
        ["Slider"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 5940,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
        },
        ["Table"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["size"] = 7885,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 2634,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20670,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17146,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 2707,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
        },
        ["Button"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5845,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 7997,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
        },
        ["Display"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 2846,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["size"] = 13760,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 15224,
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 9007,
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 11100,
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 519,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Fri Mar 14 02:52:20 2025",
    ["version"] = "2.0",
  },
}