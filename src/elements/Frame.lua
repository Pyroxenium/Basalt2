local Container = require("elements/Container")

---@class Frame : Container
local Frame = setmetatable({}, Container)
Frame.__index = Frame

function Frame.new(id, basalt)
    local self = setmetatable({}, Frame):__init()
    self:init(id, basalt)
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.blue)
    self.set("type", "Frame")
    self.set("z", 10)
    return self
end

return Frame