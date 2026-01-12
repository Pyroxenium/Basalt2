return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["elements"] = {
      ["files"] = {
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16759,
          ["path"] = "elements/Image.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8784,
          ["path"] = "elements/Toast.lua",
          ["default"] = false,
          ["description"] = "A toast notification element that displays temporary messages.",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 45330,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 22429,
          ["path"] = "elements/SideNav.lua",
          ["default"] = false,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3375,
          ["path"] = "elements/Switch.lua",
          ["default"] = false,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["size"] = 3748,
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3440,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 14122,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15714,
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22552,
          ["path"] = "elements/Tree.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10509,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15169,
          ["path"] = "elements/Accordion.lua",
          ["default"] = false,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4549,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8194,
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25766,
          ["path"] = "elements/Table.lua",
          ["default"] = false,
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9941,
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = false,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 17832,
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = false,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2461,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 27731,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21637,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2962,
          ["path"] = "elements/Timer.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8058,
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
          ["description"] = "A collection of items",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5211,
          ["path"] = "elements/Slider.lua",
          ["default"] = false,
          ["description"] = "A slider control element for selecting a value within a range.",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 21136,
          ["path"] = "elements/TabControl.lua",
          ["default"] = false,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 13017,
          ["path"] = "elements/Program.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6702,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 44462,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4461,
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = false,
          ["description"] = "A breadcrumb navigation element that displays the current path.",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8972,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2987,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["size"] = 9125,
          ["path"] = "elements/Dialog.lua",
          ["default"] = false,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["size"] = 18777,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15143,
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["size"] = 3228,
          ["path"] = "elements/LineChart.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10836,
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = false,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["size"] = 3547,
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["size"] = 7045,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
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
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["responsive"] = {
          ["requires"] = {
          },
          ["size"] = 5529,
          ["path"] = "plugins/responsive.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["size"] = 23936,
          ["path"] = "plugins/animation.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["store"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/store.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["size"] = 11893,
          ["path"] = "plugins/reactive.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["size"] = 9028,
          ["path"] = "plugins/theme.lua",
          ["default"] = false,
          ["description"] = "",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
          ["default"] = false,
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["layoutManager"] = {
          ["requires"] = {
          },
          ["size"] = 3633,
          ["path"] = "layoutManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["size"] = 18433,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["generated"] = "Mon Jan 12 19:08:25 2026",
    ["version"] = "2.0",
  },
}