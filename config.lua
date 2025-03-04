return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Mar  4 13:44:30 2025",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["description"] = "",
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12515,
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["size"] = 17568,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["description"] = "",
          ["default"] = true,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["description"] = "",
          ["default"] = true,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["size"] = 8453,
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["description"] = "",
          ["default"] = true,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["size"] = 11100,
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["size"] = 519,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["description"] = "",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20332,
          ["description"] = "",
          ["default"] = false,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["description"] = "",
          ["default"] = true,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5845,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
          ["description"] = "",
          ["default"] = true,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["size"] = 2634,
          ["description"] = "",
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["size"] = 5940,
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17150,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["size"] = 23180,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["size"] = 2707,
          ["description"] = "",
          ["default"] = false,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["size"] = 7885,
          ["description"] = "",
          ["default"] = true,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["description"] = "",
          ["default"] = true,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["size"] = 13312,
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["description"] = "",
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["size"] = 7997,
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["size"] = 8645,
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
  },
}