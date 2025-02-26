return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Feb 26 20:03:15 2025",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 6389,
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 6962,
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 5885,
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 14116,
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6175,
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12515,
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 5867,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 880,
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9166,
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 6295,
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 16878,
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7887,
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2948,
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20332,
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4678,
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2872,
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 11767,
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4658,
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 22866,
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5896,
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5868,
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4256,
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10905,
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 7589,
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1632,
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 7219,
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 8911,
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 2273,
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8302,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 10935,
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15225,
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 7905,
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 519,
        },
      },
    },
  },
}