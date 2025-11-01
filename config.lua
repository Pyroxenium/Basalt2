return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sat Nov  1 01:55:38 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 622,
          ["path"] = "init.lua",
          ["default"] = true,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["default"] = true,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["size"] = 10636,
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = true,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "",
          ["size"] = 25362,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3507,
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 26063,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22135,
          ["path"] = "elements/SideNav.lua",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13870,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 16330,
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = true,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 12730,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15463,
          ["path"] = "elements/List.lua",
          ["default"] = true,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 22144,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13613,
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 4314,
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = true,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6646,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 3398,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 20903,
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4668,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2437,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["size"] = 14913,
          ["path"] = "elements/Accordion.lua",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3700,
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A toast notification element that displays temporary messages.",
          ["size"] = 7917,
          ["path"] = "elements/Toast.lua",
          ["default"] = true,
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["size"] = 7778,
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
        },
        ["FlexBox"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32404,
          ["path"] = "elements/FlexBox.lua",
          ["default"] = true,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7667,
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3171,
          ["path"] = "elements/LineChart.lua",
          ["default"] = false,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
          ["default"] = true,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
          ["default"] = true,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15117,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 21551,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["size"] = 6933,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = true,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["size"] = 8878,
          ["path"] = "elements/Dialog.lua",
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = true,
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
          ["default"] = true,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 11028,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
          ["default"] = true,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 14042,
          ["path"] = "plugins/xml.lua",
          ["default"] = true,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
          ["default"] = true,
        },
      },
      ["description"] = "Plugins",
    },
  },
}