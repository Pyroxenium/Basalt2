local elementManager = require("elementManager")
local Frame = elementManager.getElement("Frame")
---@configDescription A dialog overlay system with common presets (alert, confirm, prompt).
---@configDefault false

--- A dialog overlay system that provides common dialog types such as alert, confirm, and prompt.
---@class Dialog : Frame
local Dialog = setmetatable({}, Frame)
Dialog.__index = Dialog

---@property title string "" The dialog title
Dialog.defineProperty(Dialog, "title", {default = "", type = "string", canTriggerRender = true})

---@property primaryColor color lime Primary button color (OK, confirm actions)
Dialog.defineProperty(Dialog, "primaryColor", {default = colors.lime, type = "color"})

---@property secondaryColor color lightGray Secondary button color (Cancel, dismiss actions)
Dialog.defineProperty(Dialog, "secondaryColor", {default = colors.lightGray, type = "color"})

---@property buttonForeground color black Foreground color for buttons
Dialog.defineProperty(Dialog, "buttonForeground", {default = colors.black, type = "color"})

---@property modal boolean true If true, blocks all events outside the dialog
Dialog.defineProperty(Dialog, "modal", {default = true, type = "boolean"})

Dialog.defineEvent(Dialog, "mouse_click")
Dialog.defineEvent(Dialog, "close")

--- Creates a new Dialog instance
--- @shortDescription Creates a new Dialog instance
--- @return Dialog self The newly created Dialog instance
--- @private
function Dialog.new()
    local self = setmetatable({}, Dialog):__init()
    self.class = Dialog
    self.set("z", 100)
    self.set("width", 30)
    self.set("height", 10)
    self.set("background", colors.gray)
    self.set("foreground", colors.white)
    self.set("borderColor", colors.cyan)
    return self
end

--- Initializes a Dialog instance
--- @shortDescription Initializes a Dialog instance
--- @param props table Initial properties
--- @param basalt table The basalt instance
--- @return Dialog self The initialized Dialog instance
--- @private
function Dialog:init(props, basalt)
    Frame.init(self, props, basalt)
    self:addBorder({left = true, right = true, top = true, bottom = true})
    self.set("type", "Dialog")
    return self
end

--- Shows the dialog
--- @shortDescription Shows the dialog
--- @return Dialog self The Dialog instance
function Dialog:show()
    self:center()
    self.set("visible", true)
    -- Auto-focus when modal
    if self.get("modal") then
        self:setFocused(true)
    end
    return self
end

--- Closes the dialog
--- @shortDescription Closes the dialog
--- @return Dialog self The Dialog instance
function Dialog:close()
    self.set("visible", false)
    self:fireEvent("close")
    return self
end

--- Creates a simple alert dialog
--- @shortDescription Creates a simple alert dialog
--- @param title string The alert title
--- @param message string The alert message
--- @param callback? function Callback when OK is clicked
--- @return Dialog self The Dialog instance
function Dialog:alert(title, message, callback)
    self:clear()
    self.set("title", title)
    self.set("height", 8)

    self:addLabel({
        text = message,
        x = 2, y = 3,
        width = self.get("width") - 3,
        height = 3,
        foreground = colors.white
    })

    local btnWidth = 10
    local btnX = math.floor((self.get("width") - btnWidth) / 2) + 1

    self:addButton({
        text = "OK",
        x = btnX,
        y = self.get("height") - 2,
        width = btnWidth,
        height = 1,
        background = self.get("primaryColor"),
        foreground = self.get("buttonForeground")
    }):onClick(function()
        if callback then callback() end
        self:close()
    end)

    return self:show()
end

