return {
  ["metadata"] = {
    ["generated"] = "Mon Oct  6 22:22:23 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 14085,
          ["path"] = "main.lua",
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
          ["description"] = "",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["description"] = "",
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["description"] = "",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
        },
        ["canvas"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 10012,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
        },
        ["BarChart"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3590,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
        },
        ["Switch"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 22480,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["FlexBox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 26148,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3731,
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15122,
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43466,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21649,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8457,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2540,
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 18923,
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7642,
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5071,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Timer"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
        },
      },
    },
  },
}