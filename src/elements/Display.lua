local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition
local deepcopy = require("libraries/utils").deepcopy
local colorHex = require("libraries/colorHex")
---@configDescription The Display is a special element which uses the cc window API which you can use.
---@configDefault false

--- The Display is a special element where you can use the window (term) API to draw on the display, useful when you need to use external APIs.
--- @usage local display = main:addDisplay() -- Create a display element
--- @usage local displayWindow = display:getWindow() -- Get the window object of the display
--- @usage displayWindow.write("Hello World!") -- Write "Hello World!" to the display
---@class Display : VisualElement
local Display = setmetatable({}, VisualElement)
Display.__index = Display

--- @shortDescription Creates a new Display instance
--- @return table self The created instance
--- @private
function Display.new()
    local self = setmetatable({}, Display):__init()
    self.class = Display
    self.set("width", 25)
    self.set("height", 8)
    self.set("z", 5)
    return self
end

--- @shortDescription Initializes the Display instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function Display:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Display")
    self._window = window.create(basalt.getActiveFrame():getTerm(), 1, 1, self.get("width"), self.get("height"), false)
    local reposition = self._window.reposition
    local blit = self._window.blit
    local write = self._window.write
    self._window.reposition = function(x, y, width, height)
        self.set("x", x)
        self.set("y", y)
        self.set("width", width)
        self.set("height", height)
        reposition(1, 1, width, height)
    end

    self._window.getPosition = function(self)
        return self.get("x"), self.get("y")
    end

    self._window.setVisible = function(visible)
        self.set("visible", visible)
    end

    self._window.isVisible = function(self)
        return self.get("visible")
    end
    self._window.blit = function(x, y, text, fg, bg)
        blit(x, y, text, fg, bg)
        self:updateRender()
    end
    self._window.write = function(x, y, text)
        write(x, y, text)
        self:updateRender()
    end

    self:observe("width", function(self, width)
        local window = self._window
        if window then
            window.reposition(1, 1, width, self.get("height"))
        end
    end)
    self:observe("height", function(self, height)
        local window = self._window
        if window then
            window.reposition(1, 1, self.get("width"), height)
        end
    end)
end

--- Returns the current window object
--- @shortDescription Returns the current window object
--- @return table window The current window object
function Display:getWindow()
    return self._window
end

--- Writes text to the display at the given position with the given foreground and background colors
--- @shortDescription Writes text to the display
--- @param x number The x position to write to
--- @param y number The y position to write to
--- @param text string The text to write
--- @param fg? colors The foreground color (optional)
--- @param bg? colors The background color (optional)
--- @return Display self The display instance
function Display:write(x, y, text, fg, bg)
    local window = self._window
    if window then
        if fg then
            window.setTextColor(fg)
        end
        if bg then
            window.setBackgroundColor(bg)
        end
        window.setCursorPos(x, y)
        window.write(text)
    end
    self:updateRender()
    return self
end

--- @shortDescription Renders the Display
--- @protected
function Display:render()
    VisualElement.render(self)
    local window = self._window
    local _, height = window.getSize()
    if window then
        for y = 1, height do
            local text, fg, bg = window.getLine(y)
            self:blit(1, y, text, fg, bg)
        end
    end
end

return Display