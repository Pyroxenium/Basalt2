return {
  ["metadata"] = {
    ["generated"] = "Sun Sep 28 13:05:58 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 14085,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6297,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15524,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 622,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8758,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 9558,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43466,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 11430,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 18564,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = true,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3227,
          ["requires"] = {
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3190,
          ["requires"] = {
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["requires"] = {
          },
        },
        ["FlexBox"] = {
          ["path"] = "elements/FlexBox.lua",
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 16214,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 21049,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 14649,
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7942,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 15300,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2928,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 1656,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9686,
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25383,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7873,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7042,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7580,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 9940,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18421,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
  },
}