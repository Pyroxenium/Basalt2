# CheckBox
_A toggleable UI element that can be checked or unchecked. Displays different text based on its state and supports automatic sizing. Commonly used in forms and settings interfaces for boolean options._

Extends: `VisualElement`

## Usage
```lua run
-- Create a checkbox for a setting
```

```lua run
local checkbox = parent:addCheckBox()
```

```lua run
:setText("Enable Feature")
```

```lua run
:setCheckedText("✓")
```

```lua run
:onChange("checked", function(self, checked)
```

```lua run
-- React to checkbox state changes
```

```lua run
if checked then
```

```lua run
-- Handle enabled state
```

```lua run
else
```

```lua run
-- Handle disabled state
```

```lua run
end
```

```lua run
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|false|The current state of the checkbox (true=checked, false=unchecked)|
|text|string|empty|Text shown when the checkbox is unchecked|
|checkedText|string|x|Text shown when the checkbox is checked|
|autoSize|boolean|true|Automatically adjusts width based on text length|
