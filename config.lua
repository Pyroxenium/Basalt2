return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Feb 24 22:54:35 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7887,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2948,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5248,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 15495,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 6593,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4658,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 22610,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 6522,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 8488,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4678,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 2273,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["size"] = 2872,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 1103,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8302,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 7057,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["size"] = 9166,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Button"] = {
          ["description"] = "Standard button element with click handling and state management",
          ["size"] = 1719,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10905,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 7589,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5896,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["animation"] = {
          ["description"] = "",
          ["size"] = 14116,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["state"] = {
          ["description"] = "",
          ["size"] = 5867,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 6371,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6175,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 6962,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12515,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 5879,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["size"] = 880,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["description"] = "",
          ["size"] = 519,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6290,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15220,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 10919,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 7849,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
      },
    },
  },
}