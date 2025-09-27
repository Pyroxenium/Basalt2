return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Sep 27 20:42:39 2025",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["description"] = "",
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 7580,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 15300,
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25383,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["FlexBox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 7942,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 18564,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["description"] = "",
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Timer"] = {
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["CheckBox"] = {
          ["description"] = "",
          ["size"] = 2928,
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 21049,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9686,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 38993,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 14649,
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 14085,
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 622,
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
  },
}