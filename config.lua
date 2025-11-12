return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["expect"] = {
          ["default"] = true,
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["collectionentry"] = {
          ["default"] = true,
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["layoutManager"] = {
          ["default"] = true,
          ["size"] = 3633,
          ["path"] = "layoutManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["main"] = {
          ["default"] = true,
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 622,
          ["path"] = "init.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 18433,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["ScrollFrame"] = {
          ["default"] = false,
          ["size"] = 17831,
          ["path"] = "elements/ScrollFrame.lua",
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 18777,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 2461,
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["BigFont"] = {
          ["default"] = false,
          ["size"] = 21675,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 27731,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 44462,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 15714,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["BarChart"] = {
          ["default"] = true,
          ["size"] = 3547,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["Toast"] = {
          ["default"] = false,
          ["size"] = 7945,
          ["path"] = "elements/Toast.lua",
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Tree"] = {
          ["default"] = false,
          ["size"] = 22552,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["size"] = 3748,
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
        },
        ["Breadcrumb"] = {
          ["default"] = false,
          ["size"] = 4461,
          ["path"] = "elements/Breadcrumb.lua",
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 3440,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Program"] = {
          ["default"] = false,
          ["size"] = 12833,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["DropDown"] = {
          ["default"] = false,
          ["size"] = 8194,
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Switch"] = {
          ["default"] = false,
          ["size"] = 3375,
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["LineChart"] = {
          ["default"] = true,
          ["size"] = 3228,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["SideNav"] = {
          ["default"] = false,
          ["size"] = 22429,
          ["path"] = "elements/SideNav.lua",
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Graph"] = {
          ["default"] = false,
          ["size"] = 7045,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
        },
        ["Display"] = {
          ["default"] = false,
          ["size"] = 4549,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Image"] = {
          ["default"] = true,
          ["size"] = 15372,
          ["path"] = "elements/Image.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 45338,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
        ["ScrollBar"] = {
          ["default"] = false,
          ["size"] = 9941,
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Table"] = {
          ["default"] = false,
          ["size"] = 25766,
          ["path"] = "elements/Table.lua",
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["requires"] = {
            [1] = "Collection",
          },
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 6702,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Accordion"] = {
          ["default"] = false,
          ["size"] = 15169,
          ["path"] = "elements/Accordion.lua",
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 2987,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Dialog"] = {
          ["default"] = false,
          ["size"] = 9125,
          ["path"] = "elements/Dialog.lua",
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
        },
        ["ContextMenu"] = {
          ["default"] = false,
          ["size"] = 10836,
          ["path"] = "elements/ContextMenu.lua",
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 14123,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 9456,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["TabControl"] = {
          ["default"] = false,
          ["size"] = 21136,
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Slider"] = {
          ["default"] = false,
          ["size"] = 5211,
          ["path"] = "elements/Slider.lua",
          ["description"] = "A slider control element for selecting a value within a range.",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["Collection"] = {
          ["default"] = true,
          ["size"] = 7874,
          ["path"] = "elements/Collection.lua",
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["size"] = 15143,
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 8972,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
        },
        ["Timer"] = {
          ["default"] = false,
          ["size"] = 2962,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["default"] = false,
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["reactive"] = {
          ["default"] = false,
          ["size"] = 11893,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["theme"] = {
          ["default"] = false,
          ["size"] = 9028,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["canvas"] = {
          ["default"] = false,
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["xml"] = {
          ["default"] = false,
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["animation"] = {
          ["default"] = false,
          ["size"] = 23936,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["responsive"] = {
          ["default"] = false,
          ["size"] = 5529,
          ["path"] = "plugins/responsive.lua",
          ["description"] = "",
          ["requires"] = {
          },
        },
        ["benchmark"] = {
          ["default"] = false,
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
        },
      },
      ["description"] = "Plugins",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Nov  5 15:20:56 2025",
  },
}