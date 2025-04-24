return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Graph"] = {
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
        },
        ["Flexbox"] = {
          ["size"] = 32431,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Slider"] = {
          ["size"] = 4766,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["Label"] = {
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["size"] = 25093,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BarChart"] = {
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["BigFont"] = {
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["size"] = 9544,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["Input"] = {
          ["size"] = 8876,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["VisualElement"] = {
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Program"] = {
          ["size"] = 8224,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["size"] = 9191,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["size"] = 9668,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Display"] = {
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["size"] = 10928,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["size"] = 8702,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["size"] = 634,
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["render"] = {
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["size"] = 10578,
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
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
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["state"] = {
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["animation"] = {
          ["size"] = 15774,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["size"] = 7253,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Apr 23 18:39:57 2025",
    ["version"] = "2.0",
  },
}