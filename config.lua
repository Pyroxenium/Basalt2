return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Nov  5 13:15:01 2025",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["main"] = {
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 19883,
        },
        ["layoutManager"] = {
          ["requires"] = {
          },
          ["path"] = "layoutManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3633,
        },
        ["init"] = {
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 622,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15411,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 12422,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3142,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3789,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 18433,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["size"] = 2461,
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = false,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["size"] = 9941,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["size"] = 8758,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["size"] = 45338,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["size"] = 27731,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 2962,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3228,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 21675,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["size"] = 2987,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["description"] = "A text input field with various features",
          ["size"] = 9456,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["size"] = 44462,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = false,
          ["description"] = "A slider control element for selecting a value within a range.",
          ["size"] = 5211,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 22552,
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = false,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["size"] = 17831,
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
          ["default"] = false,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["size"] = 21136,
        },
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = false,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["size"] = 10836,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
          ["size"] = 15714,
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/SideNav.lua",
          ["default"] = false,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["size"] = 22429,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["description"] = "A point based graph element",
          ["size"] = 7045,
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["size"] = 3748,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["size"] = 8972,
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = false,
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["size"] = 4461,
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["size"] = 15143,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["size"] = 6702,
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["path"] = "elements/Dialog.lua",
          ["default"] = false,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["size"] = 9125,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 12833,
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Accordion.lua",
          ["default"] = false,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["size"] = 15169,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 15372,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["size"] = 4549,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3547,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["default"] = false,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["size"] = 3375,
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["size"] = 8194,
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
          ["description"] = "A collection of items",
          ["size"] = 7874,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = false,
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["size"] = 25766,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3440,
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Toast.lua",
          ["default"] = false,
          ["description"] = "A toast notification element that displays temporary messages.",
          ["size"] = 7945,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["size"] = 18777,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["debug"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 6274,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 7897,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 9028,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 12604,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 14068,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 23936,
        },
        ["responsive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/responsive.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 5529,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = false,
          ["description"] = "",
          ["size"] = 11893,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 3551,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 132,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["description"] = "",
          ["size"] = 2661,
        },
      },
    },
  },
}