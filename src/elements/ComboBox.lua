local VisualElement = require("elements/VisualElement")
local Dropdown = require("src.elements.DropDown")
local tHex = require("libraries/colorHex")

---@configDescription A ComboBox that combines dropdown selection with editable text input
---@configDefault false

--- This is the ComboBox class. It extends the dropdown functionality with editable text input,
--- allowing users to either select from a list or type their own custom text.
--- @usage local ComboBox = main:addCombobox()
--- @usage ComboBox:setEditable(true)
--- @usage ComboBox:setItems({
--- @usage     {text = "Option 1"},
--- @usage     {text = "Option 2"},
--- @usage     {text = "Option 3"},
--- @usage })
--- @usage ComboBox:setText("Custom input...")
---@class ComboBox : Dropdown
local ComboBox = setmetatable({}, Dropdown)
ComboBox.__index = ComboBox

---@property editable boolean true Whether the ComboBox allows text input
ComboBox.defineProperty(ComboBox, "editable", {default = true, type = "boolean", canTriggerRender = true})
---@property text string "" The current text content of the ComboBox
ComboBox.defineProperty(ComboBox, "text", {default = "", type = "string", canTriggerRender = true})
---@property cursorPos number 1 The current cursor position in the text
ComboBox.defineProperty(ComboBox, "cursorPos", {default = 1, type = "number"})
---@property viewOffset number 0 The horizontal scroll offset for viewing long text
ComboBox.defineProperty(ComboBox, "viewOffset", {default = 0, type = "number", canTriggerRender = true})
---@property placeholder string "..." Text to display when input is empty
ComboBox.defineProperty(ComboBox, "placeholder", {default = "...", type = "string"})
---@property placeholderColor color gray Color of the placeholder text
ComboBox.defineProperty(ComboBox, "placeholderColor", {default = colors.gray, type = "color"})
---@property focusedBackground color blue Background color when ComboBox is focused
ComboBox.defineProperty(ComboBox, "focusedBackground", {default = colors.blue, type = "color"})
---@property focusedForeground color white Foreground color when ComboBox is focused  
ComboBox.defineProperty(ComboBox, "focusedForeground", {default = colors.white, type = "color"})
---@property autoComplete boolean false Whether to enable auto-complete filtering when typing
ComboBox.defineProperty(ComboBox, "autoComplete", {default = false, type = "boolean"})
---@property manuallyOpened boolean false Whether the dropdown was manually opened (not by auto-complete)
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
    Dropdown.init(self, props, basalt)
    self.set("type", "ComboBox")

    self.set("cursorPos", 1)
    self.set("viewOffset", 0)

    return self
end

--- Sets the text content of the ComboBox
--- @shortDescription Sets the text content
--- @param text string The text to set
--- @return ComboBox self
function ComboBox:setText(text)
    if text == nil then text = "" end
    self.set("text", tostring(text))
    self.set("cursorPos", #self.get("text") + 1)
    self:updateViewport()
    return self
end

--- Gets the current text content
--- @shortDescription Gets the text content
--- @return string text The current text
function ComboBox:getText()
    return self.get("text")
end

--- Sets whether the ComboBox is editable
--- @shortDescription Sets editable state
--- @param editable boolean Whether the ComboBox should be editable
--- @return ComboBox self
function ComboBox:setEditable(editable)
    self.set("editable", editable)
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
        self.set("isOpen", true)
        self.set("manuallyOpened", false)
        local dropdownHeight = self.get("dropdownHeight") or 5
        local actualHeight = math.min(dropdownHeight, #filteredItems)
        self.set("height", 1 + actualHeight)
    else
        self.set("isOpen", false)
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
    if not self.get("focused") then return end

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
    if not self.get("focused") then return end

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
        self.set("isOpen", not self.get("isOpen"))
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

    if relY == 1 then
        if relX >= width - #dropSymbol + 1 and relX <= width then

            local isCurrentlyOpen = self.get("isOpen")
            self.set("isOpen", not isCurrentlyOpen)

            if self.get("isOpen") then
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

            item.selected = true

            if item.text then
                self:setText(item.text)
            end
            self.set("isOpen", false)
            self.set("height", 1)
            self:updateRender()

            return true
        end
    end

    return false
end

--- Renders the ComboBox
--- @shortDescription Renders the ComboBox
function ComboBox:render()
    VisualElement.render(self)
    
    local text = self.get("text")
    local width = self.get("width")
    local dropSymbol = self.get("dropSymbol")
    local isFocused = self.get("focused")
    local isOpen = self.get("isOpen")
    local viewOffset = self.get("viewOffset")
    local placeholder = self.get("placeholder")

    local bg = isFocused and self.get("focusedBackground") or self.get("background")
    local fg = isFocused and self.get("focusedForeground") or self.get("foreground")

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
            self:setCursor(cursorX, 1, true, self.get("foreground"))
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

                    local itemBg = isSelected and self.get("selectedBackground") or self.get("background")
                    local itemFg = isSelected and self.get("selectedForeground") or self.get("foreground")

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

--- Called when the ComboBox gains focus
--- @shortDescription Called when gaining focus
function ComboBox:focus()
    Dropdown.focus(self)
    -- Additional focus logic for input if needed
end

--- Called when the ComboBox loses focus
--- @shortDescription Called when losing focus
function ComboBox:blur()
    Dropdown.blur(self)
    self.set("isOpen", false)
    self.set("height", 1)
    self:updateRender()
end

return ComboBox
