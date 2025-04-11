return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Apr 11 20:37:49 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4435,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 9405,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4657,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3069,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7919,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15102,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1354,
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4218,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8680,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8657,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3368,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8853,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 6967,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7708,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 24776,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6333,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10904,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3200,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3164,
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4676,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17744,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8439,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20926,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 12190,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9164,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 14733,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6926,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 9901,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 7166,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 7193,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 583,
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 15224,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 10456,
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
  },
}