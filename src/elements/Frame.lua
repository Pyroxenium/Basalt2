local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local Container = elementManager.getElement("Container")
---@configDescription A frame element that serves as a grouping container for other elements.

--- This is the frame class. It serves as a grouping container for other elements.
---@class Frame : Container
local Frame = setmetatable({}, Container)
Frame.__index = Frame

---@property draggable boolean false Whether the frame is draggable
Frame.defineProperty(Frame, "draggable", {default = false, type = "boolean", setter=function(self, value)
    if value then
        self:listenEvent("mouse_click", true)
        self:listenEvent("mouse_up", true)
        self:listenEvent("mouse_drag", true)
    end
    return value
end})
---@property draggingMap table {} The map of dragging positions
Frame.defineProperty(Frame, "draggingMap", {default = {{x=1, y=1, width="width", height=1}}, type = "table"})

--- Creates a new Frame instance
--- @shortDescription Creates a new Frame instance
--- @return Frame self The newly created Frame instance
--- @private
function Frame.new()
    local self = setmetatable({}, Frame):__init()
    self.class = Frame
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.gray)
    self.set("z", 10)
    return self
end

--- @shortDescription Initializes the Frame instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Frame self The initialized instance
--- @protected
function Frame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Frame")
    return self
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Frame:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        if self.get("draggable") then
            local relX, relY = self:getRelativePosition(x, y)
            local draggingMap = self.get("draggingMap")

            for _, map in ipairs(draggingMap) do
                local width = map.width or 1
                local height = map.height or 1

                if type(width) == "string" and width == "width" then
                    width = self.get("width")
                elseif type(width) == "function" then
                    width = width(self)
                end
                if type(height) == "string" and height == "height" then
                    height = self.get("height")
                elseif type(height) == "function" then
                    height = height(self)
                end

                local mapY = map.y or 1
                if relX >= map.x and relX <= map.x + width - 1 and
                relY >= mapY and relY <= mapY + height - 1 then
                    self.dragStartX = x - self.get("x")
                    self.dragStartY = y - self.get("y")
                    self.dragging = true
                    return true
                end
            end
        end
        return Container.mouse_click(self, button, x, y)
    end
    return false
end

--- @shortDescription Handles mouse release events
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @return boolean handled Whether the event was handled
--- @protected
function Frame:mouse_up(button, x, y)
    self.dragging = false
    self.dragStartX = nil
    self.dragStartY = nil
    return Container.mouse_up(self, button, x, y)
end

--- @shortDescription Handles mouse drag events
--- @param button number The button that was clicked
--- @param x number The x position of the drag position
--- @param y number The y position of the drag position
--- @return boolean handled Whether the event was handled
--- @protected
function Frame:mouse_drag(button, x, y)
    if self.get("clicked") and self.dragging then
        local newX = x - self.dragStartX
        local newY = y - self.dragStartY

        self.set("x", newX)
        self.set("y", newY)
        return true
    end
    if not self.dragging then
        return Container.mouse_drag(self, button, x, y)
    end
    return false
end

return Frame