--- Creates a confirm dialog
--- @shortDescription Creates a confirm dialog
--- @param title string The dialog title
--- @param message string The confirmation message
--- @param callback function Callback (receives boolean result)
--- @return Dialog self The Dialog instance
function Dialog:confirm(title, message, callback)
    self:clear()
    self.set("title", title)
    self.set("height", 8)

    self:addLabel({
        text = message,
        x = 2, y = 3,
        width = self.get("width") - 3,
        height = 3,
        foreground = colors.white
    })

    local btnWidth = 10
    local spacing = 2
    local totalWidth = btnWidth * 2 + spacing
    local startX = math.floor((self.get("width") - totalWidth) / 2) + 1

    self:addButton({
        text = "Cancel",
        x = startX,
        y = self.get("height") - 2,
        width = btnWidth,
        height = 1,
        background = self.get("secondaryColor"),
        foreground = self.get("buttonForeground")
    }):onClick(function()
        if callback then callback(false) end
        self:close()
    end)

    self:addButton({
        text = "OK",
        x = startX + btnWidth + spacing,
        y = self.get("height") - 2,
        width = btnWidth,
        height = 1,
        background = self.get("primaryColor"),
        foreground = self.get("buttonForeground")
    }):onClick(function()
        if callback then callback(true) end
        self:close()
    end)

    return self:show()
end

--- Creates a prompt dialog with input
--- @shortDescription Creates a prompt dialog with input
--- @param title string The dialog title
--- @param message string The prompt message
--- @param default? string Default input value
--- @param callback? function Callback (receives input text or nil if cancelled)
--- @return Dialog self The Dialog instance
function Dialog:prompt(title, message, default, callback)
    self:clear()
    self.set("title", title)
    self.set("height", 11)

    self:addLabel({
        text = message,
        x = 2, y = 3,
        foreground = colors.white
    })

    local input = self:addInput({
        x = 2, y = 5,
        width = self.get("width") - 3,
        height = 1,
        defaultText = default or "",
        background = colors.white,
        foreground = colors.black
    })

    local btnWidth = 10
    local spacing = 2
    local totalWidth = btnWidth * 2 + spacing
    local startX = math.floor((self.get("width") - totalWidth) / 2) + 1

    self:addButton({
        text = "Cancel",
        x = startX,
        y = self.get("height") - 2,
        width = btnWidth,
        height = 1,
        background = self.get("secondaryColor"),
        foreground = self.get("buttonForeground")
    }):onClick(function()
        if callback then callback(nil) end
        self:close()
    end)

    self:addButton({
        text = "OK",
        x = startX + btnWidth + spacing,
        y = self.get("height") - 2,
        width = btnWidth,
        height = 1,
        background = self.get("primaryColor"),
        foreground = self.get("buttonForeground")
    }):onClick(function()
        if callback then callback(input.get("text") or "") end
        self:close()
    end)

    return self:show()
end

--- Renders the dialog
--- @shortDescription Renders the dialog
--- @protected
function Dialog:render()
    Frame.render(self)

    local title = self.get("title")
    if title ~= "" then
        local width = self.get("width")
        local titleText = title:sub(1, width - 4)
        self:textFg(2, 2, titleText, colors.white)
    end
end

--- Handles mouse click events
--- @shortDescription Handles mouse click events
--- @protected
function Dialog:mouse_click(button, x, y)
    if self.get("modal") then
        if self:isInBounds(x, y) then
            return Frame.mouse_click(self, button, x, y)
        end
        return true
    end
    return Frame.mouse_click(self, button, x, y)
end

--- Handles mouse drag events
--- @shortDescription Handles mouse drag events
--- @protected
function Dialog:mouse_drag(button, x, y)
    if self.get("modal") then
        if self:isInBounds(x, y) then
            return Frame.mouse_drag and Frame.mouse_drag(self, button, x, y) or false
        end
        return true
    end
    return Frame.mouse_drag and Frame.mouse_drag(self, button, x, y) or false
end

--- Handles mouse up events
--- @shortDescription Handles mouse up events
--- @protected
function Dialog:mouse_up(button, x, y)
    if self.get("modal") then
        if self:isInBounds(x, y) then
            return Frame.mouse_up and Frame.mouse_up(self, button, x, y) or false
        end
        return true
    end
    return Frame.mouse_up and Frame.mouse_up(self, button, x, y) or false
end

--- Handles mouse scroll events
--- @shortDescription Handles mouse scroll events
--- @protected
function Dialog:mouse_scroll(direction, x, y)
    if self.get("modal") then
        if self:isInBounds(x, y) then
            return Frame.mouse_scroll and Frame.mouse_scroll(self, direction, x, y) or false
        end
        return true
    end
    return Frame.mouse_scroll and Frame.mouse_scroll(self, direction, x, y) or false
end

return Dialog