return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["size"] = 3142,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["main"] = {
          ["size"] = 10456,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["propertySystem"] = {
          ["size"] = 15523,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["init"] = {
          ["size"] = 583,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["render"] = {
          ["size"] = 12422,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["size"] = 14731,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
        },
        ["state"] = {
          ["size"] = 6895,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
        },
        ["theme"] = {
          ["size"] = 7166,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["size"] = 9901,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["debug"] = {
          ["size"] = 6250,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["reactive"] = {
          ["size"] = 7193,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["size"] = 2661,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["BarChart"] = {
          ["size"] = 3190,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["Frame"] = {
          ["size"] = 4458,
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["List"] = {
          ["size"] = 8702,
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["TextBox"] = {
          ["size"] = 10929,
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Flexbox"] = {
          ["size"] = 12215,
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["Button"] = {
          ["size"] = 1656,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["VisualElement"] = {
          ["size"] = 17775,
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Image"] = {
          ["size"] = 15125,
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["Input"] = {
          ["size"] = 8876,
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["BaseElement"] = {
          ["size"] = 9415,
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Graph"] = {
          ["size"] = 6990,
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["Tree"] = {
          ["size"] = 7941,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["BigFont"] = {
          ["size"] = 20951,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["Display"] = {
          ["size"] = 4243,
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
        },
        ["Dropdown"] = {
          ["size"] = 6359,
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
        ["Scrollbar"] = {
          ["size"] = 9191,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Container"] = {
          ["size"] = 24818,
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["Slider"] = {
          ["size"] = 4700,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["Switch"] = {
          ["size"] = 1378,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
        },
        ["Table"] = {
          ["size"] = 8680,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["Checkbox"] = {
          ["size"] = 2898,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Label"] = {
          ["size"] = 3092,
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Program"] = {
          ["size"] = 7733,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Apr 16 03:03:23 2025",
  },
}