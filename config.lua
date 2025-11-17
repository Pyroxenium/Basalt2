return {
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
        },
        ["responsive"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 5529,
          ["path"] = "plugins/responsive.lua",
        },
        ["debug"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
        },
        ["benchmark"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
        },
        ["store"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["path"] = "plugins/store.lua",
        },
        ["reactive"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 11893,
          ["path"] = "plugins/reactive.lua",
        },
        ["animation"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 23936,
          ["path"] = "plugins/animation.lua",
        },
        ["canvas"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
        },
        ["theme"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 9028,
          ["path"] = "plugins/theme.lua",
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["collectionentry"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
        },
        ["colorHex"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
        },
        ["utils"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
        },
        ["expect"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18433,
          ["path"] = "propertySystem.lua",
        },
        ["render"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 12422,
          ["path"] = "render.lua",
        },
        ["errorManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
        },
        ["layoutManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3633,
          ["path"] = "layoutManager.lua",
        },
        ["elementManager"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
        },
        ["main"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 19883,
          ["path"] = "main.lua",
        },
        ["init"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 622,
          ["path"] = "init.lua",
        },
        ["log"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
          ["path"] = "log.lua",
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4549,
          ["path"] = "elements/Display.lua",
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2987,
          ["path"] = "elements/Label.lua",
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2461,
          ["path"] = "elements/Button.lua",
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18777,
          ["path"] = "elements/BaseElement.lua",
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15714,
          ["path"] = "elements/List.lua",
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15169,
          ["path"] = "elements/Accordion.lua",
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3748,
          ["path"] = "elements/CheckBox.lua",
        },
        ["BigFont"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21675,
          ["path"] = "elements/BigFont.lua",
        },
        ["LineChart"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3228,
          ["path"] = "elements/LineChart.lua",
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8972,
          ["path"] = "elements/BaseFrame.lua",
        },
        ["Program"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12944,
          ["path"] = "elements/Program.lua",
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8194,
          ["path"] = "elements/DropDown.lua",
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8784,
          ["path"] = "elements/Toast.lua",
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 7045,
          ["path"] = "elements/Graph.lua",
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = false,
          ["requires"] = {
            [1] = "Frame",
          },
          ["size"] = 9125,
          ["path"] = "elements/Dialog.lua",
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8058,
          ["path"] = "elements/Collection.lua",
        },
        ["Slider"] = {
          ["description"] = "A slider control element for selecting a value within a range.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5211,
          ["path"] = "elements/Slider.lua",
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 27731,
          ["path"] = "elements/Container.lua",
        },
        ["Table"] = {
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25766,
          ["path"] = "elements/Table.lua",
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9941,
          ["path"] = "elements/ScrollBar.lua",
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 14122,
          ["path"] = "elements/Menu.lua",
        },
        ["Tree"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22552,
          ["path"] = "elements/Tree.lua",
        },
        ["Timer"] = {
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2962,
          ["path"] = "elements/Timer.lua",
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 22429,
          ["path"] = "elements/SideNav.lua",
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 17832,
          ["path"] = "elements/ScrollFrame.lua",
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10836,
          ["path"] = "elements/ContextMenu.lua",
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3440,
          ["path"] = "elements/ProgressBar.lua",
        },
        ["Breadcrumb"] = {
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4461,
          ["path"] = "elements/Breadcrumb.lua",
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6702,
          ["path"] = "elements/Frame.lua",
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 45330,
          ["path"] = "elements/VisualElement.lua",
        },
        ["Image"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 15372,
          ["path"] = "elements/Image.lua",
        },
        ["BarChart"] = {
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3547,
          ["path"] = "elements/BarChart.lua",
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10509,
          ["path"] = "elements/Input.lua",
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 21136,
          ["path"] = "elements/TabControl.lua",
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 44462,
          ["path"] = "elements/TextBox.lua",
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3375,
          ["path"] = "elements/Switch.lua",
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15143,
          ["path"] = "elements/ComboBox.lua",
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Mon Nov 17 21:16:13 2025",
  },
}