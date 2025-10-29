return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Oct 29 17:41:52 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4945,
          ["path"] = "elements/Display.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6933,
          ["path"] = "elements/Graph.lua",
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 24453,
          ["path"] = "elements/Table.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3507,
          ["path"] = "elements/BarChart.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15436,
          ["path"] = "elements/List.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 3171,
          ["path"] = "elements/LineChart.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 43389,
          ["path"] = "elements/VisualElement.lua",
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 13613,
          ["path"] = "elements/ComboBox.lua",
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3700,
          ["path"] = "elements/CheckBox.lua",
        },
        ["Timer"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 13859,
          ["path"] = "elements/BaseElement.lua",
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2437,
          ["path"] = "elements/Button.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 11435,
          ["path"] = "elements/Program.lua",
        },
        ["FlexBox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 32404,
          ["path"] = "elements/FlexBox.lua",
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7703,
          ["path"] = "elements/Collection.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3398,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 18817,
          ["path"] = "elements/Tree.lua",
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 14559,
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 26177,
          ["path"] = "elements/Container.lua",
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 20221,
          ["path"] = "elements/SideNav.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21551,
          ["path"] = "elements/BigFont.lua",
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 18961,
          ["path"] = "elements/TabControl.lua",
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7631,
          ["path"] = "elements/DropDown.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 19883,
          ["path"] = "main.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 13484,
          ["path"] = "plugins/xml.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
        },
        ["canvas"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
      },
    },
  },
}