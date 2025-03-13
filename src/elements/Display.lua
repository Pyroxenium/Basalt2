local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition
local deepcopy = require("libraries/utils").deepcopy
---@cofnigDescription The Display is a special element which uses the cc window API which you can use.
---@configDefault false

--- The Display is a special element where you can use the window (term) API to draw on a element, useful when you need to use external APIs.
---@class Display : VisualElement
local Display = setmetatable({}, VisualElement)
Display.__index = Display

--- @shortDescription Creates a new Display instance
--- @return table self The created instance
--- @private
function Display.new()
    local self = setmetatable({}, Display):__init()
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
    self._window.reposition = function(self, x, y, width, height)
        self.set("x", x)
        self.set("y", y)
        self.set("width", width)
        self.set("height", height)
        reposition(self, 1, 1, width, height)
    end

    self._window.getPosition = function(self)
        return self.get("x"), self.get("y")
    end

    self._window.setVisible = function(self, visible)
        self.set("visible", visible)
    end

    self._window.isVisible = function(self)
        return self.get("visible")
    end

    self:observe("width", function(self, width)
        local window = self.get("window")
        if window then
            window.reposition(1, 1, width, self.get("height"))
        end
    end)
    self:observe("height", function(self, height)
        local window = self.get("window")
        if window then
            window.reposition(1, 1, self.get("width"), height)
        end
    end)
end

function Display:getWindow()
    return self._window
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