return {
  ["metadata"] = {
    ["generated"] = "Sun Mar  1 22:07:08 2026",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["default"] = true,
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["default"] = true,
        },
        ["layoutManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3633,
          ["path"] = "layoutManager.lua",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["default"] = true,
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["default"] = true,
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 18433,
          ["path"] = "propertySystem.lua",
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Slider"] = {
          ["description"] = "A slider control element for selecting a value within a range.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5211,
          ["path"] = "elements/Slider.lua",
          ["default"] = false,
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3375,
          ["path"] = "elements/Switch.lua",
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8972,
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 14122,
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8784,
          ["path"] = "elements/Toast.lua",
          ["default"] = false,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3547,
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15714,
          ["path"] = "elements/List.lua",
          ["default"] = true,
        },
        ["Timer"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2962,
          ["path"] = "elements/Timer.lua",
          ["default"] = false,
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15169,
          ["path"] = "elements/Accordion.lua",
          ["default"] = false,
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 22429,
          ["path"] = "elements/SideNav.lua",
          ["default"] = false,
        },
        ["Breadcrumb"] = {
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4461,
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = false,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 27731,
          ["path"] = "elements/Container.lua",
          ["default"] = true,
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8058,
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
        },
        ["Table"] = {
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25766,
          ["path"] = "elements/Table.lua",
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["size"] = 3748,
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["size"] = 7045,
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6702,
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15143,
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 44462,
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
          ["size"] = 9125,
          ["path"] = "elements/Dialog.lua",
          ["default"] = false,
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2461,
          ["path"] = "elements/Button.lua",
          ["default"] = true,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2987,
          ["path"] = "elements/Label.lua",
          ["default"] = true,
        },
        ["Image"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16759,
          ["path"] = "elements/Image.lua",
          ["default"] = true,
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 17832,
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = false,
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8194,
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 45330,
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9941,
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = false,
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10836,
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = false,
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 21136,
          ["path"] = "elements/TabControl.lua",
          ["default"] = false,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4690,
          ["path"] = "elements/Display.lua",
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["size"] = 18777,
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3228,
          ["path"] = "elements/LineChart.lua",
          ["default"] = true,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10509,
          ["path"] = "elements/Input.lua",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3440,
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 13017,
          ["path"] = "elements/Program.lua",
          ["default"] = false,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21637,
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22552,
          ["path"] = "elements/Tree.lua",
          ["default"] = false,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
        },
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
          ["default"] = false,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
          ["default"] = false,
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 9028,
          ["path"] = "plugins/theme.lua",
          ["default"] = false,
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
          ["default"] = false,
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 11893,
          ["path"] = "plugins/reactive.lua",
          ["default"] = false,
        },
        ["store"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/store.lua",
          ["default"] = true,
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 23936,
          ["path"] = "plugins/animation.lua",
          ["default"] = false,
        },
        ["canvas"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
          ["default"] = false,
        },
        ["responsive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["size"] = 5529,
          ["path"] = "plugins/responsive.lua",
          ["default"] = false,
        },
      },
    },
  },
}