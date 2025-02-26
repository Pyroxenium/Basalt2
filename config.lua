return {
  ["metadata"] = {
    ["generated"] = "Wed Feb 26 16:35:38 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["description"] = "",
          ["size"] = 5885,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["description"] = "",
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 6389,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12515,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 880,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7887,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 11767,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 7219,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4678,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2948,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 22866,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 7589,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5868,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8302,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 8911,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 20332,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 10905,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["description"] = "",
          ["size"] = 1632,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 6295,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5896,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["size"] = 9166,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 16878,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 11530,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 2273,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4658,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 4291,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["size"] = 2872,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15225,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 7905,
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 519,
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 10935,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
  },
}