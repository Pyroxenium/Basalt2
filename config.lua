return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 16878,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9166,
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5896,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["size"] = 7219,
          ["description"] = "A text input field with various features",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["size"] = 4291,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["size"] = 22866,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["size"] = 7589,
          ["description"] = "",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10905,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2273,
          ["description"] = "",
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["description"] = "",
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["size"] = 2948,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["description"] = "",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["size"] = 8302,
          ["description"] = "A scrollable list of selectable items",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20332,
          ["description"] = "",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["size"] = 4658,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["size"] = 4678,
          ["description"] = "",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["description"] = "",
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["size"] = 11767,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["size"] = 7887,
          ["description"] = "",
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
          ["size"] = 880,
          ["description"] = "",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["description"] = "",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12515,
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["size"] = 6389,
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["description"] = "",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["description"] = "",
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["size"] = 7905,
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["size"] = 10935,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["size"] = 519,
          ["description"] = "",
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Feb 26 19:24:43 2025",
    ["version"] = "2.0",
  },
}