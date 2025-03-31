return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Mar 31 01:28:40 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6962,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12497,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 5901,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
        },
        ["canvas"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7988,
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9901,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 14749,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6175,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6926,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15224,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["description"] = "",
          ["path"] = "errorManager.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 583,
          ["description"] = "",
          ["path"] = "init.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
          ["description"] = "",
          ["path"] = "render.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["description"] = "",
          ["path"] = "log.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6297,
          ["description"] = "",
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 10282,
          ["description"] = "",
          ["path"] = "main.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4676,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5941,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2272,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9164,
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 5940,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8439,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8358,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20670,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9402,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3964,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
        },
        ["BarChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 2635,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 24547,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15102,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7586,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
          ["description"] = "",
          ["path"] = "elements/Button.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 2707,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8684,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17732,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7919,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
        },
      },
    },
  },
}