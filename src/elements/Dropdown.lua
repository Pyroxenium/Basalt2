local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@configDescription A dropdown menu that shows a list of selectable items
---@configDefault false

--- This is the dropdown class. It is a visual element that can show a list of selectable items in a dropdown menu.
--- @usage local dropdown = main:addDropdown()
--- @usage dropdown:setItems({
--- @usage     {text = "Item 1", callback = function() basalt.LOGGER.debug("Item 1 selected") end},
--- @usage     {text = "Item 2", callback = function() basalt.LOGGER.debug("Item 2 selected") end},
--- @usage     {text = "Item 3", callback = function() basalt.LOGGER.debug("Item 3 selected") end},
--- @usage })
---@class Dropdown : List
local Dropdown = setmetatable({}, List)
Dropdown.__index = Dropdown

---@property isOpen boolean false Whether the dropdown menu is currently open
Dropdown.defineProperty(Dropdown, "isOpen", {default = false, type = "boolean", canTriggerRender = true})
---@property dropdownHeight number 5 Maximum height of the dropdown menu when open
Dropdown.defineProperty(Dropdown, "dropdownHeight", {default = 5, type = "number"})
---@property selectedText string "" The text to show when no item is selected
Dropdown.defineProperty(Dropdown, "selectedText", {default = "", type = "string"})
---@property dropSymbol string "\31" The symbol to show for dropdown indication
Dropdown.defineProperty(Dropdown, "dropSymbol", {default = "\31", type = "string"})

--- Creates a new Dropdown instance
--- @shortDescription Creates a new Dropdown instance
--- @return Dropdown self The newly created Dropdown instance
--- @private
function Dropdown.new()
    local self = setmetatable({}, Dropdown):__init()
    self.class = Dropdown
    self.set("width", 16)
    self.set("height", 1)
    self.set("z", 8)
    return self
end

--- @shortDescription Initializes the Dropdown instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Dropdown self The initialized instance
--- @protected
function Dropdown:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Dropdown")
    return self
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Dropdown:mouse_click(button, x, y)
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

--- @shortDescription Renders the Dropdown
--- @protected
function Dropdown:render()
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

return Dropdown
