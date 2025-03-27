return {
  ["metadata"] = {
    ["generated"] = "Thu Mar 27 23:37:12 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Scrollbar"] = {
          ["size"] = 9164,
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Container"] = {
          ["size"] = 23195,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Input"] = {
          ["size"] = 8358,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Tree"] = {
          ["size"] = 7919,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["size"] = 9402,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Program"] = {
          ["size"] = 6295,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Slider"] = {
          ["size"] = 4676,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["size"] = 7769,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["TextBox"] = {
          ["size"] = 10904,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Button"] = {
          ["size"] = 1632,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BigFont"] = {
          ["size"] = 20670,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Table"] = {
          ["size"] = 7586,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["size"] = 17054,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Menu"] = {
          ["size"] = 4657,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["LineChart"] = {
          ["size"] = 2707,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BarChart"] = {
          ["size"] = 2635,
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["List"] = {
          ["size"] = 8684,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Display"] = {
          ["size"] = 3964,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["Dropdown"] = {
          ["size"] = 5941,
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Image"] = {
          ["size"] = 15102,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Label"] = {
          ["size"] = 3069,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Graph"] = {
          ["size"] = 5940,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["ProgressBar"] = {
          ["size"] = 2272,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["size"] = 14749,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["size"] = 12497,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["size"] = 6175,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["size"] = 9614,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["size"] = 5901,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["size"] = 6926,
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["size"] = 15224,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["size"] = 11100,
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["size"] = 10142,
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["size"] = 519,
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
}