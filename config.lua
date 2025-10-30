return {
  ["metadata"] = {
    ["generated"] = "Thu Oct 30 06:43:39 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 13484,
          ["path"] = "plugins/xml.lua",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 11028,
          ["path"] = "plugins/reactive.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["size"] = 7645,
          ["path"] = "elements/DropDown.lua",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["size"] = 43389,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["size"] = 6933,
          ["path"] = "elements/Graph.lua",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 18817,
          ["path"] = "elements/Tree.lua",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["size"] = 26177,
          ["path"] = "elements/Container.lua",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = true,
          ["size"] = 18961,
          ["path"] = "elements/TabControl.lua",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["size"] = 6513,
          ["path"] = "elements/Frame.lua",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["size"] = 15463,
          ["path"] = "elements/List.lua",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["size"] = 2437,
          ["path"] = "elements/Button.lua",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["size"] = 4945,
          ["path"] = "elements/Display.lua",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = true,
          ["size"] = 20221,
          ["path"] = "elements/SideNav.lua",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3398,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["size"] = 3171,
          ["path"] = "elements/LineChart.lua",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["size"] = 21551,
          ["path"] = "elements/BigFont.lua",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = true,
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["size"] = 3700,
          ["path"] = "elements/CheckBox.lua",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["size"] = 13613,
          ["path"] = "elements/ComboBox.lua",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 11435,
          ["path"] = "elements/Program.lua",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = true,
          ["size"] = 14559,
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = true,
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["size"] = 32404,
          ["path"] = "elements/FlexBox.lua",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["default"] = true,
          ["size"] = 7703,
          ["path"] = "elements/Collection.lua",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 24453,
          ["path"] = "elements/Table.lua",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["size"] = 13859,
          ["path"] = "elements/BaseElement.lua",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3507,
          ["path"] = "elements/BarChart.lua",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 19883,
          ["path"] = "main.lua",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
      },
      ["description"] = "Libraries",
    },
  },
}