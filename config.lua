return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri May  9 01:30:02 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["canvas"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["size"] = 15774,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 11941,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 648,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 25093,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 8876,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9191,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["size"] = 9668,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["size"] = 4701,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["size"] = 8919,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9544,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10928,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32431,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 8702,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
        },
      },
      ["description"] = "UI Elements",
    },
  },
}