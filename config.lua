return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Sep 29 18:10:08 2025",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["DropDown"] = {
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["path"] = "elements/DropDown.lua",
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
        ["TextBox"] = {
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43466,
          ["path"] = "elements/TextBox.lua",
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
        ["Menu"] = {
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
        },
        ["Display"] = {
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
        },
        ["Container"] = {
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25383,
          ["path"] = "elements/Container.lua",
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
        ["Label"] = {
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
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
        ["BigFont"] = {
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21049,
          ["path"] = "elements/BigFont.lua",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 14649,
          ["path"] = "elements/ComboBox.lua",
        },
        ["List"] = {
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
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
        ["BarChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
        },
        ["Button"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 9686,
          ["path"] = "elements/BaseElement.lua",
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
        ["ScrollBar"] = {
          ["default"] = true,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
        },
        ["Tree"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7942,
          ["path"] = "elements/Tree.lua",
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
        ["CheckBox"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
          ["path"] = "elements/CheckBox.lua",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
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
        ["ProgressBar"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
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
        ["Timer"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["Graph"] = {
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15300,
          ["path"] = "elements/TabControl.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["main"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 14085,
          ["path"] = "main.lua",
        },
        ["log"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
        },
        ["init"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
        },
        ["reactive"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7580,
          ["path"] = "plugins/reactive.lua",
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
        ["xml"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
        },
        ["state"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
        },
        ["canvas"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["debug"] = {
          ["default"] = true,
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
      },
      ["description"] = "Plugins",
    },
  },
}