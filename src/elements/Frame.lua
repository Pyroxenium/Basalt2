local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")

--- This is the frame class. It serves as a grouping container for other elements.
---@class Frame : Container
local Frame = setmetatable({}, Container)
Frame.__index = Frame

--- Creates a new Frame instance
--- @shortDescription Creates a new Frame instance
--- @return Frame self The newly created Frame instance
--- @usage local frame = Frame.new()
function Frame.new()
    local self = setmetatable({}, Frame):__init()
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.gray)
    self.set("z", 10)
    return self
end

--- Initializes the Frame instance
--- @shortDescription Initializes the Frame instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Frame self The initialized instance
function Frame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Frame")
    return self
end

return Frame