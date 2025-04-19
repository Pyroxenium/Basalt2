return {
  ["metadata"] = {
    ["generated"] = "Sat Apr 19 04:19:26 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["xml"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14731,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 7166,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7193,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Slider"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4700,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["requires"] = {
          },
        },
        ["TextBox"] = {
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10929,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9191,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Display"] = {
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 12215,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["LineChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["requires"] = {
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9544,
          ["requires"] = {
          },
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 8680,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8702,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 25104,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 7733,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 8876,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6990,
          ["requires"] = {
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 10456,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
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
        ["log"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 583,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
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
        ["utils"] = {
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
  },
}