return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 846,
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 519,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 15224,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 11100,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 9007,
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 5901,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 5867,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6175,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12496,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 14116,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6962,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 8669,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 2634,
          ["requires"] = {
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["size"] = 8645,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["size"] = 17054,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["size"] = 5868,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 2707,
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["size"] = 23195,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["size"] = 9023,
          ["requires"] = {
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 20670,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["size"] = 5940,
          ["requires"] = {
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["size"] = 5845,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7586,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["size"] = 8333,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2272,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 2846,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Mar 16 03:04:09 2025",
  },
}