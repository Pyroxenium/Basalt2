return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["size"] = 15225,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["size"] = 8158,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["size"] = 519,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["size"] = 10935,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["size"] = 6297,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["size"] = 8911,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["size"] = 2272,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["size"] = 7885,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["size"] = 17105,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["size"] = 7997,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["size"] = 5868,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["size"] = 13312,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["size"] = 5896,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["size"] = 7586,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["size"] = 2707,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["size"] = 2634,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["size"] = 5940,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["size"] = 20332,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["size"] = 23180,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["size"] = 8643,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["size"] = 846,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["size"] = 12515,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["size"] = 5885,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["size"] = 5867,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["size"] = 6962,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["size"] = 14116,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["size"] = 6175,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["size"] = 17568,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["generated"] = "Tue Mar  4 00:54:15 2025",
    ["version"] = "2.0",
  },
}