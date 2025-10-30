return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Oct 30 08:24:16 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["expect"] = {
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["main"] = {
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 19883,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 18186,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 622,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["FlexBox"] = {
          ["default"] = true,
          ["path"] = "elements/FlexBox.lua",
          ["size"] = 32404,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
        },
        ["Menu"] = {
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 8582,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["List"] = {
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 15463,
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["TabControl"] = {
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["size"] = 20900,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["SideNav"] = {
          ["default"] = true,
          ["path"] = "elements/SideNav.lua",
          ["size"] = 22135,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
        },
        ["Input"] = {
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 9200,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["LineChart"] = {
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3171,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Collection"] = {
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
          ["size"] = 7703,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
        },
        ["Label"] = {
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3398,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Frame"] = {
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 6425,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["Container"] = {
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 25916,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["ScrollFrame"] = {
          ["default"] = true,
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 14559,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 43530,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Display"] = {
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4668,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["Tree"] = {
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["size"] = 22144,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Slider"] = {
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 13613,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["size"] = 7645,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Program"] = {
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["size"] = 12730,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Image"] = {
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["size"] = 15117,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3700,
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["Switch"] = {
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21551,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Graph"] = {
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 6933,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["Timer"] = {
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 9017,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 43389,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Button"] = {
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 2437,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9665,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["BarChart"] = {
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3507,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 13859,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["Table"] = {
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["size"] = 25362,
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["size"] = 6775,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11028,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["size"] = 14042,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["debug"] = {
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
  },
}