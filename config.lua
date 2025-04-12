return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Apr 12 16:35:44 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["ProgressBar"] = {
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 3368,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6333,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17744,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 3164,
          ["requires"] = {
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 8657,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4218,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8439,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20926,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 3200,
          ["requires"] = {
          },
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 12190,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["TextBox"] = {
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["description"] = "",
          ["size"] = 1354,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9405,
          ["requires"] = {
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 7708,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8680,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 8853,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 6967,
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 24791,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 7166,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["size"] = 7873,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9901,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6930,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["animation"] = {
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 14733,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 7193,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["default"] = true,
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 583,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["default"] = true,
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 10456,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["default"] = true,
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15523,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
      },
    },
  },
}