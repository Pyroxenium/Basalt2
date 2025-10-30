return {
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6425,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["size"] = 10636,
          ["default"] = true,
          ["path"] = "elements/ContextMenu.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 21551,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 3171,
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["size"] = 14913,
          ["default"] = true,
          ["path"] = "elements/Accordion.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13859,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15117,
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22135,
          ["default"] = true,
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Program"] = {
          ["description"] = "",
          ["size"] = 12730,
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 3507,
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["size"] = 8878,
          ["default"] = true,
          ["path"] = "elements/Dialog.lua",
          ["requires"] = {
            [1] = "Frame",
          },
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Breadcrumb"] = {
          ["description"] = "",
          ["size"] = 4314,
          ["default"] = true,
          ["path"] = "elements/Breadcrumb.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Timer"] = {
          ["description"] = "",
          ["size"] = 2914,
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 22144,
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7645,
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 25362,
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3700,
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 25916,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["size"] = 7917,
          ["default"] = true,
          ["path"] = "elements/Toast.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15463,
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13613,
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 3398,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["FlexBox"] = {
          ["description"] = "A flexbox container that arranges its children in a flexible layout.",
          ["size"] = 32404,
          ["default"] = true,
          ["path"] = "elements/FlexBox.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 6933,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2437,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["default"] = true,
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["size"] = 7703,
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4668,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 16330,
          ["default"] = true,
          ["path"] = "elements/ScrollFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Slider"] = {
          ["description"] = "",
          ["size"] = 4977,
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 20903,
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["description"] = "",
          ["size"] = 12581,
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["theme"] = {
          ["description"] = "",
          ["size"] = 6775,
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["description"] = "",
          ["size"] = 7873,
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
        },
        ["debug"] = {
          ["description"] = "",
          ["size"] = 6250,
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["description"] = "",
          ["size"] = 18421,
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["description"] = "",
          ["size"] = 14042,
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["description"] = "",
          ["size"] = 11028,
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["description"] = "",
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["description"] = "",
          ["size"] = 19883,
          ["default"] = true,
          ["path"] = "main.lua",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["description"] = "",
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 15411,
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["size"] = 18186,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["description"] = "",
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["size"] = 3551,
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
          ["requires"] = {
          },
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Thu Oct 30 13:13:20 2025",
  },
}