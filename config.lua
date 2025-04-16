return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15523,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 583,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 10456,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4700,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 8680,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["size"] = 2898,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Switch"] = {
          ["description"] = "",
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9415,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10929,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 6990,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 7733,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["size"] = 9191,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8702,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Button"] = {
          ["description"] = "",
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 24818,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 8876,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 12215,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["description"] = "",
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 7193,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 14731,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["state"] = {
          ["description"] = "",
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["canvas"] = {
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 7166,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Apr 16 03:08:47 2025",
    ["version"] = "2.0",
  },
}