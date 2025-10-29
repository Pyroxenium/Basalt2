# Button
_A clickable interface element that triggers actions when pressed. Supports text labels, custom styling, and automatic text centering. Commonly used for user interactions and form submissions._

Extends: `VisualElement`

## Usage
```lua
-- Create a simple action button
```

```lua
local button = parent:addButton()
```

```lua
:setPosition(5, 5)
```

```lua
:setText("Click me!")
```

```lua
:setBackground(colors.blue)
```

```lua
:setForeground(colors.white)
```

```lua

```

```lua
-- Add click handling
```

```lua
button:onClick(function(self, button, x, y)
```

```lua
-- Change appearance when clicked
```

```lua
self:setBackground(colors.green)
```

```lua
self:setText("Success!")
```

```lua

```

```lua
-- Revert after delay
```

```lua
basalt.schedule(function()
```

```lua
sleep(1)
```

```lua
self:setBackground(colors.blue)
```

```lua
self:setText("Click me!")
```

```lua
end)
```

```lua
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|Button|Label text displayed centered within the button|
