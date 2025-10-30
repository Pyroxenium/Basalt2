local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local tHex = require("libraries/colorHex")

---@class Breadcrumb : VisualElement
local Breadcrumb = setmetatable({}, VisualElement)
Breadcrumb.__index = Breadcrumb

---@property path table {} Array of strings representing the breadcrumb segments
Breadcrumb.defineProperty(Breadcrumb, "path", {default = {}, type = "table", canTriggerRender = true})
---@property separator > string Character(s) separating path segments
Breadcrumb.defineProperty(Breadcrumb, "separator", {default = " > ", type = "string", canTriggerRender = true})
---@property clickable true boolean Whether the segments are clickable
Breadcrumb.defineProperty(Breadcrumb, "clickable", {default = true, type = "boolean"})
---@property autoSize false boolean Whether to resize the element width automatically based on text
Breadcrumb.defineProperty(Breadcrumb, "autoSize", {default = true, type = "boolean"})

Breadcrumb.defineEvent(Breadcrumb, "mouse_click")
Breadcrumb.defineEvent(Breadcrumb, "mouse_up")

--- @shortDescription Creates a new Breadcrumb instance
--- @return table self
function Breadcrumb.new()
    local self = setmetatable({}, Breadcrumb):__init()
    self.class = Breadcrumb
    self.set("z", 5)
    self.set("height", 1)
    self.set("backgroundEnabled", false)
    return self
end

--- @shortDescription Initializes the Breadcrumb instance
--- @param props table
--- @param basalt table
function Breadcrumb:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Breadcrumb")
end

--- @shortDescription Handles mouse click events
--- @param button number
--- @param x number
--- @param y number
--- @return boolean handled
function Breadcrumb:mouse_click(button, x, y)
    if not self.get("clickable") then return false end
        if VisualElement.mouse_click(self, button, x, y) then
        local path = self.get("path")
        local separator = self.get("separator")

        local cursorX = 1
        for i, segment in ipairs(path) do
            local segLen = #segment
            if x >= cursorX and x < cursorX + segLen then
                self:fireEvent("select",
                    i,
                    {table.unpack(path, 1, i)}
                )
                return true
            end
            cursorX = cursorX + segLen
            if i < #path then
                cursorX = cursorX + #separator
            end
        end
    end
    return false
end

--- Registers a callback for the select event
--- @shortDescription Registers a callback for the select event
--- @param callback function The callback function to register
--- @return Breadcrumb self The Breadcrumb instance
--- @usage breadcrumb:onSelect(function(segmentIndex, path) print("Navigated to segment:", segmentIndex, path) end)
function Breadcrumb:onSelect(callback)
    self:registerCallback("select", callback)
    return self
end

--- @shortDescription Renders the breadcrumb trail
--- @protected
function Breadcrumb:render()
    local path = self.get("path")
    local separator = self.get("separator")
    local fg = self.get("foreground")
    local clickable = self.get("clickable")
    local width = self.get("width")

    local fullText = ""
    for i, segment in ipairs(path) do
        fullText = fullText .. segment
        if i < #path then
            fullText = fullText .. separator
        end
    end

    if self.get("autoSize") then
        self.set("width", #fullText)
    else
        if #fullText > width then
            local ellipsis = "... > "
            local maxTextLen = width - #ellipsis
            if maxTextLen > 0 then
                fullText = ellipsis .. fullText:sub(-maxTextLen)
            else
                fullText = ellipsis:sub(1, width)
            end
        end
    end

    local cursorX = 1
    local color
    for word in fullText:gmatch("[^"..separator.."]+") do
        color = fg
        self:textFg(cursorX, 1, word, color)
        cursorX = cursorX + #word
        local sepStart = fullText:find(separator, cursorX, true)
        if sepStart then
            self:textFg(cursorX, 1, separator, clickable and colors.gray or colors.lightGray)
            cursorX = cursorX + #separator
        end
    end
end

return Breadcrumb