return {
  ["metadata"] = {
    ["generated"] = "Mon Apr 21 06:33:18 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["default"] = false,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 3227,
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2928,
          ["default"] = true,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10928,
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9544,
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17775,
          ["default"] = true,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["size"] = 2914,
          ["default"] = true,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8702,
          ["default"] = true,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20951,
          ["default"] = false,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4458,
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 8876,
          ["default"] = true,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["size"] = 1378,
          ["default"] = true,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 3190,
          ["default"] = false,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["default"] = false,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["default"] = true,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["default"] = false,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7941,
          ["default"] = true,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1656,
          ["default"] = true,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4766,
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["default"] = false,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 7733,
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25093,
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 3397,
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9191,
          ["default"] = true,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 9668,
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 7042,
          ["default"] = true,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 15774,
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6896,
          ["default"] = true,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["size"] = 7873,
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 7187,
          ["default"] = true,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12581,
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9901,
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6250,
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["default"] = true,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 10507,
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 583,
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15524,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
        },
      },
    },
  },
}