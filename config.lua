return {
  ["metadata"] = {
    ["generated"] = "Sun Jun 14 08:58:53 2026",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["benchmark"] = {
          ["path"] = "plugins/benchmark.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 12604,
        },
        ["debug"] = {
          ["path"] = "plugins/debug.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 6274,
        },
        ["canvas"] = {
          ["path"] = "plugins/canvas.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 7897,
        },
        ["responsive"] = {
          ["path"] = "plugins/responsive.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 5529,
        },
        ["xml"] = {
          ["path"] = "plugins/xml.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 14068,
        },
        ["theme"] = {
          ["path"] = "plugins/theme.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 9028,
        },
        ["animation"] = {
          ["path"] = "plugins/animation.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 23964,
        },
        ["reactive"] = {
          ["path"] = "plugins/reactive.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 11893,
        },
        ["store"] = {
          ["path"] = "plugins/store.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6896,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["collectionentry"] = {
          ["path"] = "libraries/collectionentry.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3551,
        },
        ["expect"] = {
          ["path"] = "libraries/expect.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 846,
        },
        ["utils"] = {
          ["path"] = "libraries/utils.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 2661,
        },
        ["colorHex"] = {
          ["path"] = "libraries/colorHex.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 132,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Tree"] = {
          ["path"] = "elements/Tree.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 22552,
        },
        ["BigFont"] = {
          ["path"] = "elements/BigFont.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 21637,
        },
        ["Label"] = {
          ["path"] = "elements/Label.lua",
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2987,
        },
        ["Switch"] = {
          ["path"] = "elements/Switch.lua",
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3375,
        },
        ["TextBox"] = {
          ["path"] = "elements/TextBox.lua",
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 45246,
        },
        ["Slider"] = {
          ["path"] = "elements/Slider.lua",
          ["description"] = "A slider control element for selecting a value within a range.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 5211,
        },
        ["Button"] = {
          ["path"] = "elements/Button.lua",
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 2461,
        },
        ["List"] = {
          ["path"] = "elements/List.lua",
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 15714,
        },
        ["Collection"] = {
          ["path"] = "elements/Collection.lua",
          ["description"] = "A collection of items",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8122,
        },
        ["Image"] = {
          ["path"] = "elements/Image.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 16759,
        },
        ["Dialog"] = {
          ["path"] = "elements/Dialog.lua",
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = false,
          ["requires"] = {
            [1] = "Frame",
          },
          ["size"] = 9991,
        },
        ["CheckBox"] = {
          ["path"] = "elements/CheckBox.lua",
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3748,
        },
        ["BaseElement"] = {
          ["path"] = "elements/BaseElement.lua",
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18780,
        },
        ["Frame"] = {
          ["path"] = "elements/Frame.lua",
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 6702,
        },
        ["LineChart"] = {
          ["path"] = "elements/LineChart.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3228,
        },
        ["SideNav"] = {
          ["path"] = "elements/SideNav.lua",
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 22429,
        },
        ["ComboBox"] = {
          ["path"] = "elements/ComboBox.lua",
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
          ["requires"] = {
            [1] = "DropDown",
          },
          ["size"] = 15143,
        },
        ["Graph"] = {
          ["path"] = "elements/Graph.lua",
          ["description"] = "A point based graph element",
          ["default"] = false,
          ["requires"] = {
          },
          ["size"] = 7045,
        },
        ["Table"] = {
          ["path"] = "elements/Table.lua",
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Collection",
          },
          ["size"] = 25766,
        },
        ["VisualElement"] = {
          ["path"] = "elements/VisualElement.lua",
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 46417,
        },
        ["Display"] = {
          ["path"] = "elements/Display.lua",
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4690,
        },
        ["Container"] = {
          ["path"] = "elements/Container.lua",
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 27863,
        },
        ["Breadcrumb"] = {
          ["path"] = "elements/Breadcrumb.lua",
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 4461,
        },
        ["ContextMenu"] = {
          ["path"] = "elements/ContextMenu.lua",
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 10836,
        },
        ["BarChart"] = {
          ["path"] = "elements/BarChart.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3547,
        },
        ["Program"] = {
          ["path"] = "elements/Program.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 13017,
        },
        ["ProgressBar"] = {
          ["path"] = "elements/ProgressBar.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 3440,
        },
        ["ScrollBar"] = {
          ["path"] = "elements/ScrollBar.lua",
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 9941,
        },
        ["BaseFrame"] = {
          ["path"] = "elements/BaseFrame.lua",
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 8924,
        },
        ["ScrollFrame"] = {
          ["path"] = "elements/ScrollFrame.lua",
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 17832,
        },
        ["Input"] = {
          ["path"] = "elements/Input.lua",
          ["description"] = "A text input field with various features",
          ["default"] = true,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 10411,
        },
        ["TabControl"] = {
          ["path"] = "elements/TabControl.lua",
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 21136,
        },
        ["DropDown"] = {
          ["path"] = "elements/DropDown.lua",
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 8162,
        },
        ["Timer"] = {
          ["path"] = "elements/Timer.lua",
          ["description"] = "",
          ["default"] = false,
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["size"] = 2962,
        },
        ["Toast"] = {
          ["path"] = "elements/Toast.lua",
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = false,
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["size"] = 8784,
        },
        ["Menu"] = {
          ["path"] = "elements/Menu.lua",
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
          ["requires"] = {
            [1] = "List",
          },
          ["size"] = 14066,
        },
        ["Accordion"] = {
          ["path"] = "elements/Accordion.lua",
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = false,
          ["requires"] = {
            [1] = "Container",
          },
          ["size"] = 15169,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["propertySystem"] = {
          ["path"] = "propertySystem.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 18433,
        },
        ["init"] = {
          ["path"] = "init.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 622,
        },
        ["layoutManager"] = {
          ["path"] = "layoutManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3633,
        },
        ["elementManager"] = {
          ["path"] = "elementManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 15411,
        },
        ["main"] = {
          ["path"] = "main.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 20464,
        },
        ["errorManager"] = {
          ["path"] = "errorManager.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3789,
        },
        ["log"] = {
          ["path"] = "log.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 3142,
        },
        ["render"] = {
          ["path"] = "render.lua",
          ["description"] = "",
          ["default"] = true,
          ["requires"] = {
          },
          ["size"] = 11182,
        },
      },
    },
  },
}