return {
  ["metadata"] = {
    ["generated"] = "Sun Sep 14 08:55:42 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Dropdown"] = {
          ["size"] = 6359,
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Input"] = {
          ["size"] = 9558,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Flexbox"] = {
          ["size"] = 32431,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Frame"] = {
          ["size"] = 6508,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["List"] = {
          ["size"] = 8758,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["size"] = 11430,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["size"] = 12667,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["size"] = 3190,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["ProgressBar"] = {
          ["size"] = 3397,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["size"] = 1656,
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["size"] = 20945,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseFrame"] = {
          ["size"] = 8466,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["LineChart"] = {
          ["size"] = 3227,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Tree"] = {
          ["size"] = 7942,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["size"] = 9548,
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["size"] = 16214,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Checkbox"] = {
          ["size"] = 2928,
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["size"] = 18564,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseElement"] = {
          ["size"] = 9686,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["ComboBox"] = {
          ["size"] = 14649,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "Dropdown",
          },
        },
        ["Timer"] = {
          ["size"] = 2914,
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Slider"] = {
          ["size"] = 4977,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["size"] = 4243,
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["size"] = 4679,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Graph"] = {
          ["size"] = 6989,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Switch"] = {
          ["size"] = 3269,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["size"] = 15125,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["size"] = 15300,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["size"] = 25383,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["size"] = 2661,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["size"] = 12581,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["debug"] = {
          ["size"] = 6250,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["size"] = 6896,
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["animation"] = {
          ["size"] = 18421,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["size"] = 7873,
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["size"] = 7580,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["size"] = 7042,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["size"] = 9940,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["size"] = 622,
          ["description"] = "",
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["size"] = 6297,
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["size"] = 15524,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["size"] = 3142,
          ["description"] = "",
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["size"] = 14085,
          ["description"] = "",
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["size"] = 12422,
          ["description"] = "",
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
  },
}