return {
  ["metadata"] = {
    ["generated"] = "Mon Nov  3 12:29:37 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Timer"] = {
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2914,
          ["default"] = true,
        },
        ["Tree"] = {
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22144,
          ["default"] = true,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15474,
          ["default"] = true,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 45082,
          ["default"] = true,
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["path"] = "elements/ContextMenu.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10636,
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8582,
          ["default"] = true,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 43530,
          ["default"] = false,
        },
        ["Table"] = {
          ["description"] = "",
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25362,
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12730,
          ["default"] = true,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4668,
          ["default"] = false,
        },
        ["Breadcrumb"] = {
          ["description"] = "",
          ["path"] = "elements/Breadcrumb.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4314,
          ["default"] = true,
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["path"] = "elements/Dialog.lua",
          ["requires"] = {
            [1] = "Frame",
          },
          ["size"] = 8878,
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 13870,
          ["default"] = true,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 27475,
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 9017,
          ["default"] = true,
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2437,
          ["default"] = true,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9200,
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3398,
          ["default"] = true,
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 22135,
          ["default"] = true,
        },
        ["Slider"] = {
          ["description"] = "",
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4977,
          ["default"] = true,
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["path"] = "elements/Collection.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7778,
          ["default"] = true,
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["path"] = "elements/Accordion.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 14913,
          ["default"] = true,
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["size"] = 3700,
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["size"] = 3171,
          ["default"] = false,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3092,
          ["default"] = true,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["size"] = 3507,
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 14752,
          ["default"] = false,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["size"] = 6933,
          ["default"] = false,
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["path"] = "elements/ScrollFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 17273,
          ["default"] = true,
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 20903,
          ["default"] = true,
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15117,
          ["default"] = false,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21551,
          ["default"] = false,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6646,
          ["default"] = true,
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 7887,
          ["default"] = false,
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3269,
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9665,
          ["default"] = true,
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["path"] = "elements/Toast.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 7917,
          ["default"] = true,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["layoutManager"] = {
          ["description"] = "",
          ["path"] = "layoutManager.lua",
          ["requires"] = {
          },
          ["size"] = 3634,
          ["default"] = true,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["default"] = true,
        },
        ["log"] = {
          ["description"] = "",
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 18186,
          ["default"] = true,
        },
        ["render"] = {
          ["description"] = "",
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 12422,
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 15411,
          ["default"] = true,
        },
        ["init"] = {
          ["description"] = "",
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 622,
          ["default"] = true,
        },
        ["main"] = {
          ["description"] = "",
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 19883,
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["size"] = 7873,
          ["default"] = true,
        },
        ["reactive"] = {
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 11845,
          ["default"] = true,
        },
        ["theme"] = {
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 6775,
          ["default"] = true,
        },
        ["xml"] = {
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 14042,
          ["default"] = true,
        },
        ["debug"] = {
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6250,
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 18421,
          ["default"] = true,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12581,
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["colorHex"] = {
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
          ["default"] = true,
        },
        ["utils"] = {
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["path"] = "libraries/collectionentry.lua",
          ["requires"] = {
          },
          ["size"] = 3551,
          ["default"] = true,
        },
        ["expect"] = {
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 846,
          ["default"] = true,
        },
      },
    },
  },
}