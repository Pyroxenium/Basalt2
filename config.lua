return {
  ["metadata"] = {
    ["generated"] = "Thu Apr 24 08:20:55 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7253,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6250,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["state"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 9901,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 15774,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7042,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["canvas"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7873,
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 846,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["size"] = 6989,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 4766,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["Button"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["size"] = 25093,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["size"] = 3227,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["size"] = 8702,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["Timer"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 8679,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["size"] = 10928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 9191,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["size"] = 4458,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["size"] = 8876,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["size"] = 17775,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["Switch"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["size"] = 3190,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["size"] = 9544,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 9668,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 10578,
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12422,
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 634,
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 15524,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6297,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
      },
    },
  },
}