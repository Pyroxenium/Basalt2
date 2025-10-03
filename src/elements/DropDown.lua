local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@configDescription A DropDown menu that shows a list of selectable items
---@configDefault false

--- Item Properties:
--- Property|Type|Description
--- -------|------|-------------
--- text|string|The display text for the item
--- separator|boolean|Makes item a divider line
--- callback|function|Function called when selected
--- foreground|color|Normal text color
--- background|color|Normal background color
--- selectedForeground|color|Text color when selected
--- selectedBackground|color|Background when selected

--- A collapsible selection menu that expands to show multiple options when clicked. Supports single and multi-selection modes, custom item styling, separators, and item callbacks.
--- @usage -- Create a styled dropdown menu
--- @usage local dropdown = main:addDropDown()
--- @usage     :setPosition(5, 5)
--- @usage     :setSize(20, 1)  -- Height expands when opened
--- @usage     :setSelectedText("Select an option...")
--- @usage 
--- @usage -- Add items with different styles and callbacks
--- @usage dropdown:setItems({
--- @usage     {
--- @usage         text = "Category A",
--- @usage         background = colors.blue,
--- @usage         foreground = colors.white
--- @usage     },
--- @usage     { separator = true, text = "-" },  -- Add a separator
--- @usage     {
--- @usage         text = "Option 1",
--- @usage         callback = function(self)
--- @usage             -- Handle selection
--- @usage             basalt.debug("Selected Option 1")
--- @usage         end
--- @usage     },
--- @usage     {
--- @usage         text = "Option 2",
--- @usage         -- Custom colors when selected
--- @usage         selectedBackground = colors.green,
--- @usage         selectedForeground = colors.white
--- @usage     }
--- @usage })
--- @usage
--- @usage -- Listen for selections
--- @usage dropdown:onChange(function(self, value)
--- @usage     basalt.debug("Selected:", value)
--- @usage end)
---@class DropDown : List
local DropDown = setmetatable({}, List)
DropDown.__index = DropDown

---@property isOpen boolean false Controls the expanded/collapsed state
DropDown.defineProperty(DropDown, "isOpen", {default = false, type = "boolean", canTriggerRender = true})
---@property dropdownHeight number 5 Maximum visible items when expanded
DropDown.defineProperty(DropDown, "dropdownHeight", {default = 5, type = "number"})
---@property selectedText string "" Text shown when no selection made
DropDown.defineProperty(DropDown, "selectedText", {default = "", type = "string"})
---@property dropSymbol string "\31" Indicator for dropdown state
DropDown.defineProperty(DropDown, "dropSymbol", {default = "\31", type = "string"})

--- Creates a new DropDown instance
--- @shortDescription Creates a new DropDown instance
--- @return DropDown self The newly created DropDown instance
--- @private
function DropDown.new()
    local self = setmetatable({}, DropDown):__init()
    self.class = DropDown
    self.set("width", 16)
    self.set("height", 1)
    self.set("z", 8)
    return self
end

--- @shortDescription Initializes the DropDown instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return DropDown self The initialized instance
--- @protected
function DropDown:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "DropDown")
    return self
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function DropDown:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)

    if relY == 1 then
        self.set("isOpen", not self.get("isOpen"))
        if not self.get("isOpen") then
            self.set("height", 1)
        else
            self.set("height", 1 + math.min(self.get("dropdownHeight"), #self.get("items")))
        end
        return true
    elseif self.get("isOpen") and relY > 1 and self.get("selectable") then
        local itemIndex = (relY - 1) + self.get("offset")
        local items = self.get("items")

        if itemIndex <= #items then
            local item = items[itemIndex]
            if type(item) == "string" then
                item = {text = item}
                items[itemIndex] = item
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

            self:fireEvent("select", itemIndex, item)
            self.set("isOpen", false)
            self.set("height", 1)
            self:updateRender()
            return true
        end
    end
    return false
end

--- @shortDescription Renders the DropDown
--- @protected
function DropDown:render()
    VisualElement.render(self)

    local text = self.get("selectedText")
    local selectedItems = self:getSelectedItems()
    if #selectedItems > 0 then
        local selectedItem = selectedItems[1]
        text = selectedItem.text or ""
        text = text:sub(1, self.get("width") - 2)
    end

    self:blit(1, 1, text .. string.rep(" ", self.get("width") - #text - 1) .. (self.get("isOpen") and "\31" or "\17"),
        string.rep(tHex[self.get("foreground")], self.get("width")),
        string.rep(tHex[self.get("background")], self.get("width")))

    if self.get("isOpen") then
        local items = self.get("items")
        local height = self.get("height") - 1
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

                    self:textBg(1, i + 1, string.rep(" ", width), bg)
                    self:textFg(1, i + 1, separatorText, fg)
                else
                    local text = item.text
                    local isSelected = item.selected
                    text = text:sub(1, width)

                    local bg = isSelected and 
                        (item.selectedBackground or self.get("selectedBackground")) or
                        (item.background or self.get("background"))

                    local fg = isSelected and 
                        (item.selectedForeground or self.get("selectedForeground")) or
                        (item.foreground or self.get("foreground"))

                    self:textBg(1, i + 1, string.rep(" ", width), bg)
                    self:textFg(1, i + 1, text, fg)
                end
            end
        end
    end
end

return DropDown
