return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Apr 19 16:22:32 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["size"] = 10456,
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["size"] = 583,
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Scrollbar"] = {
          ["size"] = 9191,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Label"] = {
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Slider"] = {
          ["size"] = 4766,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Checkbox"] = {
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Switch"] = {
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BigFont"] = {
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BarChart"] = {
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Program"] = {
          ["size"] = 7733,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Table"] = {
          ["size"] = 8811,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Button"] = {
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Display"] = {
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["BaseElement"] = {
          ["size"] = 9544,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Frame"] = {
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Container"] = {
          ["size"] = 25030,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Graph"] = {
          ["size"] = 6990,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["Flexbox"] = {
          ["size"] = 12215,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Tree"] = {
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Input"] = {
          ["size"] = 8876,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Dropdown"] = {
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["TextBox"] = {
          ["size"] = 10929,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["List"] = {
          ["size"] = 8702,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Image"] = {
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["size"] = 14731,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["size"] = 7193,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["size"] = 7166,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
    },
  },
}