return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["default"] = true,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 10935,
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 519,
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 7905,
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 880,
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 23026,
          ["default"] = true,
        },
        ["Dropdown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5896,
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["default"] = true,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4658,
          ["default"] = true,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 2948,
          ["default"] = true,
        },
        ["Flexbox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["default"] = true,
        },
        ["Checkbox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["default"] = true,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2273,
          ["default"] = true,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7887,
          ["default"] = true,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 7589,
          ["default"] = true,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4678,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10905,
          ["default"] = false,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 11766,
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 7851,
          ["default"] = true,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["default"] = true,
        },
        ["Scrollbar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9166,
          ["default"] = true,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20332,
          ["default"] = false,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["default"] = true,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8302,
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 16878,
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12515,
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["default"] = true,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 6389,
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["generated"] = "Fri Feb 28 09:18:43 2025",
    ["version"] = "2.0",
  },
}