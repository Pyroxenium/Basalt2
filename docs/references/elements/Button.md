# Button
_A clickable interface element that triggers actions when pressed. Supports text labels, custom styling, and automatic text centering. Commonly used for user interactions and form submissions._

Extends: `VisualElement`

## Usage
```lua
-- Create a simple action button
local button = parent:addButton()
:setPosition(5, 5)
:setText("Click me!")
:setBackground(colors.blue)
:setForeground(colors.white)

-- Add click handling
button:onClick(function(self, button, x, y)
-- Change appearance when clicked
self:setBackground(colors.green)
self:setText("Success!")

-- Revert after delay
basalt.schedule(function()
sleep(1)
self:setBackground(colors.blue)
self:setText("Click me!")
end)
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|Button|Label text displayed centered within the button|
