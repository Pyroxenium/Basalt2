# CheckBox
_A toggleable UI element that can be checked or unchecked. Displays different text based on its state and supports automatic sizing. Commonly used in forms and settings interfaces for boolean options._

Extends: `VisualElement`

## Usage
```lua
-- Create a checkbox for a setting
local checkbox = parent:addCheckBox()
:setText("Enable Feature")
:setCheckedText("✓")
:onChange("checked", function(self, checked)
-- React to checkbox state changes
if checked then
-- Handle enabled state
else
-- Handle disabled state
end
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|false|The current state of the checkbox (true=checked, false=unchecked)|
|text|string|empty|Text shown when the checkbox is unchecked|
|checkedText|string|x|Text shown when the checkbox is checked|
|autoSize|boolean|true|Automatically adjusts width based on text length|
