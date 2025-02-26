return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Feb 26 09:20:12 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 6297,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 15220,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 519,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 7905,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 10935,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 5542,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 2273,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["size"] = 4678,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 2948,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
        },
        ["Image"] = {
          ["default"] = false,
          ["size"] = 7894,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["size"] = 6295,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 4658,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 4291,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["size"] = 9166,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 7219,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["size"] = 11530,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 16549,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["size"] = 7887,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["size"] = 7589,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 1632,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Button.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 10905,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["size"] = 2872,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 8911,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 8302,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 22866,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["size"] = 20332,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["size"] = 5896,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["size"] = 880,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["default"] = true,
          ["size"] = 6389,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["size"] = 6962,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["size"] = 14116,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["size"] = 5867,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["size"] = 6175,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["size"] = 12515,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
        },
        ["theme"] = {
          ["default"] = true,
          ["size"] = 5885,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
        },
      },
    },
  },
}