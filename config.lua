return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 846,
          ["description"] = "",
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 11941,
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 622,
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 15524,
          ["description"] = "",
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 12422,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["size"] = 7873,
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 7042,
          ["description"] = "",
          ["default"] = true,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6250,
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 9940,
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 7580,
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["description"] = "",
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 16494,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25373,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["description"] = "",
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
          ["description"] = "",
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["size"] = 3227,
          ["description"] = "",
          ["default"] = false,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["description"] = "",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["size"] = 3190,
          ["description"] = "",
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["description"] = "",
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1378,
          ["description"] = "",
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["description"] = "",
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["description"] = "",
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
          ["description"] = "",
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 18564,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9548,
          ["description"] = "",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11316,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 9686,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7941,
          ["description"] = "",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20951,
          ["description"] = "",
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Aug 25 11:54:36 2025",
  },
}