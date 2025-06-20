return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
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
          ["path"] = "plugins/animation.lua",
          ["size"] = 15795,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 9966,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
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
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9548,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 11383,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 11316,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9544,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 25553,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 9554,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32476,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 9506,
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 11941,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 622,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Fri Jun 20 12:25:52 2025",
    ["version"] = "2.0",
  },
}