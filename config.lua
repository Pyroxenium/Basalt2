return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["debug"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6274,
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7897,
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11893,
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12604,
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/theme.lua",
          ["size"] = 9028,
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/animation.lua",
          ["size"] = 18446,
        },
        ["xml"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/xml.lua",
          ["size"] = 14068,
        },
        ["responsive"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "plugins/responsive.lua",
          ["size"] = 5529,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
        ["utils"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["init"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 622,
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 18433,
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["render"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["layoutManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "layoutManager.lua",
          ["size"] = 3633,
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
        },
        ["main"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 19883,
        },
        ["log"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
          ["size"] = 7874,
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3228,
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["default"] = false,
          ["path"] = "elements/Breadcrumb.lua",
          ["size"] = 4461,
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = false,
          ["path"] = "elements/TabControl.lua",
          ["size"] = 21136,
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["size"] = 8194,
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21675,
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3440,
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = false,
          ["path"] = "elements/Dialog.lua",
          ["size"] = 9125,
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 45338,
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = false,
          ["path"] = "elements/Toast.lua",
          ["size"] = 7945,
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8972,
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/Tree.lua",
          ["size"] = 22552,
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A slider control element for selecting a value within a range.",
          ["default"] = false,
          ["path"] = "elements/Slider.lua",
          ["size"] = 5211,
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 15143,
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 2987,
        },
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = false,
          ["path"] = "elements/ContextMenu.lua",
          ["size"] = 10836,
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/Timer.lua",
          ["size"] = 2962,
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 44462,
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = false,
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9941,
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 2461,
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 8758,
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = false,
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 17831,
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 7045,
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 18777,
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/Image.lua",
          ["size"] = 15372,
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = false,
          ["path"] = "elements/Switch.lua",
          ["size"] = 3375,
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
          ["path"] = "elements/Program.lua",
          ["size"] = 12833,
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4549,
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = false,
          ["path"] = "elements/SideNav.lua",
          ["size"] = 22429,
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = false,
          ["path"] = "elements/Accordion.lua",
          ["size"] = 15169,
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["default"] = false,
          ["path"] = "elements/Table.lua",
          ["size"] = 25766,
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 9456,
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3547,
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 6702,
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 15714,
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 27731,
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3748,
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Nov  5 12:56:48 2025",
  },
}