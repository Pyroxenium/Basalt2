return {
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
        },
        ["LuaLS"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "LuaLS.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Label.lua",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable",
          ["path"] = "elements/Menu.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["path"] = "elements/Flexbox.lua",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Input.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
        },
        ["pluginTemplate"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/pluginTemplate.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["path"] = "elements/Frame.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "Standard button element with click handling and state management",
          ["path"] = "elements/Button.lua",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt",
          ["path"] = "elements/BaseElement.lua",
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Feb 21 17:46:32 2025",
  },
}