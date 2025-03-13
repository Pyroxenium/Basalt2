return {
  ["metadata"] = {
    ["generated"] = "Tue Mar 11 23:42:14 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Table"] = {
          ["description"] = "",
          ["size"] = 7586,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = true,
        },
        ["Button"] = {
          ["description"] = "",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 2707,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5868,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 8911,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 5940,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 2272,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17150,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7885,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 2634,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 23195,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 20670,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8645,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 7997,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5845,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 13312,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["description"] = "",
          ["size"] = 5867,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["default"] = true,
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 8669,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 5885,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 6962,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12496,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 14116,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6175,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
        },
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["description"] = "",
          ["size"] = 9007,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 519,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15225,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 11100,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
  },
}