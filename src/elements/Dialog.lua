-- Dialog: modal message box with helpers.
--
--   local dialog = frame:addDialog()
--   dialog:alert("Info", "Saved successfully", function() ... end)
--   dialog:confirm("Delete?", "Really delete this?", function(yes) ... end)
--   dialog:prompt("Name", "Enter your name:", "Steve", function(text) ... end)
--
-- The element spans its whole parent while open and swallows every click
-- outside the box (modal). Fires "close"(result).

local require = ...
local class = require("core/class")
local Container = require("core/container")
local textutil = require("core/text")

---@alias DialogAlertCallback fun()
---@alias DialogConfirmCallback fun(confirmed: boolean)
---@alias DialogPromptCallback fun(value: string?)
---@alias DialogButtonDefinition [string, fun()]

---@class Dialog : Container
---@field public title string Title-bar text
---@field public titleBackground number Title-bar background
---@field public titleForeground number Title-bar foreground
---@field public boxBackground number Message-box background
---@field public boxForeground number Message-box foreground
---@field public boxWidth number Maximum message-box width
local Dialog = class.create("Dialog", Container)

--- Title bar text
class.property(Dialog, "title", "")
--- Title bar background
class.property(Dialog, "titleBackground", colors.blue)
--- Title bar text color
class.property(Dialog, "titleForeground", colors.white)
--- Message box background
class.property(Dialog, "boxBackground", colors.lightGray)
--- Message box text color
class.property(Dialog, "boxForeground", colors.black)
--- Maximum width of the message box
class.property(Dialog, "boxWidth", 26)
--- Whether the element is shown and hit by events
class.property(Dialog, "visible", false)
class.property(Dialog, "background", false) -- invisible modal backdrop
-- backdrop always covers the parent
--- Width in terminal cells
class.property(Dialog, "width", function(self)
    local parent = rawget(self, "parent")
    return parent and parent.width or 1
end)
--- Height in terminal cells
class.property(Dialog, "height", function(self)
    local parent = rawget(self, "parent")
    return parent and parent.height or 1
end)

--- Fired when the dialog closes, with the result
class.event(Dialog, "close")

--- Initializes per-instance state and input handlers.
function Dialog:setup()
    Container.setup(self)
    self.x, self.y = 1, 1
    self.z = 950
    -- a click handler makes the (transparent) backdrop consume every click
    self:on("click", function() end)
end

---@param self Dialog
local function clearChildren(self)
    local children = self:getChildren()
    for i = #children, 1, -1 do
        self:removeChild(children[i])
    end
end

--- Closes the dialog and fires its callback/close event.
---@param result? any Optional dialog result
---@return self
function Dialog:close(result)
    clearChildren(self)
    self.visible = false
    self:fire("close", result)
    return self
end

--- Builds the box: message + a row of buttons; returns box and content y.
---@param self Dialog
---@param title any
---@param message string
---@param extraRows? integer
---@return Frame box
---@return number contentY
local function buildBox(self, title, message, extraRows)
    clearChildren(self)
    self.title = tostring(title or "")
    self.visible = true

    local boxWidth = math.min(self.boxWidth, math.max(10, self.width - 2))
    local lines = textutil.wrap(message or "", boxWidth - 2)
    local boxHeight = 1 + 1 + #lines + (extraRows or 0) + 2 -- title/pad/btns

    local box = self:addFrame({
        x = math.max(1, math.floor((self.width - boxWidth) / 2) + 1),
        y = math.max(1, math.floor((self.height - boxHeight) / 2) + 1),
        width = boxWidth,
        height = boxHeight,
        background = self.boxBackground,
        foreground = self.boxForeground,
    })
    box:addLabel({
        x = 1, y = 1, width = boxWidth, height = 1,
        text = self.title,
        background = self.titleBackground,
        foreground = self.titleForeground,
    })
    for i, line in ipairs(lines) do
        box:addLabel({
            x = 2, y = 2 + i, text = line,
            foreground = self.boxForeground,
        })
    end
    return box, 2 + #lines + 1
end

---@param self Dialog
---@param box Frame
---@param buttons DialogButtonDefinition[]
---@param contentY number
local function addButtons(self, box, buttons, contentY)
    local totalWidth = 0
    for _, buttonDef in ipairs(buttons) do
        totalWidth = totalWidth + #buttonDef[1] + 2 + 1
    end
    local x = math.max(2, math.floor((box.width - totalWidth + 1) / 2) + 1)
    for _, buttonDef in ipairs(buttons) do
        local label, onPress = buttonDef[1], buttonDef[2]
        box:addButton({
            x = x, y = contentY + 1,
            width = #label + 2, height = 1,
            text = label,
        }):onClick(function()
            onPress()
        end)
        x = x + #label + 3
    end
end

--- Message + OK button; callback() runs after closing.
---@param title string The title bar text
---@param message string The message (word-wrapped)
---@param callback? DialogAlertCallback Called after the dialog closes
---@return self
function Dialog:alert(title, message, callback)
    local box, contentY = buildBox(self, title, message, 0)
    addButtons(self, box, {
        { "OK", function()
            self:close(true)
            if callback then callback() end
        end },
    }, contentY)
    return self
end

--- Yes/No question; callback(true|false).
---@param title string The title bar text
---@param message string The question (word-wrapped)
---@param callback? DialogConfirmCallback Receives true (Yes) or false (No)
---@return self
function Dialog:confirm(title, message, callback)
    local box, contentY = buildBox(self, title, message, 0)
    addButtons(self, box, {
        { "Yes", function()
            self:close(true)
            if callback then callback(true) end
        end },
        { "No", function()
            self:close(false)
            if callback then callback(false) end
        end },
    }, contentY)
    return self
end

--- Text input; callback(text) on OK, callback(nil) on Cancel.
---@param title string The title bar text
---@param message string The prompt text (word-wrapped)
---@param default? string Prefilled input value
---@param callback? DialogPromptCallback Receives the entered text, or nil
---@return self
function Dialog:prompt(title, message, default, callback)
    local box, contentY = buildBox(self, title, message, 2)
    local input = box:addInput({
        x = 2, y = contentY + 1,
        width = box.width - 2,
        text = tostring(default or ""),
    })
    local function accept()
        local value = input.text
        self:close(value)
        if callback then callback(value) end
    end
    input:onEnter(accept)
    addButtons(self, box, {
        { "OK", accept },
        { "Cancel", function()
            self:close(nil)
            if callback then callback(nil) end
        end },
    }, contentY + 2)
    input:focus()
    return self
end

return Dialog
