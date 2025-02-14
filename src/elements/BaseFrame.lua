local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
local Render = require("render")

---@class BaseFrame : Container
local BaseFrame = setmetatable({}, Container)
BaseFrame.__index = BaseFrame

---@property text term term nil text
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

function BaseFrame.new(props, basalt)
    local self = setmetatable({}, BaseFrame):__init()
    self:init(props, basalt)
    self.set("term", term.current())
    self.set("background", colors.red)
    return self
end

function BaseFrame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "BaseFrame")
end

function BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
    self._render:multiBlit(x, y, width, height, text, fg, bg)
end

function BaseFrame:textFg(x, y, text, fg)
    self._render:textFg(x, y, text, fg)
end

function BaseFrame:textBg(x, y, text, bg)
    self._render:textBg(x, y, text, bg)
end

function BaseFrame:blit(x, y, text, fg, bg)
    self._render:blit(x, y, text, fg, bg)
end

function BaseFrame:setCursor(x, y, blink)
    local term = self.get("term")
    self._render:setCursor(x, y, blink)
end

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