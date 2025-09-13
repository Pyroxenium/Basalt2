return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Sep 13 20:28:48 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["main"] = {
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 14085,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 15524,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 622,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 6297,
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
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["path"] = "elements/Checkbox.lua",
          ["size"] = 2928,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["path"] = "elements/Scrollbar.lua",
          ["size"] = 9548,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["description"] = "",
          ["path"] = "elements/Button.lua",
          ["size"] = 1656,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 9558,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 16214,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["path"] = "elements/Dropdown.lua",
          ["size"] = 6359,
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/Flexbox.lua",
          ["size"] = 32431,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 12667,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Timer"] = {
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 8758,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 11430,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4243,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 7942,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 20951,
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 6508,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 14649,
          ["default"] = false,
          ["requires"] = {
            [1] = "Dropdown",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 25383,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["size"] = 15300,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8466,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3190,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 18564,
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 9686,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
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
        ["debug"] = {
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 7580,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 9940,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 7042,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["state"] = {
          ["description"] = "",
          ["path"] = "plugins/state.lua",
          ["size"] = 6896,
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
      },
    },
  },
}