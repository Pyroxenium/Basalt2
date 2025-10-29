return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Oct 29 16:56:07 2025",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["reactive"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 13484,
          ["path"] = "plugins/xml.lua",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["BarChart"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3590,
          ["path"] = "elements/BarChart.lua",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 5071,
          ["path"] = "elements/Display.lua",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A collection of items",
          ["size"] = 7703,
          ["path"] = "elements/Collection.lua",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 18961,
          ["path"] = "elements/TabControl.lua",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 24453,
          ["path"] = "elements/Table.lua",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13859,
          ["path"] = "elements/BaseElement.lua",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13718,
          ["path"] = "elements/ComboBox.lua",
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7530,
          ["path"] = "elements/DropDown.lua",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3763,
          ["path"] = "elements/CheckBox.lua",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18817,
          ["path"] = "elements/Tree.lua",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 11435,
          ["path"] = "elements/Program.lua",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15436,
          ["path"] = "elements/List.lua",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 14559,
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 26177,
          ["path"] = "elements/Container.lua",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 20221,
          ["path"] = "elements/SideNav.lua",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2556,
          ["path"] = "elements/Button.lua",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 21649,
          ["path"] = "elements/BigFont.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 19883,
          ["path"] = "main.lua",
        },
      },
      ["description"] = "Core Files",
    },
  },
}