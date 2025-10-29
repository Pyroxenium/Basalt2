local Collection = require("elements/Collection")
local tHex = require("libraries/colorHex")
---@configDescription A scrollable list of selectable items

--- This is the list class. It provides a scrollable list of selectable items with support for 
--- custom item rendering, separators, and selection handling.
---@class List : Collection
local List = setmetatable({}, Collection)
List.__index = List

---@property offset number 0 Current scroll offset for viewing long lists
List.defineProperty(List, "offset", {
    default = 0,
    type = "number",
    canTriggerRender = true,
    setter = function(self, value)
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))
        return math.min(maxOffset, math.max(0, value))
    end
})

---@property emptyText string "No items" Text to display when the list is empty
List.defineProperty(List, "emptyText", {default = "No items", type = "string", canTriggerRender = true})

---@property showScrollBar boolean true Whether to show the scrollbar when items exceed height
List.defineProperty(List, "showScrollBar", {default = true, type = "boolean", canTriggerRender = true})

---@property scrollBarSymbol string " " Symbol used for the scrollbar handle
List.defineProperty(List, "scrollBarSymbol", {default = " ", type = "string", canTriggerRender = true})

---@property scrollBarBackground string "\127" Symbol used for the scrollbar background
List.defineProperty(List, "scrollBarBackground", {default = "\127", type = "string", canTriggerRender = true})

---@property scrollBarColor color lightGray Color of the scrollbar handle
List.defineProperty(List, "scrollBarColor", {default = colors.lightGray, type = "color", canTriggerRender = true})

---@property scrollBarBackgroundColor color gray Background color of the scrollbar
List.defineProperty(List, "scrollBarBackgroundColor", {default = colors.gray, type = "color", canTriggerRender = true})

---@event onSelect {index number, item table} Fired when an item is selected
List.defineEvent(List, "mouse_click")
List.defineEvent(List, "mouse_up")
List.defineEvent(List, "mouse_drag")
List.defineEvent(List, "mouse_scroll")
List.defineEvent(List, "key")

---@tableType ItemTable
---@tableField text string The display text for the item
---@tableField callback function Function called when selected
---@tableField fg color Normal text color
---@tableField bg color Normal background color
---@tableField selectedFg color Text color when selected
---@tableField selectedBg color Background when selected

local entrySchema = {
    text = { type = "string", default = "Entry" },
    bg = { type = "number", default = nil },
    fg = { type = "number", default = nil },
    selectedBg = { type = "number", default = nil },
    selectedFg = { type = "number", default = nil },
    callback = { type = "function", default = nil }
}

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
    Collection.init(self, props, basalt)
    self._entrySchema = entrySchema
    self.set("type", "List")

    self:observe("items", function()
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))
        if self.get("offset") > maxOffset then
            self.set("offset", maxOffset)
        end
    end)

    self:observe("height", function()
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))
        if self.get("offset") > maxOffset then
            self.set("offset", maxOffset)
        end
    end)

    return self
end

