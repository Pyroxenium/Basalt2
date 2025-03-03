return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12515,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 6389,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 7848,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A text input field with various features",
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 13312,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 23180,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5896,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7885,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 8643,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20332,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 16876,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 2014,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "---@configDefault false",
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 10935,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 8158,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 519,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon Mar  3 16:38:57 2025",
    ["version"] = "2.0",
  },
}