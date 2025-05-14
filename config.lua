return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["utils"] = {
          ["size"] = 2661,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["size"] = 12422,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["size"] = 11941,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["size"] = 622,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Button"] = {
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Display"] = {
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
        },
        ["Table"] = {
          ["size"] = 9668,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["size"] = 3190,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = false,
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["Graph"] = {
          ["size"] = 6989,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["Program"] = {
          ["size"] = 9231,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["List"] = {
          ["size"] = 8702,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["Frame"] = {
          ["size"] = 4458,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["Slider"] = {
          ["size"] = 4701,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Label"] = {
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["size"] = 11316,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["size"] = 17775,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["Image"] = {
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Switch"] = {
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = false,
        },
        ["Input"] = {
          ["size"] = 9558,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
        },
        ["Scrollbar"] = {
          ["size"] = 9191,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["size"] = 9544,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Container"] = {
          ["size"] = 25134,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["animation"] = {
          ["size"] = 15795,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["size"] = 7042,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["state"] = {
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["size"] = 7580,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["size"] = 6250,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["size"] = 9901,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon May 12 21:10:25 2025",
    ["version"] = "2.0",
  },
}