return {
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6926,
          ["description"] = "",
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 5901,
          ["description"] = "",
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6175,
          ["description"] = "",
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 14749,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12497,
          ["description"] = "",
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9614,
          ["description"] = "",
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6962,
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["description"] = "",
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
          ["description"] = "",
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 519,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15224,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["description"] = "",
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 10142,
          ["description"] = "",
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 11100,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6297,
          ["description"] = "",
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9164,
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9402,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7586,
          ["description"] = "",
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4657,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5845,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4435,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15102,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8358,
          ["description"] = "A text input field with various features",
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 5940,
          ["description"] = "A point based graph element",
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 7769,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4676,
          ["description"] = "",
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 23195,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 2635,
          ["description"] = "",
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10904,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2272,
          ["description"] = "",
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["description"] = "",
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20670,
          ["description"] = "",
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17054,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7919,
          ["description"] = "",
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 2707,
          ["description"] = "",
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3964,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3069,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8645,
          ["description"] = "A scrollable list of selectable items",
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Mar 26 00:02:41 2025",
    ["version"] = "2.0",
  },
}