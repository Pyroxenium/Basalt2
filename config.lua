return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8358,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 23195,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2635,
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4435,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15102,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2272,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3069,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3964,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
        },
        ["Slider"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4676,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 7769,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2707,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10904,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7919,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
        },
        ["Button"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8684,
          ["path"] = "elements/List.lua",
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4657,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
        },
        ["Table"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7586,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 9402,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9164,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20670,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5845,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["size"] = 5940,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17054,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
        },
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 10142,
          ["path"] = "main.lua",
          ["default"] = true,
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15224,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 519,
          ["path"] = "init.lua",
          ["default"] = true,
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 11100,
          ["path"] = "render.lua",
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["state"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6926,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 5901,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12497,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 9614,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 14749,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Mar 27 03:29:03 2025",
  },
}