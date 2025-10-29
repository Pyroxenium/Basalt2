# Button
_A clickable interface element that triggers actions when pressed. Supports text labels, custom styling, and automatic text centering. Commonly used for user interactions and form submissions._

Extends: `VisualElement`

## Usage
```lua run
-- Create a simple action button
```

```lua run
local button = parent:addButton()
```

```lua run
:setPosition(5, 5)
```

```lua run
:setText("Click me!")
```

```lua run
:setBackground(colors.blue)
```

```lua run
:setForeground(colors.white)
```

```lua run

```

```lua run
-- Add click handling
```

```lua run
button:onClick(function(self, button, x, y)
```

```lua run
-- Change appearance when clicked
```

```lua run
self:setBackground(colors.green)
```

```lua run
self:setText("Success!")
```

```lua run

```

```lua run
-- Revert after delay
```

```lua run
basalt.schedule(function()
```

```lua run
sleep(1)
```

```lua run
self:setBackground(colors.blue)
```

```lua run
self:setText("Click me!")
```

```lua run
end)
```

```lua run
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|Button|Label text displayed centered within the button|
