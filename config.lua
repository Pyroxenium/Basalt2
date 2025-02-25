return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["size"] = 2661,
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["size"] = 880,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["size"] = 132,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["size"] = 5885,
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["size"] = 6389,
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["size"] = 6175,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["size"] = 12515,
        },
        ["state"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["size"] = 5867,
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["size"] = 14116,
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["size"] = 6962,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["size"] = 7057,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["size"] = 8488,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["size"] = 4658,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["size"] = 5248,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["size"] = 22610,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["size"] = 6593,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["size"] = 11530,
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["size"] = 7887,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["size"] = 8302,
        },
        ["Slider"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["size"] = 4678,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["size"] = 5896,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["size"] = 2948,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["size"] = 10905,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["size"] = 15495,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["size"] = 2872,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["size"] = 9166,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["size"] = 1103,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["size"] = 2273,
        },
        ["Table"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["size"] = 7589,
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["size"] = 6522,
        },
        ["Button"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["size"] = 1632,
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
          ["size"] = 519,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["size"] = 15220,
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
          ["size"] = 7849,
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
          ["size"] = 3142,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["size"] = 3789,
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
          ["size"] = 10919,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["size"] = 6297,
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Feb 25 09:08:36 2025",
  },
}