return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7193,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6250,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7873,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7166,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 14731,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9901,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 583,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 10456,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6297,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15524,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8680,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3190,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 12215,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20951,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17775,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6990,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8702,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25030,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7733,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4458,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9544,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9191,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10929,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4700,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1378,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3227,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8876,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7941,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Sat Apr 19 04:20:14 2025",
    ["version"] = "2.0",
  },
}