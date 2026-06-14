return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Sun Jun 14 09:03:11 2026",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
          ["size"] = 3551,
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
          ["size"] = 846,
        },
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
          ["size"] = 2661,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
          ["size"] = 132,
        },
      },
      ["description"] = "Libraries",
    },
    ["plugins"] = {
      ["files"] = {
        ["responsive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/responsive.lua",
          ["default"] = false,
          ["size"] = 5529,
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = false,
          ["size"] = 9028,
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = false,
          ["size"] = 23964,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = false,
          ["size"] = 12604,
        },
        ["canvas"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["default"] = false,
          ["size"] = 7897,
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = false,
          ["size"] = 6274,
        },
        ["store"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/store.lua",
          ["default"] = true,
          ["size"] = 6896,
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = false,
          ["size"] = 11893,
        },
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = false,
          ["size"] = 14068,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = false,
          ["size"] = 17832,
        },
        ["Image"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = true,
          ["size"] = 16759,
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
          ["default"] = false,
          ["size"] = 21136,
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Accordion.lua",
          ["default"] = false,
          ["size"] = 15169,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
          ["size"] = 27863,
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = false,
          ["size"] = 10836,
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
          ["size"] = 8125,
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = false,
          ["size"] = 9941,
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
          ["size"] = 15143,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
          ["size"] = 6702,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["default"] = true,
          ["size"] = 3228,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
          ["size"] = 2987,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
          ["size"] = 21637,
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = false,
          ["size"] = 13017,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
          ["size"] = 3547,
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Toast.lua",
          ["default"] = false,
          ["size"] = 8784,
        },
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["default"] = false,
          ["size"] = 4690,
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
          ["size"] = 2461,
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
          ["path"] = "elements/Dialog.lua",
          ["default"] = false,
          ["size"] = 9991,
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = false,
          ["size"] = 22552,
        },
        ["Timer"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["default"] = false,
          ["size"] = 2962,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
          ["size"] = 15714,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
          ["size"] = 46417,
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["default"] = false,
          ["size"] = 3375,
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
          ["size"] = 8162,
        },
        ["Slider"] = {
          ["description"] = "A slider control element for selecting a value within a range.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = false,
          ["size"] = 5211,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
          ["size"] = 18780,
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/SideNav.lua",
          ["default"] = false,
          ["size"] = 22429,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
          ["size"] = 3440,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
          ["size"] = 14066,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
          ["size"] = 8924,
        },
        ["Table"] = {
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = false,
          ["size"] = 25766,
        },
        ["Breadcrumb"] = {
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = false,
          ["size"] = 4461,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
          ["size"] = 45246,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
          ["size"] = 10411,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
          ["size"] = 7045,
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
          ["size"] = 3748,
        },
      },
      ["description"] = "UI Elements",
    },
    ["core"] = {
      ["files"] = {
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
          ["size"] = 3142,
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
          ["size"] = 622,
        },
        ["layoutManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "layoutManager.lua",
          ["default"] = true,
          ["size"] = 3633,
        },
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
          ["size"] = 11182,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
          ["size"] = 3789,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
          ["size"] = 18433,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
          ["size"] = 15411,
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
          ["size"] = 20464,
        },
      },
      ["description"] = "Core Files",
    },
  },
}