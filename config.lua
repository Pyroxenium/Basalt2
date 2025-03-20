return {
  ["metadata"] = {
    ["generated"] = "Thu Mar 20 00:50:02 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["size"] = 519,
          ["description"] = "",
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["size"] = 11100,
          ["description"] = "",
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 15224,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["size"] = 9007,
          ["description"] = "",
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["description"] = "",
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["expect"] = {
          ["size"] = 846,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Menu"] = {
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["size"] = 17054,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 7919,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Image"] = {
          ["size"] = 15102,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["size"] = 2635,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Dropdown"] = {
          ["size"] = 5845,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Button"] = {
          ["size"] = 1632,
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Container"] = {
          ["size"] = 23195,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["List"] = {
          ["size"] = 8645,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Table"] = {
          ["size"] = 7586,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["size"] = 20670,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Slider"] = {
          ["size"] = 4676,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["size"] = 9402,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["size"] = 6295,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["size"] = 5823,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["size"] = 8358,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Display"] = {
          ["size"] = 2846,
          ["description"] = "",
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["size"] = 12497,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["size"] = 5901,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["size"] = 6175,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["xml"] = {
          ["size"] = 9614,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["size"] = 14749,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["state"] = {
          ["size"] = 6926,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
  },
}