-- Frame: a nestable child container with its own background.
-- Set draggable = true to move it by its top row (customize via draggingMap).

local require = ...
local class = require("core/class")
local Container = require("core/container")

local Frame = class.create("Frame", Container)

class.property(Frame, "background", colors.gray)
class.property(Frame, "width", 20)
class.property(Frame, "height", 8)
class.property(Frame, "draggable", false)
-- list of grab zones in local coordinates; width/height accept "full"
class.property(Frame, "draggingMap", false, { visual = false })

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
