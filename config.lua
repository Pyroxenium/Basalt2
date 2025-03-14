return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["size"] = 15224,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["size"] = 519,
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["size"] = 11100,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["size"] = 9007,
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["size"] = 5901,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["size"] = 12496,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["size"] = 8669,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Program"] = {
          ["size"] = 6295,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["size"] = 9023,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Table"] = {
          ["size"] = 7586,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Display"] = {
          ["size"] = 2846,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["size"] = 5868,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["List"] = {
          ["size"] = 8645,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Slider"] = {
          ["size"] = 4676,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Input"] = {
          ["size"] = 8009,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Tree"] = {
          ["size"] = 7919,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Dropdown"] = {
          ["size"] = 5845,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Container"] = {
          ["size"] = 23195,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["size"] = 17054,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Button"] = {
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Menu"] = {
          ["size"] = 4657,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["BigFont"] = {
          ["size"] = 20670,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BarChart"] = {
          ["size"] = 2634,
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Image"] = {
          ["size"] = 15102,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Label"] = {
          ["size"] = 3069,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Mar 14 16:00:35 2025",
  },
}