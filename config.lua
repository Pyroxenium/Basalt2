return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 7905,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 519,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15225,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 10935,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 7848,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 16876,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 2272,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 4435,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 8911,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 5868,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2872,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 10904,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 8300,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1632,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 7586,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 23180,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 13262,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20332,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9164,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7885,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4657,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 5896,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 6295,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3069,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4676,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 11530,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 6389,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12515,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 6962,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 14116,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 5885,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6175,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 5867,
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["generated"] = "Sun Mar  2 21:04:18 2025",
    ["version"] = "2.0",
  },
}