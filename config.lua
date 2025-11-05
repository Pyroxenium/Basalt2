return {
  ["categories"] = {
    ["libraries"] = {
      ["files"] = {
        ["collectionentry"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/collectionentry.lua",
          ["size"] = 3551,
        },
        ["utils"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/utils.lua",
          ["size"] = 2661,
        },
        ["expect"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/expect.lua",
          ["size"] = 846,
        },
        ["colorHex"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "libraries/colorHex.lua",
          ["size"] = 132,
        },
      },
      ["description"] = "Libraries",
    },
    ["core"] = {
      ["files"] = {
        ["render"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "render.lua",
          ["size"] = 12422,
        },
        ["errorManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "errorManager.lua",
          ["size"] = 3789,
        },
        ["main"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "main.lua",
          ["size"] = 19883,
        },
        ["init"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "init.lua",
          ["size"] = 622,
        },
        ["log"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "log.lua",
          ["size"] = 3142,
        },
        ["layoutManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "layoutManager.lua",
          ["size"] = 3634,
        },
        ["elementManager"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elementManager.lua",
          ["size"] = 15411,
        },
        ["propertySystem"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "propertySystem.lua",
          ["size"] = 18307,
        },
      },
      ["description"] = "Core Files",
    },
    ["plugins"] = {
      ["files"] = {
        ["xml"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/xml.lua",
          ["size"] = 14068,
        },
        ["canvas"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/canvas.lua",
          ["size"] = 7897,
        },
        ["debug"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/debug.lua",
          ["size"] = 6274,
        },
        ["reactive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/reactive.lua",
          ["size"] = 11893,
        },
        ["responsive"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/responsive.lua",
          ["size"] = 5529,
        },
        ["theme"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/theme.lua",
          ["size"] = 6801,
        },
        ["animation"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "plugins/animation.lua",
          ["size"] = 18446,
        },
        ["benchmark"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "plugins/benchmark.lua",
          ["size"] = 12604,
        },
      },
      ["description"] = "Plugins",
    },
    ["elements"] = {
      ["files"] = {
        ["Display"] = {
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Display.lua",
          ["size"] = 4549,
        },
        ["DropDown"] = {
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = false,
          ["path"] = "elements/DropDown.lua",
          ["size"] = 7988,
        },
        ["Switch"] = {
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Switch.lua",
          ["size"] = 3375,
        },
        ["BaseFrame"] = {
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/BaseFrame.lua",
          ["size"] = 8972,
        },
        ["Table"] = {
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = false,
          ["path"] = "elements/Table.lua",
          ["size"] = 25766,
        },
        ["Slider"] = {
          ["description"] = "A slider control element for selecting a value within a range.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Slider.lua",
          ["size"] = 5211,
        },
        ["Input"] = {
          ["description"] = "A text input field with various features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Input.lua",
          ["size"] = 9456,
        },
        ["Collection"] = {
          ["description"] = "A collection of items",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Collection.lua",
          ["size"] = 7874,
        },
        ["TextBox"] = {
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/TextBox.lua",
          ["size"] = 44462,
        },
        ["BarChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/BarChart.lua",
          ["size"] = 3547,
        },
        ["Accordion"] = {
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
          ["path"] = "elements/Accordion.lua",
          ["size"] = 15169,
        },
        ["Dialog"] = {
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["requires"] = {
            [1] = "Frame",
          },
          ["default"] = false,
          ["path"] = "elements/Dialog.lua",
          ["size"] = 9125,
        },
        ["Toast"] = {
          ["description"] = "A toast notification element that displays temporary messages.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Toast.lua",
          ["size"] = 7945,
        },
        ["BigFont"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/BigFont.lua",
          ["size"] = 21675,
        },
        ["TabControl"] = {
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
          ["path"] = "elements/TabControl.lua",
          ["size"] = 21136,
        },
        ["SideNav"] = {
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
          ["path"] = "elements/SideNav.lua",
          ["size"] = 22429,
        },
        ["CheckBox"] = {
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/CheckBox.lua",
          ["size"] = 3748,
        },
        ["Image"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Image.lua",
          ["size"] = 15372,
        },
        ["Menu"] = {
          ["description"] = "A horizontal menu bar with selectable items.",
          ["requires"] = {
            [1] = "List",
          },
          ["default"] = true,
          ["path"] = "elements/Menu.lua",
          ["size"] = 8758,
        },
        ["Frame"] = {
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = true,
          ["path"] = "elements/Frame.lua",
          ["size"] = 6742,
        },
        ["ContextMenu"] = {
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
          ["path"] = "elements/ContextMenu.lua",
          ["size"] = 10836,
        },
        ["List"] = {
          ["description"] = "A scrollable list of selectable items",
          ["requires"] = {
            [1] = "Collection",
          },
          ["default"] = true,
          ["path"] = "elements/List.lua",
          ["size"] = 15754,
        },
        ["BaseElement"] = {
          ["description"] = "The base class for all UI elements in Basalt.",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/BaseElement.lua",
          ["size"] = 18468,
        },
        ["Program"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Program.lua",
          ["size"] = 12833,
        },
        ["ProgressBar"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/ProgressBar.lua",
          ["size"] = 3440,
        },
        ["Label"] = {
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Label.lua",
          ["size"] = 3184,
        },
        ["LineChart"] = {
          ["description"] = "",
          ["requires"] = {
          },
          ["default"] = true,
          ["path"] = "elements/LineChart.lua",
          ["size"] = 3228,
        },
        ["ScrollBar"] = {
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/ScrollBar.lua",
          ["size"] = 9941,
        },
        ["Button"] = {
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Button.lua",
          ["size"] = 2461,
        },
        ["Tree"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Tree.lua",
          ["size"] = 22552,
        },
        ["Container"] = {
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = true,
          ["path"] = "elements/Container.lua",
          ["size"] = 27731,
        },
        ["VisualElement"] = {
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = true,
          ["path"] = "elements/VisualElement.lua",
          ["size"] = 45338,
        },
        ["ScrollFrame"] = {
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["requires"] = {
            [1] = "Container",
          },
          ["default"] = false,
          ["path"] = "elements/ScrollFrame.lua",
          ["size"] = 17831,
        },
        ["Timer"] = {
          ["description"] = "",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["default"] = false,
          ["path"] = "elements/Timer.lua",
          ["size"] = 2962,
        },
        ["Breadcrumb"] = {
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["default"] = false,
          ["path"] = "elements/Breadcrumb.lua",
          ["size"] = 4461,
        },
        ["ComboBox"] = {
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["default"] = false,
          ["path"] = "elements/ComboBox.lua",
          ["size"] = 15143,
        },
        ["Graph"] = {
          ["description"] = "A point based graph element",
          ["requires"] = {
          },
          ["default"] = false,
          ["path"] = "elements/Graph.lua",
          ["size"] = 7045,
        },
      },
      ["description"] = "UI Elements",
    },
  },
  ["metadata"] = {
    ["generated"] = "Wed Nov  5 00:37:16 2025",
    ["version"] = "2.0",
  },
}