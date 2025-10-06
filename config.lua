return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Oct  6 19:46:10 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["state"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
        ["canvas"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["theme"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["List"] = {
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21649,
          ["path"] = "elements/BigFont.lua",
        },
        ["FlexBox"] = {
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43466,
          ["path"] = "elements/TextBox.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 22480,
          ["path"] = "elements/VisualElement.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7642,
          ["path"] = "elements/DropDown.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
        },
        ["Display"] = {
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5071,
          ["path"] = "elements/Display.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 26148,
          ["path"] = "elements/Container.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2540,
          ["path"] = "elements/Button.lua",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15348,
          ["path"] = "elements/TabControl.lua",
        },
        ["Image"] = {
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 10012,
          ["path"] = "elements/BaseElement.lua",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["size"] = 3731,
          ["path"] = "elements/CheckBox.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8457,
          ["path"] = "elements/Tree.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15122,
          ["path"] = "elements/ComboBox.lua",
        },
        ["Switch"] = {
          ["default"] = true,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Timer"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["BarChart"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3590,
          ["path"] = "elements/BarChart.lua",
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 14085,
          ["path"] = "main.lua",
        },
      },
      ["description"] = "Core Files",
    },
  },
}