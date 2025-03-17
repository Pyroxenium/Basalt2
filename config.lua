return {
  ["metadata"] = {
    ["generated"] = "Sun Mar 16 12:09:12 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
          ["path"] = "elements/Image.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 2272,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["size"] = 8358,
          ["path"] = "elements/Input.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17054,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 2846,
          ["path"] = "elements/Display.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["size"] = 5940,
          ["path"] = "elements/Graph.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 7919,
          ["path"] = "elements/Tree.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9023,
          ["path"] = "elements/BaseElement.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 23195,
          ["path"] = "elements/Container.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8645,
          ["path"] = "elements/List.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 7586,
          ["path"] = "elements/Table.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["path"] = "elements/TextBox.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["path"] = "elements/Label.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["path"] = "elements/Frame.lua",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 4676,
          ["path"] = "elements/Slider.lua",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5845,
          ["path"] = "elements/Dropdown.lua",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5868,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 9164,
          ["path"] = "elements/Scrollbar.lua",
        },
        ["BarChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 2634,
          ["path"] = "elements/BarChart.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 2707,
          ["path"] = "elements/LineChart.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 6295,
          ["path"] = "elements/Program.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 20670,
          ["path"] = "elements/BigFont.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["path"] = "elements/Menu.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 11100,
          ["path"] = "render.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 9007,
          ["path"] = "main.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 519,
          ["path"] = "init.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 15224,
          ["path"] = "propertySystem.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 5901,
          ["path"] = "plugins/theme.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 12496,
          ["path"] = "plugins/benchmark.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 8669,
          ["path"] = "plugins/xml.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
        },
      },
      ["description"] = "Plugins",
    },
  },
}