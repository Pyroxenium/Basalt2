return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Sep  2 10:25:14 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
          ["description"] = "",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["description"] = "",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 14085,
          ["default"] = true,
          ["path"] = "main.lua",
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["size"] = 6297,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 15524,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25383,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11316,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1378,
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 6989,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7941,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9548,
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 18564,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3227,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 9686,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3190,
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20951,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 9940,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6250,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 7580,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7873,
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 7042,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 18421,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
        },
      },
    },
  },
}