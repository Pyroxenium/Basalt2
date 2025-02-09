local Container = require("elements/Container")
local Render = require("render")

local BaseFrame = setmetatable({}, Container)
BaseFrame.__index = BaseFrame

---@diagnostic disable-next-line: duplicate-set-field
function BaseFrame.new(id, basalt)
    local self = setmetatable({}, BaseFrame):__init()
    self:init(id, basalt)
    self.terminal = term.current() -- change to :setTerm later!!
    self._render = Render.new(self.terminal)
    self._renderUpdate = true
    local width, height = self.terminal.getSize()
    self.set("width", width)
    self.set("height", height)
    self.set("background", colors.red)
    self.set("type", "BaseFrame")
    return self
end

function BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
    self._render:multiBlit(x, y, width, height, text, fg, bg)
end

function BaseFrame:textFg(x, y, text, fg)
    self._render:textFg(x, y, text, fg)
end

---@diagnostic disable-next-line: duplicate-set-field
function BaseFrame:render()
    if(self._renderUpdate) then
        Container.render(self)
        self._render:render()
        self._renderUpdate = false
    end
end

return BaseFrame