return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
        },
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 880,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 14116,
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 6389,
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 6962,
        },
        ["state"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
          },
          ["size"] = 5867,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
          },
          ["size"] = 12515,
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 5885,
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6175,
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 519,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 7905,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 6297,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 15225,
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 10935,
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11767,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 5868,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10905,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2872,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 20332,
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7887,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8302,
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 6295,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5896,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 8911,
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7589,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22866,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2273,
        },
        ["Button"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1632,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7219,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2948,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9166,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4658,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 4291,
        },
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4678,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 16878,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 11530,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Feb 26 16:58:12 2025",
    ["version"] = "2.0",
  },
}