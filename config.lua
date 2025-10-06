return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 9940,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6250,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7873,
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 7042,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 18421,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 8619,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["default"] = true,
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 10012,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 18897,
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3590,
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 22480,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3227,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21649,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7642,
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5071,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8457,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["default"] = true,
          ["path"] = "elements/FlexBox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["size"] = 3731,
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2540,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15122,
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 26148,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 6989,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43466,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 14085,
          ["default"] = true,
          ["path"] = "main.lua",
          ["description"] = "",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 15524,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["size"] = 6297,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["description"] = "",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
          ["description"] = "",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Oct  6 22:21:30 2025",
  },
}