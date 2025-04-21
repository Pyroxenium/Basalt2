return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 10456,
          ["path"] = "main.lua",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 583,
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7733,
          ["path"] = "elements/Program.lua",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9668,
          ["path"] = "elements/Table.lua",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9544,
          ["path"] = "elements/BaseElement.lua",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["path"] = "elements/Flexbox.lua",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10928,
          ["path"] = "elements/TextBox.lua",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25093,
          ["path"] = "elements/Container.lua",
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9191,
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4766,
          ["path"] = "elements/Slider.lua",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8702,
          ["path"] = "elements/List.lua",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 8876,
          ["path"] = "elements/Input.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7187,
          ["path"] = "plugins/reactive.lua",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15774,
          ["path"] = "plugins/animation.lua",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
      },
      ["description"] = "Libraries",
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon Apr 21 06:23:29 2025",
    ["version"] = "2.0",
  },
}