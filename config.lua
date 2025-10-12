return {
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["default"] = true,
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["default"] = true,
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = true,
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = true,
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["default"] = true,
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["state"] = {
          ["default"] = true,
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 622,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 14085,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["expect"] = {
          ["default"] = true,
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["SideNav"] = {
          ["default"] = true,
          ["size"] = 20221,
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Slider"] = {
          ["default"] = true,
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 22428,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Timer"] = {
          ["default"] = true,
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
        },
        ["FlexBox"] = {
          ["default"] = true,
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 26148,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Image"] = {
          ["default"] = false,
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Graph"] = {
          ["default"] = false,
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["size"] = 18961,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Display"] = {
          ["default"] = false,
          ["size"] = 5071,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 43466,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Program"] = {
          ["default"] = true,
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["size"] = 3731,
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["size"] = 15122,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["Table"] = {
          ["default"] = true,
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 10012,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 2540,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["Switch"] = {
          ["default"] = true,
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["Tree"] = {
          ["default"] = true,
          ["size"] = 8519,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["size"] = 7642,
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["BarChart"] = {
          ["default"] = true,
          ["size"] = 3590,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["size"] = 21649,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Oct 12 20:37:36 2025",
  },
}