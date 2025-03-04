return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Program"] = {
          ["default"] = true,
          ["size"] = 6295,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 8645,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["Image"] = {
          ["default"] = false,
          ["size"] = 13312,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["size"] = 2872,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["size"] = 2707,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 5868,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["size"] = 7885,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["size"] = 7586,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 23180,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["size"] = 20332,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["size"] = 4676,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 2272,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["BarChart"] = {
          ["default"] = false,
          ["size"] = 2634,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 8911,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 1632,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 7997,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["size"] = 5940,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["size"] = 9164,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["size"] = 5845,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 17105,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["size"] = 846,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["default"] = true,
          ["size"] = 6962,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["size"] = 6175,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["size"] = 14116,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["theme"] = {
          ["default"] = true,
          ["size"] = 5885,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["size"] = 17568,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["size"] = 5867,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["size"] = 12515,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 6297,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 519,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 10935,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 8158,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 15225,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Tue Mar  4 09:38:15 2025",
    ["version"] = "2.0",
  },
}