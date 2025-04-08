# State Management in Basalt

States provide a new way to manage data and UI synchronization in your Basalt applications.

## Detailed State Methods

### initializeState
```lua
BaseFrame:initializeState("name", defaultValue, persistent, path?)
```
Creates a new state in a BaseFrame:
- `name`: Name of the state (string)
- `defaultValue`: Initial value of the state (any type)
- `persistent?`: Boolean that determines if the state should be stored into a file
- `path?`: The path the state should be stored to (default: states/BaseFrameNAME.state)
- Returns: self (for method chaining)

### setState
```lua
element:setState("name", newValue)
```
Updates an existing state's value:
- `name`: Name of the state to update
- `newValue`: New value to set
- Automatically triggers UI updates if triggerRender=true
- Returns: self (for method chaining)

### getState
```lua
local value = element:getState("name")
```
Retrieves the current value of a state:
- `name`: Name of the state to get
- Returns: Current value of the state

### computed
```lua
element:computed("name", function(self)
    local otherState = self:getState("otherState")
    return someCalculation(otherState)
end)
```
Creates a computed state that depends on other states:
- `name`: Name of the computed state
- `function`: Function that calculates the value
- Automatically recalculates when dependent states change
- Returns: self (for method chaining)

### onStateChange
```lua
element:onStateChange("name", function(self, newValue)
    -- React to changes
    self:someAction(newValue)
end)
```
Registers a listener for state changes:
- `name`: Name of the state to watch
- `function`: Callback function receiving the new value
- Executes whenever the state changes
- Returns: self (for method chaining)

### bind
```lua
local name = form:addInput():bind("text", "name")
```
Binds a property to a state
- `propertyName`: The name of the property
- `stateName`: The name of the state
- Returns: self (for method chaining)

## Example: Form Validation

Here's a comprehensive example showing state management in a form:

```lua
local main = basalt.getMainFrame()
    -- Initialize form states
    :initializeState("username", "", true) -- make them persistent
    :initializeState("password", "", true) -- make them persistent
    :initializeState("confirmPassword", "", true) -- make them persistent

local form = main:addFrame()
    :setSize("{parent.width - 4}", "{parent.height - 4}")
    :setPosition(3, 3)

-- Add computed validation state
form:computed("isValid", function(self)
    local username = self:getState("username")
    local password = self:getState("password")
    local confirmPass = self:getState("confirmPassword")
    return #username >= 3 and #password >= 6 and password == confirmPass
end)

-- Create labels
form:addLabel({text="Username:", x = 2, y = 2, foreground = colors.lightGray})
form:addLabel({text="Password:", x = 2, y = 4, foreground = colors.lightGray})
form:addLabel({text="Confirm:", x = 2, y = 6, foreground = colors.lightGray})

local userInput = form:addInput({x = 11, y = 2, width = 20, height = 1}):bind("text", "username")
local passwordInput = form:addInput({x = 11, y = 4, width = 20, height = 1}):bind("text", "password")
local confirmInput = form:addInput({x = 11, y = 6, width = 20, height = 1}):bind("text", "confirmPassword")

-- Submit button
local submitBtn = form:addButton()
    :setText("Submit")
    :setPosition(2, 8)
    :setSize(29, 1)

-- Status label
local statusLabel = form:addLabel()
    :setPosition(2, 10)
    :setSize(29, 1)


form:onStateChange("isValid", function(self, isValid)
    if isValid then
        statusLabel:setText("Form is valid!")
            :setForeground(colors.green)
        submitBtn:setBackground(colors.green)
    else
        statusLabel:setText("Please fill all fields correctly")
            :setForeground(colors.red)
        submitBtn:setBackground(colors.red)
    end
end)
```

## Tips

1. **State Initialization**
   - Always initialize states at component creation
   - Use descriptive state names
   - Consider carefully whether updates should trigger renders

2. **Computed States**
   - Use for values derived from other states
   - Keep calculations simple and performant
   - Avoid circular dependencies

3. **State Updates**
   - Only modify states through setState
   - Use onStateChange for side effects
   - Batch multiple updates when possible

4. **Common Patterns**
   - Form validation
   - UI state management
   - Data synchronization
   - Component communication
