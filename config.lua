return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Jun  1 15:59:24 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 9554,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9548,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32431,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9544,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 25134,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 9838,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 9506,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17775,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 11316,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 15795,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 622,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 11941,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
}