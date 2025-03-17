# Dropdown : List
This is the dropdown class. It is a visual element that can show a list of selectable items in a dropdown menu.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|isOpen|boolean|false|Whether the dropdown menu is currently open
|dropdownHeight|number|5|Maximum height of the dropdown menu when open
|selectedText|string|""|The text to show when no item is selected
|dropSymbol|string|"\31"|The symbol to show for dropdown indication


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[Dropdown:init](#Dropdown:init)|Dropdown|Initializes the Dropdown instance
|[Dropdown:mouse_click](#Dropdown:mouse_click)|boolean|Handles mouse click events
|[Dropdown:render](#Dropdown:render)|-|Renders the Dropdown


