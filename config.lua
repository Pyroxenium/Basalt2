return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["default"] = true,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 13312,
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["default"] = false,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["default"] = true,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8643,
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["default"] = true,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 23180,
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["default"] = true,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5896,
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 17105,
          ["default"] = true,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["default"] = true,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["default"] = true,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7885,
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 7997,
          ["default"] = true,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
          ["default"] = true,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["default"] = true,
        },
        ["Graph"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "---@configDefault false",
          ["path"] = "elements/Graph.lua",
          ["size"] = 2014,
          ["default"] = false,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20332,
          ["default"] = false,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 8158,
          ["default"] = true,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 10935,
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 519,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12515,
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 17405,
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["default"] = true,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["default"] = true,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon Mar  3 22:37:12 2025",
    ["version"] = "2.0",
  },
}