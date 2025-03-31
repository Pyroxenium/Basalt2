return {
  ["metadata"] = {
    ["generated"] = "Mon Mar 31 06:04:16 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["size"] = 2661,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["size"] = 6297,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["size"] = 10282,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["propertySystem"] = {
          ["size"] = 15224,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["log"] = {
          ["size"] = 3142,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["init"] = {
          ["size"] = 583,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["render"] = {
          ["size"] = 12422,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Container"] = {
          ["size"] = 24547,
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Dropdown"] = {
          ["size"] = 5941,
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["BaseFrame"] = {
          ["size"] = 8439,
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Input"] = {
          ["size"] = 8358,
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["Button"] = {
          ["size"] = 1632,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["Display"] = {
          ["size"] = 3964,
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["Program"] = {
          ["size"] = 6295,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["List"] = {
          ["size"] = 8684,
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["Menu"] = {
          ["size"] = 4657,
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Label"] = {
          ["size"] = 3069,
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Tree"] = {
          ["size"] = 7919,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["VisualElement"] = {
          ["size"] = 17732,
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["BarChart"] = {
          ["size"] = 2635,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["Slider"] = {
          ["size"] = 4676,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["BaseElement"] = {
          ["size"] = 9402,
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Table"] = {
          ["size"] = 7586,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["BigFont"] = {
          ["size"] = 20670,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["Image"] = {
          ["size"] = 15102,
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["size"] = 5901,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["state"] = {
          ["size"] = 6926,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
        },
        ["debug"] = {
          ["size"] = 6250,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["xml"] = {
          ["size"] = 9901,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["benchmark"] = {
          ["size"] = 12497,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["canvas"] = {
          ["size"] = 8002,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
        },
        ["animation"] = {
          ["size"] = 14749,
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
      },
      ["description"] = "Plugins",
    },
  },
}