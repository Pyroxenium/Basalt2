return {
  ["metadata"] = {
    ["generated"] = "Sun Mar  1 20:55:41 2026",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["ScrollBar"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9941,
        },
        ["Breadcrumb"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["path"] = "elements/Breadcrumb.lua",
          ["size"] = 4461,
        },
        ["TabControl"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["path"] = "elements/TabControl.lua",
          ["size"] = 21136,
        },
        ["Toast"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A toast notification element that displays temporary messages.",
          ["path"] = "elements/Toast.lua",
          ["size"] = 8784,
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 45330,
        },
        ["Graph"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["path"] = "elements/Graph.lua",
          ["size"] = 7045,
        },
        ["Accordion"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["path"] = "elements/Accordion.lua",
          ["size"] = 15169,
        },
        ["Display"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["path"] = "elements/Display.lua",
          ["size"] = 4809,
        },
        ["Switch"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["path"] = "elements/Switch.lua",
          ["size"] = 3375,
        },
        ["Slider"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A slider control element for selecting a value within a range.",
          ["path"] = "elements/Slider.lua",
          ["size"] = 5211,
        },
        ["TextBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["path"] = "elements/TextBox.lua",
          ["size"] = 44462,
        },
        ["LineChart"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3228,
        },
        ["List"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["path"] = "elements/List.lua",
          ["size"] = 15714,
        },
        ["Container"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["path"] = "elements/Container.lua",
          ["size"] = 27731,
        },
        ["ScrollFrame"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 17832,
        },
        ["Program"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Program.lua",
          ["size"] = 13017,
        },
        ["Input"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["path"] = "elements/Input.lua",
          ["size"] = 10509,
        },
        ["Timer"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["path"] = "elements/Timer.lua",
          ["size"] = 2962,
        },
        ["Label"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["path"] = "elements/Label.lua",
          ["size"] = 2987,
        },
        ["Frame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["path"] = "elements/Frame.lua",
          ["size"] = 6702,
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 15143,
        },
        ["Menu"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["path"] = "elements/Menu.lua",
          ["size"] = 14122,
        },
        ["BigFont"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21637,
        },
        ["ContextMenu"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["path"] = "elements/ContextMenu.lua",
          ["size"] = 10836,
        },
        ["Table"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["path"] = "elements/Table.lua",
          ["size"] = 25766,
        },
        ["Collection"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["path"] = "elements/Collection.lua",
          ["size"] = 8058,
        },
        ["BarChart"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3547,
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 18777,
        },
        ["Dialog"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Frame",
          },
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["path"] = "elements/Dialog.lua",
          ["size"] = 9125,
        },
        ["Button"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["path"] = "elements/Button.lua",
          ["size"] = 2461,
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3748,
        },
        ["DropDown"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["path"] = "elements/DropDown.lua",
          ["size"] = 8194,
        },
        ["Tree"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Tree.lua",
          ["size"] = 22552,
        },
        ["Image"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/Image.lua",
          ["size"] = 16759,
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3440,
        },
        ["SideNav"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["path"] = "elements/SideNav.lua",
          ["size"] = 22429,
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8972,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "init.lua",
          ["size"] = 622,
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "propertySystem.lua",
          ["size"] = 18433,
        },
        ["log"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["main"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "main.lua",
          ["size"] = 19883,
        },
        ["layoutManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "layoutManager.lua",
          ["size"] = 3633,
        },
        ["render"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["errorManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["elementManager"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
        ["expect"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
        ["collectionentry"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
        },
        ["colorHex"] = {
          ["default"] = true,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["canvas"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7897,
        },
        ["xml"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/xml.lua",
          ["size"] = 14068,
        },
        ["store"] = {
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
          ["path"] = "plugins/store.lua",
          ["size"] = 6896,
        },
        ["reactive"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11893,
        },
        ["responsive"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/responsive.lua",
          ["size"] = 5529,
        },
        ["debug"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/debug.lua",
          ["size"] = 6274,
        },
        ["benchmark"] = {
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12604,
        },
        ["theme"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/theme.lua",
          ["size"] = 9028,
        },
        ["animation"] = {
          ["default"] = false,
          ["requires"] = {
          },
          ["description"] = "",
          ["path"] = "plugins/animation.lua",
          ["size"] = 23936,
        },
      },
    },
  },
}