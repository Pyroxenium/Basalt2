return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Oct 30 07:43:35 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["size"] = 3551,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "libraries/collectionentry.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 18421,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 11028,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 6775,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7873,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 14042,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6250,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4945,
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 18961,
          ["default"] = true,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3398,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3507,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43530,
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 25916,
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25362,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Table.lua",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["default"] = true,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8582,
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 13859,
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15117,
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7703,
          ["default"] = true,
          ["description"] = "A collection of items",
          ["path"] = "elements/Collection.lua",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32404,
          ["default"] = true,
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["path"] = "elements/FlexBox.lua",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2437,
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7645,
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11435,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Program.lua",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["default"] = true,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 43389,
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22145,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21551,
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9200,
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3171,
          ["default"] = false,
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 13613,
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 20221,
          ["default"] = true,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["path"] = "elements/SideNav.lua",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 6933,
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 14559,
          ["default"] = true,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15463,
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["size"] = 3700,
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6513,
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["requires"] = {
          },
          ["size"] = 15411,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "elementManager.lua",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "log.lua",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 18186,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "propertySystem.lua",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 622,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "init.lua",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "errorManager.lua",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 19883,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "main.lua",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["default"] = true,
          ["description"] = "",
          ["path"] = "render.lua",
        },
      },
    },
  },
}