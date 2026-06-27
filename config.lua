return {
  ["metadata"] = {
    ["generated"] = "Sat Jun 27 07:26:09 2026",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["render"] = {
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["size"] = 11182,
          ["description"] = "",
          ["default"] = true,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["size"] = 19700,
          ["description"] = "",
          ["default"] = true,
        },
        ["layoutManager"] = {
          ["path"] = "layoutManager.lua",
          ["requires"] = {
          },
          ["size"] = 3633,
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["size"] = 3142,
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["size"] = 3789,
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["size"] = 622,
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["size"] = 18433,
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["size"] = 15411,
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["size"] = 2661,
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["size"] = 132,
          ["description"] = "",
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["path"] = "libraries/collectionentry.lua",
          ["requires"] = {
          },
          ["size"] = 3551,
          ["description"] = "",
          ["default"] = true,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["size"] = 846,
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["size"] = 9028,
          ["description"] = "",
          ["default"] = false,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["size"] = 11893,
          ["description"] = "",
          ["default"] = false,
        },
        ["responsive"] = {
          ["path"] = "plugins/responsive.lua",
          ["requires"] = {
          },
          ["size"] = 5529,
          ["description"] = "",
          ["default"] = false,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["size"] = 14068,
          ["description"] = "",
          ["default"] = false,
        },
        ["store"] = {
          ["path"] = "plugins/store.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
          ["description"] = "",
          ["default"] = true,
        },
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12604,
          ["description"] = "",
          ["default"] = false,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["size"] = 7897,
          ["description"] = "",
          ["default"] = false,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["size"] = 23964,
          ["description"] = "",
          ["default"] = false,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["size"] = 6274,
          ["description"] = "",
          ["default"] = false,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9941,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["size"] = 3748,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2461,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["size"] = 18780,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8924,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 27863,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3375,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = false,
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15143,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2987,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21637,
          ["description"] = "",
          ["default"] = false,
        },
        ["Collection"] = {
          ["path"] = "elements/Collection.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8125,
          ["description"] = "A collection of items",
          ["default"] = true,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10411,
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Breadcrumb"] = {
          ["path"] = "elements/Breadcrumb.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4461,
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["default"] = false,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 14066,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3440,
          ["description"] = "",
          ["default"] = true,
        },
        ["Dialog"] = {
          ["path"] = "elements/Dialog.lua",
          ["requires"] = {
            [1] = "Frame",
          },
          ["size"] = 9991,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = false,
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 21136,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 46417,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2962,
          ["description"] = "",
          ["default"] = false,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 13017,
          ["description"] = "",
          ["default"] = false,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["size"] = 3228,
          ["description"] = "",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["size"] = 3547,
          ["description"] = "",
          ["default"] = true,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5211,
          ["description"] = "A slider control element for selecting a value within a range.",
          ["default"] = false,
        },
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22552,
          ["description"] = "",
          ["default"] = false,
        },
        ["ContextMenu"] = {
          ["path"] = "elements/ContextMenu.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10836,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = false,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15714,
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["ScrollFrame"] = {
          ["path"] = "elements/ScrollFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 17832,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = false,
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8162,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6702,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16759,
          ["description"] = "",
          ["default"] = true,
        },
        ["Accordion"] = {
          ["path"] = "elements/Accordion.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15169,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = false,
        },
        ["SideNav"] = {
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 22429,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = false,
        },
        ["Toast"] = {
          ["path"] = "elements/Toast.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8784,
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = false,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 45246,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["size"] = 7045,
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25766,
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["default"] = false,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4690,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
        },
      },
    },
  },
}