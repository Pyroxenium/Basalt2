return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 7849,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15220,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 519,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 10935,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 14116,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 6962,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 5867,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6175,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 5885,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 6389,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12515,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 880,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8302,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 7589,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5248,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10905,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 15984,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 2273,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 7219,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4678,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4658,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 8488,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9166,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 6593,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7887,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4291,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2948,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20332,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 22866,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5896,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Feb 25 22:29:23 2025",
  },
}