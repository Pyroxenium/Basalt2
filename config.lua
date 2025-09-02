return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6297,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 11941,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 622,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15524,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["BarChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3190,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9548,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1378,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9686,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25373,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6989,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2928,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 20951,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 11430,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 11316,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3397,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3227,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 16214,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4977,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1656,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 18564,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 9558,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7941,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8758,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2914,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7580,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6896,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 17463,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7042,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7873,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9940,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon Aug 25 12:15:15 2025",
    ["version"] = "2.0",
  },
}