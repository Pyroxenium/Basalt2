return {
  ["categories"] = {
    ["plugins"] = {
      ["files"] = {
        ["reactive"] = {
          ["size"] = 11893,
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["xml"] = {
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["canvas"] = {
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["theme"] = {
          ["size"] = 9028,
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["animation"] = {
          ["size"] = 23936,
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["benchmark"] = {
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["responsive"] = {
          ["size"] = 5529,
          ["path"] = "plugins/responsive.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["debug"] = {
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
        },
      },
      ["description"] = "Plugins",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["size"] = 622,
          ["path"] = "init.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["render"] = {
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 18433,
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["main"] = {
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["layoutManager"] = {
          ["size"] = 3633,
          ["path"] = "layoutManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["elementManager"] = {
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["Dialog"] = {
          ["size"] = 9125,
          ["path"] = "elements/Dialog.lua",
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["size"] = 3748,
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Switch"] = {
          ["size"] = 3375,
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Program"] = {
          ["size"] = 12833,
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["ContextMenu"] = {
          ["size"] = 10836,
          ["path"] = "elements/ContextMenu.lua",
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
        },
        ["Table"] = {
          ["size"] = 25766,
          ["path"] = "elements/Table.lua",
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = false,
        },
        ["LineChart"] = {
          ["size"] = 3228,
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["Input"] = {
          ["size"] = 9456,
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Button"] = {
          ["size"] = 2461,
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Toast"] = {
          ["size"] = 7945,
          ["path"] = "elements/Toast.lua",
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Container"] = {
          ["size"] = 27731,
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Timer"] = {
          ["size"] = 2962,
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = false,
        },
        ["Slider"] = {
          ["size"] = 5211,
          ["path"] = "elements/Slider.lua",
          ["description"] = "A slider control element for selecting a value within a range.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["ScrollFrame"] = {
          ["size"] = 17832,
          ["path"] = "elements/ScrollFrame.lua",
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
        },
        ["ComboBox"] = {
          ["size"] = 15476,
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
        },
        ["Breadcrumb"] = {
          ["size"] = 4461,
          ["path"] = "elements/Breadcrumb.lua",
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Frame"] = {
          ["size"] = 6702,
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 22552,
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["size"] = 3440,
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["BigFont"] = {
          ["size"] = 21675,
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Display"] = {
          ["size"] = 4549,
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["Graph"] = {
          ["size"] = 7045,
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["default"] = false,
        },
        ["List"] = {
          ["size"] = 15714,
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
        },
        ["Label"] = {
          ["size"] = 2987,
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["TabControl"] = {
          ["size"] = 21136,
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
        },
        ["Image"] = {
          ["size"] = 15372,
          ["path"] = "elements/Image.lua",
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["DropDown"] = {
          ["size"] = 8194,
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
        },
        ["Menu"] = {
          ["size"] = 14122,
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
        },
        ["SideNav"] = {
          ["size"] = 22429,
          ["path"] = "elements/SideNav.lua",
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
        },
        ["ScrollBar"] = {
          ["size"] = 9941,
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["size"] = 18777,
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["size"] = 8972,
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
        },
        ["Collection"] = {
          ["size"] = 8133,
          ["path"] = "elements/Collection.lua",
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
        },
        ["Accordion"] = {
          ["size"] = 15169,
          ["path"] = "elements/Accordion.lua",
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
        },
        ["TextBox"] = {
          ["size"] = 44462,
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["size"] = 45338,
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
        },
        ["BarChart"] = {
          ["size"] = 3547,
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Wed Nov 12 22:14:34 2025",
  },
}