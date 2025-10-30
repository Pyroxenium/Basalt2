return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["path"] = "libraries/collectionentry.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3551,
          ["default"] = true,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 846,
          ["default"] = true,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 21551,
          ["default"] = false,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["size"] = 2914,
          ["default"] = true,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 12730,
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13613,
          ["default"] = false,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 4977,
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2437,
          ["default"] = true,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4668,
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13859,
          ["default"] = true,
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7645,
          ["default"] = false,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "",
          ["size"] = 25362,
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["default"] = true,
        },
        ["ScrollFrame"] = {
          ["path"] = "elements/ScrollFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 16330,
          ["default"] = true,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15463,
          ["default"] = true,
        },
        ["FlexBox"] = {
          ["path"] = "elements/FlexBox.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32404,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["default"] = false,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["size"] = 6933,
          ["default"] = false,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15117,
          ["default"] = false,
        },
        ["Collection"] = {
          ["path"] = "elements/Collection.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["size"] = 7703,
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 3398,
          ["default"] = true,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6425,
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["default"] = true,
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 20903,
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["default"] = true,
        },
        ["SideNav"] = {
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22135,
          ["default"] = true,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["default"] = true,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3171,
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3700,
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3507,
          ["default"] = true,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 22144,
          ["default"] = true,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25916,
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6775,
          ["default"] = true,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 14042,
          ["default"] = true,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 7873,
          ["default"] = true,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6250,
          ["default"] = true,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 11028,
          ["default"] = true,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 18421,
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 12581,
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 18186,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 15411,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 19883,
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 622,
          ["default"] = true,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 12422,
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Oct 30 08:42:57 2025",
  },
}