--- @shortDescription Handles mouse click events
--- @param button number The mouse button that was clicked
--- @param x number The x-coordinate of the click
--- @param y number The y-coordinate of the click
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_click(button, x, y)
    if Collection.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local width = self.get("width")
        local items = self.get("items")
        local height = self.get("height")
        local showScrollBar = self.get("showScrollBar")

        if showScrollBar and #items > height and relX == width then
            local maxOffset = #items - height
            local handleSize = math.max(1, math.floor((height / #items) * height))

            local currentPercent = maxOffset > 0 and (self.get("offset") / maxOffset * 100) or 0
            local handlePos = math.floor((currentPercent / 100) * (height - handleSize)) + 1

            if relY >= handlePos and relY < handlePos + handleSize then
                self._scrollBarDragging = true
                self._scrollBarDragOffset = relY - handlePos
            else
                local newPercent = ((relY - 1) / (height - handleSize)) * 100
                local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)
                self.set("offset", math.max(0, math.min(maxOffset, newOffset)))
            end
            return true
        end

        if self.get("selectable") then
            local adjustedIndex = relY + self.get("offset")

            if adjustedIndex <= #items then
                local item = items[adjustedIndex]
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
                self:fireEvent("select", adjustedIndex, item)
                self:updateRender()
            end
        end
        return true
    end
    return false
end

--- @shortDescription Handles mouse drag events for scrollbar
--- @param button number The mouse button being dragged
--- @param x number The x-coordinate of the drag
--- @param y number The y-coordinate of the drag
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_drag(button, x, y)
    if self._scrollBarDragging then
        local _, relY = self:getRelativePosition(x, y)
        local items = self.get("items")
        local height = self.get("height")
        local handleSize = math.max(1, math.floor((height / #items) * height))
        local maxOffset = #items - height
        relY = math.max(1, math.min(height, relY))

        local newPos = relY - (self._scrollBarDragOffset or 0)
        local newPercent = ((newPos - 1) / (height - handleSize)) * 100
        local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)

        self.set("offset", math.max(0, math.min(maxOffset, newOffset)))
        return true
    end
    return Collection.mouse_drag and Collection.mouse_drag(self, button, x, y) or false
end

--- @shortDescription Handles mouse up events to stop scrollbar dragging
--- @param button number The mouse button that was released
--- @param x number The x-coordinate of the release
--- @param y number The y-coordinate of the release
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_up(button, x, y)
    if self._scrollBarDragging then
        self._scrollBarDragging = false
        self._scrollBarDragOffset = nil
        return true
    end
    return Collection.mouse_up and Collection.mouse_up(self, button, x, y) or false
end

--- @shortDescription Handles mouse scroll events
--- @param direction number The direction of the scroll (1 for down, -1 for up)
--- @param x number The x-coordinate of the scroll
--- @param y number The y-coordinate of the scroll
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_scroll(direction, x, y)
    if Collection.mouse_scroll(self, direction, x, y) then
        local offset = self.get("offset")
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))

        offset = math.min(maxOffset, math.max(0, offset + direction))
        self.set("offset", offset)
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

--- Scrolls to make a specific item visible
--- @shortDescription Scrolls to a specific item
--- @param index number The index of the item to scroll to
--- @return List self The List instance
--- @usage list:scrollToItem(5)
function List:scrollToItem(index)
    local height = self.get("height")
    local offset = self.get("offset")

    if index < offset + 1 then
        self.set("offset", math.max(0, index - 1))
    elseif index > offset + height then
        self.set("offset", index - height)
    end

    return self
end

--- Handles key events for keyboard navigation
--- @shortDescription Handles key events
--- @param keyCode number The key code
--- @return boolean Whether the event was handled
--- @protected
function List:key(keyCode)
    if Collection.key(self, keyCode) and self.get("selectable") then
        local items = self.get("items")
        local currentIndex = self:getSelectedIndex()

        if keyCode == keys.up then
            self:selectPrevious()
            if currentIndex and currentIndex > 1 then
                self:scrollToItem(currentIndex - 1)
            end
            return true
        elseif keyCode == keys.down then
            self:selectNext()
            if currentIndex and currentIndex < #items then
                self:scrollToItem(currentIndex + 1)
            end
            return true
        elseif keyCode == keys.home then
            self:clearItemSelection()
            self:selectItem(1)
            self:scrollToTop()
            return true
        elseif keyCode == keys["end"] then
            self:clearItemSelection()
            self:selectItem(#items)
            self:scrollToBottom()
            return true
        elseif keyCode == keys.pageUp then
            local height = self.get("height")
            local newIndex = math.max(1, (currentIndex or 1) - height)
            self:clearItemSelection()
            self:selectItem(newIndex)
            self:scrollToItem(newIndex)
            return true
        elseif keyCode == keys.pageDown then
            local height = self.get("height")
            local newIndex = math.min(#items, (currentIndex or 1) + height)
            self:clearItemSelection()
            self:selectItem(newIndex)
            self:scrollToItem(newIndex)
            return true
        end
    end
    return false
end

--- @shortDescription Renders the list
--- @protected
function List:render(vOffset)
    Collection.render(self)

    local items = self.get("items")
    local height = self.get("height")
    local offset = self.get("offset")
    local width = self.get("width")
    local listBg = self.getResolved("background")
    local listFg = self.getResolved("foreground")
    local showScrollBar = self.get("showScrollBar")

    local needsScrollBar = showScrollBar and #items > height
    local contentWidth = needsScrollBar and width - 1 or width

    if #items == 0 then
        local emptyText = self.get("emptyText")
        local y = math.floor(height / 2) + vOffset
        local x = math.max(1, math.floor((width - #emptyText) / 2) + 1)

        for i = 1, height do
            self:textBg(1, i, string.rep(" ", width), listBg)
        end

        if y >= 1 and y <= height then
            self:textFg(x, y + vOffset, emptyText, colors.gray)
        end
        return
    end

    for i = 1, height do
        local itemIndex = i + offset
        local item = items[itemIndex]

        if item then
            if item.separator then
                local separatorChar = ((item.text or "-") ~= "" and item.text or "-"):sub(1,1)
                local separatorText = string.rep(separatorChar, contentWidth)
                local fg = item.fg or listFg
                local bg = item.bg or listBg

                self:textBg(1, i + vOffset, string.rep(" ", contentWidth), bg)
                self:textFg(1, i + vOffset, separatorText, fg)
            else
                local text = item.text or ""
                local isSelected = item.selected
                local bg = isSelected and
                    (item.selectedBg or self.getResolved("selectedBackground")) or
                    (item.bg or listBg)

                local fg = isSelected and
                    (item.selectedFg or self.getResolved("selectedForeground")) or
                    (item.fg or listFg)

                local displayText = text
                if #displayText > contentWidth then
                    displayText = displayText:sub(1, contentWidth - 3) .. "..."
                else
                    displayText = displayText .. string.rep(" ", contentWidth - #displayText)
                end

                self:textBg(1, i + vOffset, string.rep(" ", contentWidth), bg)
                self:textFg(1, i + vOffset, displayText, fg)
            end
        else
            self:textBg(1, i + vOffset, string.rep(" ", contentWidth), listBg)
        end
    end

    if needsScrollBar then
        local handleSize = math.max(1, math.floor((height / #items) * height))
        local maxOffset = #items - height

        local currentPercent = maxOffset > 0 and (offset / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (height - handleSize)) + 1

        local scrollBarSymbol = self.getResolved("scrollBarSymbol")
        local scrollBarBg = self.getResolved("scrollBarBackground")
        local scrollBarColor = self.getResolved("scrollBarColor")
        local scrollBarBgColor = self.getResolved("scrollBarBackgroundColor")

        for i = 1, height do
            self:blit(width, i + vOffset, scrollBarBg, tHex[listFg], tHex[scrollBarBgColor])
        end

        for i = handlePos, math.min(height, handlePos + handleSize - 1) do
            self:blit(width, i + vOffset, scrollBarSymbol, tHex[scrollBarColor], tHex[scrollBarBgColor])
        end
    end
end

return List