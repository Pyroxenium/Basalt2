# State Management in Basalt

Basalt provides a powerful state management system that allows elements to respond to different interaction states (hover, clicked, focused, etc.) with automatic property changes. This system makes it easy to create interactive UIs without manual event handling.

## Understanding States

States are named conditions that elements can be in. When a state becomes active, the element can automatically change its appearance or behavior. States have priorities, allowing you to control which state takes precedence when multiple states are active.

## Core State Methods

### registerState
```lua
element:registerState(stateName, condition?, priority?)
```
Registers a new state with optional auto-activation condition:
- `stateName`: Name of the state (string)
- `condition?`: Optional function that returns true when state should be active: `function(element) return boolean end`
- `priority?`: Priority value (higher = more important, default: 0)
- Returns: self (for method chaining)

### setState
```lua
element:setState(stateName, priority?)
```
Manually activates a state:
- `stateName`: Name of the state to activate
- `priority?`: Optional priority override
- Returns: self (for method chaining)

**Example:**
```lua
button:setState("clicked")
button:setState("error", 300) -- High priority error state
```

### unsetState
```lua
element:unsetState(stateName)
```
Deactivates a state:
- `stateName`: Name of the state to deactivate
- Returns: self (for method chaining)

**Example:**
```lua
button:unsetState("clicked")
```

### hasState
```lua
local isActive = element:hasState(stateName)
```
Checks if a state is currently active:
- `stateName`: Name of the state to check
- Returns: boolean

**Example:**
```lua
if button:hasState("hover") then
    basalt.LOGGER.debug("Button is being hovered!")
end
```

### getCurrentState
```lua
local state = element:getCurrentState()
```
Gets the state with highest priority:
- Returns: string (state name) or nil

**Example:**
```lua
local currentState = button:getCurrentState()
-- Returns "clicked" if clicked state has highest priority
```

### getActiveStates
```lua
local states = element:getActiveStates()
```
Gets all active states sorted by priority:
- Returns: array of `{name, priority}` tables

**Example:**
```lua
local states = button:getActiveStates()
-- Returns: {{name="clicked", priority=200}, {name="hover", priority=100}}
```

### updateConditionalStates
```lua
element:updateConditionalStates()
```
Updates all states that have auto-conditions:
- Evaluates condition functions for all registered states
- Automatically activates/deactivates states based on conditions
- Returns: self (for method chaining)

### unregisterState
```lua
element:unregisterState(stateName)
```
Removes a state from the registry:
- `stateName`: Name of the state to remove
- Also deactivates the state if currently active
- Returns: self (for method chaining)

## State-Bound Properties

Properties can be bound to states, allowing automatic property changes when states activate.

### Setting State Properties

Use the `set<Property>State` methods to define property values for specific states:

```lua
-- Set background color for different states
button:setBackgroundState("clicked", colors.blue)

-- Set text for different states
button:setText("Click Me")
button:setTextState("clicked", "Clicked!")
```

### Getting State Properties

```lua
local value = element:get<Property>State(stateName)
```

**Example:**
```lua
local clickedBg = button:getBackgroundState("clicked")
```

### How State Properties Work

1. When a state activates, the element looks for bound properties
2. The property automatically changes to the state-bound value
3. When the state deactivates, the property returns to its base value (or next highest priority state)
4. Higher priority states override lower priority states

## Built-in Interactive States

Many elements automatically register common interaction states:

### Button States
- `hover` (priority: 100) - Mouse is over the button
- `clicked` (priority: 200) - Button is being clicked

### Input States
- `focused` (priority: 100) - Input has focus

### Custom States
You can create any custom state names for your own logic:
```lua
button:registerState("loading")
button:registerState("success")
button:registerState("error")
```

## Using States with Reactive Expressions

States integrate seamlessly with the reactive system:

```lua
-- State values can be used in expressions
label:setText("{parent.clicked and 'Clicked!' or 'Click Me'}")
```

## Complete Examples

### Example: Interactive Button

```lua
local button = main:addButton()
    :setText("Click Me!")
    :setPosition(10, 5)
    :setSize(20, 3)

-- Register states (they're auto-registered by Button, but shown for clarity)
button:registerState("clicked", nil, 200)

-- Set appearance for each state
button:setBackgroundState("clicked", colors.blue)
button:setForegroundState("clicked", colors.white)
button:setTextState("clicked", "Clicked!")

-- Normal state
button:setBackground(colors.gray)
button:setForeground(colors.black)
```

## State Priorities

When multiple states are active, the highest priority wins:

```lua
button:registerState("hover", nil, 100)
button:registerState("clicked", nil, 200)
button:registerState("disabled", nil, 300)

-- Set different backgrounds
button:setBackgroundState("hover", colors.lightGray)
button:setBackgroundState("clicked", colors.blue)
button:setBackgroundState("disabled", colors.gray)

-- If both hover and clicked are active, clicked wins (higher priority)
-- If disabled is active, it always wins (highest priority)
```

## State Integration with XML

States can be configured in XML:

```xml
<button text="Click Me">
    <state name="hover">
        <background>lightGray</background>
        <foreground>white</foreground>
    </state>
    <state name="clicked">
        <background value="blue" />
        <text value="Clicked!" />
    </state>
</button>
```

Or using inline attributes:
```xml
<button 
    text="Click Me"
    backgroundState:hover="lightGray"
    textState:clicked="Clicked!"
/>
```