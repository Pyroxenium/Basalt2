return {
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["size"] = 648,
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["size"] = 11941,
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["animation"] = {
          ["size"] = 15774,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["debug"] = {
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["size"] = 7253,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Frame"] = {
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Checkbox"] = {
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["VisualElement"] = {
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseElement"] = {
          ["size"] = 9544,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["BarChart"] = {
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Switch"] = {
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["size"] = 8702,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["size"] = 9668,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Graph"] = {
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["TextBox"] = {
          ["size"] = 10928,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["size"] = 32431,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["size"] = 4766,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Input"] = {
          ["size"] = 8876,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Container"] = {
          ["size"] = 25093,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["size"] = 9191,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["size"] = 8762,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Apr 28 10:15:28 2025",
  },
}