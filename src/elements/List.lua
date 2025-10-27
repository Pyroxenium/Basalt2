local Collection = require("elements/Collection")
---@configDescription A scrollable list of selectable items

--- This is the list class. It provides a scrollable list of selectable items with support for 
--- custom item rendering, separators, and selection handling.
---@class List : Collection
local List = setmetatable({}, Collection)
List.__index = List

---@property offset number 0 Current scroll offset for viewing long lists
List.defineProperty(List, "offset", {default = 0, type = "number", canTriggerRender = true})

---@event onSelect {index number, item table} Fired when an item is selected
List.defineEvent(List, "mouse_click")
List.defineEvent(List, "mouse_up")
List.defineEvent(List, "mouse_scroll")

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
    return self
end

--- @shortDescription Handles mouse click events
--- @param button number The mouse button that was clicked
--- @param x number The x-coordinate of the click
--- @param y number The y-coordinate of the click
--- @return boolean Whether the event was handled
--- @protected
function List:mouse_click(button, x, y)
    if Collection.mouse_click(self, button, x, y) and self.get("selectable") then
        local _, index = self:getRelativePosition(x, y)
        local adjustedIndex = index + self.get("offset")
        local items = self.get("items")

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

--- @shortDescription Renders the list
--- @protected
function List:render()
    Collection.render(self)

    local items = self.get("items")
    local height = self.get("height")
    local offset = self.get("offset")
    local width = self.get("width")
    local listBg = self.getResolved("background")
    local listFg = self.getResolved("foreground")

    for i = 1, height do
        local itemIndex = i + offset
        local item = items[itemIndex]

        if item then
            if item.separator then
                local separatorChar = (item.text or "-"):sub(1,1)
                local separatorText = string.rep(separatorChar, width)
                local fg = item.fg or listFg
                local bg = item.bg or listBg

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, separatorText:sub(1, width), fg)
            else
                local text = item.text
                local isSelected = item.selected
                local bg = isSelected and
                    (item.selectedBg or self.getResolved("selectedBackground")) or
                    (item.bg or listBg)

                local fg = isSelected and
                    (item.selectedFg or self.getResolved("selectedForeground")) or
                    (item.fg or listFg)
                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, text:sub(1, width), fg)
            end
        end
    end
end

return List
