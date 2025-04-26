return {
  ["metadata"] = {
    ["generated"] = "Sat Apr 26 11:32:26 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25093,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 8762,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 8876,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["requires"] = {
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4458,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3190,
          ["requires"] = {
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9191,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8702,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17775,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3227,
          ["requires"] = {
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10928,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9544,
          ["requires"] = {
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9668,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4766,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15774,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7253,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7042,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9901,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7873,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15524,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 634,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 10578,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
  },
}