return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 648,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 11941,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15524,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 3227,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 9231,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8702,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 8876,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4458,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25134,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9544,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 9668,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9191,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17775,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4701,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 3190,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 7042,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9901,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 15774,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["size"] = 7873,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 7580,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["generated"] = "Sat May 10 21:41:29 2025",
    ["version"] = "2.0",
  },
}