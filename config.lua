return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Mar 18 01:06:23 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["size"] = 846,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Slider"] = {
          ["size"] = 4676,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
        },
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["size"] = 5823,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["size"] = 20670,
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Table"] = {
          ["size"] = 7586,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["size"] = 7919,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["size"] = 6295,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Display"] = {
          ["size"] = 2846,
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["size"] = 23195,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
        },
        ["Dropdown"] = {
          ["size"] = 5845,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["VisualElement"] = {
          ["size"] = 17054,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Button"] = {
          ["size"] = 1632,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["size"] = 9402,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
        },
        ["Label"] = {
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["size"] = 8358,
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["size"] = 8645,
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["size"] = 2635,
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["size"] = 15102,
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["size"] = 6297,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["size"] = 9007,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["size"] = 519,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
        },
        ["render"] = {
          ["size"] = 11100,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["size"] = 3142,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["size"] = 15224,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["size"] = 6175,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
        },
        ["state"] = {
          ["size"] = 5867,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["size"] = 14116,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["size"] = 12497,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["xml"] = {
          ["size"] = 9614,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["size"] = 5901,
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
  },
}