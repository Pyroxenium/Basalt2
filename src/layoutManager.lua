--- LayoutManager - Core layout system for Basalt
--- Handles loading and applying layouts to containers
local LayoutManager = {}
LayoutManager._cache = {}

--- Loads a layout from a file
--- @param path string Path to the layout file
--- @return table layout The loaded layout module
function LayoutManager.load(path)
    if LayoutManager._cache[path] then
        return LayoutManager._cache[path]
    end

    local success, layout = pcall(require, path)
    if not success then
        error("Failed to load layout: " .. path .. "\n" .. layout)
    end

    if type(layout) ~= "table" then
        error("Layout must return a table: " .. path)
    end
    if type(layout.calculate) ~= "function" then
        error("Layout must have a calculate() function: " .. path)
    end

    LayoutManager._cache[path] = layout
    return layout
end

--- Applies a layout to a container
--- @param container Container The container to apply the layout to
--- @param layoutPath string Path to the layout file
--- @return table layoutInstance The layout instance
function LayoutManager.apply(container, layoutPath)
    local layout = LayoutManager.load(layoutPath)

    local instance = {
        layout = layout,
        container = container,
        options = {},
    }

    layout.calculate(instance)
    LayoutManager._applyPositions(instance)

    return instance
end

--- Internal: Applies calculated positions to children
--- @param instance table The layout instance
--- @private
function LayoutManager._applyPositions(instance)
    if not instance._positions then return end

    for child, pos in pairs(instance._positions) do
        if not child._destroyed then
            child.set("x", pos.x)
            child.set("y", pos.y)
            child.set("width", pos.width)
            child.set("height", pos.height)
        end
    end
end

--- Updates a layout instance (recalculates positions)
--- @param instance table The layout instance
function LayoutManager.update(instance)
    if instance and instance.layout and instance.layout.calculate then
        instance.layout.calculate(instance)
        LayoutManager._applyPositions(instance)
    end
end

--- Destroys a layout instance
--- @param instance table The layout instance
function LayoutManager.destroy(instance)
    if instance and instance.layout and instance.layout.destroy then
        instance.layout.destroy(instance)
    end
    if instance then
        instance._positions = nil
    end
end

return LayoutManager
