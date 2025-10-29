# DropDown
_A collapsible selection menu that expands to show multiple options when clicked. Supports single and multi-selection modes, custom item styling, separators, and item callbacks._

Extends: `List`

## Examples (Executable)
```lua run
-- Create a styled dropdown menu
local dropdown = main:addDropDown()
:setPosition(5, 5)
:setSize(20, 1)  -- Height expands when opened
:setSelectedText("Select an option...")

-- Add items with different styles and callbacks
dropdown:setItems({
{
text = "Category A",
background = colors.blue,
foreground = colors.white
},
{ separator = true, text = "-" },  -- Add a separator
{
text = "Option 1",
callback = function(self)
-- Handle selection
basalt.debug("Selected Option 1")
end
},
{
text = "Option 2",
-- Custom colors when selected
selectedBackground = colors.green,
selectedForeground = colors.white
}
})

-- Listen for selections
dropdown:onChange(function(self, value)
basalt.debug("Selected:", value)
end)
```

## Table Types

### ItemTable

|Property|Type|Description|
|---|---|---|
|text|string|The display text for the item|
|callback|function|Function called when selected|
|fg|color|Normal text color|
|bg|color|Normal background color|
|selectedFg|color|Text color when selected|
|selectedBg|color|Background when selected|

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|dropdownHeight|number|5|Maximum visible items when expanded|
|selectedText|string|""|Text shown when no selection made|
|dropSymbol|string|"\31"|Indicator for dropdown state|
