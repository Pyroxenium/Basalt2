# Reactive System

The reactive system in Basalt allows you to create dynamic property values using expressions. These expressions automatically update when related values change.

## Basic Usage

```lua
local basalt = require("basalt")

-- Create a simple label and center it horizontally
local main = basalt.getMainFrame()
    :addLabel()
    :setText("Hello World")
    :setX("{parent.width / 2 - self.width / 2}")  -- Centers the label horizontally

-- Create a progress bar that takes 80% of parent width
main:addProgressbar()
    :setWidth("{parent.width * 0.8}")
    :setX("{parent.width * 0.1}")  -- 10% margin on both sides
```

## Available Variables

In reactive expressions, you have access to:

- `self` - The current element
- `parent` - The parent element
- `elementName` - A given name of a element
- Any property of these elements (width, height, value, text, etc.)

## Common Use Cases

### Responsive Layout

```lua
local frame = basalt.getMainFrame()
    :addFrame()
    :setSize("{parent.width * 0.5}", "{parent.height * 0.5}")  -- Takes half of parent size
    :setPosition("{parent.width / 2 - self.width / 2}",        -- Centers the frame
                 "{parent.height / 2 - self.height / 2}")
```

### Dynamic Sizing

```lua
local label = frame:addLabel()
    :setText("Dynamic width based on text")
    :setWidth("{#self.text}")  -- Width equals text length
```

### Linked Properties

```lua
local slider = frame:addSlider("mySlider")
    :setPosition(2, 2)
    :setSize(10, 1)

local progress = frame:addProgressBar()
    :setPosition(2, 4)
    :setSize(10, 1)
    :setProgress("{mySlider.value}")  -- Progress syncs with slider value
```

## Syntax

- Use curly braces `{}` to define a reactive expression
- Basic math operators are supported (+, -, *, /, %)
- Access properties using dot notation (element.property)
- Can use basic functions and comparisons

## Best Practices

1. Keep expressions simple and readable
2. Use meaningful variable names in complex calculations
3. Test expressions with different parent sizes
4. Consider edge cases (minimum/maximum sizes)
