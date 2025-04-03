return {
  ["metadata"] = {
    ["generated"] = "Thu Apr  3 16:03:40 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 8358,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["Switch"] = {
          ["description"] = "",
          ["size"] = 1354,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 24547,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 7586,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 20670,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4676,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8680,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7919,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 2635,
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9402,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 2272,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17732,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 3964,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["size"] = 9164,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 6295,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 2707,
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["size"] = 2872,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Button"] = {
          ["description"] = "",
          ["size"] = 1632,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5941,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 5940,
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8439,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["description"] = "",
          ["size"] = 8002,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6250,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 6962,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12497,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["state"] = {
          ["description"] = "",
          ["size"] = 6926,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 14749,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 5901,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 9901,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 583,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6297,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 12422,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15224,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 10282,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
      },
    },
  },
}