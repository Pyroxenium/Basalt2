return {
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Tree"] = {
          ["size"] = 7887,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["size"] = 4678,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["size"] = 7851,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["size"] = 9166,
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["size"] = 5896,
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Table"] = {
          ["size"] = 7589,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["size"] = 11766,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["size"] = 20332,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["size"] = 1632,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["size"] = 10905,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["size"] = 5868,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Menu"] = {
          ["size"] = 4658,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Frame"] = {
          ["size"] = 4435,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Label"] = {
          ["size"] = 2948,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["size"] = 6295,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["size"] = 8302,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["size"] = 22866,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["size"] = 11530,
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseElement"] = {
          ["size"] = 8911,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["Checkbox"] = {
          ["size"] = 2872,
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["size"] = 16878,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["ProgressBar"] = {
          ["size"] = 2273,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["size"] = 880,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["size"] = 519,
          ["default"] = true,
          ["path"] = "init.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["size"] = 7905,
          ["default"] = true,
          ["path"] = "main.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["size"] = 15225,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["render"] = {
          ["size"] = 10935,
          ["default"] = true,
          ["path"] = "render.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["reactive"] = {
          ["size"] = 6962,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["size"] = 14116,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["size"] = 5885,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["size"] = 12515,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["state"] = {
          ["size"] = 5867,
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["size"] = 6389,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["size"] = 6175,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Feb 26 23:42:11 2025",
    ["version"] = "2.0",
  },
}