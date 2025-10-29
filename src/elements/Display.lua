local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition
local deepcopy = require("libraries/utils").deepcopy
local colorHex = require("libraries/colorHex")
---@configDescription The Display is a special element which uses the CC Window API which you can use.
---@configDefault false

--- A specialized element that provides direct access to ComputerCraft's Window API. 
--- It acts as a canvas where you can use standard CC terminal operations, making it ideal for:
--- - Integration with existing CC programs and APIs
--- - Custom drawing operations
--- - Terminal emulation
--- - Complex text manipulation
--- The Display maintains its own terminal buffer and can be manipulated using familiar CC terminal methods.
--- @usage [[
--- -- Create a display for a custom terminal
--- local display = main:addDisplay()
---     :setSize(30, 10)
---     :setPosition(2, 2)
---
--- -- Get the window object for CC API operations
--- local win = display:getWindow()
---
--- -- Use standard CC terminal operations
--- win.setTextColor(colors.yellow)
--- win.setBackgroundColor(colors.blue)
--- win.clear()
--- win.setCursorPos(1, 1)
--- win.write("Hello World!")
---
--- -- Or use the helper method
--- display:write(1, 2, "Direct write", colors.red, colors.black)
---
--- -- Useful for external APIs
--- local paintutils = require("paintutils")
--- paintutils.drawLine(1, 1, 10, 1, colors.red, win)
--- ]]
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

--- Retrieves the underlying ComputerCraft window object
--- @shortDescription Gets the CC window instance
--- @return table window A CC window object with all standard terminal methods
function Display:getWindow()
    return self._window
end

--- Writes text directly to the display with optional colors
--- @shortDescription Writes colored text to the display
--- @param x number X position (1-based)
--- @param y number Y position (1-based)
--- @param text string Text to write
--- @param fg? colors Foreground color (optional)
--- @param bg? colors Background color (optional)
--- @return Display self For method chaining
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