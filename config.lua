return {
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["size"] = 14085,
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["size"] = 622,
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
          ["default"] = true,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
          ["description"] = "",
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["description"] = "",
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["description"] = "",
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["size"] = 8619,
          ["description"] = "",
          ["default"] = true,
        },
        ["state"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["description"] = "",
          ["default"] = true,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["description"] = "",
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["size"] = 9940,
          ["description"] = "",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["LineChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["description"] = "",
          ["default"] = false,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["description"] = "",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["description"] = "",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21649,
          ["description"] = "",
          ["default"] = false,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["size"] = 5071,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9665,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = true,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["size"] = 2540,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 15122,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["size"] = 7942,
          ["description"] = "",
          ["default"] = true,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
          ["size"] = 8758,
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3731,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
          ["size"] = 15348,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = true,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["size"] = 6508,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["size"] = 43466,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/FlexBox.lua",
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 22480,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 9017,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["size"] = 26148,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3590,
          ["description"] = "",
          ["default"] = true,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["description"] = "",
          ["default"] = true,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["size"] = 11430,
          ["description"] = "",
          ["default"] = true,
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
          ["size"] = 7642,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
          ["size"] = 16214,
          ["description"] = "",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 10012,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["generated"] = "Fri Oct  3 01:26:34 2025",
    ["version"] = "2.0",
  },
}