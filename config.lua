return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Sep 13 10:43:02 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 6297,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 622,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 15524,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 14085,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4977,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["size"] = 6359,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8466,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "",
          ["size"] = 1656,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 11430,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["size"] = 2914,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 18564,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 7941,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 9686,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 3227,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["size"] = 4243,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 12667,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 9558,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 16214,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
          ["size"] = 2928,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 3397,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 3190,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 14649,
          ["default"] = false,
          ["requires"] = {
            [1] = "Dropdown",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
          ["size"] = 9548,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 8758,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 15300,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 20951,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25383,
          ["default"] = true,
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
          ["description"] = "",
          ["size"] = 7873,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 7580,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["path"] = "plugins/state.lua",
          ["description"] = "",
          ["size"] = 6896,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6250,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12581,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 18421,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 9940,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 7042,
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
  },
}