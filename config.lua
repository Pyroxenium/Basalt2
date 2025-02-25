return {
  ["metadata"] = {
    ["generated"] = "Tue Feb 25 08:09:59 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 10905,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["size"] = 7589,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["size"] = 5896,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 5248,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 15495,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 8302,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["size"] = 6593,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 2948,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["size"] = 9166,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 4658,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 8488,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 2273,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 1103,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["size"] = 6522,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 7057,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["size"] = 7887,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["default"] = true,
          ["size"] = 4678,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 22610,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["default"] = true,
          ["size"] = 10919,
          ["path"] = "render.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 519,
          ["path"] = "init.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 6290,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 15220,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 7849,
          ["path"] = "main.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["size"] = 880,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["default"] = true,
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["default"] = true,
          ["size"] = 6389,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["state"] = {
          ["default"] = true,
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["default"] = true,
          ["size"] = 5885,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["default"] = true,
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = true,
          ["size"] = 12515,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
  },
}