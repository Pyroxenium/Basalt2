return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["size"] = 13484,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["size"] = 8619,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["size"] = 7873,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["size"] = 6775,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["size"] = 18421,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["size"] = 18186,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["size"] = 622,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["size"] = 19883,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["size"] = 15411,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["collectionentry"] = {
          ["path"] = "libraries/collectionentry.lua",
          ["description"] = "",
          ["size"] = 3551,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["size"] = 132,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["size"] = 846,
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7528,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 18961,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13718,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["size"] = 3590,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["FlexBox"] = {
          ["path"] = "elements/FlexBox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["size"] = 3227,
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2556,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["size"] = 3397,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 26177,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13859,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15436,
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
        },
        ["Collection"] = {
          ["path"] = "elements/Collection.lua",
          ["description"] = "A collection of items",
          ["size"] = 7703,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["size"] = 21649,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3763,
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "",
          ["size"] = 24453,
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
        },
        ["SideNav"] = {
          ["path"] = "elements/SideNav.lua",
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 20221,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 5071,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["size"] = 18817,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["ScrollFrame"] = {
          ["path"] = "elements/ScrollFrame.lua",
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 14559,
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["size"] = 11435,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Oct 29 17:18:09 2025",
    ["version"] = "2.0",
  },
}