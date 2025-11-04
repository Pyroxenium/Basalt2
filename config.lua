return {
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Nov  4 21:41:15 2025",
  },
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["utils"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
          ["default"] = true,
          ["description"] = "",
        },
        ["collectionentry"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
          ["default"] = true,
          ["description"] = "",
        },
        ["expect"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
          ["default"] = true,
          ["description"] = "",
        },
        ["colorHex"] = {
          ["requires"] = {
          },
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["init"] = {
          ["requires"] = {
          },
          ["path"] = "init.lua",
          ["size"] = 622,
          ["default"] = true,
          ["description"] = "",
        },
        ["elementManager"] = {
          ["requires"] = {
          },
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
          ["default"] = true,
          ["description"] = "",
        },
        ["errorManager"] = {
          ["requires"] = {
          },
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
          ["default"] = true,
          ["description"] = "",
        },
        ["log"] = {
          ["requires"] = {
          },
          ["path"] = "log.lua",
          ["size"] = 3142,
          ["default"] = true,
          ["description"] = "",
        },
        ["propertySystem"] = {
          ["requires"] = {
          },
          ["path"] = "propertySystem.lua",
          ["size"] = 18186,
          ["default"] = true,
          ["description"] = "",
        },
        ["render"] = {
          ["requires"] = {
          },
          ["path"] = "render.lua",
          ["size"] = 12422,
          ["default"] = true,
          ["description"] = "",
        },
        ["layoutManager"] = {
          ["requires"] = {
          },
          ["path"] = "layoutManager.lua",
          ["size"] = 3634,
          ["default"] = true,
          ["description"] = "",
        },
        ["main"] = {
          ["requires"] = {
          },
          ["path"] = "main.lua",
          ["size"] = 19883,
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "Core Files",
    },
    ["elements"] = {
      ["files"] = {
        ["ContextMenu"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ContextMenu.lua",
          ["size"] = 10836,
          ["default"] = false,
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
        },
        ["Table"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/Table.lua",
          ["size"] = 25766,
          ["default"] = false,
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
        },
        ["Input"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Input.lua",
          ["size"] = 9456,
          ["default"] = true,
          ["description"] = "A text input field with various features",
        },
        ["BaseElement"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 18432,
          ["default"] = true,
          ["description"] = "The base class for all UI elements in Basalt.",
        },
        ["BarChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3547,
          ["default"] = true,
          ["description"] = "",
        },
        ["List"] = {
          ["requires"] = {
            [1] = "Collection",
          },
          ["path"] = "elements/List.lua",
          ["size"] = 15754,
          ["default"] = true,
          ["description"] = "A scrollable list of selectable items",
        },
        ["BaseFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8972,
          ["default"] = true,
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
        },
        ["Switch"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Switch.lua",
          ["size"] = 3375,
          ["default"] = false,
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
        },
        ["Image"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Image.lua",
          ["size"] = 15372,
          ["default"] = true,
          ["description"] = "",
        },
        ["Program"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Program.lua",
          ["size"] = 12833,
          ["default"] = false,
          ["description"] = "",
        },
        ["ProgressBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3440,
          ["default"] = true,
          ["description"] = "",
        },
        ["TabControl"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/TabControl.lua",
          ["size"] = 21136,
          ["default"] = false,
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
        },
        ["Accordion"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Accordion.lua",
          ["size"] = 15169,
          ["default"] = false,
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
        },
        ["SideNav"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/SideNav.lua",
          ["size"] = 22429,
          ["default"] = false,
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
        },
        ["Toast"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Toast.lua",
          ["size"] = 7945,
          ["default"] = false,
          ["description"] = "A toast notification element that displays temporary messages.",
        },
        ["Timer"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/Timer.lua",
          ["size"] = 2962,
          ["default"] = false,
          ["description"] = "",
        },
        ["Display"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Display.lua",
          ["size"] = 4549,
          ["default"] = false,
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
        },
        ["Button"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Button.lua",
          ["size"] = 2461,
          ["default"] = true,
          ["description"] = "The Button is a standard button element with click handling and state management.",
        },
        ["Slider"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Slider.lua",
          ["size"] = 5211,
          ["default"] = false,
          ["description"] = "A slider control element for selecting a value within a range.",
        },
        ["DropDown"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/DropDown.lua",
          ["size"] = 7988,
          ["default"] = false,
          ["description"] = "A DropDown menu that shows a list of selectable items",
        },
        ["Label"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Label.lua",
          ["size"] = 3184,
          ["default"] = true,
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
        },
        ["ScrollBar"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9941,
          ["default"] = false,
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
        },
        ["Frame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/Frame.lua",
          ["size"] = 6742,
          ["default"] = true,
          ["description"] = "A frame element that serves as a grouping container for other elements.",
        },
        ["CheckBox"] = {
          ["requires"] = {
          },
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3748,
          ["default"] = true,
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
        },
        ["BigFont"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21675,
          ["default"] = false,
          ["description"] = "",
        },
        ["TextBox"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/TextBox.lua",
          ["size"] = 44462,
          ["default"] = false,
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
        },
        ["VisualElement"] = {
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 45338,
          ["default"] = true,
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
        },
        ["Dialog"] = {
          ["requires"] = {
            [1] = "Frame",
          },
          ["path"] = "elements/Dialog.lua",
          ["size"] = 9125,
          ["default"] = false,
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
        },
        ["Breadcrumb"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Breadcrumb.lua",
          ["size"] = 4461,
          ["default"] = false,
          ["description"] = "A breadcrumb navigation element that displays the current path.",
        },
        ["Collection"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Collection.lua",
          ["size"] = 7874,
          ["default"] = true,
          ["description"] = "A collection of items",
        },
        ["ScrollFrame"] = {
          ["requires"] = {
            [1] = "Container",
          },
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 17831,
          ["default"] = false,
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
        },
        ["Tree"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Tree.lua",
          ["size"] = 22552,
          ["default"] = false,
          ["description"] = "",
        },
        ["Menu"] = {
          ["requires"] = {
            [1] = "List",
          },
          ["path"] = "elements/Menu.lua",
          ["size"] = 8758,
          ["default"] = true,
          ["description"] = "A horizontal menu bar with selectable items.",
        },
        ["ComboBox"] = {
          ["requires"] = {
            [1] = "DropDown",
          },
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 15143,
          ["default"] = false,
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
        },
        ["Container"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "elements/Container.lua",
          ["size"] = 27731,
          ["default"] = true,
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
        },
        ["Graph"] = {
          ["requires"] = {
          },
          ["path"] = "elements/Graph.lua",
          ["size"] = 7045,
          ["default"] = false,
          ["description"] = "A point based graph element",
        },
        ["LineChart"] = {
          ["requires"] = {
          },
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3228,
          ["default"] = true,
          ["description"] = "",
        },
      },
      ["description"] = "UI Elements",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/xml.lua",
          ["size"] = 14068,
          ["default"] = false,
          ["description"] = "",
        },
        ["canvas"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7897,
          ["default"] = false,
          ["description"] = "",
        },
        ["debug"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/debug.lua",
          ["size"] = 6274,
          ["default"] = false,
          ["description"] = "",
        },
        ["reactive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11869,
          ["default"] = false,
          ["description"] = "",
        },
        ["benchmark"] = {
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12604,
          ["default"] = false,
          ["description"] = "",
        },
        ["theme"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/theme.lua",
          ["size"] = 6801,
          ["default"] = false,
          ["description"] = "",
        },
        ["responsive"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/responsive.lua",
          ["size"] = 5529,
          ["default"] = false,
          ["description"] = "",
        },
        ["animation"] = {
          ["requires"] = {
          },
          ["path"] = "plugins/animation.lua",
          ["size"] = 18446,
          ["default"] = false,
          ["description"] = "",
        },
      },
      ["description"] = "Plugins",
    },
  },
}