return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 6962,
          ["default"] = true,
          ["description"] = "",
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 14116,
          ["default"] = true,
          ["description"] = "",
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 5885,
          ["default"] = true,
          ["description"] = "",
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["requires"] = {
          },
          ["size"] = 5867,
          ["default"] = true,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
          },
          ["size"] = 12515,
          ["default"] = true,
          ["description"] = "",
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6175,
          ["default"] = true,
          ["description"] = "",
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 6389,
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5896,
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 5868,
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7219,
          ["default"] = true,
          ["description"] = "A text input field with various features",
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10905,
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7589,
          ["default"] = true,
          ["description"] = "",
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7887,
          ["default"] = true,
          ["description"] = "",
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8302,
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9166,
          ["default"] = true,
          ["description"] = "",
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7894,
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2948,
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 8911,
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2273,
          ["default"] = true,
          ["description"] = "",
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20332,
          ["default"] = false,
          ["description"] = "",
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4291,
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4658,
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4678,
          ["default"] = true,
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
          ["default"] = true,
          ["description"] = "",
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
          ["default"] = true,
          ["description"] = "",
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22866,
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 16878,
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
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
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
          ["description"] = "",
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 7905,
          ["default"] = true,
          ["description"] = "",
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 519,
          ["default"] = true,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
          ["description"] = "",
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 10935,
          ["default"] = true,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["default"] = true,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 15220,
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 880,
          ["default"] = true,
          ["description"] = "",
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
          ["description"] = "",
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
          ["description"] = "",
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Feb 26 13:51:23 2025",
    ["version"] = "2.0",
  },
}