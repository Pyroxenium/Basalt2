return {
  ["metadata"] = {
    ["generated"] = "Tue Feb 25 22:41:07 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 5885,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
        },
        ["state"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6389,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12515,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Scrollbar"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9166,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5896,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["TextBox"] = {
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10905,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4678,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4658,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2948,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 6593,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["description"] = "",
          ["size"] = 20332,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8302,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7589,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2273,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7887,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 8911,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 22866,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4291,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6295,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5248,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 7219,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 15984,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 10935,
          ["path"] = "render.lua",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7849,
          ["path"] = "main.lua",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 519,
          ["path"] = "init.lua",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15220,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["default"] = true,
          ["description"] = "",
          ["size"] = 880,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
  },
}