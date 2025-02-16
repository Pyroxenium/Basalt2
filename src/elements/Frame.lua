local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")

---@class Frame : Container
local Frame = setmetatable({}, Container)
Frame.__index = Frame

--- Creates a new Frame instance
--- @return Frame object The newly created Frame instance
--- @usage local element = Frame.new("myId", basalt)
function Frame.new()
    local self = setmetatable({}, Frame):__init()
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.gray)
    self.set("z", 10)
    return self
end

--- Initializes the Frame instance
function Frame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Frame")
end

return Frame