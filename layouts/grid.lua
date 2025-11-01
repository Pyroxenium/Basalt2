local grid = {}

--- Calculates positions for all children in a grid layout
--- @param instance table The layout instance
---   - container: the container to layout
---   - options: layout options
---     - rows: number of rows (optional, auto-calculated if not provided)
---     - columns: number of columns (optional, auto-calculated if not provided)
---     - spacing: gap between cells (default: 0)
---     - padding: padding around the grid (default: 0)
function grid.calculate(instance)
    local container = instance.container
    local options = instance.options or {}

    local children = container.get("children")
    local containerWidth = container.get("width")
    local containerHeight = container.get("height")

    local spacing = options.spacing or 0
    local padding = options.padding or 0
    local rows = options.rows
    local columns = options.columns

    local childCount = #children
    if not rows and not columns then
        columns = math.ceil(math.sqrt(childCount))
        rows = math.ceil(childCount / columns)
    elseif rows and not columns then
        columns = math.ceil(childCount / rows)
    elseif columns and not rows then
        rows = math.ceil(childCount / columns)
    end

    local availableWidth = containerWidth - (2 * padding) - ((columns - 1) * spacing)
    local availableHeight = containerHeight - (2 * padding) - ((rows - 1) * spacing)
    local cellWidth = math.floor(availableWidth / columns)
    local cellHeight = math.floor(availableHeight / rows)

    local positions = {}

    for i, child in ipairs(children) do
        local row = math.floor((i - 1) / columns)
        local col = (i - 1) % columns

        local x = padding + 1 + (col * (cellWidth + spacing))
        local y = padding + 1 + (row * (cellHeight + spacing))

        positions[child] = {
            x = x,
            y = y,
            width = cellWidth,
            height = cellHeight
        }
    end

    instance._positions = positions
end

return grid
