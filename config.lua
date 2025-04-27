return {
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Display"] = {
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["Slider"] = {
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["size"] = 4766,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Input"] = {
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 8876,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Image"] = {
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Label"] = {
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9544,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Graph"] = {
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["Tree"] = {
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["List"] = {
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 8702,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Container"] = {
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 25093,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["BarChart"] = {
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9191,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Switch"] = {
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Menu"] = {
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Frame"] = {
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Program"] = {
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["size"] = 8762,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Button"] = {
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Table"] = {
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["size"] = 9668,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Timer"] = {
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["state"] = {
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["size"] = 15774,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7253,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["expect"] = {
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 11941,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 634,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Apr 27 23:33:08 2025",
  },
}