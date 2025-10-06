return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["animation"] = {
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["size"] = 622,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["render"] = {
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["size"] = 14085,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["CheckBox"] = {
          ["size"] = 3731,
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Slider"] = {
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Program"] = {
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 8457,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["size"] = 10012,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Image"] = {
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["FlexBox"] = {
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["BarChart"] = {
          ["size"] = 3590,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["size"] = 15122,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["TabControl"] = {
          ["size"] = 18889,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = true,
        },
        ["Container"] = {
          ["size"] = 26148,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["DropDown"] = {
          ["size"] = 7642,
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Label"] = {
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["List"] = {
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["Switch"] = {
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = true,
        },
        ["Table"] = {
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = true,
        },
        ["Frame"] = {
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["size"] = 21649,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Button"] = {
          ["size"] = 2540,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
        },
        ["Input"] = {
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Display"] = {
          ["size"] = 5071,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
        },
        ["Graph"] = {
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["size"] = 22480,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["size"] = 43466,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Oct  6 22:16:11 2025",
  },
}