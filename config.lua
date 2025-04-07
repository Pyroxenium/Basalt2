return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Apr  6 17:31:58 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 10456,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15224,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 583,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 7193,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 14749,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9901,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6926,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["size"] = 8002,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 7044,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20926,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17732,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9402,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 24654,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 12190,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8680,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 3164,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["size"] = 1354,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6333,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 6967,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8439,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 3200,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4218,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 8657,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 8774,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 3368,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
      },
    },
  },
}