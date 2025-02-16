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

function List.new()
    local self = setmetatable({}, List):__init()
    self.set("width", 16)
    self.set("height", 8)
    self.set("background", colors.gray)
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
        local _, index = self:getRelativePosition(x, y)
        
        local adjustedIndex = index + self.get("offset")
        local items = self.get("items")

        if adjustedIndex <= #items then
            local item = items[adjustedIndex]
            self.set("selectedIndex", adjustedIndex)

            if type(item) == "table" and item.callback then
                item.callback(self)
            end

            self:fireEvent("select", adjustedIndex, item)
            self:updateRender()
            return true
        end
    end
    return false
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

function List:onSelect(callback)
    self:registerCallback("select", callback)
    return self
end

function List:render()
    VisualElement.render(self)

    local items = self.get("items")
    local height = self.get("height")
    local offset = self.get("offset")
    local selected = self.get("selectedIndex")
    local width = self.get("width")

    for i = 1, height do
        local itemIndex = i + offset
        local item = items[itemIndex]

        if item then
            if type(item) == "table" and item.separator then
                local separatorChar = (item.text or "-"):sub(1,1)
                local separatorText = string.rep(separatorChar, width)
                local fg = item.foreground or self.get("foreground")
                local bg = item.background or self.get("background")

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, separatorText, fg)
            else
                local text = type(item) == "table" and item.text or item
                local isSelected = itemIndex == selected

                local bg = isSelected and 
                    (item.selectedBackground or self.get("selectedColor")) or
                    (item.background or self.get("background"))

                local fg = isSelected and 
                    (item.selectedForeground or colors.white) or 
                    (item.foreground or self.get("foreground"))

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, text, fg)
            end
        end
    end
end

return List
