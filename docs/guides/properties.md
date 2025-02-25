# Properties in Basalt

Properties are a core concept in Basalt that control how elements store and access their values.

## Property Initialization

You can set properties when creating elements:

```lua
-- Initialize multiple properties at creation
local button = main:addButton({
    x = 5,
    y = 5,
    width = 10,
    height = 3,
    text = "Click me"
})

-- Equivalent to:
local button = main:addButton()
    :setX(5)
    :setY(5)
    :setSize(10, 3)
    :setText("Click me")
```

## Accessing Properties

There are three ways to interact with properties, each with different characteristics:

### 1. Method Syntax (Traditional)
```lua
element:setX(5)      -- Most validation, observers called
local x = element:getX()
```
- Full validation
- Type checking
- Observers called
- Most overhead

### 2. Direct Access (Convenient)
```lua
element.x = 5        -- Convenient, observers called
local x = element.x
```
- Medium validation
- Observers called
- Good balance of safety and performance

### 3. Set/Get Function (Performance)
```lua
element.set("x", 5)  -- Minimal validation, observers called
local x = element.get("x")
```
- Minimal validation
- Only calls observers
- Best performance
- Use with caution

## Combined Properties

These are special methods that modify multiple properties at once:

```lua
-- These modify x and y properties together
element:setPosition(5, 5)

-- These modify width and height properties together
element:setSize(10, 3)
```

## Dynamic Properties

Any property can be set to a function that gets called on access:

```lua
-- Function as property value
element.x = function(self)
    return self:getParent():getWidth() - 10
end

-- Function gets called when accessing x
local xPos = element.x  -- Calls the function
```

## Reactive Properties (Plugin Required)

With the reactive plugin, you can use string expressions that automatically update:

```lua
-- Requires reactive plugin
element:setX("{parent.width - 10}")  -- Updates when parent width changes
```

## Property Observers

You can react to property changes:

```lua
element:onChange("x", function(self, newX)
    -- Called when x changes through any method
end)
```

## Tips & Performance

1. **Choose the Right Access Method**
   - Use `:setX()` when you need validation
   - Use `.x` for convenient access
   - Use `.set()` for maximum performance

2. **Dynamic Properties**
   - Function properties don't auto-update observers
   - Reactive strings (with plugin) do update observers
   - Cache computed values when possible

3. **Combined Properties**
   - `setPosition` modifies x and y
   - `setSize` modifies width and height
   - More efficient than setting individually
