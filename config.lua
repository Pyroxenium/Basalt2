return {
  ["metadata"] = {
    ["generated"] = "Mon Feb 24 22:13:54 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["expect"] = {
          ["size"] = 880,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["size"] = 5867,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["size"] = 6175,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["size"] = 12515,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["size"] = 6371,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["size"] = 5879,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["size"] = 14116,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["size"] = 6962,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Table"] = {
          ["size"] = 7673,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["List"] = {
          ["size"] = 8382,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Container"] = {
          ["size"] = 23200,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["ProgressBar"] = {
          ["size"] = 2348,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Frame"] = {
          ["size"] = 1147,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["BaseFrame"] = {
          ["size"] = 5212,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Input"] = {
          ["size"] = 7157,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Button"] = {
          ["size"] = 1846,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "Standard button element with click handling and state management",
        },
        ["Menu"] = {
          ["size"] = 4721,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Slider"] = {
          ["size"] = 4767,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["size"] = 11685,
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Program"] = {
          ["size"] = 6687,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["size"] = 8733,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Scrollbar"] = {
          ["size"] = 9281,
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Checkbox"] = {
          ["size"] = 2942,
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Image"] = {
          ["size"] = 5638,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["VisualElement"] = {
          ["size"] = 14506,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Label"] = {
          ["size"] = 2964,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Tree"] = {
          ["size"] = 7902,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["TextBox"] = {
          ["size"] = 10931,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Dropdown"] = {
          ["size"] = 5975,
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["size"] = 15220,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["size"] = 519,
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["size"] = 7849,
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["size"] = 10919,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["size"] = 6290,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
}