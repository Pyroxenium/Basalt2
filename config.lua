return {
  ["metadata"] = {
    ["generated"] = "Sun Apr 20 08:28:09 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 15774,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 7187,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8876,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8702,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = false,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9668,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 9544,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7733,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4766,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25093,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10928,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9191,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = false,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
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
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 10456,
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 583,
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
  },
}