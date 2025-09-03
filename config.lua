return {
  ["metadata"] = {
    ["generated"] = "Wed Sep  3 16:27:36 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["size"] = 14085,
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["BarChart"] = {
          ["size"] = 3190,
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Container"] = {
          ["size"] = 25383,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Program"] = {
          ["size"] = 11430,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Input"] = {
          ["size"] = 9558,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["TextBox"] = {
          ["size"] = 12667,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["List"] = {
          ["size"] = 8758,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["Flexbox"] = {
          ["size"] = 32431,
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Tree"] = {
          ["size"] = 7941,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Display"] = {
          ["size"] = 4243,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["Switch"] = {
          ["size"] = 3269,
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["Scrollbar"] = {
          ["size"] = 9548,
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Frame"] = {
          ["size"] = 6508,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Slider"] = {
          ["size"] = 4977,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Image"] = {
          ["size"] = 15125,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["TabControl"] = {
          ["size"] = 15300,
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Table"] = {
          ["size"] = 16214,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BigFont"] = {
          ["size"] = 20951,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["VisualElement"] = {
          ["size"] = 18564,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Label"] = {
          ["size"] = 3092,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["BaseElement"] = {
          ["size"] = 9686,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Button"] = {
          ["size"] = 1656,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["ComboBox"] = {
          ["size"] = 14649,
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "Dropdown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
        },
        ["Dropdown"] = {
          ["size"] = 6359,
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A dropdown menu that shows a list of selectable items",
        },
        ["Checkbox"] = {
          ["size"] = 2928,
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Graph"] = {
          ["size"] = 6989,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["size"] = 9940,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["size"] = 12581,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["state"] = {
          ["size"] = 6896,
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["size"] = 7042,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["size"] = 18421,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["size"] = 7580,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["size"] = 6250,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
  },
}