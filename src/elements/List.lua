local VisualElement = require("elements/VisualElement")

---@class List : VisualElement
local List = setmetatable({}, VisualElement)
List.__index = List

---@property items table List of items to display
List.defineProperty(List, "items", {default = {}, type = "table", canTriggerRender = true})
---@property selectedIndex number Currently selected item index
List.defineProperty(List, "selectedIndex", {default = 0, type = "number", canTriggerRender = true})
---@property selectable boolean Whether items can be selected
List.defineProperty(List, "selectable", {default = true, type = "boolean"})
---@property offset number Scrolling offset
List.defineProperty(List, "offset", {default = 0, type = "number", canTriggerRender = true})
---@property selectedColor color Color for selected item
List.defineProperty(List, "selectedColor", {default = colors.blue, type = "number"})

List.listenTo(List, "mouse_click")
List.listenTo(List, "mouse_scroll")

function List.new(props, basalt)
    local self = setmetatable({}, List):__init()
    self:init(props, basalt)
    self.set("width", 16)
    self.set("height", 8)
    return self
end

function List:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "List")
end

function List:addItem(text)
    local items = self.get("items")
    table.insert(items, text)
    self:updateRender()
    return self
end

function List:removeItem(index)
    local items = self.get("items")
    table.remove(items, index)
    self:updateRender()
    return self
end

function List:clear()
    self.set("items", {})
    self.set("selectedIndex", 0)
    self:updateRender()
    return self
end

function List:mouse_click(button, x, y)
    if button == 1 and self:isInBounds(x, y) and self.get("selectable") then
        local relY = self:getRelativePosition(x, y)
        local index = relY + self.get("offset")
        
        if index <= #self.get("items") then
            self.set("selectedIndex", index)
            self:fireEvent("select", index, self.get("items")[index])
            self:updateRender()
            return true
        end
    end
end

function List:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local offset = self.get("offset")
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))
        
        offset = math.min(maxOffset, math.max(0, offset + direction))
        self.set("offset", offset)
        return true
    end
end

function List:render()
    VisualElement.render(self)
    
    local items = self.get("items")
    local height = self.get("height")
    local offset = self.get("offset")
    local selected = self.get("selectedIndex")
    
    for i = 1, height do
        local itemIndex = i + offset
        local item = items[itemIndex]
        
        if item then
            if itemIndex == selected then
                self:textBg(1, i, string.rep(" ", self.get("width")), self.get("selectedColor"))
                self:textFg(1, i, item, colors.white)
            else
                self:textFg(1, i, item, self.get("foreground"))
            end
        end
    end
end

return List
