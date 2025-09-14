return {
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7580,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
        },
        ["state"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/state.lua",
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7042,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Checkbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2928,
          ["path"] = "elements/Checkbox.lua",
          ["description"] = "",
        },
        ["Dropdown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 6359,
          ["path"] = "elements/Dropdown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7942,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
        },
        ["Timer"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
        },
        ["Switch"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 1656,
          ["path"] = "elements/Button.lua",
          ["description"] = "",
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8466,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Dropdown",
          },
          ["size"] = 14653,
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 18564,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9558,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 9686,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21049,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12667,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15300,
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Scrollbar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9548,
          ["path"] = "elements/Scrollbar.lua",
          ["description"] = "",
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4243,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the cc window API which you can use.",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11430,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Flexbox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32431,
          ["path"] = "elements/Flexbox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8758,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25383,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
        },
        ["BarChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3190,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15524,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 14085,
          ["path"] = "main.lua",
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
          ["description"] = "",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6297,
          ["path"] = "elementManager.lua",
          ["description"] = "",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["description"] = "",
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Sep 14 10:20:10 2025",
  },
}