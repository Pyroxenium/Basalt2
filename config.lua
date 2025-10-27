return {
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 9940,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["debug"] = {
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 6775,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["reactive"] = {
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 8619,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["canvas"] = {
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Slider"] = {
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 4679,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 13859,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3227,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3763,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
          ["size"] = 8100,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6989,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 43530,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 9017,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
          ["size"] = 2556,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Table"] = {
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 16214,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9665,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 9200,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["size"] = 18961,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 26177,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 43326,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Tree"] = {
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 8519,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 13718,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 5071,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Timer"] = {
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 6508,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["FlexBox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/FlexBox.lua",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 6039,
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["path"] = "elements/SideNav.lua",
          ["size"] = 20221,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["path"] = "elements/Collection.lua",
          ["size"] = 6008,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3590,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 11435,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21649,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 18186,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 622,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 19883,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Oct 27 07:26:27 2025",
  },
}