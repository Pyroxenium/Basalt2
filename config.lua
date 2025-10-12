return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Oct  9 20:17:02 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Display"] = {
          ["default"] = false,
          ["size"] = 5071,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
        },
        ["Slider"] = {
          ["default"] = true,
          ["size"] = 4977,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["size"] = 18961,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 26148,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["size"] = 9665,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 43466,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Timer"] = {
          ["default"] = true,
          ["size"] = 2914,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["size"] = 3227,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["size"] = 7642,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["size"] = 15122,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 3397,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 9017,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Program"] = {
          ["default"] = true,
          ["size"] = 11430,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["size"] = 3731,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 22480,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["Table"] = {
          ["default"] = true,
          ["size"] = 16214,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Table.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 8758,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/List.lua",
        },
        ["BarChart"] = {
          ["default"] = true,
          ["size"] = 3590,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["Image"] = {
          ["default"] = false,
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 10012,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 6508,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["size"] = 8457,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 2540,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["Switch"] = {
          ["default"] = true,
          ["size"] = 3269,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["SideNav"] = {
          ["default"] = true,
          ["size"] = 20451,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/SideNav.lua",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["size"] = 21649,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["FlexBox"] = {
          ["default"] = true,
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/FlexBox.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["default"] = true,
          ["size"] = 6250,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["size"] = 12581,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["size"] = 6896,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/state.lua",
        },
        ["theme"] = {
          ["default"] = true,
          ["size"] = 7042,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["default"] = true,
          ["size"] = 9940,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["size"] = 8619,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["animation"] = {
          ["default"] = true,
          ["size"] = 18421,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["canvas"] = {
          ["default"] = true,
          ["size"] = 7873,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["size"] = 846,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 15524,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 12422,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 622,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 14085,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 6297,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
      },
      ["description"] = "Core Files",
    },
  },
}