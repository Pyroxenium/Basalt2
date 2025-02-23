return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Feb 23 11:20:35 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4465,
        },
        ["Label"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2848,
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7284,
        },
        ["Button"] = {
          ["description"] = "Standard button element with click handling and state management",
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1837,
        },
        ["Flexbox"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10132,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable",
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4714,
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5589,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2874,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 14456,
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8475,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7180,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 5188,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8976,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21768,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7793,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 5976,
        },
        ["Frame"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 1053,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt",
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 8969,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2348,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8413,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["state"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
          },
          ["size"] = 5867,
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 6371,
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 14116,
        },
        ["pluginTemplate"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/pluginTemplate.lua",
          ["requires"] = {
          },
          ["size"] = 695,
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 6989,
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
          ["size"] = 5879,
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
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 15220,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 6290,
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 10919,
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 519,
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 7849,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
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
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
        },
      },
    },
  },
}