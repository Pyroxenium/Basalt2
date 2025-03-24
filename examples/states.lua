local basalt = require("basalt")

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

basalt.run()