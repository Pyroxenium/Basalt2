return {
  ["metadata"] = {
    ["generated"] = "Sun Sep 14 10:11:33 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 6297,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 622,
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 14085,
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 12422,
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 15524,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
        },
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15300,
        },
        ["Checkbox"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Checkbox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12667,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["size"] = 6989,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 9686,
        },
        ["Button"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 18564,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21049,
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
        },
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["size"] = 3190,
        },
        ["Dropdown"] = {
          ["description"] = "A dropdown menu that shows a list of selectable items",
          ["default"] = false,
          ["path"] = "elements/Dropdown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7942,
        },
        ["Timer"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
        },
        ["Scrollbar"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Scrollbar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9548,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
        },
        ["Flexbox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["path"] = "elements/Flexbox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "Dropdown",
          },
          ["size"] = 14649,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["size"] = 3227,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25383,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
        },
        ["state"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/state.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6250,
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 18421,
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 7042,
        },
        ["canvas"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["size"] = 7873,
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 9940,
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 7580,
        },
      },
    },
  },
}