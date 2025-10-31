return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["description"] = "",
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
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
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
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
        ["render"] = {
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["description"] = "",
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
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
        ["init"] = {
          ["description"] = "",
          ["size"] = 622,
          ["path"] = "init.lua",
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
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["size"] = 7778,
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
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
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 20903,
          ["path"] = "elements/TabControl.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15463,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["Table"] = {
          ["description"] = "",
          ["size"] = 25362,
          ["path"] = "elements/Table.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["size"] = 3398,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4668,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["description"] = "",
          ["size"] = 21551,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["size"] = 14913,
          ["path"] = "elements/Accordion.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7645,
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Timer"] = {
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22135,
          ["path"] = "elements/SideNav.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
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
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["size"] = 10636,
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Tree"] = {
          ["description"] = "",
          ["size"] = 22144,
          ["path"] = "elements/Tree.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 26063,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["size"] = 7917,
          ["path"] = "elements/Toast.lua",
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
          ["size"] = 32404,
          ["path"] = "elements/FlexBox.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15117,
          ["path"] = "elements/Image.lua",
          ["default"] = false,
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
        ["Program"] = {
          ["description"] = "",
          ["size"] = 12730,
          ["path"] = "elements/Program.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6646,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["size"] = 6933,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["requires"] = {
          },
        },
        ["BarChart"] = {
          ["description"] = "",
          ["size"] = 3507,
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["LineChart"] = {
          ["description"] = "",
          ["size"] = 3171,
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
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 16330,
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
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
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2437,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 13613,
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
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
        ["Breadcrumb"] = {
          ["description"] = "",
          ["size"] = 4314,
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3700,
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["size"] = 8878,
          ["path"] = "elements/Dialog.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "Frame",
          },
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13870,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["description"] = "",
          ["size"] = 14042,
          ["path"] = "plugins/xml.lua",
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
        ["theme"] = {
          ["description"] = "",
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
          ["default"] = true,
          ["requires"] = {
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
          ["size"] = 11028,
          ["path"] = "plugins/reactive.lua",
          ["default"] = true,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Fri Oct 31 17:56:15 2025",
  },
}