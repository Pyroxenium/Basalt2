# Dropdown : List
This is the dropdown class. It is a visual element that can show a list of selectable items in a dropdown menu.

### Usage
 ```lua
local dropdown = main:addDropdown()
dropdown:setItems({
{text = "Item 1", callback = function() basalt.LOGGER.debug("Item 1 selected") end},
{text = "Item 2", callback = function() basalt.LOGGER.debug("Item 2 selected") end},
{text = "Item 3", callback = function() basalt.LOGGER.debug("Item 3 selected") end},
})
```


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
|Dropdown:init|Dropdown|Initializes the Dropdown instance
|Dropdown:mouse_click|boolean|Handles mouse click events
|Dropdown:render|-|Renders the Dropdown


