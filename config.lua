return {
  ["metadata"] = {
    ["generated"] = "Sat Nov  1 09:48:17 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = true,
          ["size"] = 9665,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["size"] = 2437,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["size"] = 27481,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["default"] = false,
          ["size"] = 3171,
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["size"] = 15474,
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/List.lua",
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["size"] = 13613,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["size"] = 43389,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["size"] = 4668,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3398,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 22144,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
        },
        ["Table"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 25362,
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/Table.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["size"] = 9200,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = true,
          ["size"] = 14913,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Accordion.lua",
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = true,
          ["size"] = 20903,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
        },
        ["Breadcrumb"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 4314,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Breadcrumb.lua",
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = true,
          ["size"] = 10636,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ContextMenu.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12730,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = true,
          ["size"] = 3269,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["size"] = 6646,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["size"] = 6933,
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = true,
          ["size"] = 16330,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["size"] = 43530,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
        },
        ["Timer"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2914,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3507,
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = true,
          ["size"] = 22135,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/SideNav.lua",
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["size"] = 7667,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["size"] = 13870,
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = true,
          ["size"] = 7917,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Toast.lua",
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["size"] = 3700,
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
        },
        ["Slider"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 4977,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = true,
          ["size"] = 8878,
          ["requires"] = {
            [1] = "Frame",
          },
          ["path"] = "elements/Dialog.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["size"] = 3092,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
        },
        ["Image"] = {
          ["description"] = "An element that displays an image in bimg format",
          ["default"] = false,
          ["size"] = 15117,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["size"] = 8582,
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["size"] = 21551,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["size"] = 9017,
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["default"] = true,
          ["size"] = 7778,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Collection.lua",
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12581,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 18421,
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6775,
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6250,
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 11028,
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
        },
        ["canvas"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 7873,
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
        },
        ["xml"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 14042,
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3551,
          ["requires"] = {
          },
          ["path"] = "libraries/collectionentry.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 846,
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 18186,
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
          ["path"] = "log.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 622,
          ["requires"] = {
          },
          ["path"] = "init.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 15411,
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 19883,
          ["requires"] = {
          },
          ["path"] = "main.lua",
        },
        ["layoutManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2488,
          ["requires"] = {
          },
          ["path"] = "layoutManager.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12422,
          ["requires"] = {
          },
          ["path"] = "render.lua",
        },
      },
    },
  },
}