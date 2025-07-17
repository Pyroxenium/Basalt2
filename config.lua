return {
  ["metadata"] = {
    ["generated"] = "Sun Jun 22 02:32:03 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9783,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17774,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["size"] = 11430,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
        },
        ["Switch"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["size"] = 1378,
        },
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["size"] = 8978,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
        },
        ["Timer"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9548,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32476,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
        },
        ["Button"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["size"] = 11316,
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["size"] = 7941,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["size"] = 25553,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["size"] = 9506,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["size"] = 4458,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["size"] = 622,
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["size"] = 12076,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
        },
        ["state"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["size"] = 9966,
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["size"] = 15795,
        },
      },
    },
  },
}