return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Mar 10 02:21:01 2025",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12496,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["xml"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 7772,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Checkbox"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 2707,
          ["requires"] = {
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17150,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5845,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BarChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 2634,
          ["requires"] = {
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5869,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["TextBox"] = {
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 23195,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Slider"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8645,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7885,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 5940,
          ["requires"] = {
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["requires"] = {
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 13312,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20670,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 7997,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 11100,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 9007,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 519,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
      },
    },
  },
}