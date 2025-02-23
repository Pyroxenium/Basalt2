return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Feb 23 10:12:02 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Label"] = {
          ["default"] = true,
          ["size"] = 2848,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["description"] = "",
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 21768,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 4714,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 8969,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["size"] = 7793,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 8976,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 2348,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 5188,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Table"] = {
          ["default"] = true,
          ["size"] = 8475,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["description"] = "",
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 1053,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["description"] = "",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["size"] = 10132,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "",
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 8413,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
        },
        ["Tree"] = {
          ["default"] = true,
          ["size"] = 7284,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 14456,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 1837,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["description"] = "Standard button element with click handling and state management",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["size"] = 5976,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["size"] = 2874,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
        },
        ["Slider"] = {
          ["default"] = true,
          ["size"] = 4465,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
        },
        ["Program"] = {
          ["default"] = true,
          ["size"] = 5589,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["description"] = "",
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 7180,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 6290,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["description"] = "",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 7849,
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 10919,
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["description"] = "",
        },
        ["log"] = {
          ["default"] = true,
          ["size"] = 3140,
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 15220,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 519,
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["description"] = "",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
        },
        ["expect"] = {
          ["default"] = true,
          ["size"] = 880,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["state"] = {
          ["default"] = true,
          ["size"] = 5867,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["size"] = 12515,
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = true,
          ["size"] = 14116,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = true,
          ["size"] = 6371,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["size"] = 6989,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
        },
        ["pluginTemplate"] = {
          ["default"] = true,
          ["size"] = 695,
          ["requires"] = {
          },
          ["path"] = "plugins/pluginTemplate.lua",
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = true,
          ["size"] = 5879,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
        },
        ["debug"] = {
          ["default"] = true,
          ["size"] = 6175,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
        },
      },
    },
  },
}