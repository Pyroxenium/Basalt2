return {
  ["metadata"] = {
    ["generated"] = "Sun Jun 14 08:57:31 2026",
    ["version"] = "2.0",
  },
  ["categories"] = {
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["expect"] = {
          ["size"] = 846,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["size"] = 3551,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/collectionentry.lua",
          ["default"] = true,
        },
        ["utils"] = {
          ["size"] = 2661,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["reactive"] = {
          ["size"] = 11893,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["default"] = false,
        },
        ["debug"] = {
          ["size"] = 6274,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["default"] = false,
        },
        ["benchmark"] = {
          ["size"] = 12604,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["default"] = false,
        },
        ["canvas"] = {
          ["size"] = 7897,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["default"] = false,
        },
        ["theme"] = {
          ["size"] = 9028,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["default"] = false,
        },
        ["store"] = {
          ["size"] = 6896,
          ["description"] = "",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "plugins/store.lua",
          ["default"] = true,
        },
        ["xml"] = {
          ["size"] = 14068,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["default"] = false,
        },
        ["responsive"] = {
          ["size"] = 5529,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/responsive.lua",
          ["default"] = false,
        },
        ["animation"] = {
          ["size"] = 23964,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["default"] = false,
        },
      },
    },
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["elementManager"] = {
          ["size"] = 15411,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["default"] = true,
        },
        ["init"] = {
          ["size"] = 622,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 18433,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["default"] = true,
        },
        ["layoutManager"] = {
          ["size"] = 3633,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "layoutManager.lua",
          ["default"] = true,
        },
        ["render"] = {
          ["size"] = 11182,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["default"] = true,
        },
        ["main"] = {
          ["size"] = 20464,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Table"] = {
          ["size"] = 25766,
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/Table.lua",
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["size"] = 3748,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
          ["default"] = true,
        },
        ["BigFont"] = {
          ["size"] = 21637,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["default"] = false,
        },
        ["TextBox"] = {
          ["size"] = 45246,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["default"] = false,
        },
        ["List"] = {
          ["size"] = 15714,
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/List.lua",
          ["default"] = true,
        },
        ["Program"] = {
          ["size"] = 13017,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["default"] = false,
        },
        ["Accordion"] = {
          ["size"] = 15169,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Accordion.lua",
          ["default"] = false,
        },
        ["LineChart"] = {
          ["size"] = 3228,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["default"] = true,
        },
        ["ScrollFrame"] = {
          ["size"] = 17832,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ScrollFrame.lua",
          ["default"] = false,
        },
        ["Graph"] = {
          ["size"] = 7045,
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["default"] = false,
        },
        ["BaseFrame"] = {
          ["size"] = 8924,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["default"] = true,
        },
        ["Menu"] = {
          ["size"] = 14066,
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 22552,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["size"] = 3440,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["default"] = true,
        },
        ["DropDown"] = {
          ["size"] = 8194,
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
          ["default"] = false,
        },
        ["Dialog"] = {
          ["size"] = 9991,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
          ["path"] = "elements/Dialog.lua",
          ["default"] = false,
        },
        ["Switch"] = {
          ["size"] = 3375,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["default"] = false,
        },
        ["Image"] = {
          ["size"] = 16759,
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["default"] = true,
        },
        ["Container"] = {
          ["size"] = 27863,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["default"] = true,
        },
        ["Collection"] = {
          ["size"] = 8122,
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Collection.lua",
          ["default"] = true,
        },
        ["ContextMenu"] = {
          ["size"] = 10836,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ContextMenu.lua",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["size"] = 46417,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["default"] = true,
        },
        ["BaseElement"] = {
          ["size"] = 18780,
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["default"] = true,
        },
        ["Toast"] = {
          ["size"] = 8784,
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Toast.lua",
          ["default"] = false,
        },
        ["Breadcrumb"] = {
          ["size"] = 4461,
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Breadcrumb.lua",
          ["default"] = false,
        },
        ["Slider"] = {
          ["size"] = 5211,
          ["description"] = "A slider control element for selecting a value within a range.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["default"] = false,
        },
        ["Frame"] = {
          ["size"] = 6702,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["default"] = true,
        },
        ["ComboBox"] = {
          ["size"] = 15143,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
          ["default"] = false,
        },
        ["SideNav"] = {
          ["size"] = 22429,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/SideNav.lua",
          ["default"] = false,
        },
        ["Label"] = {
          ["size"] = 2987,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["size"] = 3547,
          ["description"] = "",
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["default"] = true,
        },
        ["Input"] = {
          ["size"] = 10411,
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["default"] = true,
        },
        ["Button"] = {
          ["size"] = 2461,
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["default"] = true,
        },
        ["TabControl"] = {
          ["size"] = 21136,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
          ["default"] = false,
        },
        ["Display"] = {
          ["size"] = 4690,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["default"] = false,
        },
        ["ScrollBar"] = {
          ["size"] = 9941,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
          ["default"] = false,
        },
        ["Timer"] = {
          ["size"] = 2962,
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["default"] = false,
        },
      },
    },
  },
}