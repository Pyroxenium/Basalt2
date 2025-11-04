local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")
---@configDescription A DropDown menu that shows a list of selectable items
---@configDefault false

---@tableType ItemTable
---@tableField text string The display text for the item
---@tableField callback function Function called when selected
---@tableField fg color Normal text color
---@tableField bg color Normal background color
---@tableField selectedFg color Text color when selected
---@tableField selectedBg color Background when selected

--- A collapsible selection menu that expands to show multiple options when clicked. Supports single and multi-selection modes, custom item styling, separators, and item callbacks.
--- @run [[
--- local basalt = require("basalt")
--- local main = basalt.getMainFrame()
--- 
--- -- Create a styled dropdown menu
--- local dropdown = main:addDropDown()
---     :setPosition(5, 5)
---     :setSize(20, 1)  -- Height expands when opened
---     :setSelectedText("Select an option...")
--- 
--- -- Add items with different styles and callbacks
--- dropdown:setItems({
---     {
---         text = "Category A",
---         background = colors.blue,
---         foreground = colors.white
---     },
---     { separator = true, text = "-" },  -- Add a separator
---     {
---         text = "Option 1",
---         callback = function(self)
---             -- Handle selection
---             basalt.LOGGER.debug("Selected Option 1")
---         end
---     },
---     {
---         text = "Option 2",
---         -- Custom colors when selected
---         selectedBackground = colors.green,
---         selectedForeground = colors.white
---     }
--- })
---
--- -- Listen for selections
--- dropdown:onChange(function(self, value)
---     basalt.LOGGER.debug("Selected:", value)
--- end)
--- 
--- basalt.run()
--- ]]
---@class DropDown : List
local DropDown = setmetatable({}, List)
DropDown.__index = DropDown

---@property dropdownHeight number 5 Maximum visible items when expanded
DropDown.defineProperty(DropDown, "dropdownHeight", {default = 5, type = "number"})
---@property selectedText string "" Text shown when no selection made
DropDown.defineProperty(DropDown, "selectedText", {default = "", type = "string"})
---@property dropSymbol string "\31" Indicator for dropdown state
DropDown.defineProperty(DropDown, "dropSymbol", {default = "\31", type = "string"})
---@property undropSymbol string "\31" Indicator for dropdown state
DropDown.defineProperty(DropDown, "undropSymbol", {default = "\17", type = "string"})

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
    self:registerState("opened", nil, 200)
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
    local isOpen = self:hasState("opened")
    if relY == 1 then
        if isOpen then
            self.set("height", 1)
            self:unsetState("opened")
        else
            self.set("height", 1 + math.min(self.get("dropdownHeight"), #self.get("items")))
            self:setState("opened")
        end
        return true
    elseif isOpen and relY > 1 then
        return List.mouse_click(self, button, x, y - 1)
    end
    return false
end

--- @shortDescription Handles mouse drag events for scrollbar
--- @param button number The mouse button being dragged
--- @param x number The x-coordinate of the drag
--- @param y number The y-coordinate of the drag
--- @return boolean Whether the event was handled
--- @protected
function DropDown:mouse_drag(button, x, y)
    if self:hasState("opened") then
        return List.mouse_drag(self, button, x, y - 1)
    end
    return VisualElement.mouse_drag and VisualElement.mouse_drag(self, button, x, y) or false
end

--- @shortDescription Handles mouse up events to stop scrollbar dragging
--- @param button number The mouse button that was released
--- @param x number The x-coordinate of the release
--- @param y number The y-coordinate of the release
--- @return boolean Whether the event was handled
--- @protected
function DropDown:mouse_up(button, x, y)
    if self:hasState("opened") then
        local relX, relY = self:getRelativePosition(x, y)

        if relY > 1 and self.get("selectable") and not self._scrollBarDragging then
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
                self:unsetState("opened")
                self:unsetState("clicked")
                self.set("height", 1)
                self:updateRender()

                return true
            end
        end

        List.mouse_up(self, button, x, y - 1)
        self:unsetState("clicked")
        return true
    end
    return VisualElement.mouse_up and VisualElement.mouse_up(self, button, x, y) or false
end

--- @shortDescription Renders the DropDown
--- @protected
function DropDown:render()
    VisualElement.render(self)

    local text = self.get("selectedText")
    local isOpen = self:hasState("opened")
    local selectedItems = self:getSelectedItems()
    if #selectedItems > 0 then
        local selectedItem = selectedItems[1]
        text = selectedItem.text or ""
        text = text:sub(1, self.get("width") - 2)
    end

    if isOpen then
        local actualHeight = self.get("height")
        local dropdownHeight = math.min(self.get("dropdownHeight"), #self.get("items"))
        self.set("height", dropdownHeight)
        List.render(self, 1)
        self.set("height", actualHeight)
    end

    self:blit(1, 1, text .. string.rep(" ", self.get("width") - #text - 1) .. (isOpen and self.dropSymbol or self.undropSymbol),
        string.rep(tHex[self.getResolved("foreground")], self.get("width")),
        string.rep(tHex[self.getResolved("background")], self.get("width")))
end

--- Called when the DropDown gains focus
--- @shortDescription Called when gaining focus
--- @protected
function DropDown:focus()
    VisualElement.focus(self)
    self:prioritize()
    self:setState("opened")
end

--- Called when the DropDown loses focus
--- @shortDescription Called when losing focus
--- @protected
function DropDown:blur()
    VisualElement.blur(self)
    self:unsetState("opened")
    self.set("height", 1)
    self:updateRender()
end

return DropDown