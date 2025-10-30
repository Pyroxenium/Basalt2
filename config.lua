return {
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 18186,
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 19883,
        },
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 622,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
        ["collectionentry"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 14042,
        },
        ["theme"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 6775,
        },
        ["reactive"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11028,
        },
        ["debug"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
        },
        ["benchmark"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
        },
        ["animation"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
        },
        ["canvas"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 43389,
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 6513,
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9665,
        },
        ["Switch"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 13859,
        },
        ["FlexBox"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/FlexBox.lua",
          ["size"] = 32404,
        },
        ["Tree"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 18817,
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 8582,
        },
        ["Program"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 11435,
        },
        ["SideNav"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["path"] = "elements/SideNav.lua",
          ["size"] = 20221,
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 43530,
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 13613,
        },
        ["TabControl"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["size"] = 18961,
        },
        ["Image"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["size"] = 15125,
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
        },
        ["LineChart"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3171,
        },
        ["Collection"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["path"] = "elements/Collection.lua",
          ["size"] = 7703,
        },
        ["Slider"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
        },
        ["BarChart"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3507,
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3398,
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 6933,
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
          ["size"] = 2437,
        },
        ["ScrollFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 14559,
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 9017,
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4945,
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3700,
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 15463,
        },
        ["Timer"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 9200,
        },
        ["DropDown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
          ["size"] = 7645,
        },
        ["Table"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["size"] = 24453,
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 26177,
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21551,
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Thu Oct 30 07:14:28 2025",
    ["version"] = "2.0",
  },
}