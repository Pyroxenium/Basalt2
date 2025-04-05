return {
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 10282,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 583,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15224,
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Button"] = {
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20926,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6333,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 8657,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3200,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6925,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3368,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 8774,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8439,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Switch"] = {
          ["description"] = "",
          ["path"] = "elements/Switch.lua",
          ["size"] = 1354,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7919,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15102,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4218,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3164,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 24805,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8680,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 12190,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17732,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9402,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["default"] = true,
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
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
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
          ["size"] = 6962,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 5901,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 9901,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 6926,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["benchmark"] = {
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12497,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["canvas"] = {
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 8002,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14749,
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Sat Apr  5 22:57:43 2025",
    ["version"] = "2.0",
  },
}