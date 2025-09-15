return {
  ["metadata"] = {
    ["generated"] = "Mon Sep 15 08:45:49 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["size"] = 9940,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["size"] = 14085,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["size"] = 622,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["size"] = 25383,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21049,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 18564,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["FlexBox"] = {
          ["path"] = "elements/FlexBox.lua",
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["size"] = 7942,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["size"] = 11430,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 2928,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9665,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["size"] = 6359,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["size"] = 6508,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 14649,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["size"] = 12667,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["size"] = 8758,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9686,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["size"] = 15300,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["size"] = 16214,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
  },
}