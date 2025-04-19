local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
local errorManager = require("errorManager")
local Render = require("render")
---@configDescription This is the base frame class. It is the root element of all elements and the only element without a parent.


--- This is the base frame class. It is the root element of all elements and the only element without a parent.
---@class BaseFrame : Container
---@field _render Render The render object
---@field _renderUpdate boolean Whether the render object needs to be updated
---@field _peripheralName string The name of a peripheral
local BaseFrame = setmetatable({}, Container)
BaseFrame.__index = BaseFrame

local function isPeripheral(t)
    local ok, result = pcall(function()
        return peripheral.getType(t)
    end)
    if ok then
        return true
    end
    return false
end

---@property term term|peripheral term.current() The terminal or (monitor) peripheral object to render to
BaseFrame.defineProperty(BaseFrame, "term", {default = nil, type = "table", setter = function(self, value)
    self._peripheralName = nil
    if self.basalt.getActiveFrame(self._values.term)==self then
        self.basalt.setActiveFrame(self, false)
    end
    if value == nil or value.setCursorPos == nil then
        return value
    end

    if(isPeripheral(value)) then
        self._peripheralName = peripheral.getName(value)
    end

    self._values.term = value
    if self.basalt.getActiveFrame(value) == nil then
        self.basalt.setActiveFrame(self)
    end

    self._render = Render.new(value)
    self._renderUpdate = true
    local width, height = value.getSize()
    self.set("width", width)
    self.set("height", height)
    return value
end})

--- Creates a new Frame instance
--- @shortDescription Creates a new Frame instance
--- @return BaseFrame object The newly created Frame instance
--- @usage local element = BaseFrame.new()
--- @private
function BaseFrame.new()
    local self = setmetatable({}, BaseFrame):__init()
    self.class = BaseFrame
    return self
end

--- @shortDescription Initializes the Frame instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return table self The initialized instance
--- @protected
function BaseFrame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("term", term.current())
    self.set("type", "BaseFrame")
    return self
end

--- @shortDescription Renders a multiBlit to the render Object
--- @param x number The x position to render to
--- @param y number The y position to render to
--- @param width number The width of the text
--- @param height number The height of the text
--- @param text string The text to render
--- @param fg string The foreground color
--- @param bg string The background color
--- @protected
function BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
    if(x<1)then width = width + x - 1; x = 1 end
    if(y<1)then height = height + y - 1; y = 1 end
    self._render:multiBlit(x, y, width, height, text, fg, bg)
end

--- @shortDescription Renders a text with a foreground color to the render Object
--- @param x number The x position to render to
--- @param y number The y position to render to
--- @param text string The text to render
--- @param fg colors The foreground color
--- @protected
function BaseFrame:textFg(x, y, text, fg)
    if x < 1 then text = string.sub(text, 1 - x); x = 1 end
    self._render:textFg(x, y, text, fg)
end

--- @shortDescription Renders a text with a background color to the render Object
--- @param x number The x position to render to
--- @param y number The y position to render to
--- @param text string The text to render
--- @param bg colors The background color
--- @protected
function BaseFrame:textBg(x, y, text, bg)
    if x < 1 then text = string.sub(text, 1 - x); x = 1 end
    self._render:textBg(x, y, text, bg)
end

--- @shortDescription Renders a text with a background color to the render Object
--- @param x number The x position to render to
--- @param y number The y position to render to
--- @param text string The text to render
--- @param bg colors The background color
--- @protected
function BaseFrame:drawText(x, y, text)
    if x < 1 then text = string.sub(text, 1 - x); x = 1 end
    self._render:text(x, y, text)
end

function BaseFrame:drawFg(x, y, fg)
    if x < 1 then fg = string.sub(fg, 1 - x); x = 1 end
    self._render:fg(x, y, fg)
end

function BaseFrame:drawBg(x, y, bg)
    if x < 1 then bg = string.sub(bg, 1 - x); x = 1 end
    self._render:bg(x, y, bg)
end

--- @shortDescription Renders a text with a foreground and background color to the render Object
--- @param x number The x position to render to
--- @param y number The y position to render to
--- @param text string The text to render
--- @param fg string The foreground color
--- @param bg string The background color
--- @protected
function BaseFrame:blit(x, y, text, fg, bg)
    if x < 1 then 
        text = string.sub(text, 1 - x)
        fg = string.sub(fg, 1 - x)
        bg = string.sub(bg, 1 - x)
        x = 1 end
    self._render:blit(x, y, text, fg, bg)
end

--- Sets the cursor position
--- @shortDescription Sets the cursor position
--- @param x number The x position to set the cursor to
--- @param y number The y position to set the cursor to
--- @param blink boolean Whether the cursor should blink
function BaseFrame:setCursor(x, y, blink, color)
    local _term = self.get("term")
    self._render:setCursor(x, y, blink, color)
end

--- @shortDescription Handles monitor touch events
--- @param name string The name of the monitor that was touched
--- @param x number The x position of the mouse
--- @param y number The y position of the mouse
--- @protected
function BaseFrame:monitor_touch(name, x, y)
    local _term = self.get("term")
    if _term == nil then return end
        if(isPeripheral(_term))then
        if self._peripheralName == name then
            self:mouse_click(1, x, y)
            self.basalt.schedule(function()
                sleep(0.1)
                self:mouse_up(1, x, y)
            end)
        end
    end
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the mouse
--- @param y number The y position of the mouse
--- @protected
function BaseFrame:mouse_click(button, x, y)
    Container.mouse_click(self, button, x, y)
    self.basalt.setFocus(self)
end

--- @shortDescription Handles mouse up events
--- @param button number The button that was released
--- @param x number The x position of the mouse
--- @param y number The y position of the mouse
--- @protected
function BaseFrame:mouse_up(button, x, y)
    Container.mouse_up(self, button, x, y)
    Container.mouse_release(self, button, x, y)
end

--- @shortDescription Resizes the Frame
--- @protected
function BaseFrame:term_resize()
    local width, height = self.get("term").getSize()
    if(width == self.get("width") and height == self.get("height")) then
        return
    end
    self.set("width", width)
    self.set("height", height)
    self._render:setSize(width, height)
    self._renderUpdate = true
end

--- @shortDescription Handles key events
--- @param key number The key that was pressed
--- @protected
function BaseFrame:key(key)
    self:fireEvent("key", key)
    Container.key(self, key)
end

--- @shortDescription Handles key up events
--- @param key number The key that was released
--- @protected
function BaseFrame:key_up(key)
    self:fireEvent("key_up", key)
    Container.key_up(self, key)
end

--- @shortDescription Handles character events
--- @param char string The character that was pressed
--- @protected
function BaseFrame:char(char)
    self:fireEvent("char", char)
    Container.char(self, char)
end

function BaseFrame:dispatchEvent(event, ...)
    local _term = self.get("term")
    if _term == nil then return end
    if(isPeripheral(_term))then
        if event == "mouse_click" then
            return
        end
    end
    Container.dispatchEvent(self, event, ...)
end

--- @shortDescription Renders the Frame
--- @protected
function BaseFrame:render()
    if(self._renderUpdate) then
        if self._render ~= nil then
            Container.render(self)
            self._render:render()
            self._renderUpdate = false
        end
    end
end

return BaseFrame