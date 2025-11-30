return {
  ["metadata"] = {
    ["generated"] = "Sun Nov 30 14:23:14 2025",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 132,
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 2661,
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 846,
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3551,
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 23936,
          ["default"] = false,
          ["path"] = "plugins/animation.lua",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 12604,
          ["default"] = false,
          ["path"] = "plugins/benchmark.lua",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 9028,
          ["default"] = false,
          ["path"] = "plugins/theme.lua",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 11893,
          ["default"] = false,
          ["path"] = "plugins/reactive.lua",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 6274,
          ["default"] = false,
          ["path"] = "plugins/debug.lua",
        },
        ["store"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["size"] = 6896,
          ["default"] = true,
          ["path"] = "plugins/store.lua",
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 14068,
          ["default"] = false,
          ["path"] = "plugins/xml.lua",
        },
        ["responsive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 5529,
          ["default"] = false,
          ["path"] = "plugins/responsive.lua",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 7897,
          ["default"] = false,
          ["path"] = "plugins/canvas.lua",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["BarChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3547,
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 17832,
          ["default"] = false,
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3228,
          ["default"] = true,
          ["path"] = "elements/LineChart.lua",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 44462,
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 21136,
          ["default"] = false,
          ["path"] = "elements/TabControl.lua",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15714,
          ["default"] = true,
          ["path"] = "elements/List.lua",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3375,
          ["default"] = false,
          ["path"] = "elements/Switch.lua",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 3440,
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["size"] = 10836,
          ["default"] = false,
          ["path"] = "elements/ContextMenu.lua",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 45330,
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6702,
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["size"] = 25766,
          ["default"] = false,
          ["path"] = "elements/Table.lua",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["size"] = 8058,
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A slider control element for selecting a value within a range.",
          ["size"] = 5211,
          ["default"] = false,
          ["path"] = "elements/Slider.lua",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 21675,
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 27731,
          ["default"] = true,
          ["path"] = "elements/Container.lua",
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["size"] = 9125,
          ["default"] = false,
          ["path"] = "elements/Dialog.lua",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 8194,
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 15143,
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 18777,
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["size"] = 4461,
          ["default"] = false,
          ["path"] = "elements/Breadcrumb.lua",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 14122,
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2987,
          ["default"] = true,
          ["path"] = "elements/Label.lua",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22429,
          ["default"] = false,
          ["path"] = "elements/SideNav.lua",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2461,
          ["default"] = true,
          ["path"] = "elements/Button.lua",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 15372,
          ["default"] = true,
          ["path"] = "elements/Image.lua",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 13017,
          ["default"] = false,
          ["path"] = "elements/Program.lua",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["size"] = 7045,
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["size"] = 15169,
          ["default"] = false,
          ["path"] = "elements/Accordion.lua",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3748,
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8972,
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4549,
          ["default"] = false,
          ["path"] = "elements/Display.lua",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["size"] = 2962,
          ["default"] = false,
          ["path"] = "elements/Timer.lua",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["size"] = 22552,
          ["default"] = false,
          ["path"] = "elements/Tree.lua",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["size"] = 10509,
          ["default"] = true,
          ["path"] = "elements/Input.lua",
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A toast notification element that displays temporary messages.",
          ["size"] = 8784,
          ["default"] = false,
          ["path"] = "elements/Toast.lua",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9941,
          ["default"] = false,
          ["path"] = "elements/ScrollBar.lua",
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3789,
          ["default"] = true,
          ["path"] = "errorManager.lua",
        },
        ["layoutManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3633,
          ["default"] = true,
          ["path"] = "layoutManager.lua",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 19883,
          ["default"] = true,
          ["path"] = "main.lua",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 15411,
          ["default"] = true,
          ["path"] = "elementManager.lua",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 18433,
          ["default"] = true,
          ["path"] = "propertySystem.lua",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 3142,
          ["default"] = true,
          ["path"] = "log.lua",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 12422,
          ["default"] = true,
          ["path"] = "render.lua",
        },
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["size"] = 622,
          ["default"] = true,
          ["path"] = "init.lua",
        },
      },
      ["description"] = "Core Files",
    },
  },
}