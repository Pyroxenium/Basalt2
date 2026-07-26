-- Canvas: a single custom-painted surface.
-- The draw callback receives (canvas, renderBuffer) and paints in local
-- coordinates. This avoids building large trees of tiny visual elements.

local require = ...
local class = require("core/class")
local Element = require("core/element")

---@alias CanvasDrawCallback fun(canvas: Canvas, buffer: Render)

---@class Canvas : Element
---@field public draw CanvasDrawCallback|false Custom paint callback
local Canvas = class.create("Canvas", Element)

--- Custom renderer: function(canvas, renderBuffer)
class.property(Canvas, "draw", false, { rawFunction = true })

---@param buf Render The render buffer
function Canvas:render(buf)
    Element.render(self, buf)
    local draw = self.draw
    if draw then draw(self, buf) end
end

return Canvas
