return {
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7042,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6250,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7873,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7580,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15795,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 9901,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9260,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25134,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["size"] = 6989,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3190,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17775,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1378,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3227,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4458,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9668,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7941,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11316,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 9544,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9548,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20951,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 11941,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15524,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6297,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 622,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 12422,
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed May 14 23:04:09 2025",
    ["version"] = "2.0",
  },
}