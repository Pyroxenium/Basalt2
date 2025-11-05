---@diagnostic disable: duplicate-set-field
local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription A multi-line text editor component with cursor support and text manipulation features
---@configDefault false

---A multi-line text editor component with cursor support and text manipulation features
---@class TextBox : VisualElement
local TextBox = setmetatable({}, VisualElement)
TextBox.__index = TextBox

---@property lines table {} Array of text lines
TextBox.defineProperty(TextBox, "lines", {default = {""}, type = "table", canTriggerRender = true})
---@property cursorX number 1 Cursor X position
TextBox.defineProperty(TextBox, "cursorX", {default = 1, type = "number"})
---@property cursorY number 1 Cursor Y position (line number)
TextBox.defineProperty(TextBox, "cursorY", {default = 1, type = "number"})
---@property scrollX number 0 Horizontal scroll offset
TextBox.defineProperty(TextBox, "scrollX", {default = 0, type = "number", canTriggerRender = true})
---@property scrollY number 0 Vertical scroll offset
TextBox.defineProperty(TextBox, "scrollY", {default = 0, type = "number", canTriggerRender = true})
---@property editable boolean true Whether text can be edited
TextBox.defineProperty(TextBox, "editable", {default = true, type = "boolean"})
---@property syntaxPatterns table {} Syntax highlighting patterns
TextBox.defineProperty(TextBox, "syntaxPatterns", {default = {}, type = "table"})
---@property cursorColor number nil Color of the cursor
TextBox.defineProperty(TextBox, "cursorColor", {default = nil, type = "color"})
---@property autoPairEnabled boolean true Whether automatic bracket/quote pairing is enabled
TextBox.defineProperty(TextBox, "autoPairEnabled", {default = true, type = "boolean"})
---@property autoPairCharacters table { ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
TextBox.defineProperty(TextBox, "autoPairCharacters", {default = { ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`' }, type = "table"})
---@property autoPairSkipClosing boolean true Skip inserting a closing char if the same one is already at cursor
TextBox.defineProperty(TextBox, "autoPairSkipClosing", {default = true, type = "boolean"})
---@property autoPairOverType boolean true When pressing a closing char that matches the next char, move over it instead of inserting
TextBox.defineProperty(TextBox, "autoPairOverType", {default = true, type = "boolean"})
---@property autoPairNewlineIndent boolean true On Enter between matching braces, create blank line and keep closing aligned
TextBox.defineProperty(TextBox, "autoPairNewlineIndent", {default = true, type = "boolean"})
---@property autoCompleteEnabled boolean false Whether autocomplete suggestions are enabled
TextBox.defineProperty(TextBox, "autoCompleteEnabled", {default = false, type = "boolean"})
---@property autoCompleteItems table {} List of suggestions used when no provider is supplied
TextBox.defineProperty(TextBox, "autoCompleteItems", {default = {}, type = "table"})
---@property autoCompleteProvider function nil Optional suggestion provider returning a list for the current prefix
TextBox.defineProperty(TextBox, "autoCompleteProvider", {default = nil, type = "function", allowNil = true})
---@property autoCompleteMinChars number 1 Minimum characters required before showing suggestions
TextBox.defineProperty(TextBox, "autoCompleteMinChars", {default = 1, type = "number"})
---@property autoCompleteMaxItems number 6 Maximum number of visible suggestions
TextBox.defineProperty(TextBox, "autoCompleteMaxItems", {default = 6, type = "number"})
---@property autoCompleteCaseInsensitive boolean true Whether suggestions should match case-insensitively
TextBox.defineProperty(TextBox, "autoCompleteCaseInsensitive", {default = true, type = "boolean"})
---@property autoCompleteTokenPattern string "[%w_]+" Pattern used to extract the current token for suggestions
TextBox.defineProperty(TextBox, "autoCompleteTokenPattern", {default = "[%w_]+", type = "string"})
---@property autoCompleteOffsetX number 0 Horizontal offset applied to the popup frame relative to the TextBox
TextBox.defineProperty(TextBox, "autoCompleteOffsetX", {default = 0, type = "number"})
---@property autoCompleteOffsetY number 1 Vertical offset applied to the popup frame relative to the TextBox bottom edge
TextBox.defineProperty(TextBox, "autoCompleteOffsetY", {default = 1, type = "number"})
---@property autoCompleteZOffset number 1 Z-index offset applied to the popup frame
TextBox.defineProperty(TextBox, "autoCompleteZOffset", {default = 1, type = "number"})
---@property autoCompleteMaxWidth number 0 Maximum width of the autocomplete popup (0 uses the textbox width)
TextBox.defineProperty(TextBox, "autoCompleteMaxWidth", {default = 0, type = "number"})
---@property autoCompleteShowBorder boolean true Whether to render a character border around the popup
TextBox.defineProperty(TextBox, "autoCompleteShowBorder", {default = true, type = "boolean"})
---@property autoCompleteBorderColor color black Color of the popup border when enabled
TextBox.defineProperty(TextBox, "autoCompleteBorderColor", {default = colors.black, type = "color"})
---@property autoCompleteBackground color lightGray Background color of the suggestion popup
TextBox.defineProperty(TextBox, "autoCompleteBackground", {default = colors.lightGray, type = "color"})
---@property autoCompleteForeground color black Foreground color of the suggestion popup
TextBox.defineProperty(TextBox, "autoCompleteForeground", {default = colors.black, type = "color"})
---@property autoCompleteSelectedBackground color gray Background color for the selected suggestion
TextBox.defineProperty(TextBox, "autoCompleteSelectedBackground", {default = colors.gray, type = "color"})
---@property autoCompleteSelectedForeground color white Foreground color for the selected suggestion
TextBox.defineProperty(TextBox, "autoCompleteSelectedForeground", {default = colors.white, type = "color"})
---@property autoCompleteAcceptOnEnter boolean true Whether pressing Enter accepts the current suggestion
TextBox.defineProperty(TextBox, "autoCompleteAcceptOnEnter", {default = true, type = "boolean"})
---@property autoCompleteAcceptOnClick boolean true Whether clicking a suggestion accepts it immediately
TextBox.defineProperty(TextBox, "autoCompleteAcceptOnClick", {default = true, type = "boolean"})
---@property autoCompleteCloseOnEscape boolean true Whether pressing Escape closes the popup
TextBox.defineProperty(TextBox, "autoCompleteCloseOnEscape", {default = true, type = "boolean"})

TextBox.defineEvent(TextBox, "mouse_click")
TextBox.defineEvent(TextBox, "key")
TextBox.defineEvent(TextBox, "char")
TextBox.defineEvent(TextBox, "mouse_scroll")
TextBox.defineEvent(TextBox, "paste")
TextBox.defineEvent(TextBox, "auto_complete_open")
TextBox.defineEvent(TextBox, "auto_complete_close")
TextBox.defineEvent(TextBox, "auto_complete_accept")

local updateAutoCompleteBorder
local layoutAutoCompleteList

local function autoCompleteVisible(self)
    local frame = self._autoCompleteFrame
    return frame and not frame._destroyed and frame.get and frame.get("visible")
end

local function getBorderPadding(self)
    return self.getResolved("autoCompleteShowBorder") and 1 or 0
end

local function updateAutoCompleteStyles(self)
    local frame = self._autoCompleteFrame
    local list = self._autoCompleteList
    if not frame or frame._destroyed then return end
    frame:setBackground(self.getResolved("autoCompleteBackground"))
    frame:setForeground(self.getResolved("autoCompleteForeground"))
    if list and not list._destroyed then
        list:setBackground(self.getResolved("autoCompleteBackground"))
        list:setForeground(self.getResolved("autoCompleteForeground"))
        list:setSelectedBackground(self.getResolved("autoCompleteSelectedBackground"))
        list:setSelectedForeground(self.getResolved("autoCompleteSelectedForeground"))
        list:updateRender()
    end
    layoutAutoCompleteList(self)
    updateAutoCompleteBorder(self)
    frame:updateRender()
end

local function setAutoCompleteSelection(self, index, clampOnly)
    local list = self._autoCompleteList
    if not list or list._destroyed then return end
    local items = list.get("items")
    local count = #items
    if count == 0 then return end
    if index < 1 then index = 1 end
    if index > count then index = count end
    self._autoCompleteIndex = index

    for i, item in ipairs(items) do
        if type(item) == "table" then
            item.selected = (i == index)
        end
    end

    local height = list.get("height") or 0
    local offset = list.get("offset") or 0
    if not clampOnly and height > 0 then
        if index > offset + height then
            list:setOffset(math.max(0, index - height))
        elseif index <= offset then
            list:setOffset(math.max(0, index - 1))
        end
    end
    list:updateRender()
end

local function hideAutoComplete(self, silent)
    if autoCompleteVisible(self) then
        self._autoCompleteFrame:setVisible(false)
        if not silent then
            self:fireEvent("auto_complete_close")
        end
    end
    self._autoCompleteIndex = nil
    self._autoCompleteSuggestions = nil
    self._autoCompleteToken = nil
    self._autoCompleteTokenStart = nil
    self._autoCompletePopupWidth = nil
end

local function applyAutoCompleteSelection(self, item)
    local suggestions = self._autoCompleteSuggestions or {}
    local index = self._autoCompleteIndex or 1
    local entry = item or suggestions[index]
    if not entry then return end
    local insertText = entry.insert or entry.text or ""
    if insertText == "" then return end

    local lines = self.getResolved("lines")
    local cursorY = self.getResolved("cursorY")
    local cursorX = self.getResolved("cursorX")
    local line = lines[cursorY] or ""
    local startIndex = self._autoCompleteTokenStart or cursorX
    if startIndex < 1 then startIndex = 1 end

    local before = line:sub(1, startIndex - 1)
    local after = line:sub(cursorX)
    lines[cursorY] = before .. insertText .. after

    self.set("cursorX", startIndex + #insertText)
    self:updateViewport()
    self:updateRender()
    hideAutoComplete(self, true)
    self:fireEvent("auto_complete_accept", insertText, entry.source or entry)
end

local function ensureAutoCompleteUI(self)
    if not self.getResolved("autoCompleteEnabled") then return nil end
    local frame = self._autoCompleteFrame
    if frame and not frame._destroyed then
        return self._autoCompleteList
    end

    local base = self:getBaseFrame()
    if not base or not base.addFrame then return nil end

    frame = base:addFrame({
        width = self.getResolved("width"),
        height = 1,
        x = 1,
        y = 1,
        visible = false,
        background = self.getResolved("autoCompleteBackground"),
        foreground = self.getResolved("autoCompleteForeground"),
        ignoreOffset = true,
        z = self.getResolved("z") + self.getResolved("autoCompleteZOffset"),
    })
    frame:setIgnoreOffset(true)
    frame:setVisible(false)

    local padding = getBorderPadding(self)
    local list = frame:addList({
        x = padding + 1,
        y = padding + 1,
        width = math.max(1, frame.get("width") - padding * 2),
        height = math.max(1, frame.get("height") - padding * 2),
        selectable = true,
        multiSelection = false,
        background = self.getResolved("autoCompleteBackground"),
        foreground = self.getResolved("autoCompleteForeground"),
    })
    list:setSelectedBackground(self.getResolved("autoCompleteSelectedBackground"))
    list:setSelectedForeground(self.getResolved("autoCompleteSelectedForeground"))
    list:setOffset(0)
    list:onSelect(function(_, index, selectedItem)
        if not autoCompleteVisible(self) then return end
        setAutoCompleteSelection(self, index)
        if self.getResolved("autoCompleteAcceptOnClick") then
            applyAutoCompleteSelection(self, selectedItem)
        end
    end)

    self._autoCompleteFrame = frame
    self._autoCompleteList = list
    updateAutoCompleteStyles(self)
    return list
end

layoutAutoCompleteList = function(self, contentWidth, visibleCount)
    local frame = self._autoCompleteFrame
    local list = self._autoCompleteList
    if not frame or frame._destroyed or not list or list._destroyed then return end

    local border = getBorderPadding(self)
    local width = tonumber(contentWidth) or rawget(self, "_autoCompletePopupWidth") or list.get("width") or frame.get("width")
    local height = tonumber(visibleCount) or (list.get and list.get("height")) or (#(rawget(self, "_autoCompleteSuggestions") or {}))

    width = math.max(1, width or 1)
    height = math.max(1, height or 1)

    local frameWidth = frame.get and frame.get("width") or width
    local frameHeight = frame.get and frame.get("height") or height
    local maxWidth = math.max(1, frameWidth - border * 2)
    local maxHeight = math.max(1, frameHeight - border * 2)
    if width > maxWidth then width = maxWidth end
    if height > maxHeight then height = maxHeight end

    list:setPosition(border + 1, border + 1)
    list:setWidth(math.max(1, width))
    list:setHeight(math.max(1, height))
end

updateAutoCompleteBorder = function(self)
    local frame = self._autoCompleteFrame
    if not frame or frame._destroyed then return end

    local canvas = frame.get and frame.get("canvas")
    if not canvas then return end

    canvas:setType("post")
    if frame._autoCompleteBorderCommand then
        canvas:removeCommand(frame._autoCompleteBorderCommand)
        frame._autoCompleteBorderCommand = nil
    end

    if not self.getResolved("autoCompleteShowBorder") then
        frame:updateRender()
        return
    end

    local borderColor = self.getResolved("autoCompleteBorderColor") or colors.black

    local commandIndex = canvas:addCommand(function(element)
        local width = element.get("width") or 0
        local height = element.get("height") or 0
        if width < 1 or height < 1 then return end

        local bgColor = element.get("background") or colors.black
        local bgHex = tHex[bgColor] or tHex[colors.black]
        local borderHex = tHex[borderColor] or tHex[colors.black]

        element:textFg(1, 1, ("\131"):rep(width), borderColor)
        element:multiBlit(1, height, width, 1, "\143", bgHex, borderHex)
        element:multiBlit(1, 1, 1, height, "\149", borderHex, bgHex)
        element:multiBlit(width, 1, 1, height, "\149", bgHex, borderHex)
        element:blit(1, 1, "\151", borderHex, bgHex)
        element:blit(width, 1, "\148", bgHex, borderHex)
        element:blit(1, height, "\138", bgHex, borderHex)
        element:blit(width, height, "\133", bgHex, borderHex)
    end)

    frame._autoCompleteBorderCommand = commandIndex
    frame:updateRender()
end

local function getTokenInfo(self)
    local lines = self.getResolved("lines")
    local cursorY = self.getResolved("cursorY")
    local cursorX = self.getResolved("cursorX")
    local line = lines[cursorY] or ""
    local uptoCursor = line:sub(1, math.max(cursorX - 1, 0))
    local pattern = self.getResolved("autoCompleteTokenPattern") or "[%w_]+"

    local token = ""
    if pattern ~= "" then
        token = uptoCursor:match("(" .. pattern .. ")$") or ""
    end
    local startIndex = cursorX - #token
    if startIndex < 1 then startIndex = 1 end
    return token, startIndex
end

local function normalizeSuggestion(entry)
    if type(entry) == "string" then
        return {text = entry, insert = entry, source = entry}
    elseif type(entry) == "table" then
        local text = entry.text or entry.label or entry.value or entry.insert or entry[1]
        if not text then return nil end
        local item = {
            text = text,
            insert = entry.insert or entry.value or text,
            source = entry,
        }
        if entry.foreground then item.foreground = entry.foreground end
        if entry.background then item.background = entry.background end
        if entry.selectedForeground then item.selectedForeground = entry.selectedForeground end
        if entry.selectedBackground then item.selectedBackground = entry.selectedBackground end
        if entry.icon then item.icon = entry.icon end
        if entry.info then item.info = entry.info end
        return item
    end
end

local function iterateSuggestions(source, handler)
    if type(source) ~= "table" then return end
    local length = #source
    if length > 0 then
        for index = 1, length do
            handler(source[index])
        end
    else
        for _, value in pairs(source) do
            handler(value)
        end
    end
end

local function gatherSuggestions(self, token)
    local provider = self.getResolved("autoCompleteProvider")
    local source = {}
    if provider then
        local ok, result = pcall(provider, self, token)
        if ok and type(result) == "table" then
            source = result
        end
    else
        source = self.getResolved("autoCompleteItems") or {}
    end

    local suggestions = {}
    local caseInsensitive = self.getResolved("autoCompleteCaseInsensitive")
    local target = caseInsensitive and token:lower() or token
    iterateSuggestions(source, function(entry)
        local normalized = normalizeSuggestion(entry)
        if normalized and normalized.text then
            local compare = caseInsensitive and normalized.text:lower() or normalized.text
            if target == "" or compare:find(target, 1, true) == 1 then
                table.insert(suggestions, normalized)
            end
        end
    end)

    local maxItems = self.getResolved("autoCompleteMaxItems")
    if #suggestions > maxItems then
        while #suggestions > maxItems do
            table.remove(suggestions)
        end
    end
    return suggestions
end

local function measureSuggestionWidth(self, suggestions)
    local maxLen = 0
    for _, entry in ipairs(suggestions) do
        local text = entry
        if type(entry) == "table" then
            text = entry.text or entry.label or entry.value or entry.insert or entry[1]
        end
        if text ~= nil then
            local len = #tostring(text)
            if len > maxLen then
                maxLen = len
            end
        end
    end

    local limit = self.getResolved("autoCompleteMaxWidth")
    local maxWidth = self.getResolved("width")
    if limit and limit > 0 then
        maxWidth = math.min(maxWidth, limit)
    end

    local border = getBorderPadding(self)
    local base = self:getBaseFrame()
    if base and base.get then
        local baseWidth = base.get("width")
        if baseWidth and baseWidth > 0 then
            local available = baseWidth - border * 2
            if available < 1 then available = 1 end
            maxWidth = math.min(maxWidth, available)
        end
    end

    maxLen = math.min(maxLen, maxWidth)

    return math.max(1, maxLen)
end

local function placeAutoCompleteFrame(self, visibleCount, width)
    local frame = self._autoCompleteFrame
    local list = self._autoCompleteList
    if not frame or frame._destroyed then return end
    local border = getBorderPadding(self)
    local contentWidth = math.max(1, width or self.getResolved("width"))
    local contentHeight = math.max(1, visibleCount or 1)

    local base = self:getBaseFrame()
    if not base then return end
    local baseWidth = base.get and base.get("width")
    local baseHeight = base.get and base.get("height")

    if baseWidth and baseWidth > 0 then
        local maxContentWidth = baseWidth - border * 2
        if maxContentWidth < 1 then maxContentWidth = 1 end
        if contentWidth > maxContentWidth then
            contentWidth = maxContentWidth
        end
    end

    if baseHeight and baseHeight > 0 then
        local maxContentHeight = baseHeight - border * 2
        if maxContentHeight < 1 then maxContentHeight = 1 end
        if contentHeight > maxContentHeight then
            contentHeight = maxContentHeight
        end
    end

    local frameWidth = contentWidth + border * 2
    local frameHeight = contentHeight + border * 2
    local originX, originY = self:calculatePosition()
    local scrollX = self.getResolved("scrollX") or 0
    local scrollY = self.getResolved("scrollY") or 0
    local tokenStart = (self._autoCompleteTokenStart or self.getResolved("cursorX"))
    local column = tokenStart - scrollX
    column = math.max(1, math.min(self.getResolved("width"), column))

    local cursorRow = self.getResolved("cursorY") - scrollY
    cursorRow = math.max(1, math.min(self.getResolved("height"), cursorRow))

    local offsetX = self.getResolved("autoCompleteOffsetX")
    local offsetY = self.getResolved("autoCompleteOffsetY")

    local baseX = originX + column - 1 + offsetX
    local x = baseX - border
    if border > 0 then
        x = x + 1
    end
    local listTopBelow = originY + cursorRow + offsetY
    local listBottomAbove = originY + cursorRow - offsetY - 1
    local belowY = listTopBelow - border
    local aboveY = listBottomAbove - contentHeight + 1 - border
    local y = belowY

    if baseWidth and baseWidth > 0 then
        if frameWidth > baseWidth then
            frameWidth = baseWidth
            contentWidth = math.max(1, frameWidth - border * 2)
        end
        if x + frameWidth - 1 > baseWidth then
            x = math.max(1, baseWidth - frameWidth + 1)
        end
        if x < 1 then
            x = 1
        end
    else
        if x < 1 then x = 1 end
    end

    if baseHeight and baseHeight > 0 then
        if y + frameHeight - 1 > baseHeight then
            -- Place above
            y = aboveY
            if border > 0 then
                -- Shift further up so lower border does not overlap the text line
                y = y - border
            end
            if y < 1 then
                y = math.max(1, baseHeight - frameHeight + 1)
            end
        end
        if y < 1 then
            y = 1
        end
    else
        if y < 1 then y = 1 end
        if y == aboveY and border > 0 then
            y = math.max(1, y - border)
        end
    end

    frame:setPosition(x, y)
    frame:setWidth(frameWidth)
    frame:setHeight(frameHeight)
    frame:setZ(self.getResolved("z") + self.getResolved("autoCompleteZOffset"))

    layoutAutoCompleteList(self, contentWidth, contentHeight)

    if list and not list._destroyed then
        list:updateRender()
    end
    frame:updateRender()
end

local function refreshAutoComplete(self)
    if not self.getResolved("autoCompleteEnabled") then
        hideAutoComplete(self, true)
        return
    end
    if not self:hasState("focused") then
        hideAutoComplete(self, true)
        return
    end

    local token, startIndex = getTokenInfo(self)
    self._autoCompleteToken = token
    self._autoCompleteTokenStart = startIndex

    if #token < self.getResolved("autoCompleteMinChars") then
        hideAutoComplete(self)
        return
    end

    local suggestions = gatherSuggestions(self, token)
    if #suggestions == 0 then
        hideAutoComplete(self)
        return
    end

    local list = ensureAutoCompleteUI(self)
    if not list then return end

    list:setOffset(0)
    list:setItems(suggestions)
    self._autoCompleteSuggestions = suggestions
    setAutoCompleteSelection(self, 1, true)

    local popupWidth = measureSuggestionWidth(self, suggestions)
    self._autoCompletePopupWidth = popupWidth
    placeAutoCompleteFrame(self, #suggestions, popupWidth)
    updateAutoCompleteStyles(self)
    self._autoCompleteFrame:setVisible(true)
    self._autoCompleteList:updateRender()
    self._autoCompleteFrame:updateRender()
    self:fireEvent("auto_complete_open", token, suggestions)
end

local function handleAutoCompleteKey(self, key)
    if not autoCompleteVisible(self) then return false end

    if key == keys.tab or (key == keys.enter and self.getResolved("autoCompleteAcceptOnEnter")) then
        applyAutoCompleteSelection(self)
        return true
    elseif key == keys.up then
        setAutoCompleteSelection(self, (self._autoCompleteIndex or 1) - 1)
        return true
    elseif key == keys.down then
        setAutoCompleteSelection(self, (self._autoCompleteIndex or 1) + 1)
        return true
    elseif key == keys.pageUp then
        local height = (self._autoCompleteList and self._autoCompleteList.get("height")) or 1
        setAutoCompleteSelection(self, (self._autoCompleteIndex or 1) - height)
        return true
    elseif key == keys.pageDown then
        local height = (self._autoCompleteList and self._autoCompleteList.get("height")) or 1
        setAutoCompleteSelection(self, (self._autoCompleteIndex or 1) + height)
        return true
    elseif key == keys.escape and self.getResolved("autoCompleteCloseOnEscape") then
        hideAutoComplete(self)
        return true
    end
    return false
end

local function handleAutoCompleteScroll(self, direction)
    if not autoCompleteVisible(self) then return false end
    local list = self._autoCompleteList
    if not list or list._destroyed then return false end
    local items = list.get("items")
    local height = list.get("height") or 1
    local offset = list.get("offset") or 0
    local count = #items
    if count == 0 then return false end

    local maxOffset = math.max(0, count - height)
    local newOffset = math.max(0, math.min(maxOffset, offset + direction))
    if newOffset ~= offset then
        list:setOffset(newOffset)
    end

    local target = (self._autoCompleteIndex or 1) + direction
    if target >= 1 and target <= count then
        setAutoCompleteSelection(self, target)
    else
        list:updateRender()
    end
    return true
end

--- Creates a new TextBox instance
--- @shortDescription Creates a new TextBox instance
--- @return TextBox self The newly created TextBox instance
--- @private
function TextBox.new()
    local self = setmetatable({}, TextBox):__init()
    self.class = TextBox
    self.set("width", 20)
    self.set("height", 10)
    return self
end

--- @shortDescription Initializes the TextBox instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return TextBox self The initialized instance
--- @protected
function TextBox:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "TextBox")

    local function refreshIfEnabled()
        if self.getResolved("autoCompleteEnabled") and self:hasState("focused") then
            refreshAutoComplete(self)
        end
    end

    local function restyle()
        updateAutoCompleteStyles(self)
    end

    local function reposition()
        if autoCompleteVisible(self) then
            local suggestions = rawget(self, "_autoCompleteSuggestions") or {}
            placeAutoCompleteFrame(self, math.max(#suggestions, 1), rawget(self, "_autoCompletePopupWidth") or self.getResolved("width"))
        end
    end

    self:observe("autoCompleteEnabled", function(_, value)
        if not value then
            hideAutoComplete(self, true)
        elseif self:hasState("focused") then
            refreshAutoComplete(self)
        end
    end)

    --[[
    self:observe("focused", function(_, focused)
        if focused then
            refreshIfEnabled()
        else
            hideAutoComplete(self, true)
        end
    end)]] -- needs a REWORK

    self:observe("foreground", restyle)
    self:observe("background", restyle)
    self:observe("autoCompleteBackground", restyle)
    self:observe("autoCompleteForeground", restyle)
    self:observe("autoCompleteSelectedBackground", restyle)
    self:observe("autoCompleteSelectedForeground", restyle)
    self:observe("autoCompleteBorderColor", restyle)

    self:observe("autoCompleteZOffset", function()
        if self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
            self._autoCompleteFrame:setZ(self.getResolved("z") + self.getResolved("autoCompleteZOffset"))
        end
    end)
    self:observe("z", function()
        if self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
            self._autoCompleteFrame:setZ(self.getResolved("z") + self.getResolved("autoCompleteZOffset"))
        end
    end)

    self:observe("autoCompleteShowBorder", function()
        restyle()
        reposition()
    end)

    for _, prop in ipairs({
        "autoCompleteItems",
        "autoCompleteProvider",
        "autoCompleteMinChars",
        "autoCompleteMaxItems",
        "autoCompleteCaseInsensitive",
        "autoCompleteTokenPattern",
        "autoCompleteOffsetX",
        "autoCompleteOffsetY",
    }) do
        self:observe(prop, refreshIfEnabled)
    end

    self:observe("x", reposition)
    self:observe("y", reposition)
    self:observe("width", function()
        reposition()
        refreshIfEnabled()
    end)
    self:observe("height", reposition)
    self:observe("cursorX", reposition)
    self:observe("cursorY", reposition)
    self:observe("scrollX", reposition)
    self:observe("scrollY", reposition)
    self:observe("autoCompleteOffsetX", reposition)
    self:observe("autoCompleteOffsetY", reposition)
    self:observe("autoCompleteMaxWidth", function()
        if autoCompleteVisible(self) then
            local suggestions = rawget(self, "_autoCompleteSuggestions") or {}
            if #suggestions > 0 then
                local popupWidth = measureSuggestionWidth(self, suggestions)
                self._autoCompletePopupWidth = popupWidth
                placeAutoCompleteFrame(self, math.max(#suggestions, 1), popupWidth)
            end
        end
    end)
    return self
end

--- Adds a new syntax highlighting pattern
--- @shortDescription Adds a new syntax highlighting pattern
--- @param pattern string The regex pattern to match
--- @param color number The color to apply
--- @return TextBox self The TextBox instance
function TextBox:addSyntaxPattern(pattern, color)
    table.insert(self.getResolved("syntaxPatterns"), {pattern = pattern, color = color})
    return self
end

--- Removes a syntax pattern by index (1-based)
--- @param index number The index of the pattern to remove
--- @return TextBox self
function TextBox:removeSyntaxPattern(index)
    local patterns = self.getResolved("syntaxPatterns") or {}
    if type(index) ~= "number" then return self end
    if index >= 1 and index <= #patterns then
        table.remove(patterns, index)
        self.set("syntaxPatterns", patterns)
        self:updateRender()
    end
    return self
end

--- Clears all syntax highlighting patterns
--- @return TextBox self
function TextBox:clearSyntaxPatterns()
    self.set("syntaxPatterns", {})
    self:updateRender()
    return self
end

local function insertChar(self, char)
    local lines = self.getResolved("lines")
    local cursorX = self.getResolved("cursorX")
    local cursorY = self.getResolved("cursorY")
    local currentLine = lines[cursorY]
    lines[cursorY] = currentLine:sub(1, cursorX-1) .. char .. currentLine:sub(cursorX)
    self.set("cursorX", cursorX + 1)
    self:updateViewport()
    self:updateRender()
end

local function insertText(self, text)
    for i = 1, #text do
        insertChar(self, text:sub(i,i))
    end
end

local function newLine(self)
    local lines = self.getResolved("lines")
    local cursorX = self.getResolved("cursorX")
    local cursorY = self.getResolved("cursorY")
    local currentLine = lines[cursorY]

    local restOfLine = currentLine:sub(cursorX)
    lines[cursorY] = currentLine:sub(1, cursorX-1)
    table.insert(lines, cursorY + 1, restOfLine)

    self.set("cursorX", 1)
    self.set("cursorY", cursorY + 1)
    self:updateViewport()
    self:updateRender()
end

local function backspace(self)
    local lines = self.getResolved("lines")
    local cursorX = self.getResolved("cursorX")
    local cursorY = self.getResolved("cursorY")
    local currentLine = lines[cursorY]

    if cursorX > 1 then
        lines[cursorY] = currentLine:sub(1, cursorX-2) .. currentLine:sub(cursorX)
        self.set("cursorX", cursorX - 1)
    elseif cursorY > 1 then
        local previousLine = lines[cursorY-1]
        self.set("cursorX", #previousLine + 1)
        self.set("cursorY", cursorY - 1)
        lines[cursorY-1] = previousLine .. currentLine
        table.remove(lines, cursorY)
    end
    self:updateViewport()
    self:updateRender()
end

--- Updates the viewport to keep the cursor in view
--- @shortDescription Updates the viewport to keep the cursor in view
--- @return TextBox self The TextBox instance
function TextBox:updateViewport()
    local cursorX = self.getResolved("cursorX")
    local cursorY = self.getResolved("cursorY")
    local scrollX = self.getResolved("scrollX")
    local scrollY = self.getResolved("scrollY")
    local width = self.getResolved("width")
    local height = self.getResolved("height")

    -- Horizontal scrolling
    if cursorX - scrollX > width then
        self.set("scrollX", cursorX - width)
    elseif cursorX - scrollX < 1 then
        self.set("scrollX", cursorX - 1)
    end

    -- Vertical scrolling
    if cursorY - scrollY > height then
        self.set("scrollY", cursorY - height)
    elseif cursorY - scrollY < 1 then
        self.set("scrollY", cursorY - 1)
    end
    return self
end

--- @shortDescription Handles character input
--- @param char string The character that was typed
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:char(char)
    if not self.getResolved("editable") or not self:hasState("focused") then return false end
    -- Auto-pair logic only triggers for single characters
    local autoPair = self.getResolved("autoPairEnabled")
    if autoPair and #char == 1 then
        local map = self.getResolved("autoPairCharacters") or {}
        local lines = self.getResolved("lines")
        local cursorX = self.getResolved("cursorX")
        local cursorY = self.getResolved("cursorY")
        local line = lines[cursorY] or ""
        local afterChar = line:sub(cursorX, cursorX)

        -- If typed char is an opening pair and we should skip duplicating closing when already there
        local closing = map[char]
        if closing then
            -- If skip closing and same closing already directly after, just insert opening?
            insertChar(self, char)
            if self.getResolved("autoPairSkipClosing") then
                if afterChar ~= closing then
                    insertChar(self, closing)
                    -- Move cursor back inside pair
                    self.set("cursorX", self.getResolved("cursorX") - 1)
                end
            else
                insertChar(self, closing)
                self.set("cursorX", self.getResolved("cursorX") - 1)
            end
            refreshAutoComplete(self)
            return true
        end

        -- If typed char is a closing we might want to overtype
        if self.getResolved("autoPairOverType") then
            for open, close in pairs(map) do
                if char == close and afterChar == close then
                    -- move over instead of inserting
                    self.set("cursorX", cursorX + 1)
                    refreshAutoComplete(self)
                    return true
                end
            end
        end
    end

    insertChar(self, char)
    refreshAutoComplete(self)
    return true
end

--- @shortDescription Handles key events
--- @param key number The key that was pressed
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:key(key)
    if not self.getResolved("editable") or not self:hasState("focused") then return false end
    if handleAutoCompleteKey(self, key) then
        return true
    end
    local lines = self.getResolved("lines")
    local cursorX = self.getResolved("cursorX")
    local cursorY = self.getResolved("cursorY")

    if key == keys.enter then
        -- Smart newline between matching braces/brackets if enabled
        if self.getResolved("autoPairEnabled") and self.getResolved("autoPairNewlineIndent") then
            local lines = self.getResolved("lines")
            local cursorX = self.getResolved("cursorX")
            local cursorY = self.getResolved("cursorY")
            local line = lines[cursorY] or ""
            local before = line:sub(1, cursorX - 1)
            local after = line:sub(cursorX)
            local pairMap = self.getResolved("autoPairCharacters") or {}
            local inverse = {}
            for o,c in pairs(pairMap) do inverse[c]=o end
            local prevChar = before:sub(-1)
            local nextChar = after:sub(1,1)
            if prevChar ~= "" and nextChar ~= "" and pairMap[prevChar] == nextChar then
                -- Split line into two with an empty line between, caret positioned on inner line
                lines[cursorY] = before
                table.insert(lines, cursorY + 1, "")
                table.insert(lines, cursorY + 2, after)
                self.set("cursorY", cursorY + 1)
                self.set("cursorX", 1)
                self:updateViewport()
                self:updateRender()
                refreshAutoComplete(self)
                return true
            end
        end
        newLine(self)
    elseif key == keys.backspace then
        backspace(self)
    elseif key == keys.left then
        if cursorX > 1 then
            self.set("cursorX", cursorX - 1)
        elseif cursorY > 1 then
            self.set("cursorY", cursorY - 1)
            self.set("cursorX", #lines[cursorY-1] + 1)
        end
    elseif key == keys.right then
        if cursorX <= #lines[cursorY] then
            self.set("cursorX", cursorX + 1)
        elseif cursorY < #lines then
            self.set("cursorY", cursorY + 1)
            self.set("cursorX", 1)
        end
    elseif key == keys.up and cursorY > 1 then
        self.set("cursorY", cursorY - 1)
        self.set("cursorX", math.min(cursorX, #lines[cursorY-1] + 1))
    elseif key == keys.down and cursorY < #lines then
        self.set("cursorY", cursorY + 1)
        self.set("cursorX", math.min(cursorX, #lines[cursorY+1] + 1))
    end
    self:updateRender()
    self:updateViewport()
    refreshAutoComplete(self)
    return true
end

--- @shortDescription Handles mouse scroll events
--- @param direction number The scroll direction
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:mouse_scroll(direction, x, y)
    if handleAutoCompleteScroll(self, direction) then
        return true
    end
    if self:isInBounds(x, y) then
        local scrollY = self.getResolved("scrollY")
        local height = self.getResolved("height")
        local lines = self.getResolved("lines")

        local maxScroll = math.max(0, #lines - height + 2)

        local newScroll = math.max(0, math.min(maxScroll, scrollY + direction))

        self.set("scrollY", newScroll)
        self:updateRender()
        return true
    end
    return false
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local scrollX = self.getResolved("scrollX")
        local scrollY = self.getResolved("scrollY")

        local targetY = (relY or 0) + (scrollY or 0)
        local lines = self.getResolved("lines") or {}

        -- clamp and validate before indexing to avoid nil errors
        if targetY < 1 then targetY = 1 end
        if targetY <= #lines and lines[targetY] ~= nil then
            self.set("cursorY", targetY)
            local lineLen = #tostring(lines[targetY])
            self.set("cursorX", math.min((relX or 1) + (scrollX or 0), lineLen + 1))
        end
        self:updateRender()
        refreshAutoComplete(self)
        return true
    end
    if autoCompleteVisible(self) then
        local frame = self._autoCompleteFrame
        if not (frame and frame:isInBounds(x, y)) and not self:isInBounds(x, y) then
            hideAutoComplete(self)
        end
    end
    return false
end

--- @shortDescription Handles paste events
--- @protected
function TextBox:paste(text)
    if not self.getResolved("editable") or not self:hasState("focused") then return false end

    for char in text:gmatch(".") do
        if char == "\n" then
            newLine(self)
        else
            insertChar(self, char)
        end
    end

    refreshAutoComplete(self)
    return true
end

--- Sets the text of the TextBox
--- @shortDescription Sets the text of the TextBox
--- @param text string The text to set
--- @return TextBox self The TextBox instance
function TextBox:setText(text)
    local lines = {}
    if text == "" then
        lines = {""}
    else
        for line in (text.."\n"):gmatch("([^\n]*)\n") do
            table.insert(lines, line)
        end
    end
    self.set("lines", lines)
    hideAutoComplete(self, true)
    return self
end

--- Gets the text of the TextBox
--- @shortDescription Gets the text of the TextBox
--- @return string text The text of the TextBox
function TextBox:getText()
    return table.concat(self.getResolved("lines"), "\n")
end

local function applySyntaxHighlighting(self, line)
    local text = line
    local colors = string.rep(tHex[self.getResolved("foreground")], #text)
    local patterns = self.getResolved("syntaxPatterns")

    for _, syntax in ipairs(patterns) do
        local start = 1
        while true do
            local s, e = text:find(syntax.pattern, start)
            if not s then break end
            local matchLen = e - s + 1
            if matchLen <= 0 then
                -- avoid infinite loops for zero-length matches: color one char and advance
                colors = colors:sub(1, s-1) .. string.rep(tHex[syntax.color], 1) .. colors:sub(s+1)
                start = s + 1
            else
                colors = colors:sub(1, s-1) .. string.rep(tHex[syntax.color], matchLen) .. colors:sub(e+1)
                start = e + 1
            end
        end
    end

    return text, colors
end

--- @shortDescription Renders the TextBox with syntax highlighting
--- @protected
function TextBox:render()
    VisualElement.render(self)

    local lines = self.getResolved("lines")
    local scrollX = self.getResolved("scrollX")
    local scrollY = self.getResolved("scrollY")
    local width = self.getResolved("width")
    local height = self.getResolved("height")
    local foreground = self.getResolved("foreground")
    local background = self.getResolved("background")
    local fg = tHex[foreground]
    local bg = tHex[background]

    for y = 1, height do
        local lineNum = y + scrollY
        local line = lines[lineNum] or ""

        local fullText, fullColors = applySyntaxHighlighting(self, line)
        local text = fullText:sub(scrollX + 1, scrollX + width)
        local colors = fullColors:sub(scrollX + 1, scrollX + width)

        local padLen = width - #text
        if padLen > 0 then
            text = text .. string.rep(" ", padLen)
            colors = colors .. string.rep(tHex[foreground], padLen)
        end

        self:blit(1, y, text, colors, string.rep(bg, #text))
    end

    if self:hasState("focused") then
        local relativeX = self.getResolved("cursorX") - scrollX
        local relativeY = self.getResolved("cursorY") - scrollY
        if relativeX >= 1 and relativeX <= width and relativeY >= 1 and relativeY <= height then
            self:setCursor(relativeX, relativeY, true, self.getResolved("cursorColor") or foreground)
        end
    end
end

function TextBox:destroy()
    if self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
        self._autoCompleteFrame:destroy()
    end
    self._autoCompleteFrame = nil
    self._autoCompleteList = nil
    self._autoCompletePopupWidth = nil
    VisualElement.destroy(self)
end

return TextBox
