return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7042,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6250,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9940,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
        },
        ["canvas"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7873,
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7580,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18421,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
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
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["BarChart"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3590,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7942,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43466,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2540,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15300,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
        },
        ["Switch"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 22480,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5071,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3227,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 10012,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21649,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15122,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3731,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25963,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
        },
        ["Timer"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
        },
        ["FlexBox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/FlexBox.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15524,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 14085,
          ["description"] = "",
          ["path"] = "main.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["description"] = "",
          ["path"] = "log.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["description"] = "",
          ["path"] = "errorManager.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6297,
          ["description"] = "",
          ["path"] = "elementManager.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 622,
          ["description"] = "",
          ["path"] = "init.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
          ["description"] = "",
          ["path"] = "render.lua",
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Tue Sep 30 12:42:47 2025",
    ["version"] = "2.0",
  },
}