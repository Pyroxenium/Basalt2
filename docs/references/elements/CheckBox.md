# CheckBox
_A toggleable UI element that can be checked or unchecked. Displays different text based on its state and supports automatic sizing. Commonly used in forms and settings interfaces for boolean options._

Extends: `VisualElement`

## Usage
```lua
-- Create a checkbox for a setting
```

```lua
local checkbox = parent:addCheckBox()
```

```lua
:setText("Enable Feature")
```

```lua
:setCheckedText("✓")
```

```lua
:onChange("checked", function(self, checked)
```

```lua
-- React to checkbox state changes
```

```lua
if checked then
```

```lua
-- Handle enabled state
```

```lua
else
```

```lua
-- Handle disabled state
```

```lua
end
```

```lua
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|false|The current state of the checkbox (true=checked, false=unchecked)|
|text|string|empty|Text shown when the checkbox is unchecked|
|checkedText|string|x|Text shown when the checkbox is checked|
|autoSize|boolean|true|Automatically adjusts width based on text length|
