# ComboBox
_A hybrid input element that combines a text input field with a dropdown list. Users can either type directly or select from predefined options. _
_Supports auto-completion, custom styling, and both single and multi-selection modes._

Extends: `DropDown`

## Usage
```lua run
-- Create a searchable country selector
```

```lua run
local combo = main:addComboBox()
```

```lua run
:setPosition(5, 5)
```

```lua run
:setSize(20, 1)  -- Height will expand when opened
```

```lua run
:setItems({
```

```lua run
{text = "Germany"},
```

```lua run
{text = "France"},
```

```lua run
{text = "Spain"},
```

```lua run
{text = "Italy"}
```

```lua run
})
```

```lua run
:setPlaceholder("Select country...")
```

```lua run
:setAutoComplete(true)  -- Enable filtering while typing
```

```lua run

```

```lua run
-- Handle selection changes
```

```lua run
combo:onChange(function(self, value)
```

```lua run
-- value will be the selected country
```

```lua run
basalt.debug("Selected:", value)
```

```lua run
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|editable|boolean|true|Enables direct text input in the field|
|text|string|""|The current text value of the input field|
|cursorPos|number|1|Current cursor position in the text input|
|viewOffset|number|0|Horizontal scroll position for viewing long text|
|placeholder|string|"..."|Text shown when the input is empty|
|placeholderColor|color|gray|Color used for placeholder text|
|autoComplete|boolean|false|Enables filtering dropdown items while typing|
|manuallyOpened|boolean|false|Indicates if dropdown was opened by user action|

## Functions

|Method|Returns|Description|
|---|---|---|
|[ComboBox.new](#combobox-new)|ComboBox|Creates a new ComboBox instance|
|[ComboBox:char](#combobox-char-char)|-|Handles character input|
|[ComboBox:key](#combobox-key-key-held)|-|Handles key input|

## ComboBox.new()

Creates a new ComboBox instance

### Returns
* `ComboBox` `self` The newly created ComboBox instance

## ComboBox:char(char)

Handles character input when editable

### Parameters
* `char` `string` The character that was typed

## ComboBox:key(key, held)

Handles key input when editable

### Parameters
* `key` `number` The key code that was pressed
* `held` `boolean` Whether the key is being held
