return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Apr 14 00:40:38 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 583,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 10456,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15523,
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14731,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 7166,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7193,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 6930,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Graph"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6990,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4700,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 7733,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9415,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8702,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 8876,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 8680,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2898,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 24818,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10929,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9191,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 12215,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
      },
      ["description"] = "Libraries",
    },
  },
}