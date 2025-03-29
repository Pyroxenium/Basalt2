return {
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["TextBox"] = {
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 7769,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 23194,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 3964,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 7586,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8684,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 8358,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 5940,
          ["requires"] = {
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5941,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 17054,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7919,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20670,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9402,
          ["requires"] = {
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15102,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 2272,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 2707,
          ["requires"] = {
          },
        },
        ["Slider"] = {
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 2635,
          ["requires"] = {
          },
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 14749,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9901,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 5901,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 6962,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12497,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6175,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6926,
          ["requires"] = {
            [1] = "Container",
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["default"] = true,
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 10255,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15224,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["default"] = true,
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 11100,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["default"] = true,
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["default"] = true,
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 519,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Mar 29 02:47:28 2025",
  },
}