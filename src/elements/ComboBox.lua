local VisualElement = require("elements/VisualElement")
local DropDown = require("elements/DropDown")
local tHex = require("libraries/colorHex")

---@configDescription A ComboBox that combines dropdown selection with editable text input
---@configDefault false

--- A hybrid input element that combines a text input field with a dropdown list. Users can either type directly or select from predefined options. 
--- Supports auto-completion, custom styling, and both single and multi-selection modes.
--- @usage [[
--- -- Create a searchable country selector
--- local combo = main:addComboBox()
---     :setPosition(5, 5)
---     :setSize(20, 1)  -- Height will expand when opened
---     :setItems({
---         {text = "Germany"},
---         {text = "France"},
---         {text = "Spain"},
---         {text = "Italy"}
---     })
---     :setPlaceholder("Select country...")
---     :setAutoComplete(true)  -- Enable filtering while typing
--- 
--- -- Handle selection changes
--- combo:onChange(function(self, value)
---     -- value will be the selected country
---     basalt.debug("Selected:", value)
--- end)
--- ]]
---@class ComboBox : DropDown
local ComboBox = setmetatable({}, DropDown)
ComboBox.__index = ComboBox

---@property editable boolean true Enables direct text input in the field
ComboBox.defineProperty(ComboBox, "editable", {default = true, type = "boolean", canTriggerRender = true})
---@property text string "" The current text value of the input field
ComboBox.defineProperty(ComboBox, "text", {default = "", type = "string", canTriggerRender = true, seetter = function(self, value)
    self.set("cursorPos", #self.get("text") + 1)
    self:updateViewport()
end})
---@property cursorPos number 1 Current cursor position in the text input
ComboBox.defineProperty(ComboBox, "cursorPos", {default = 1, type = "number"})
---@property viewOffset number 0 Horizontal scroll position for viewing long text
ComboBox.defineProperty(ComboBox, "viewOffset", {default = 0, type = "number", canTriggerRender = true})
---@property placeholder string "..." Text shown when the input is empty
ComboBox.defineProperty(ComboBox, "placeholder", {default = "...", type = "string"})
---@property placeholderColor color gray Color used for placeholder text
ComboBox.defineProperty(ComboBox, "placeholderColor", {default = colors.gray, type = "color"})
---@property autoComplete boolean false Enables filtering dropdown items while typing
ComboBox.defineProperty(ComboBox, "autoComplete", {default = false, type = "boolean"})
---@property manuallyOpened boolean false Indicates if dropdown was opened by user action
ComboBox.defineProperty(ComboBox, "manuallyOpened", {default = false, type = "boolean"})

--- Creates a new ComboBox instance
--- @shortDescription Creates a new ComboBox instance
--- @return ComboBox self The newly created ComboBox instance
function ComboBox.new()
    local self = setmetatable({}, ComboBox):__init()
    self.class = ComboBox
    self.set("width", 16)
    self.set("height", 1)
    self.set("z", 8)
    return self
end

--- @shortDescription Initializes the ComboBox instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return ComboBox self The initialized instance
--- @protected
function ComboBox:init(props, basalt)
    DropDown.init(self, props, basalt)
    self.set("type", "ComboBox")

    self.set("cursorPos", 1)
    self.set("viewOffset", 0)
    return self
end

--- Filters items based on current text for auto-complete
--- @shortDescription Filters items for auto-complete
--- @private
function ComboBox:getFilteredItems()
    local allItems = self.get("items") or {}
    local currentText = self.get("text"):lower()

    if not self.get("autoComplete") or #currentText == 0 then
        return allItems
    end

    local filteredItems = {}
    for _, item in ipairs(allItems) do
        local itemText = ""
        if type(item) == "string" then
            itemText = item:lower()
        elseif type(item) == "table" and item.text then
            itemText = item.text:lower()
        end

        if itemText:find(currentText, 1, true) then
            table.insert(filteredItems, item)
        end
    end

    return filteredItems
end

--- Updates the dropdown with filtered items
--- @shortDescription Updates dropdown with filtered items
--- @private
function ComboBox:updateFilteredDropdown()
    if not self.get("autoComplete") then return end

    local filteredItems = self:getFilteredItems()
    local shouldOpen = #filteredItems > 0 and #self.get("text") > 0

    if shouldOpen then
        self:setState("opened")
        self.set("manuallyOpened", false)
        local dropdownHeight = self.get("dropdownHeight") or 5
        local actualHeight = math.min(dropdownHeight, #filteredItems)
        self.set("height", 1 + actualHeight)
    else
        self:unsetState("opened")
        self.set("manuallyOpened", false)
        self.set("height", 1)
    end
    self:updateRender()
end

--- @shortDescription Updates the viewport
--- @private
function ComboBox:updateViewport()
    local text = self.get("text")
    local cursorPos = self.get("cursorPos")
    local width = self.get("width")
    local dropSymbol = self.get("dropSymbol")

    local textWidth = width - #dropSymbol
    if textWidth < 1 then textWidth = 1 end

    local viewOffset = self.get("viewOffset")

    if cursorPos - viewOffset > textWidth then
        viewOffset = cursorPos - textWidth
    elseif cursorPos - 1 < viewOffset then
        viewOffset = math.max(0, cursorPos - 1)
    end

    self.set("viewOffset", viewOffset)
end

--- Handles character input when editable
--- @shortDescription Handles character input
--- @param char string The character that was typed
function ComboBox:char(char)
    if not self.get("editable") then return end
    if not self:hasState("focused") then return end

    local text = self.get("text")
    local cursorPos = self.get("cursorPos")

    local newText = text:sub(1, cursorPos - 1) .. char .. text:sub(cursorPos)
    self.set("text", newText)
    self.set("cursorPos", cursorPos + 1)
    self:updateViewport()

    if self.get("autoComplete") then
        self:updateFilteredDropdown()
    else
        self:updateRender()
    end
end

--- Handles key input when editable
--- @shortDescription Handles key input
--- @param key number The key code that was pressed
--- @param held boolean Whether the key is being held
function ComboBox:key(key, held)
    if not self.get("editable") then return end
    if not self:hasState("focused") then return end

    local text = self.get("text")
    local cursorPos = self.get("cursorPos")

    if key == keys.left then
        self.set("cursorPos", math.max(1, cursorPos - 1))
        self:updateViewport()
    elseif key == keys.right then
        self.set("cursorPos", math.min(#text + 1, cursorPos + 1))
        self:updateViewport()
    elseif key == keys.backspace then
        if cursorPos > 1 then
            local newText = text:sub(1, cursorPos - 2) .. text:sub(cursorPos)
            self.set("text", newText)
            self.set("cursorPos", cursorPos - 1)
            self:updateViewport()

            if self.get("autoComplete") then
                self:updateFilteredDropdown()
            else
                self:updateRender()
            end
        end
    elseif key == keys.delete then
        if cursorPos <= #text then
            local newText = text:sub(1, cursorPos - 1) .. text:sub(cursorPos + 1)
            self.set("text", newText)
            self:updateViewport()

            if self.get("autoComplete") then
                self:updateFilteredDropdown()
            else
                self:updateRender()
            end
        end
    elseif key == keys.home then
        self.set("cursorPos", 1)
        self:updateViewport()
    elseif key == keys["end"] then
        self.set("cursorPos", #text + 1)
        self:updateViewport()
    elseif key == keys.enter then
        if self:hasState("opened") then
            self:unsetState("opened")
        else
            self:setState("opened")
        end
        self:updateRender()
    end
end

--- Handles mouse clicks
--- @shortDescription Handles mouse clicks
--- @param button number The mouse button (1 = left, 2 = right, 3 = middle)
--- @param x number The x coordinate of the click
--- @param y number The y coordinate of the click
--- @return boolean handled Whether the event was handled
--- @protected
function ComboBox:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)
    local width = self.get("width")
    local dropSymbol = self.get("dropSymbol")
    local isOpen = self:hasState("opened")

    if relY == 1 then
        if relX >= width - #dropSymbol + 1 and relX <= width then

            if isOpen then
                self:unsetState("opened")
            else
                self:setState("opened")
            end

            if not isOpen then
                local allItems = self.get("items") or {}
                local dropdownHeight = self.get("dropdownHeight") or 5
                local actualHeight = math.min(dropdownHeight, #allItems)
                self.set("height", 1 + actualHeight)
                self.set("manuallyOpened", true)
            else
                self.set("height", 1)
                self.set("manuallyOpened", false)
            end
            self:updateRender()
            return true
        end

        if relX <= width - #dropSymbol and self.get("editable") then
            local text = self.get("text")
            local viewOffset = self.get("viewOffset")
            local maxPos = #text + 1
            local targetPos = math.min(maxPos, viewOffset + relX)

            self.set("cursorPos", targetPos)
            self:updateRender()
            return true
        end

        return true
    elseif isOpen and relY > 1 and self.get("selectable") then
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

            item.selected = true

            if item.text then
                self:setText(item.text)
            end
            self:unsetState("opened")
            self.set("height", 1)
            self:updateRender()

            return true
        end
    end

    return false
end

--- Renders the ComboBox
--- @shortDescription Renders the ComboBox
--- @protected
function ComboBox:render()
    VisualElement.render(self)

    local text = self.getResolved("text")
    local width = self.get("width")
    local dropSymbol = self.getResolved("dropSymbol")
    local isFocused = self:hasState("focused")
    local isOpen = self:hasState("opened")
    local viewOffset = self.get("viewOffset")
    local placeholder = self.getResolved("placeholder")
    local bg = self.getResolved("background")
    local fg = self.getResolved("foreground")

    local displayText = text
    local textWidth = width - #dropSymbol

    if #text == 0 and not isFocused and #placeholder > 0 then
        displayText = placeholder
        fg = self.get("placeholderColor")
    end

    if #displayText > 0 then
        displayText = displayText:sub(viewOffset + 1, viewOffset + textWidth)
    end

    displayText = displayText .. string.rep(" ", textWidth - #displayText)

    local fullText = displayText .. (isOpen and "\31" or "\17")

    self:blit(1, 1, fullText,
        string.rep(tHex[fg], width),
        string.rep(tHex[bg], width))

    if isFocused and self.get("editable") then
        local cursorPos = self.get("cursorPos")
        local cursorX = cursorPos - viewOffset
        if cursorX >= 1 and cursorX <= textWidth then
            self:setCursor(cursorX, 1, true, fg)
        end
    end

    if isOpen then
        local items
        if self.get("autoComplete") and not self.get("manuallyOpened") then
            items = self:getFilteredItems()
        else
            items = self.get("items")
        end

        local dropdownHeight = math.min(self.get("dropdownHeight"), #items)
        if dropdownHeight > 0 then
            local offset = self.get("offset")

            for i = 1, dropdownHeight do
                local itemIndex = i + offset
                if items[itemIndex] then
                    local item = items[itemIndex]
                    local itemText = item.text or ""
                    local isSelected = item.selected or false

                    local itemBg = isSelected and self.get("selectedBackground") or bg
                    local itemFg = isSelected and self.get("selectedForeground") or fg

                    if #itemText > width then
                        itemText = itemText:sub(1, width)
                    end

                    itemText = itemText .. string.rep(" ", width - #itemText)
                    self:blit(1, i + 1, itemText,
                        string.rep(tHex[itemFg], width),
                        string.rep(tHex[itemBg], width))
                end
            end
        end
    end
end

return ComboBox