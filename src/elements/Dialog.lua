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

local Dialog = class.create("Dialog", Container)

class.property(Dialog, "title", "")
class.property(Dialog, "titleBackground", colors.blue)
class.property(Dialog, "titleForeground", colors.white)
class.property(Dialog, "boxBackground", colors.lightGray)
class.property(Dialog, "boxForeground", colors.black)
class.property(Dialog, "boxWidth", 26)
class.property(Dialog, "visible", false)
class.property(Dialog, "background", false) -- invisible modal backdrop
-- backdrop always covers the parent
class.property(Dialog, "width", function(self)
    local parent = rawget(self, "parent")
    return parent and parent.width or 1
end)
class.property(Dialog, "height", function(self)
    local parent = rawget(self, "parent")
    return parent and parent.height or 1
end)

class.event(Dialog, "close")

function Dialog:setup()
    Container.setup(self)
    self.x, self.y = 1, 1
    self.z = 950
    -- a click handler makes the (transparent) backdrop consume every click
    self:on("click", function() end)
end

local function clearChildren(self)
    local children = self:getChildren()
    for i = #children, 1, -1 do
        self:removeChild(children[i])
    end
end

function Dialog:close(result)
    clearChildren(self)
    self.visible = false
    self:fire("close", result)
    return self
end

--- Builds the box: message + a row of buttons; returns box and content y.
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
