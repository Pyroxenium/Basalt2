return {
  ["metadata"] = {
    ["generated"] = "Thu Jul 17 09:13:02 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 11941,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 622,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 6508,
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17936,
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 25373,
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 9628,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 11316,
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32431,
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 8758,
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9548,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 11430,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9686,
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 15795,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
        },
      },
    },
  },
}