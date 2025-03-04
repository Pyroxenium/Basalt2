return {
  ["metadata"] = {
    ["generated"] = "Mon Mar  3 22:44:55 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5896,
          ["default"] = false,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 23180,
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4657,
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2272,
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 5868,
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7885,
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9164,
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["default"] = true,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7586,
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20332,
          ["default"] = false,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8643,
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7997,
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3069,
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 13312,
          ["default"] = false,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4676,
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4435,
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10904,
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 17105,
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 8911,
          ["default"] = true,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "---@configDefault false",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2014,
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 5867,
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6962,
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 14116,
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 12515,
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 17568,
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 5885,
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6175,
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 10935,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15225,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 519,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 8158,
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
  },
}