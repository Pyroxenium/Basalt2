local VisualElement = require("elements/VisualElement")
---@configDescription A scrollable list of selectable items

--- This is the list class. It provides a scrollable list of selectable items with support for 
--- custom item rendering, separators, and selection handling.
---@class List : VisualElement
local List = setmetatable({}, VisualElement)
List.__index = List

---@property items table {} List of items to display. Items can be tables with properties including selected state
List.defineProperty(List, "items", {default = {}, type = "table", canTriggerRender = true})
---@property selectable boolean true Whether items in the list can be selected
List.defineProperty(List, "selectable", {default = true, type = "boolean"})
---@property multiSelection boolean false Whether multiple items can be selected at once
List.defineProperty(List, "multiSelection", {default = false, type = "boolean"})
---@property offset number 0 Current scroll offset for viewing long lists
List.defineProperty(List, "offset", {default = 0, type = "number", canTriggerRender = true})
---@property selectedBackground color blue Background color for selected items
List.defineProperty(List, "selectedBackground", {default = colors.blue, type = "color"})
---@property selectedForeground color white Text color for selected items
List.defineProperty(List, "selectedForeground", {default = colors.white, type = "color"})

---@event onSelect {index number, item table} Fired when an item is selected
List.defineEvent(List, "mouse_click")
List.defineEvent(List, "mouse_scroll")

--- Creates a new List instance
--- @shortDescription Creates a new List instance
--- @return List self The newly created List instance
--- @private
function List.new()
    local self = setmetatable({}, List):__init()
    self.class = List
    self.set("width", 16)
    self.set("height", 8)
    self.set("z", 5)
    self.set("background", colors.gray)
    return self
end

--- @shortDescription Initializes the List instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return List self The initialized instance
--- @protected
function List:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "List")
    return self
end

--- Adds an item to the list
--- @shortDescription Adds an item to the list
--- @param text string|table The item to add (string or item table)
--- @return List self The List instance
--- @usage list:addItem("New Item")
--- @usage list:addItem({text="Item", callback=function() end})
function List:addItem(text)
    local items = self.get("items")
    table.insert(items, text)
    self:updateRender()
    return self
end

--- Removes an item from the list
--- @shortDescription Removes an item from the list
--- @param index number The index of the item to remove
--- @return List self The List instance
--- @usage list:removeItem(1)
function List:removeItem(index)
    local items = self.get("items")
    table.remove(items, index)
    self:updateRender()
    return self
end

--- Clears all items from the list
--- @shortDescription Clears all items from the list
--- @return List self The List instance
--- @usage list:clear()
function List:clear()
    self.set("items", {})
    self:updateRender()
    return self
end

-- Gets the currently selected items
--- @shortDescription Gets the currently selected items
--- @return table selected List of selected items
--- @usage local selected = list:getSelectedItems()
function List:getSelectedItems()
    local selected = {}
    for i, item in ipairs(self.get("items")) do
        if type(item) == "table" and item.selected then
            local selectedItem = item
            selectedItem.index = i
            table.insert(selected, selectedItem)
        end
    end
    return selected
end

--- Gets first selected item
--- @shortDescription Gets first selected item
--- @return table? selected The first item
function List:getSelectedItem()
    local items = self.get("items")
    for i, item in ipairs(items) do
        if type(item) == "table" and item.selected then
            return item
        end
    end
    return nil
end

--- @shortDescription Handles mouse click events
--- @param button number The mouse button that was clicked
--- @param x number The x-coordinate of the click
--- @param y number The y-coordinate of the click
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_click(button, x, y)
    if self:isInBounds(x, y) and self.get("selectable") then
        local _, index = self:getRelativePosition(x, y)
        local adjustedIndex = index + self.get("offset")
        local items = self.get("items")

        if adjustedIndex <= #items then
            local item = items[adjustedIndex]
            if type(item) == "string" then
                item = {text = item}
                items[adjustedIndex] = item
            end

            if not self.get("multiSelection") then
                for _, otherItem in ipairs(items) do
                    if type(otherItem) == "table" then
                        otherItem.selected = false
                    end
                end
            end

            item.selected = not item.selected

            if item.callback then
                item.callback(self)
            end
            self:fireEvent("mouse_click", button, x, y)
            self:fireEvent("select", adjustedIndex, item)
            self:updateRender()
        end
        return true
    end
    return false
end

--- @shortDescription Handles mouse scroll events
--- @param direction number The direction of the scroll (1 for down, -1 for up)
--- @param x number The x-coordinate of the scroll
--- @param y number The y-coordinate of the scroll
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local offset = self.get("offset")
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))

        offset = math.min(maxOffset, math.max(0, offset + direction))
        self.set("offset", offset)
        self:fireEvent("mouse_scroll", direction, x, y)
        return true
    end
    return false
end

--- Registers a callback for the select event
--- @shortDescription Registers a callback for the select event
--- @param callback function The callback function to register
--- @return List self The List instance
--- @usage list:onSelect(function(index, item) print("Selected item:", index, item) end)
function List:onSelect(callback)
    self:registerCallback("select", callback)
    return self
end

--- Scrolls the list to the bottom
--- @shortDescription Scrolls the list to the bottom
--- @return List self The List instance
function List:scrollToBottom()
    local maxOffset = math.max(0, #self.get("items") - self.get("height"))
    self.set("offset", maxOffset)
    return self
end

--- Scrolls the list to the top
--- @shortDescription Scrolls the list to the top
--- @return List self The List instance
function List:scrollToTop()
    self.set("offset", 0)
    return self
end

--- @shortDescription Renders the list
--- @protected
function List:render()
    VisualElement.render(self)

    local items = self.get("items")
    local height = self.get("height")
    local offset = self.get("offset")
    local width = self.get("width")

    for i = 1, height do
        local itemIndex = i + offset
        local item = items[itemIndex]

        if item then
            if type(item) == "string" then
                item = {text = item}
                items[itemIndex] = item
            end

            if item.separator then
                local separatorChar = (item.text or "-"):sub(1,1)
                local separatorText = string.rep(separatorChar, width)
                local fg = item.foreground or self.get("foreground")
                local bg = item.background or self.get("background")

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, separatorText:sub(1, width), fg)
            else
                local text = item.text
                local isSelected = item.selected

                local bg = isSelected and
                    (item.selectedBackground or self.get("selectedBackground")) or
                    (item.background or self.get("background"))

                local fg = isSelected and
                    (item.selectedForeground or self.get("selectedForeground")) or
                    (item.foreground or self.get("foreground"))

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, text:sub(1, width), fg)
            end
        end
    end
end

return List
