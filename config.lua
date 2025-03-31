return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 583,
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 10282,
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15224,
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6926,
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 6962,
        },
        ["canvas"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["size"] = 8002,
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 14749,
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6175,
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9901,
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 5901,
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12497,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 2707,
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7919,
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5941,
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8684,
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9164,
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9402,
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 8358,
        },
        ["BarChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 2635,
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 3964,
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17732,
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20670,
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1632,
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8439,
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 2272,
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 24547,
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4676,
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 6295,
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 5940,
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 7586,
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2872,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Mar 31 01:35:48 2025",
  },
}