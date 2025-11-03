return {
  ["metadata"] = {
    ["generated"] = "Sun Nov  2 17:37:23 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["files"] = {
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 3092,
          ["path"] = "elements/Label.lua",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3507,
          ["path"] = "elements/BarChart.lua",
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4314,
          ["path"] = "elements/Breadcrumb.lua",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 27534,
          ["path"] = "elements/Container.lua",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4668,
          ["path"] = "elements/Display.lua",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 7887,
          ["path"] = "elements/DropDown.lua",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 4977,
          ["path"] = "elements/Slider.lua",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15474,
          ["path"] = "elements/List.lua",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "An element that displays an image in bimg format",
          ["size"] = 15117,
          ["path"] = "elements/Image.lua",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3398,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 9017,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3269,
          ["path"] = "elements/Switch.lua",
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A toast notification element that displays temporary messages.",
          ["size"] = 7917,
          ["path"] = "elements/Toast.lua",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 6933,
          ["path"] = "elements/Graph.lua",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 20903,
          ["path"] = "elements/TabControl.lua",
        },
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["size"] = 10636,
          ["path"] = "elements/ContextMenu.lua",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A collection of items",
          ["size"] = 7778,
          ["path"] = "elements/Collection.lua",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 43389,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6646,
          ["path"] = "elements/Frame.lua",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 14752,
          ["path"] = "elements/ComboBox.lua",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2437,
          ["path"] = "elements/Button.lua",
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["size"] = 14913,
          ["path"] = "elements/Accordion.lua",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 13870,
          ["path"] = "elements/BaseElement.lua",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22135,
          ["path"] = "elements/SideNav.lua",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 3171,
          ["path"] = "elements/LineChart.lua",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9665,
          ["path"] = "elements/ScrollBar.lua",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3700,
          ["path"] = "elements/CheckBox.lua",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["description"] = "",
          ["size"] = 21551,
          ["path"] = "elements/BigFont.lua",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 25362,
          ["path"] = "elements/Table.lua",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2914,
          ["path"] = "elements/Timer.lua",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 16330,
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 22144,
          ["path"] = "elements/Tree.lua",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12730,
          ["path"] = "elements/Program.lua",
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["default"] = true,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["size"] = 8878,
          ["path"] = "elements/Dialog.lua",
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
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12581,
          ["path"] = "plugins/benchmark.lua",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18421,
          ["path"] = "plugins/animation.lua",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6250,
          ["path"] = "plugins/debug.lua",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 7873,
          ["path"] = "plugins/canvas.lua",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 6775,
          ["path"] = "plugins/theme.lua",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 14042,
          ["path"] = "plugins/xml.lua",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 11845,
          ["path"] = "plugins/reactive.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["layoutManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2488,
          ["path"] = "layoutManager.lua",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 19883,
          ["path"] = "main.lua",
        },
      },
      ["description"] = "Core Files",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
      },
      ["description"] = "Libraries",
    },
  },
}