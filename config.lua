return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
        },
        ["main"] = {
          ["size"] = 8188,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
        },
        ["propertySystem"] = {
          ["size"] = 15225,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
        },
        ["render"] = {
          ["size"] = 11100,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
        },
        ["init"] = {
          ["size"] = 519,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["size"] = 5885,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
        },
        ["benchmark"] = {
          ["size"] = 12515,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
        },
        ["animation"] = {
          ["size"] = 14116,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
        },
        ["state"] = {
          ["size"] = 5867,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
        },
        ["xml"] = {
          ["size"] = 17568,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["size"] = 6175,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Checkbox"] = {
          ["size"] = 2872,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
        },
        ["Program"] = {
          ["size"] = 6295,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
        },
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Tree"] = {
          ["size"] = 7885,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
        },
        ["Label"] = {
          ["size"] = 3069,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
        },
        ["Dropdown"] = {
          ["size"] = 5845,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
        },
        ["BarChart"] = {
          ["size"] = 2634,
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
        },
        ["Button"] = {
          ["size"] = 1632,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Button.lua",
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
        },
        ["Image"] = {
          ["size"] = 13312,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
        },
        ["Table"] = {
          ["size"] = 7586,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
        },
        ["BigFont"] = {
          ["size"] = 20332,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
        },
        ["Input"] = {
          ["size"] = 7997,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
        },
        ["VisualElement"] = {
          ["size"] = 17150,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
        },
        ["List"] = {
          ["size"] = 8645,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
        },
        ["BaseFrame"] = {
          ["size"] = 5868,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
        },
        ["Slider"] = {
          ["size"] = 4676,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
        },
        ["Menu"] = {
          ["size"] = 4657,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
        },
        ["Container"] = {
          ["size"] = 23180,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
        },
        ["BaseElement"] = {
          ["size"] = 8911,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["generated"] = "Tue Mar  4 13:33:59 2025",
    ["version"] = "2.0",
  },
}