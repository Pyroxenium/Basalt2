return {
  ["metadata"] = {
    ["generated"] = "Sun Apr  6 17:27:35 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17732,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 24654,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6967,
          ["requires"] = {
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3164,
          ["requires"] = {
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 20926,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 8657,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1354,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 12190,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8680,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6333,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8439,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3200,
          ["requires"] = {
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9402,
          ["requires"] = {
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3368,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4218,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 8774,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 583,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15224,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 10456,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7193,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 8002,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9901,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6799,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 14749,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6926,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "Plugins",
    },
  },
}