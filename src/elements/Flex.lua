-- Shared flex-style layout container used by Row and Column.

local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Container = require("core/container")

local Flex = class.create("Flex", Container)

class.property(Flex, "direction", "row")
class.property(Flex, "gap", 0)
class.property(Flex, "padding", 0)
class.property(Flex, "align", "start")
class.property(Flex, "justify", "start")
class.property(Flex, "overflow", "clip")
class.property(Flex, "background", false)

local function contentSize(self)
    local padding = math.max(0, math.floor(tonumber(self.padding) or 0))
    return padding,
        math.max(0, self.width - padding * 2),
        math.max(0, self.height - padding * 2)
end

local function desiredSize(child, axis, spec, availableWidth, availableHeight)
    if layout.is(spec) and (spec.kind == "auto" or spec.kind == "fill") then
        local mw, mh = layout.measure(child, availableWidth, availableHeight)
        return layout.constrain(child, axis, axis == "width" and mw or mh)
    end
    return layout.resolveSize(child, axis, spec, availableWidth, availableHeight)
end

function Flex:measure(availableWidth, availableHeight)
    availableWidth = availableWidth or 1
    availableHeight = availableHeight or 1
    local direction = self.direction
    local isRow = direction == "row"
    if not isRow and direction ~= "column" then
        error("Basalt 2.5 layout: direction must be 'row' or 'column'", 2)
    end

    local padding = math.max(0, math.floor(tonumber(self.padding) or 0))
    local gap = math.max(0, math.floor(tonumber(self.gap) or 0))
    local main, cross, count = 0, 0, 0
    local children = self:getChildren()
    for i = 1, #children do
        local child = children[i]
        if child.visible and child.position ~= "absolute" then
            local wSpec = layout.spec(child, "width")
            local hSpec = layout.spec(child, "height")
            local w = desiredSize(child, "width", wSpec, availableWidth, availableHeight)
            local h = desiredSize(child, "height", hSpec, availableWidth, availableHeight)
            main = main + (isRow and w or h)
            cross = math.max(cross, isRow and h or w)
            count = count + 1
        end
    end
    if count > 1 then main = main + gap * (count - 1) end
    main, cross = main + padding * 2, cross + padding * 2
    return isRow and main or cross, isRow and cross or main
end

function Flex:layoutChildren()
    local direction = self.direction
    local isRow = direction == "row"
    if not isRow and direction ~= "column" then
        error("Basalt 2.5 layout: direction must be 'row' or 'column'", 2)
    end

    local padding, contentWidth, contentHeight = contentSize(self)
    local contentMain = isRow and contentWidth or contentHeight
    local contentCross = isRow and contentHeight or contentWidth
    local gap = math.max(0, math.floor(tonumber(self.gap) or 0))
    local items, fillWeight, fixed, lastFill = {}, 0, 0, nil
    local children = self:getChildren()

    for i = 1, #children do
        local child = children[i]
        if child.position == "absolute" then
            layout.resolveFreeChild(self, child)
        elseif child.visible then
            local mainAxis = isRow and "width" or "height"
            local crossAxis = isRow and "height" or "width"
            local mainSpec = layout.spec(child, mainAxis)
            local crossSpec = layout.spec(child, crossAxis)
            local item = {
                child = child,
                mainSpec = mainSpec,
                crossSpec = crossSpec,
                fill = layout.is(mainSpec) and mainSpec.kind == "fill",
                weight = layout.is(mainSpec) and mainSpec.kind == "fill"
                    and mainSpec.value or 0,
            }
            local configuredShrink = child.shrink
            if configuredShrink == false then
                item.shrink = layout.is(mainSpec) and 1 or 0
            else
                item.shrink = math.max(0, tonumber(configuredShrink) or 0)
            end
            if item.fill then
                fillWeight = fillWeight + item.weight
                lastFill = #items + 1
            else
                item.main = desiredSize(child, mainAxis, mainSpec,
                    contentWidth, contentHeight)
                fixed = fixed + item.main
            end
            item.cross = layout.resolveSize(child, crossAxis, crossSpec,
                contentWidth, contentHeight)
            items[#items + 1] = item
        else
            rawset(child, "_layoutBox", nil)
        end
    end

    local gapTotal = gap * math.max(0, #items - 1)
    local distributable = math.max(0, contentMain - fixed - gapTotal)
    local distributed = 0
    for i = 1, #items do
        local item = items[i]
        if item.fill then
            local size
            if i == lastFill then
                size = distributable - distributed
            else
                size = math.floor(distributable * item.weight / fillWeight)
                distributed = distributed + size
            end
            local axis = isRow and "width" or "height"
            item.main = layout.constrain(item.child, axis, size)
        end
    end

    local used = gapTotal
    for i = 1, #items do used = used + items[i].main end

    -- When fixed/intrinsic content does not fit, shrink eligible items in
    -- proportion to their weights without crossing minWidth/minHeight.
    local deficit = math.max(0, used - contentMain)
    while deficit > 0 do
        local totalWeight = 0
        for i = 1, #items do
            local item = items[i]
            local minName = isRow and "minWidth" or "minHeight"
            local minimum = item.child[minName]
            if minimum == false then minimum = 0 end
            item.minimum = math.max(0, tonumber(minimum) or 0)
            if item.shrink > 0 and item.main > item.minimum then
                totalWeight = totalWeight + item.shrink
            end
        end
        if totalWeight == 0 then break end

        local reduced = 0
        for i = 1, #items do
            local item = items[i]
            if item.shrink > 0 and item.main > item.minimum then
                local share = math.max(1,
                    math.floor(deficit * item.shrink / totalWeight))
                local amount = math.min(share, item.main - item.minimum,
                    deficit - reduced)
                item.main = item.main - amount
                reduced = reduced + amount
                if reduced >= deficit then break end
            end
        end
        if reduced == 0 then break end
        deficit = deficit - reduced
    end

    used = gapTotal
    for i = 1, #items do used = used + items[i].main end
    local free = math.max(0, contentMain - used)
    local justify, offset, actualGap = self.justify, 0, gap
    if self.overflow ~= "clip" then
        error("Basalt 2.5 layout: only overflow='clip' is currently supported", 2)
    end
    if justify == "center" then
        offset = math.floor(free / 2)
    elseif justify == "end" then
        offset = free
    elseif justify == "spaceBetween" and #items > 1 then
        actualGap = gap + math.floor(free / (#items - 1))
    elseif justify ~= "start" then
        error("Basalt 2.5 layout: invalid justify '" .. tostring(justify) .. "'", 2)
    end

    local cursor = padding + offset + 1
    for i = 1, #items do
        local item, child = items[i], items[i].child
        local align = child.alignSelf ~= false and child.alignSelf or self.align
        local cross = item.cross
        if align == "stretch" and layout.is(item.crossSpec)
            and item.crossSpec.kind == "auto" then
            cross = contentCross
        end
        local crossOffset = 0
        if align == "center" then
            crossOffset = math.floor((contentCross - cross) / 2)
        elseif align == "end" then
            crossOffset = contentCross - cross
        elseif align ~= "start" and align ~= "stretch" then
            error("Basalt 2.5 layout: invalid align '" .. tostring(align) .. "'", 2)
        end
        crossOffset = math.max(0, crossOffset)

        if isRow then
            layout.setBox(child, cursor, padding + crossOffset + 1,
                item.main, cross)
        else
            layout.setBox(child, padding + crossOffset + 1, cursor,
                cross, item.main)
        end
        cursor = cursor + item.main + actualGap
    end
end

return Flex
