# Properties in Basalt

Properties are the foundation of how Basalt elements store and manage their attributes. Understanding how properties work is key to effectively using Basalt.

## Basic Usage

Every element in Basalt has properties that can be accessed and modified:

```lua
local button = main:addButton()
    :setPosition(5, 5)      -- Set position property
    :setSize(10, 3)        -- Set size property
    :setText("Click me")    -- Set text property
```

## Dynamic Properties

Properties can be dynamic using strings or functions:

```lua
-- String-based dynamic properties
button:setPosition("{parent.width - 10}", 5)  -- 10 pixels from right edge

-- Function-based dynamic properties
button:setPosition(function(self)
    return self:getParent():getWidth() - 10
end, 5)
```

## Property Types

### Position Properties
- `x`, `y` - Element position
- `width`, `height` - Element size
- `z` - Layer order (higher numbers = on top)

### Visual Properties
- `background` - Background color
- `foreground` - Text color
- `visible` - Whether element is shown
- `text` - Element's text content

### State Properties
- `focused` - Has keyboard focus
- `clicked` - Currently being clicked
- `enabled` - Can receive input

## Combined Properties

Some properties can be set together:

```lua
button:setSize(10, 3)           -- Individual
button:setPosition(5, 5)        -- Individual

-- OR combined:
button:setSize({10, 3})         -- Combined
button:setPosition({5, 5})      -- Combined
```

## Property Inheritance

Elements inherit properties from their parent containers:

```lua
local frame = main:addFrame()
    :setBackground(colors.blue)  -- All children inherit this background
    
frame:addButton()  -- Button has blue background unless overridden
```

## Property Events

You can react to property changes:

```lua
button:onChange("text", function(self, newText)
    -- Called when text property changes
end)
```

## Tips & Best Practices

1. **Dynamic Updates**
   - Use dynamic properties for responsive layouts
   - Avoid expensive calculations in property functions
   - Chain property setters for cleaner code

2. **Performance**
   - Only update properties when needed
   - Use combined setters when changing multiple related properties
   - Consider using states for complex property management

3. **Organization**
   - Group related property changes together
   - Initialize all important properties at creation
   - Use meaningful values for better readability

## Common Patterns

### Responsive Layout
```lua
element:setPosition(2, 2)
    :setSize("{parent.width - 4}", "{parent.height - 4}")
```

### Conditional Styling
```lua
button:setBackground(function(self)
    return self.clicked and colors.gray or colors.lightGray
end)
```

### Layout Calculations
```lua
element:setPosition(function(self)
    local parent = self:getParent()
    return math.floor((parent:getWidth() - self:getWidth()) / 2)
end)

