-- Frame: a nestable child container with its own background.
-- Set draggable = true to move it by its top row (customize via draggingMap).

local require = ...
local class = require("core/class")
local Container = require("core/container")

---@class FrameDragZone
---@field x number Local x coordinate
---@field y number Local y coordinate
---@field width? number|"full" Zone width
---@field height? number|"full" Zone height

---@class FrameDragPoint
---@field x number Grab x coordinate
---@field y number Grab y coordinate

---@class Frame : Container
---@field public draggable boolean Whether the frame can be dragged
---@field public draggingMap FrameDragZone[]|false Custom grab zones
---@field private _dragFrom? FrameDragPoint Active grab position
local Frame = class.create("Frame", Container)

--- Background color (false = transparent)
class.property(Frame, "background", colors.gray)
--- Width in terminal cells
class.property(Frame, "width", 20)
--- Height in terminal cells
class.property(Frame, "height", 8)
class.property(Frame, "draggable", false) -- move the frame by its grab zones
--- List of grab zones in local coordinates, e.g. {{x=1, y=1, width="full",
--- height=1}}; false = the whole top row
class.property(Frame, "draggingMap", false, { visual = false })

---@param self Frame
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return boolean inside
local function inDragZone(self, x, y)
    local zones = self.draggingMap
    if not zones then
        zones = { { x = 1, y = 1, width = "full", height = 1 } }
    end
    for i = 1, #zones do
        local zone = zones[i]
        local zw = zone.width == "full" and self.width or (zone.width or 1)
        local zh = zone.height == "full" and self.height or (zone.height or 1)
        if x >= zone.x and x < zone.x + zw
            and y >= zone.y and y < zone.y + zh then
            return true
        end
    end
    return false
end

--- Initializes per-instance state and input handlers.
function Frame:setup()
    Container.setup(self)

    self:on("click", function(s, _, x, y)
        if s.draggable and inDragZone(s, x, y) then
            rawset(s, "_dragFrom", { x = x, y = y })
        end
    end)
    self:on("drag", function(s, _, x, y)
        local from = rawget(s, "_dragFrom")
        if from then
            -- drag coords are relative to the frame's current position, so
            -- the delta against the grab point is the movement
            s.x = s.x + x - from.x
            s.y = s.y + y - from.y
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_dragFrom", nil)
    end)
end

--- Moves the frame above its siblings (highest z + 1).
---@return self
---@usage frame:onFocus(function(f) f:toFront() end)
function Frame:toFront()
    local parent = rawget(self, "parent")
    if not parent then return self end
    local top = self.z
    for _, sibling in ipairs(parent:getChildren()) do
        if sibling.z > top then top = sibling.z end
    end
    if top >= self.z then self.z = top + 1 end
    return self
end

return Frame
