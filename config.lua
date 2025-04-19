return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 583,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 10456,
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["BarChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["default"] = false,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["default"] = false,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["default"] = true,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["default"] = true,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6990,
          ["default"] = false,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 12215,
          ["default"] = true,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 8680,
          ["default"] = true,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8702,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10929,
          ["default"] = false,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["default"] = true,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 7733,
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 25030,
          ["default"] = true,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9191,
          ["default"] = true,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4766,
          ["default"] = true,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["default"] = false,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 8876,
          ["default"] = true,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["default"] = true,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["default"] = false,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9544,
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7193,
          ["default"] = true,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["default"] = true,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["default"] = true,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14731,
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 7166,
          ["default"] = true,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Sat Apr 19 04:26:08 2025",
    ["version"] = "2.0",
  },
}