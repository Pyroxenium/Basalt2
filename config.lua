return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["size"] = 20926,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["size"] = 4218,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["size"] = 8439,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["description"] = "",
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["size"] = 1354,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["size"] = 17744,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["size"] = 3164,
          ["requires"] = {
          },
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["size"] = 12190,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["size"] = 24791,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["size"] = 8853,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["size"] = 9405,
          ["requires"] = {
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["size"] = 3200,
          ["requires"] = {
          },
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["size"] = 8680,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["size"] = 6333,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["size"] = 6967,
          ["requires"] = {
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["size"] = 8657,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["size"] = 7708,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["size"] = 3368,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["size"] = 846,
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["description"] = "",
          ["path"] = "init.lua",
          ["default"] = true,
          ["size"] = 583,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["description"] = "",
          ["path"] = "main.lua",
          ["default"] = true,
          ["size"] = 10456,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["description"] = "",
          ["path"] = "render.lua",
          ["default"] = true,
          ["size"] = 12422,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["path"] = "log.lua",
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["size"] = 15523,
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["size"] = 7193,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["size"] = 14733,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["size"] = 7873,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["size"] = 6250,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["size"] = 9901,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["size"] = 6926,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["benchmark"] = {
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["theme"] = {
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["size"] = 7166,
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Apr 11 20:49:30 2025",
  },
}