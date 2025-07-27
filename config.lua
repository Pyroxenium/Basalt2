return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 8758,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9548,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 18564,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 11316,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 16214,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 25373,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 11430,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 6508,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9686,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 11941,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 622,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 15795,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Jul 27 14:02:01 2025",
  },
}