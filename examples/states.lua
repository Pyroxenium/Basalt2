local basalt = require("basalt")

-- Create main frame
local main = basalt.getMainFrame()

-- Create a complex form using states for managing its data
local form = main:addFrame()
    :setSize("{parent.width - 4}", "{parent.height - 4}")
    :setPosition(3, 3)
    :setBackground(colors.lightGray)
    -- Initialize form states with default values
    :initializeState("username", "", true)  -- true = triggers render update
    :initializeState("email", "")
    :initializeState("age", 0)
    :initializeState("submitted", false)
    -- Add computed state for form validation
    :computed("isValid", function(self)
        local username = self:getState("username")
        local email = self:getState("email")
        local age = self:getState("age")
        return #username > 0 and email:match(".+@.+") and age > 0
    end)

-- Create form title
form:addLabel()
    :setText("Registration Form")
    :setPosition(2, 2)
    :setForeground(colors.black)

-- Username input with state binding
local usernameInput = form:addInput()
    :setPosition(2, 4)
    :setSize(20, 1)
    :setBackground(colors.white)
    :setForeground(colors.black)
    -- Update username state when input changes
    :onChange(function(self, value)
        form:setState("username", value)
    end)

form:addLabel()
    :setText("Username:")
    :setPosition(2, 3)
    :setForeground(colors.black)

-- Email input
local emailInput = form:addInput()
    :setPosition(2, 6)
    :setSize(20, 1)
    :setBackground(colors.white)
    :setForeground(colors.black)
    :onChange(function(self, value)
        form:setState("email", value)
    end)

form:addLabel()
    :setText("Email:")
    :setPosition(2, 5)
    :setForeground(colors.black)

-- Age input
local ageInput = form:addInput()
    :setPosition(2, 8)
    :setSize(5, 1)
    :setBackground(colors.white)
    :setForeground(colors.black)
    :onChange(function(self, value)
        -- Convert to number and update state
        form:setState("age", tonumber(value) or 0)
    end)

form:addLabel()
    :setText("Age:")
    :setPosition(2, 7)
    :setForeground(colors.black)

-- Submit button that reacts to form validity
local submitBtn = form:addButton()
    :setPosition(2, 10)
    :setSize(10, 1)
    :setText("Submit")
    -- Button color changes based on form validity
    :onStateChange("isValid", function(self, isValid)
        submitBtn:setBackground(isValid and colors.lime or colors.gray)
    end)
    :onMouseClick(function()
        if form.computedStates.isValid() then
            form:setState("submitted", true)
        end
    end)

-- Status message that updates when form is submitted
local statusLabel = form:addLabel()
    :setPosition(2, 12)
    :setForeground(colors.black)

-- Listen for form submission
form:onStateChange("submitted", function(self, submitted)
    if submitted then
        local username = self:getState("username")
        local email = self:getState("email")
        local age = self:getState("age")
        statusLabel:setText(string.format(
            "Submitted: %s (%s) - Age: %d",
            username, email, age
        ))
    end
end)

-- Run basalt
basalt.run()
