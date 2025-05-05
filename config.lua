return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["size"] = 15774,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["size"] = 7253,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["size"] = 12581,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["size"] = 6250,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["size"] = 7873,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["size"] = 7042,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["size"] = 6896,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["size"] = 9901,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["size"] = 9544,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["size"] = 8702,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["size"] = 3227,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["size"] = 20951,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["size"] = 8876,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["size"] = 10928,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["size"] = 17775,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["size"] = 2914,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["size"] = 1378,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["size"] = 9191,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["size"] = 3397,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["size"] = 9668,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["size"] = 4243,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["size"] = 4458,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["size"] = 25093,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["size"] = 8919,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["size"] = 4766,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["size"] = 3190,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["size"] = 8466,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["size"] = 1656,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["size"] = 2928,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["size"] = 7941,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["size"] = 6359,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["size"] = 132,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["size"] = 846,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["size"] = 2661,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["size"] = 12422,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["size"] = 11941,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["size"] = 3142,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["size"] = 3789,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["size"] = 6297,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["size"] = 648,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["size"] = 15524,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon May  5 10:29:24 2025",
  },
}