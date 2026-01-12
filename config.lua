return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["path"] = "libraries/collectionentry.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3551,
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 132,
          ["requires"] = {
          },
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 2661,
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 846,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 6274,
          ["requires"] = {
          },
        },
        ["store"] = {
          ["path"] = "plugins/store.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 6896,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 7897,
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 9028,
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 23936,
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 12604,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["responsive"] = {
          ["path"] = "plugins/responsive.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 5529,
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 14068,
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 11893,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["size"] = 15714,
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["size"] = 8972,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["size"] = 2461,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["size"] = 18777,
          ["requires"] = {
          },
        },
        ["ScrollFrame"] = {
          ["path"] = "elements/ScrollFrame.lua",
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = false,
          ["size"] = 17832,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3547,
          ["requires"] = {
          },
        },
        ["Toast"] = {
          ["path"] = "elements/Toast.lua",
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = false,
          ["size"] = 8784,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["size"] = 8194,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["ContextMenu"] = {
          ["path"] = "elements/ContextMenu.lua",
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = false,
          ["size"] = 10836,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["size"] = 44462,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["size"] = 45330,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 13017,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Breadcrumb"] = {
          ["path"] = "elements/Breadcrumb.lua",
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["default"] = false,
          ["size"] = 4461,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3228,
          ["requires"] = {
          },
        },
        ["Collection"] = {
          ["path"] = "elements/Collection.lua",
          ["description"] = "A collection of items",
          ["default"] = true,
          ["size"] = 8058,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = false,
          ["size"] = 9941,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["size"] = 2987,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3440,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 22552,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["default"] = false,
          ["size"] = 25766,
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["size"] = 15143,
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["size"] = 6702,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["size"] = 27731,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["size"] = 3748,
          ["requires"] = {
          },
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["size"] = 7045,
          ["requires"] = {
          },
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = false,
          ["size"] = 3375,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dialog"] = {
          ["path"] = "elements/Dialog.lua",
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = false,
          ["size"] = 9125,
          ["requires"] = {
            [1] = "Frame",
          },
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 21675,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = false,
          ["size"] = 21136,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["size"] = 4549,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Accordion"] = {
          ["path"] = "elements/Accordion.lua",
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = false,
          ["size"] = 15169,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 16759,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["SideNav"] = {
          ["path"] = "elements/SideNav.lua",
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = false,
          ["size"] = 22429,
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["size"] = 10509,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "A slider control element for selecting a value within a range.",
          ["default"] = false,
          ["size"] = 5211,
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["size"] = 14122,
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["default"] = false,
          ["size"] = 2962,
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 622,
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 15411,
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 18433,
          ["requires"] = {
          },
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3142,
          ["requires"] = {
          },
        },
        ["layoutManager"] = {
          ["path"] = "layoutManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3633,
          ["requires"] = {
          },
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 12422,
          ["requires"] = {
          },
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 19883,
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["size"] = 3789,
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Nov 30 15:01:15 2025",
  },
}