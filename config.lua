return {
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 622,
          ["path"] = "init.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 8619,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 9940,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Timer"] = {
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13718,
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 3227,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 3397,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 6039,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 5071,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2556,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 4679,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 26177,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 20221,
          ["path"] = "elements/SideNav.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43413,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6508,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 18961,
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 21649,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 6989,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 16214,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["size"] = 6008,
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 8519,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["FlexBox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32431,
          ["path"] = "elements/FlexBox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 3590,
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15125,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 11435,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3763,
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13859,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 8100,
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon Oct 27 16:47:10 2025",
    ["version"] = "2.0",
  },
}