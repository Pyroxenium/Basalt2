return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Feb 22 10:26:48 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["description"] = "",
          ["size"] = 3140,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6290,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 519,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 7781,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 10919,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15220,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 21693,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["Label"] = {
          ["description"] = "",
          ["size"] = 2848,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Button"] = {
          ["description"] = "Standard button element with click handling and state management",
          ["size"] = 1837,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["size"] = 2874,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Checkbox.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 8475,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt",
          ["size"] = 8969,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4465,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 2348,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["size"] = 7793,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Scrollbar.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 5589,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 7180,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 5188,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Frame"] = {
          ["description"] = "",
          ["size"] = 1053,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 5981,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Dropdown.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 14388,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8326,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 8976,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Flexbox"] = {
          ["description"] = "",
          ["size"] = 10132,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Flexbox.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable",
          ["size"] = 4823,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7284,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 880,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["description"] = "",
          ["size"] = 5867,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/state.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6175,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 6989,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["pluginTemplate"] = {
          ["description"] = "",
          ["size"] = 695,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/pluginTemplate.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 5879,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 6371,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12515,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 14116,
          ["default"] = true,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
      },
      ["description"] = "Plugins",
    },
  },
}