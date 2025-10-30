return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 18421,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6250,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 11028,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 6775,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 13484,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7873,
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 14559,
          ["default"] = true,
          ["path"] = "elements/ScrollFrame.lua",
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 18817,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["description"] = "An element that displays an image in bimg format",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 24453,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["description"] = "",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 20221,
          ["default"] = true,
          ["path"] = "elements/SideNav.lua",
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7645,
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3398,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 26177,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["default"] = true,
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 18961,
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8582,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2437,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["size"] = 3700,
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4945,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43530,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 6933,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3171,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 13613,
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11435,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15436,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21551,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32404,
          ["default"] = true,
          ["path"] = "elements/FlexBox.lua",
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 13859,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3507,
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 43389,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9200,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7703,
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
          ["description"] = "A collection of items",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["description"] = "",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["size"] = 3551,
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
          ["description"] = "",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 19883,
          ["default"] = true,
          ["path"] = "main.lua",
          ["description"] = "",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
          ["description"] = "",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 18186,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["size"] = 15411,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["description"] = "",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["description"] = "",
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Oct 30 06:33:27 2025",
  },
}