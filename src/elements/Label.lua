-- Label: text display. Auto-sizes to its text until width is set manually;
-- with a manual width the text word-wraps and the height auto-grows until
-- height is set manually too.

local require = ...
local class = require("core/class")
local Element = require("core/element")
local textutil = require("core/text")

local Label = class.create("Label", Element)

local function reflow(self)
    local p = rawget(self, "_p")
    if rawget(self, "_autoSize") then
        if type(p.width) ~= "function" then
            p.width = math.max(#tostring(self.text), 1)
        end
        return
    end
    -- manual width: wrap and grow the height unless it was set manually
    if rawget(self, "_autoHeight") and type(p.height) ~= "function"
        and type(p.width) ~= "function" then
        p.height = #textutil.wrap(self.text, self.width)
    end
end

class.property(Label, "text", "", {
    onChange = function(self) reflow(self) end,
})
class.property(Label, "width", 1, {
    onChange = function(self)
        rawset(self, "_autoSize", false)
        reflow(self)
    end,
})
class.property(Label, "height", 1, {
    onChange = function(self)
        rawset(self, "_autoHeight", false)
    end,
})

function Label:setup()
    Element.setup(self)
    rawset(self, "_autoSize", true)
    rawset(self, "_autoHeight", true)
end

function Label:render(buf)
    Element.render(self, buf)
    -- tostring: dynamic/reactive text may evaluate to a number
    local str = tostring(self.text)
    if rawget(self, "_autoSize") or self.height == 1 then
        buf:blit(1, 1, str, self.foreground, nil)
    else
        local lines = textutil.wrap(str, self.width)
        for i = 1, math.min(#lines, self.height) do
            buf:blit(1, i, lines[i], self.foreground, nil)
        end
    end
end

function Label:measure()
    return math.max(1, #tostring(self.text)), 1
end

return Label
