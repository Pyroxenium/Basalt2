# State Management in Basalt

States provide a powerful way to manage data and UI synchronization in your Basalt applications.

## Core Concepts

- **States**: Named values stored in frames
- **Computed States**: States that depend on other states
- **State Changes**: Automatic UI updates when states change
- **State Listeners**: React to state changes

## Basic State Methods

```lua
-- Initialize states
frame:initializeState("name", defaultValue, triggerRender)
frame:setState("name", newValue)
frame:getState("name")

-- Computed states
frame:computed("name", function(self)
    -- Calculate and return value based on other states
end)

-- Listen to changes
frame:onStateChange("name", function(self, newValue)
    -- React to state changes
end)
```

## Complete Form Example

Here's a comprehensive example showing state management in a form:

```lua
local main = basalt.getMainFrame()
local form = main:addFrame()
    :setSize("{parent.width - 4}", "{parent.height - 4}")
    -- Initialize multiple states
    :initializeState("username", "")
    :initializeState("email", "")
    :initializeState("age", 0)
    :initializeState("submitted", false)
    -- Add computed validation state
    :computed("isValid", function(self)
        local username = self:getState("username")
        local email = self:getState("email")
        local age = self:getState("age")
        return #username > 0 and email:match(".+@.+") and age > 0
    end)

-- Input with state binding
form:addInput()
    :onChange(function(self, value)
        form:setState("username", value)
    end)

-- Button reacting to computed state
form:addButton()
    :onStateChange("isValid", function(self, isValid)
        self:setBackground(isValid and colors.lime or colors.gray)
    end)
```

## Best Practices

1. **State Initialization**
   - Initialize all states at component creation
   - Use meaningful default values
   - Consider whether state changes should trigger renders

2. **Computed States**
   - Use for values that depend on multiple states
   - Keep computations simple and efficient
   - Avoid circular dependencies

3. **State Updates**
   - Update states through setState, not directly
   - Use onStateChange for side effects
   - Consider batching multiple state updates

4. **Form Validation**
   - Use computed states for form validation
   - Update UI elements based on validation state
   - Trigger actions only when validation passes

## Tips

- Use states for data that affects multiple components
- Consider using tables for complex state
- Keep state updates minimal and efficient
- Use meaningful state names
- Document state dependencies
