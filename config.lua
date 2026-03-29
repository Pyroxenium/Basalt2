return {
  ["metadata"] = {
    ["generated"] = "Sun Mar 29 09:45:13 2026",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["core"] = {
      ["files"] = {
        ["main"] = {
          ["default"] = true,
          ["size"] = 20464,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["log"] = {
          ["default"] = true,
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["render"] = {
          ["default"] = true,
          ["size"] = 11182,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["errorManager"] = {
          ["default"] = true,
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["default"] = true,
          ["size"] = 18433,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["layoutManager"] = {
          ["default"] = true,
          ["size"] = 3633,
          ["path"] = "layoutManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["init"] = {
          ["default"] = true,
          ["size"] = 622,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["elementManager"] = {
          ["default"] = true,
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["debug"] = {
          ["default"] = false,
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["xml"] = {
          ["default"] = false,
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["theme"] = {
          ["default"] = false,
          ["size"] = 9028,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["reactive"] = {
          ["default"] = false,
          ["size"] = 11893,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["animation"] = {
          ["default"] = false,
          ["size"] = 23964,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["benchmark"] = {
          ["default"] = false,
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["responsive"] = {
          ["default"] = false,
          ["size"] = 5529,
          ["path"] = "plugins/responsive.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["canvas"] = {
          ["default"] = false,
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["store"] = {
          ["default"] = true,
          ["size"] = 6896,
          ["path"] = "plugins/store.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Graph"] = {
          ["default"] = false,
          ["size"] = 7045,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
        },
        ["Table"] = {
          ["default"] = false,
          ["size"] = 25766,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
        },
        ["BarChart"] = {
          ["default"] = true,
          ["size"] = 3547,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["CheckBox"] = {
          ["default"] = true,
          ["size"] = 3748,
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["TabControl"] = {
          ["default"] = false,
          ["size"] = 21136,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["ScrollBar"] = {
          ["default"] = false,
          ["size"] = 9941,
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["DropDown"] = {
          ["default"] = false,
          ["size"] = 8194,
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Menu"] = {
          ["default"] = true,
          ["size"] = 14122,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["LineChart"] = {
          ["default"] = true,
          ["size"] = 3228,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["Button"] = {
          ["default"] = true,
          ["size"] = 2461,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["Dialog"] = {
          ["default"] = false,
          ["size"] = 9991,
          ["path"] = "elements/Dialog.lua",
          ["requires"] = {
            [1] = "Frame",
          },
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
        },
        ["ContextMenu"] = {
          ["default"] = false,
          ["size"] = 10836,
          ["path"] = "elements/ContextMenu.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
        },
        ["Input"] = {
          ["default"] = true,
          ["size"] = 10411,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
        },
        ["Container"] = {
          ["default"] = true,
          ["size"] = 27863,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Program"] = {
          ["default"] = false,
          ["size"] = 13017,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Timer"] = {
          ["default"] = false,
          ["size"] = 2962,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
        },
        ["ScrollFrame"] = {
          ["default"] = false,
          ["size"] = 17832,
          ["path"] = "elements/ScrollFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
        },
        ["Frame"] = {
          ["default"] = true,
          ["size"] = 6702,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["ComboBox"] = {
          ["default"] = false,
          ["size"] = 15143,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["Accordion"] = {
          ["default"] = false,
          ["size"] = 15169,
          ["path"] = "elements/Accordion.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
        },
        ["Display"] = {
          ["default"] = false,
          ["size"] = 4690,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["Breadcrumb"] = {
          ["default"] = false,
          ["size"] = 4461,
          ["path"] = "elements/Breadcrumb.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A breadcrumb navigation element that displays the current path.",
        },
        ["Switch"] = {
          ["default"] = false,
          ["size"] = 3375,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["Tree"] = {
          ["default"] = false,
          ["size"] = 22552,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["BaseElement"] = {
          ["default"] = true,
          ["size"] = 18780,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["SideNav"] = {
          ["default"] = false,
          ["size"] = 22429,
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
        },
        ["Label"] = {
          ["default"] = true,
          ["size"] = 2987,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["ProgressBar"] = {
          ["default"] = true,
          ["size"] = 3440,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Collection"] = {
          ["default"] = true,
          ["size"] = 8058,
          ["path"] = "elements/Collection.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
        },
        ["Toast"] = {
          ["default"] = false,
          ["size"] = 8784,
          ["path"] = "elements/Toast.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A toast notification element that displays temporary messages.",
        },
        ["BaseFrame"] = {
          ["default"] = true,
          ["size"] = 8924,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["BigFont"] = {
          ["default"] = false,
          ["size"] = 21637,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["Image"] = {
          ["default"] = true,
          ["size"] = 16759,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
        },
        ["TextBox"] = {
          ["default"] = false,
          ["size"] = 45246,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["Slider"] = {
          ["default"] = false,
          ["size"] = 5211,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A slider control element for selecting a value within a range.",
        },
        ["List"] = {
          ["default"] = true,
          ["size"] = 15714,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
        },
        ["VisualElement"] = {
          ["default"] = true,
          ["size"] = 46417,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
      },
      ["description"] = "UI Elements",
    },
    ["libraries"] = {
      ["files"] = {
        ["expect"] = {
          ["default"] = true,
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["colorHex"] = {
          ["default"] = true,
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["collectionentry"] = {
          ["default"] = true,
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
        ["utils"] = {
          ["default"] = true,
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
  },
}