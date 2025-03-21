local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
local Render = require("render")
---@configDescription This is the base frame class. It is the root element of all elements and the only element without a parent.


--- This is the base frame class. It is the root element of all elements and the only element without a parent.
---@class BaseFrame : Container
---@field _render Render The render object
---@field _renderUpdate boolean Whether the render object needs to be updated
local BaseFrame = setmetatable({}, Container)
BaseFrame.__index = BaseFrame

---@property text term nil The terminal object to render to
BaseFrame.defineProperty(BaseFrame, "term", {default = nil, type = "table", setter = function(self, value)
    if value == nil or value.setCursorPos == nil then
        return value
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
    local term = self.get("term")
    self._render:setCursor(x, y, blink, color)
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