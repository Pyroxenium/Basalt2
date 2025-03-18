return {
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["size"] = 5901,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["size"] = 9614,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["size"] = 12496,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["debug"] = {
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["size"] = 9007,
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["size"] = 15224,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["size"] = 11100,
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["size"] = 519,
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Frame"] = {
          ["size"] = 4435,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Display"] = {
          ["size"] = 2846,
          ["path"] = "elements/Display.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["size"] = 4657,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Dropdown"] = {
          ["size"] = 5845,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BaseFrame"] = {
          ["size"] = 5823,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["size"] = 23195,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["size"] = 15102,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["size"] = 20670,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["size"] = 4676,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["size"] = 7919,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["size"] = 6295,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["size"] = 9402,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["Label"] = {
          ["size"] = 3069,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["size"] = 2635,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["VisualElement"] = {
          ["size"] = 17054,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Table"] = {
          ["size"] = 7586,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["size"] = 8645,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["size"] = 8358,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Mar 18 00:52:17 2025",
  },
}