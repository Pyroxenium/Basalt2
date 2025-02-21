return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Feb 21 18:26:34 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "init.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "render.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "main.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "errorManager.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "log.lua",
        },
        ["LuaLS"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "LuaLS.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "propertySystem.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["state"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/state.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
        },
        ["pluginTemplate"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "plugins/pluginTemplate.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Frame"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Input.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Container.lua",
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Program.lua",
        },
        ["Flexbox"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/List.lua",
        },
        ["Label"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Label.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Table.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Button"] = {
          ["description"] = "Standard button element with click handling and state management",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Button.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
        },
      },
    },
  },
}