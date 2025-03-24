return {
  ["metadata"] = {
    ["generated"] = "Mon Mar 24 19:20:14 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 15224,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["description"] = "",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 519,
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 10142,
          ["description"] = "",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 11100,
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["size"] = 9614,
          ["description"] = "",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["size"] = 14749,
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["size"] = 5901,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12497,
          ["description"] = "",
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["size"] = 6926,
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["description"] = "",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 8645,
          ["description"] = "A scrollable list of selectable items",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 2635,
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9402,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5845,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 2707,
          ["description"] = "",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["description"] = "",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["description"] = "",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["size"] = 7919,
          ["description"] = "",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 8358,
          ["description"] = "A text input field with various features",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["size"] = 15102,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
          ["description"] = "",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4006,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 5940,
          ["description"] = "A point based graph element",
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["description"] = "",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 23195,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["description"] = "",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 7769,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["description"] = "",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17054,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20670,
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
  },
}