return {
  ["metadata"] = {
    ["generated"] = "Tue Sep 30 17:23:24 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Display"] = {
          ["size"] = 5071,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["default"] = false,
        },
        ["Input"] = {
          ["size"] = 9558,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["size"] = 21649,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
        },
        ["FlexBox"] = {
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/FlexBox.lua",
          ["default"] = true,
        },
        ["Button"] = {
          ["size"] = 2540,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
          ["default"] = true,
        },
        ["List"] = {
          ["size"] = 8758,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["size"] = 9017,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 7942,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
        },
        ["Label"] = {
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["size"] = 10012,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
        },
        ["Table"] = {
          ["size"] = 16214,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["default"] = true,
        },
        ["Graph"] = {
          ["size"] = 6989,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["size"] = 22480,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
        },
        ["Program"] = {
          ["size"] = 11430,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["default"] = true,
        },
        ["DropDown"] = {
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
        },
        ["Frame"] = {
          ["size"] = 6508,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["size"] = 9665,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
        },
        ["Container"] = {
          ["size"] = 26148,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["size"] = 43466,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
        },
        ["Slider"] = {
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
        },
        ["Switch"] = {
          ["size"] = 3269,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["size"] = 3590,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
        },
        ["TabControl"] = {
          ["size"] = 15300,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
        },
        ["Image"] = {
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["size"] = 3731,
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["size"] = 15122,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["reactive"] = {
          ["size"] = 8619,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
        },
        ["theme"] = {
          ["size"] = 7042,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
        },
        ["xml"] = {
          ["size"] = 9940,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
        },
        ["state"] = {
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["default"] = true,
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
        },
        ["animation"] = {
          ["size"] = 18421,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
        },
        ["debug"] = {
          ["size"] = 6250,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
        },
        ["utils"] = {
          ["size"] = 2661,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["size"] = 14085,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
          ["default"] = true,
        },
        ["init"] = {
          ["size"] = 622,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
          ["default"] = true,
        },
        ["render"] = {
          ["size"] = 12422,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
  },
}