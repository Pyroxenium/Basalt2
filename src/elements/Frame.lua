local Container = require("elements/Container")

local Frame = setmetatable({}, Container)
Frame.__index = Frame

---@diagnostic disable-next-line: duplicate-set-field
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