return {
  ["categories"] = {
    ["core"] = {
      ["description"] = "Core Files",
      ["files"] = {
        ["main"] = {
          ["size"] = 19883,
          ["path"] = "main.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["errorManager"] = {
          ["size"] = 3789,
          ["path"] = "errorManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["elementManager"] = {
          ["size"] = 15411,
          ["path"] = "elementManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["render"] = {
          ["size"] = 12422,
          ["path"] = "render.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["propertySystem"] = {
          ["size"] = 18186,
          ["path"] = "propertySystem.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["layoutManager"] = {
          ["size"] = 3634,
          ["path"] = "layoutManager.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["init"] = {
          ["size"] = 622,
          ["path"] = "init.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["log"] = {
          ["size"] = 3142,
          ["path"] = "log.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
    ["elements"] = {
      ["description"] = "UI Elements",
      ["files"] = {
        ["Program"] = {
          ["size"] = 12753,
          ["path"] = "elements/Program.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["LineChart"] = {
          ["size"] = 3172,
          ["path"] = "elements/LineChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["BarChart"] = {
          ["size"] = 3507,
          ["path"] = "elements/BarChart.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Timer"] = {
          ["size"] = 2938,
          ["path"] = "elements/Timer.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["List"] = {
          ["size"] = 15474,
          ["path"] = "elements/List.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "A scrollable list of selectable items",
          ["default"] = true,
        },
        ["Image"] = {
          ["size"] = 15076,
          ["path"] = "elements/Image.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Input"] = {
          ["size"] = 9200,
          ["path"] = "elements/Input.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A text input field with various features",
          ["default"] = true,
        },
        ["Collection"] = {
          ["size"] = 7778,
          ["path"] = "elements/Collection.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A collection of items",
          ["default"] = true,
        },
        ["SideNav"] = {
          ["size"] = 22159,
          ["path"] = "elements/SideNav.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A SideNav element that provides sidebar navigation with multiple content areas.",
          ["default"] = false,
        },
        ["ProgressBar"] = {
          ["size"] = 3398,
          ["path"] = "elements/ProgressBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["Label"] = {
          ["size"] = 3088,
          ["path"] = "elements/Label.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A simple text display element that automatically resizes its width based on the text content.",
          ["default"] = true,
        },
        ["TextBox"] = {
          ["size"] = 43530,
          ["path"] = "elements/TextBox.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A multi-line text editor component with cursor support and text manipulation features",
          ["default"] = false,
        },
        ["Display"] = {
          ["size"] = 4493,
          ["path"] = "elements/Display.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Display is a special element which uses the CC Window API which you can use.",
          ["default"] = false,
        },
        ["Graph"] = {
          ["size"] = 6933,
          ["path"] = "elements/Graph.lua",
          ["requires"] = {
          },
          ["description"] = "A point based graph element",
          ["default"] = false,
        },
        ["BaseElement"] = {
          ["size"] = 13870,
          ["path"] = "elements/BaseElement.lua",
          ["requires"] = {
          },
          ["description"] = "The base class for all UI elements in Basalt.",
          ["default"] = true,
        },
        ["Accordion"] = {
          ["size"] = 14937,
          ["path"] = "elements/Accordion.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "An Accordion element that provides collapsible panels with headers.",
          ["default"] = false,
        },
        ["ContextMenu"] = {
          ["size"] = 10660,
          ["path"] = "elements/ContextMenu.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A ContextMenu element that displays a menu with items and submenus.",
          ["default"] = false,
        },
        ["CheckBox"] = {
          ["size"] = 3700,
          ["path"] = "elements/CheckBox.lua",
          ["requires"] = {
          },
          ["description"] = "This is a checkbox. It is a visual element that can be checked.",
          ["default"] = true,
        },
        ["Button"] = {
          ["size"] = 2437,
          ["path"] = "elements/Button.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Button is a standard button element with click handling and state management.",
          ["default"] = true,
        },
        ["Breadcrumb"] = {
          ["size"] = 4381,
          ["path"] = "elements/Breadcrumb.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A breadcrumb navigation element that displays the current path.",
          ["default"] = false,
        },
        ["Table"] = {
          ["size"] = 25512,
          ["path"] = "elements/Table.lua",
          ["requires"] = {
            [1] = "Collection",
          },
          ["description"] = "The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.",
          ["default"] = false,
        },
        ["ComboBox"] = {
          ["size"] = 14751,
          ["path"] = "elements/ComboBox.lua",
          ["requires"] = {
            [1] = "DropDown",
          },
          ["description"] = "A ComboBox that combines dropdown selection with editable text input",
          ["default"] = false,
        },
        ["ScrollBar"] = {
          ["size"] = 9689,
          ["path"] = "elements/ScrollBar.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A ScrollBar element that can be attached to other elements to control their scroll properties.",
          ["default"] = false,
        },
        ["BigFont"] = {
          ["size"] = 21551,
          ["path"] = "elements/BigFont.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Menu"] = {
          ["size"] = 8582,
          ["path"] = "elements/Menu.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A horizontal menu bar with selectable items.",
          ["default"] = true,
        },
        ["TabControl"] = {
          ["size"] = 20900,
          ["path"] = "elements/TabControl.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A TabControl element that provides tabbed interface with multiple content areas.",
          ["default"] = false,
        },
        ["ScrollFrame"] = {
          ["size"] = 17463,
          ["path"] = "elements/ScrollFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A scrollable container that automatically displays scrollbars when content overflows.",
          ["default"] = false,
        },
        ["Slider"] = {
          ["size"] = 5043,
          ["path"] = "elements/Slider.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A slider control element for selecting a value within a range.",
          ["default"] = false,
        },
        ["DropDown"] = {
          ["size"] = 7886,
          ["path"] = "elements/DropDown.lua",
          ["requires"] = {
            [1] = "List",
          },
          ["description"] = "A DropDown menu that shows a list of selectable items",
          ["default"] = false,
        },
        ["Container"] = {
          ["size"] = 27475,
          ["path"] = "elements/Container.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The container class. It is a visual element that can contain other elements. It is the base class for all containers",
          ["default"] = true,
        },
        ["Tree"] = {
          ["size"] = 22168,
          ["path"] = "elements/Tree.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["Dialog"] = {
          ["size"] = 8901,
          ["path"] = "elements/Dialog.lua",
          ["requires"] = {
            [1] = "Frame",
          },
          ["description"] = "A dialog overlay system with common presets (alert, confirm, prompt).",
          ["default"] = false,
        },
        ["Switch"] = {
          ["size"] = 3293,
          ["path"] = "elements/Switch.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "The Switch is a standard Switch element with click handling and state management.",
          ["default"] = false,
        },
        ["Frame"] = {
          ["size"] = 6646,
          ["path"] = "elements/Frame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "A frame element that serves as a grouping container for other elements.",
          ["default"] = true,
        },
        ["BaseFrame"] = {
          ["size"] = 8972,
          ["path"] = "elements/BaseFrame.lua",
          ["requires"] = {
            [1] = "Container",
          },
          ["description"] = "This is the base frame class. It is the root element of all elements and the only element without a parent.",
          ["default"] = true,
        },
        ["Toast"] = {
          ["size"] = 7897,
          ["path"] = "elements/Toast.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "A toast notification element that displays temporary messages.",
          ["default"] = false,
        },
        ["VisualElement"] = {
          ["size"] = 45082,
          ["path"] = "elements/VisualElement.lua",
          ["requires"] = {
            [1] = "BaseElement",
          },
          ["description"] = "The Visual Element class which is the base class for all visual UI elements",
          ["default"] = true,
        },
      },
    },
    ["plugins"] = {
      ["description"] = "Plugins",
      ["files"] = {
        ["xml"] = {
          ["size"] = 14068,
          ["path"] = "plugins/xml.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["theme"] = {
          ["size"] = 6801,
          ["path"] = "plugins/theme.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["animation"] = {
          ["size"] = 18446,
          ["path"] = "plugins/animation.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["debug"] = {
          ["size"] = 6274,
          ["path"] = "plugins/debug.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["reactive"] = {
          ["size"] = 11869,
          ["path"] = "plugins/reactive.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["benchmark"] = {
          ["size"] = 12604,
          ["path"] = "plugins/benchmark.lua",
          ["requires"] = {
            [1] = "VisualElement",
          },
          ["description"] = "",
          ["default"] = false,
        },
        ["canvas"] = {
          ["size"] = 7897,
          ["path"] = "plugins/canvas.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = false,
        },
      },
    },
    ["libraries"] = {
      ["description"] = "Libraries",
      ["files"] = {
        ["utils"] = {
          ["size"] = 2661,
          ["path"] = "libraries/utils.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["colorHex"] = {
          ["size"] = 132,
          ["path"] = "libraries/colorHex.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["expect"] = {
          ["size"] = 846,
          ["path"] = "libraries/expect.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
        ["collectionentry"] = {
          ["size"] = 3551,
          ["path"] = "libraries/collectionentry.lua",
          ["requires"] = {
          },
          ["description"] = "",
          ["default"] = true,
        },
      },
    },
  },
  ["metadata"] = {
    ["version"] = "2.0",
    ["generated"] = "Tue Nov  4 09:01:43 2025",
  },
}