return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11383,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 9544,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9548,
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3190,
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["size"] = 6989,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17775,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32476,
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3227,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
        },
        ["Timer"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9554,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9506,
          ["default"] = true,
          ["path"] = "elements/List.lua",
        },
        ["Switch"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1378,
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11316,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7941,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25553,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
        },
        ["Button"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20951,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4458,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15795,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7580,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
        },
        ["canvas"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7873,
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6250,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 9901,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
        },
        ["state"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["default"] = true,
          ["path"] = "plugins/state.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7042,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15524,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["default"] = true,
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 11941,
          ["default"] = true,
          ["path"] = "main.lua",
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["generated"] = "Fri Jun 20 12:19:38 2025",
    ["version"] = "2.0",
  },
}