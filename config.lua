return {
  ["metadata"] = {
    ["generated"] = "Mon Apr  7 03:01:34 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 7051,
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
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 14749,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
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
          ["size"] = 6926,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["size"] = 8002,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7193,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 8657,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3368,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17732,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 8774,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 8680,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["size"] = 1354,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9402,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3164,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3200,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["size"] = 4218,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6333,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 12190,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 24654,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 6967,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20926,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8439,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15224,
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
          ["size"] = 583,
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
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 10456,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
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
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
  },
}