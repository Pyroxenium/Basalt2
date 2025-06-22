return {
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
        },
        ["Switch"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 1378,
          ["path"] = "elements/Switch.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 9544,
          ["path"] = "elements/BaseElement.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["size"] = 17775,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Button"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 25553,
          ["path"] = "elements/Container.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
        },
        ["Timer"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["size"] = 20951,
          ["path"] = "elements/BigFont.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 9548,
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 7941,
          ["path"] = "elements/Tree.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["size"] = 11316,
          ["path"] = "elements/TextBox.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["default"] = false,
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 9506,
          ["path"] = "elements/List.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["size"] = 32476,
          ["path"] = "elements/Flexbox.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["size"] = 4458,
          ["path"] = "elements/Frame.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 9767,
          ["path"] = "elements/Table.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["canvas"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 7580,
          ["path"] = "plugins/reactive.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
        ["state"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 15795,
          ["path"] = "plugins/animation.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 9966,
          ["path"] = "plugins/xml.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 11941,
          ["path"] = "main.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["size"] = 622,
          ["path"] = "init.lua",
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Jun 20 19:30:40 2025",
  },
}