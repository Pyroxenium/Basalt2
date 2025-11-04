return {
  ["metadata"] = {
    ["generated"] = "Tue Nov  4 08:43:59 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["ComboBox"] = {
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 14752,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 45082,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21551,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ContextMenu"] = {
          ["default"] = true,
          ["path"] = "elements/ContextMenu.lua",
          ["size"] = 10636,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Image"] = {
          ["default"] = false,
          ["path"] = "elements/Image.lua",
          ["size"] = 15117,
          ["description"] = "An element that displays an image in bimg format",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["default"] = true,
          ["path"] = "elements/Slider.lua",
          ["size"] = 4977,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = true,
          ["path"] = "elements/Tree.lua",
          ["size"] = 22144,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 6646,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Collection"] = {
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
          ["size"] = 7778,
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 9200,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ScrollFrame"] = {
          ["default"] = true,
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 17439,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Switch"] = {
          ["default"] = true,
          ["path"] = "elements/Switch.lua",
          ["size"] = 3269,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ScrollBar"] = {
          ["default"] = true,
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9665,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["default"] = true,
          ["path"] = "elements/Program.lua",
          ["size"] = 12730,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3398,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Graph"] = {
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 6933,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
        },
        ["Timer"] = {
          ["default"] = true,
          ["path"] = "elements/Timer.lua",
          ["size"] = 2914,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 13870,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["TabControl"] = {
          ["default"] = true,
          ["path"] = "elements/TabControl.lua",
          ["size"] = 20903,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Toast"] = {
          ["default"] = true,
          ["path"] = "elements/Toast.lua",
          ["size"] = 7917,
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["DropDown"] = {
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["size"] = 7887,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Table"] = {
          ["default"] = true,
          ["path"] = "elements/Table.lua",
          ["size"] = 25362,
          ["description"] = "",
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 9017,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Accordion"] = {
          ["default"] = true,
          ["path"] = "elements/Accordion.lua",
          ["size"] = 14913,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3700,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
        },
        ["TextBox"] = {
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 43530,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 8582,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 2437,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 15474,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3092,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["default"] = false,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3171,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["BarChart"] = {
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3507,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 27475,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dialog"] = {
          ["default"] = true,
          ["path"] = "elements/Dialog.lua",
          ["size"] = 8878,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
        },
        ["Display"] = {
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4668,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["SideNav"] = {
          ["default"] = true,
          ["path"] = "elements/SideNav.lua",
          ["size"] = 22135,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Breadcrumb"] = {
          ["default"] = true,
          ["path"] = "elements/Breadcrumb.lua",
          ["size"] = 4314,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 622,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["layoutManager"] = {
          ["default"] = true,
          ["path"] = "layoutManager.lua",
          ["size"] = 3634,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 18186,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 19883,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["render"] = {
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["collectionentry"] = {
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["default"] = true,
          ["path"] = "plugins/xml.lua",
          ["size"] = 14042,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["default"] = true,
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7873,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["default"] = true,
          ["path"] = "plugins/theme.lua",
          ["size"] = 6775,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["default"] = true,
          ["path"] = "plugins/animation.lua",
          ["size"] = 18421,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = true,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11845,
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = true,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12581,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["debug"] = {
          ["default"] = true,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6250,
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
    },
  },
}