local tHex = require("libraries/colorHex")
local errorManager = require("errorManager")
local Canvas = {}
Canvas.__index = Canvas

local sub, rep = string.sub, string.rep

function Canvas.new(element)
    local self = setmetatable({}, Canvas)
    self.commands = {pre={},post={}}
    self.type = "pre"
    self.element = element
    return self
end

function Canvas:clear()
    self.commands = {pre={},post={}}
    return self
end

function Canvas:getValue(v)
    if type(v) == "function" then
        return v(self.element)
    end
    return v
end

function Canvas:setType(type)
    if type == "pre" or type == "post" then
        self.type = type
    else
        errorManager.error("Invalid type. Use 'pre' or 'post'.")
    end
    return self
end

function Canvas:addCommand(drawFn)
    local index = #self.commands[self.type] + 1
    self.commands[self.type][index] = drawFn
    return index
end

function Canvas:setCommand(index, drawFn)
    self.commands[index] = drawFn
    return self
end

function Canvas:removeCommand(index)
    --self.commands[self.type][index] = nil
    table.remove(self.commands[self.type], index)
    return self
end

function Canvas:text(x, y, text, fg, bg)
    return self:addCommand(function(render)
        local _x, _y = self:getValue(x), self:getValue(y)
        local _text = self:getValue(text)
        local _fg = self:getValue(fg)
        local _bg = self:getValue(bg)
        local __fg = type(_fg) == "number" and tHex[_fg]:rep(#text) or _fg
        local __bg = type(_bg) == "number" and tHex[_bg]:rep(#text) or _bg
        render:drawText(_x, _y, _text)
        if __fg then render:drawFg(_x, _y, __fg) end
        if __bg then render:drawBg(_x, _y, __bg) end
    end)
end

function Canvas:bg(x, y, bg)
    return self:addCommand(function(render)
        render:drawBg(x, y, bg)
    end)
end

function Canvas:fg(x, y, fg)
    return self:addCommand(function(render)
        render:drawFg(x, y, fg)
    end)
end

function Canvas:rect(x, y, width, height, char, fg, bg)
    return self:addCommand(function(render)
        local _x, _y = self:getValue(x), self:getValue(y)
        local _width, _height = self:getValue(width), self:getValue(height)
        local _char = self:getValue(char)
        local _fg = self:getValue(fg)
        local _bg = self:getValue(bg)

        if(type(_fg) == "number") then _fg = tHex[_fg] end
        if(type(_bg) == "number") then _bg = tHex[_bg] end

        local bgLine = _bg and sub(_bg:rep(_width), 1, _width)
        local fgLine = _fg and sub(_fg:rep(_width), 1, _width)
        local textLine = _char and sub(_char:rep(_width), 1, _width)

        for i = 0, _height - 1 do
            if _bg then render:drawBg(_x, _y + i, bgLine) end
            if _fg then render:drawFg(_x, _y + i, fgLine) end
            if _char then render:drawText(_x, _y + i, textLine) end
        end
    end)
end

function Canvas:line(x1, y1, x2, y2, char, fg, bg)
    local function linePoints(x1, y1, x2, y2)
        local points = {}
        local count = 0

        local dx = math.abs(x2 - x1)
        local dy = math.abs(y2 - y1)
        local sx = (x1 < x2) and 1 or -1
        local sy = (y1 < y2) and 1 or -1
        local err = dx - dy

        while true do
            count = count + 1
            points[count] = {x = x1, y = y1}

            if (x1 == x2) and (y1 == y2) then break end

            local err2 = err * 2
            if err2 > -dy then
                err = err - dy
                x1 = x1 + sx
            end
            if err2 < dx then
                err = err + dx
                y1 = y1 + sy
            end
        end

        return points
    end
    local needsRecreate = false
    local points
    if type(x1) == "function" or type(y1) == "function" or type(x2) == "function" or type(y2) == "function" then
        needsRecreate = true
    else
        points = linePoints(self:getValue(x1), self:getValue(y1), self:getValue(x2), self:getValue(y2))
    end

    return self:addCommand(function(render)
        if needsRecreate then
            points = linePoints(self:getValue(x1), self:getValue(y1), self:getValue(x2), self:getValue(y2))
        end
        local _char = self:getValue(char)
        local _fg = self:getValue(fg)
        local _bg = self:getValue(bg)
        local __fg = type(_fg) == "number" and tHex[_fg] or _fg
        local __bg = type(_bg) == "number" and tHex[_bg] or _bg

        for _, point in ipairs(points) do
            local x = math.floor(point.x)
            local y = math.floor(point.y)

            if _char then render:drawText(x, y, _char) end
            if __fg then render:drawFg(x, y, __fg) end
            if __bg then render:drawBg(x, y, __bg) end
        end
    end)
end

function Canvas:ellipse(centerX, centerY, radiusX, radiusY, char, fg, bg)
    local function ellipsePoints(x, y, radiusX, radiusY)
        local points = {}
        local count = 0

        local a2 = radiusX * radiusX
        local b2 = radiusY * radiusY

        local px = 0
        local py = radiusY

        local p = b2 - a2 * radiusY + 0.25 * a2
        local px2 = 0
        local py2 = 2 * a2 * py

        local function addPoint(px, py)
            count = count + 1
            points[count] = {x = x + px, y = y + py}
            count = count + 1
            points[count] = {x = x - px, y = y + py}
            count = count + 1
            points[count] = {x = x + px, y = y - py}
            count = count + 1
            points[count] = {x = x - px, y = y - py}
        end

        addPoint(px, py)

        while px2 < py2 do
            px = px + 1
            px2 = px2 + 2 * b2
            if p < 0 then
                p = p + b2 + px2
            else
                py = py - 1
                py2 = py2 - 2 * a2
                p = p + b2 + px2 - py2
            end
            addPoint(px, py)
        end

        p = b2 * (px + 0.5) * (px + 0.5) + a2 * (py - 1) * (py - 1) - a2 * b2

        while py > 0 do
            py = py - 1
            py2 = py2 - 2 * a2
            if p > 0 then
                p = p + a2 - py2
            else
                px = px + 1
                px2 = px2 + 2 * b2
                p = p + a2 - py2 + px2
            end
            addPoint(px, py)
        end

        return points
    end

    local points = ellipsePoints(centerX, centerY, radiusX, radiusY)
    return self:addCommand(function(render)
        local _char = self:getValue(char)
        local _fg = self:getValue(fg)
        local _bg = self:getValue(bg)
        local __fg = type(_fg) == "number" and tHex[_fg] or _fg
        local __bg = type(_bg) == "number" and tHex[_bg] or _bg

        for y, line in pairs(points) do
            local x = math.floor(line.x)
            local y = math.floor(line.y)

            if _char then render:drawText(x, y, _char) end
            if __fg then render:drawFg(x, y, __fg) end
            if __bg then render:drawBg(x, y, __bg) end
        end
    end)
end

local VisualElement = {hooks={}}

function VisualElement.setup(element)
    element.defineProperty(element, "canvas", {
        default = nil,
        type = "table",
        getter = function(self)
            if not self._values.canvas then
                self._values.canvas = Canvas.new(self)
            end
            return self._values.canvas
        end
    })
end

function VisualElement.hooks.render(self)
    local canvas = self.get("canvas")
    if canvas and #canvas.commands.pre > 0 then
        for _, cmd in pairs(canvas.commands.pre) do
            cmd(self)
        end
    end
end

function VisualElement.hooks.postRender(self)
    local canvas = self.get("canvas")
    if canvas and #canvas.commands.post > 0 then
        for _, cmd in pairs(canvas.commands.post) do
            cmd(self)
        end
    end
end

return {
    VisualElement = VisualElement,
    API = Canvas
}