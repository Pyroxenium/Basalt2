return {
  ["metadata"] = {
    ["generated"] = "Mon Feb 24 19:52:36 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["pluginTemplate"] = {
          ["size"] = 695,
          ["requires"] = {
          },
          ["path"] = "plugins/pluginTemplate.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["xml"] = {
          ["size"] = 6371,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["size"] = 12515,
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["state"] = {
          ["size"] = 5867,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["theme"] = {
          ["size"] = 5879,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["animation"] = {
          ["size"] = 14116,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["debug"] = {
          ["size"] = 6175,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["reactive"] = {
          ["size"] = 6989,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["expect"] = {
          ["size"] = 880,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["BaseElement"] = {
          ["size"] = 8733,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Slider"] = {
          ["size"] = 4767,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Menu"] = {
          ["size"] = 4721,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Flexbox"] = {
          ["size"] = 11685,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["VisualElement"] = {
          ["size"] = 14506,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Frame"] = {
          ["size"] = 1147,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Tree"] = {
          ["size"] = 7902,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Input"] = {
          ["size"] = 7157,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
        },
        ["Checkbox"] = {
          ["size"] = 2942,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Label"] = {
          ["size"] = 2964,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Image"] = {
          ["size"] = 5638,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
        },
        ["ProgressBar"] = {
          ["size"] = 2348,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["TextBox"] = {
          ["size"] = 10931,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Program"] = {
          ["size"] = 6687,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Dropdown"] = {
          ["size"] = 5975,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["List"] = {
          ["size"] = 8382,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
        },
        ["Container"] = {
          ["size"] = 23200,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Table"] = {
          ["size"] = 7673,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Button"] = {
          ["size"] = 1846,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "Standard button element with click handling and state management",
        },
        ["BaseFrame"] = {
          ["size"] = 5212,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Scrollbar"] = {
          ["size"] = 9281,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["size"] = 7849,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["render"] = {
          ["size"] = 10919,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["init"] = {
          ["size"] = 519,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["size"] = 6290,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["log"] = {
          ["size"] = 3142,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["size"] = 15220,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
}