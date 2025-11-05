# Dynamic & Reactive Systems

Basalt provides three systems for creating dynamic, responsive UIs: the **State System**, the **Responsive Plugin**, and the **Reactive Plugin**. Each serves a different purpose and can be combined for maximum flexibility.

---

## State System

The state system allows elements to have conditional states that automatically activate based on custom logic. This is the foundation that powers the responsive plugin.

### Conditional States

Register states that evaluate conditions and automatically activate/deactivate:

```lua
-- Using a function
-- When using functions, you need to manually specify which properties to observe
local label = main:addLabel()
    :registerResponsiveState("small", function(self)
        return self.parent:getWidth() < 25
    end, {
        observe = { 
            {main, "width"}  -- Format: {element, "property"}
        },
    })
    :setTextState("small", "Compact")
    :setText("Full Text")

-- Using a string expression (automatic dependency detection)
-- String expressions automatically detect and observe referenced properties
local sidebar = main:addFrame()
    :registerResponsiveState("collapsed", "parent.width < 30", 100)
    :setWidthState("collapsed", 5)
    :setWidthState("default", 15)
    :setY(15)
```

### String Expressions

String expressions automatically parse and detect dependencies - no manual `observe` needed:

```lua
-- Dependencies are auto-detected from the expression
element:registerResponsiveState("portrait", "parent.width < parent.height", 100)
```

You can optionally add extra dependencies that aren't in the expression:

```lua
-- Auto-detects parent.width, but also observes otherElement.text
element:registerResponsiveState("complex", "parent.width < 30", {
    priority = 100,
    observe = {
        {otherElement, "text"}  -- Additional dependency
    }
})
```

**Behind the scenes:** The system parses expressions like `"parent.width < 30"`, extracts property references (`parent.width`), and automatically sets up observers for reactive updates.

### Manual State Control

You can also control states manually:

```lua
element:setState("customState", 100)  -- Activate with priority 100
element:unsetState("customState")     -- Deactivate
element:hasState("customState")       -- Check if active
element:getActiveStates()             -- Get all active states sorted by priority
```

---

## Responsive Plugin

The responsive plugin builds on the state system to create layouts that adapt to parent size or other conditions. It provides a fluent builder API.

### Basic Responsive Layout

```lua
local sidebar = main:addFrame()
    :responsive()
        :when("parent.width < 15")
            :apply({ width = 10, background = colors.gray })
        :when("parent.width >= 40")
            :apply({ width = 25, background = colors.lightGray })
        :otherwise({ width = 15 })
```

### Advanced Conditions

String expressions support math operations and can reference any element property:

```lua
local dynamicFrame = frame:addFrame()
    :responsive()
        :when("parent.width < parent.height")
            :apply({ width = "parent.width * 0.9", height = 10 })
        :otherwise({ width = 20, height = "parent.height * 0.9" })
```

**Behind the scenes:** The responsive plugin automatically detects dependencies from expressions (like `parent.width`) and sets up observers for reactive updates.

---

## Reactive Plugin

The reactive plugin allows property values themselves to be dynamic expressions that automatically update when dependencies change.

### Basic Usage

```lua
-- Center a label horizontally
local label = frame:addLabel()
    :setText("Centered")
    :setX("{parent.width / 2 - self.width / 2}")

-- Progress bar that takes 80% of parent width
frame:addProgressBar()
    :setWidth("{parent.width * 0.8}")
    :setX("{parent.width * 0.1}")
```

### Available Variables

- `self` - The current element
- `parent` - The parent element  
- `elementName` - Named elements (e.g., `mySlider.value`)

### Linked Properties

```lua
local slider = frame:addSlider("volumeSlider")
    :setPosition(2, 2)

local label = frame:addLabel()
    :setText("{volumeSlider.value}")  -- Text updates with slider
    :setX("{volumeSlider.x + volumeSlider.width + 2}")
```

### Dynamic Sizing

```lua
local label = frame:addLabel()
    :setText("Dynamic width")
    :setWidth("{#self.text + 2}")  -- Width = text length + padding
```

---

### Combining Systems

You can combine all three systems for maximum flexibility:

```lua
local frame = main:addFrame()
    :setWidth("{parent.width * 0.8}")  -- Reactive: 80% of parent
    :responsive()                       -- Responsive: breakpoints
        :when("parent.width < 30")
            :apply({ background = colors.gray })
        :otherwise({ background = colors.lightGray })
    :setPropertyState("background", "hover", colors.white)  -- State: hover effect
```

The responsive and reactive plugins work together - you can use reactive expressions within `:apply()`:

```lua
local element = main:addLabel()
    :responsive()
        :when("parent.width < 30")
            :apply({ text = "Small", x = "{parent.width - self.width}" })  -- Reactive expression
        :otherwise({ text = "Large", x = 5 })
```

---

## Practical Example: Adaptive Layout

A common use case is creating a layout that adapts between side-by-side and stacked views based on screen width:

```lua run
local basalt = require("basalt")
local main = basalt.getMainFrame()

-- Left container
local rightContainer = main:addFrame()
    :setSize(20, 10)
    :setBackground(colors.green)
    :responsive()
        :when("parent.width >= 45")  -- Wide: positioned next to left
            :apply({
                x = 24,
                y = 2,
                width = 20
            })
        :otherwise({
                x = 2,
                y = 13,
                width = "{parent.width - 3}"
            })  -- Narrow: positioned below left
    :done()

rightContainer:addLabel()
    :setText("Right Panel")
    :setPosition(2, 2)

-- Status label showing current layout mode
local statusLabel = main:addLabel()
    :setPosition(2, 24)
    :responsive()
        :when("parent.width >= 45")
            :apply({ text = "Layout: Side by Side", foreground = colors.lime })
        :otherwise({ text = "Layout: Stacked", foreground = colors.orange })
    :done()
basalt.run()
```

When the main frame is wide (≥45 characters), the containers appear side by side. When it's narrow, they stack vertically - and the status label updates to reflect the current mode.
