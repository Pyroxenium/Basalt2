local flow = {}

--- Calculates positions for all children in a flow layout
--- @param instance table The layout instance
---   - container: the container to layout
---   - options: layout options
---     - direction: "horizontal" or "vertical" (default: "horizontal")
---     - spacing: gap between elements (default: 0)
---     - padding: padding around the flow (default: 0)
---     - align: "start", "center", or "end" (default: "start")
function flow.calculate(instance)
    local container = instance.container
    local options = instance.options or {}

    local children = container.get("children")
    local containerWidth = container.get("width")
    local containerHeight = container.get("height")

    local direction = options.direction or "horizontal"
    local spacing = options.spacing or 0
    local padding = options.padding or 0
    local align = options.align or "start"

    local childCount = #children
    if childCount == 0 then
        instance._positions = {}
        return
    end

    local positions = {}

    if direction == "horizontal" then
        local rows = {}
        local currentRow = {}
        local currentX = padding + 1
        local currentY = padding + 1
        local maxHeightInRow = 0

        for i, child in ipairs(children) do
            local childWidth = child.get("width")
            local childHeight = child.get("height")
            local layoutConfig = child.get("layoutConfig") or {}

            if child._userModified then
                child._originalWidth = childWidth
                child._originalHeight = childHeight
            end

            local basis = layoutConfig.basis
            if not basis then
                if not child._originalWidth then
                    child._originalWidth = childWidth
                end
                basis = child._originalWidth
            end

            local hasFlexConfig = layoutConfig.grow or layoutConfig.shrink or layoutConfig.basis

            if currentX + basis - 1 > containerWidth - padding and currentX > padding + 1 then

                table.insert(rows, {
                    children = currentRow,
                    y = currentY,
                    height = maxHeightInRow
                })

                currentRow = {}
                currentX = padding + 1
                currentY = currentY + maxHeightInRow + spacing
                maxHeightInRow = 0
            end

            table.insert(currentRow, {
                child = child,
                width = childWidth,
                height = childHeight,
                basis = basis,
                grow = layoutConfig.grow or 0,
                shrink = layoutConfig.shrink or 1,
                hasFlexConfig = hasFlexConfig
            })

            currentX = currentX + basis + spacing
            maxHeightInRow = math.max(maxHeightInRow, childHeight)
        end

        if #currentRow > 0 then
            table.insert(rows, {
                children = currentRow,
                y = currentY,
                height = maxHeightInRow
            })
        end

        for _, row in ipairs(rows) do
            local totalBasis = 0
            local totalSpacing = (#row.children - 1) * spacing
            local totalGrow = 0
            local totalShrink = 0

            for _, item in ipairs(row.children) do
                totalBasis = totalBasis + item.basis
                totalGrow = totalGrow + item.grow
                totalShrink = totalShrink + item.shrink
            end

            local availableWidth = containerWidth - 2 * padding
            local remainingSpace = availableWidth - totalBasis - totalSpacing

            for _, item in ipairs(row.children) do
                if remainingSpace > 0 and totalGrow > 0 then
                    local extraSpace = (remainingSpace * item.grow) / totalGrow
                    item.finalWidth = item.basis + extraSpace
                elseif remainingSpace < 0 and totalShrink > 0 then
                    local reduceSpace = (-remainingSpace * item.shrink) / totalShrink
                    item.finalWidth = math.max(1, item.basis - reduceSpace)
                else
                    item.finalWidth = item.basis
                end

                if not item.hasFlexConfig then
                    item.finalWidth = item.basis
                end
            end

            local rowWidth = 0
            for j, item in ipairs(row.children) do
                rowWidth = rowWidth + item.finalWidth
                if j < #row.children then
                    rowWidth = rowWidth + spacing
                end
            end

            local startX = padding + 1
            if align == "center" then
                startX = padding + 1 + math.floor((containerWidth - 2 * padding - rowWidth) / 2)
            elseif align == "end" then
                startX = containerWidth - padding - rowWidth + 1
            end

            local x = startX
            for _, item in ipairs(row.children) do
                local y = row.y
                if align == "center" then
                    y = row.y + math.floor((row.height - item.height) / 2)
                elseif align == "end" then
                    y = row.y + row.height - item.height
                end

                positions[item.child] = {
                    x = x,
                    y = y,
                    width = math.floor(item.finalWidth),
                    height = item.height
                }

                x = x + math.floor(item.finalWidth) + spacing
            end
        end

    else
        local columns = {}
        local currentColumn = {}
        local currentX = padding + 1
        local currentY = padding + 1
        local maxWidthInColumn = 0

        for i, child in ipairs(children) do
            local childWidth = child.get("width")
            local childHeight = child.get("height")
            local layoutConfig = child.get("layoutConfig") or {}

            -- If user modified the element, update the original size
            if child._userModified then
                child._originalWidth = childWidth
                child._originalHeight = childHeight
            end

            local basis = layoutConfig.basis
            if not basis then
                if not child._originalHeight then
                    child._originalHeight = childHeight
                end
                basis = child._originalHeight
            end

            local hasFlexConfig = layoutConfig.grow or layoutConfig.shrink or layoutConfig.basis

            if currentY + basis - 1 > containerHeight - padding and currentY > padding + 1 then
                table.insert(columns, {
                    children = currentColumn,
                    x = currentX,
                    width = maxWidthInColumn
                })

                currentColumn = {}
                currentY = padding + 1
                currentX = currentX + maxWidthInColumn + spacing
                maxWidthInColumn = 0
            end

            table.insert(currentColumn, {
                child = child,
                width = childWidth,
                height = childHeight,
                basis = basis,
                grow = layoutConfig.grow or 0,
                shrink = layoutConfig.shrink or 1,
                hasFlexConfig = hasFlexConfig
            })

            currentY = currentY + basis + spacing
            maxWidthInColumn = math.max(maxWidthInColumn, childWidth)
        end

        if #currentColumn > 0 then
            table.insert(columns, {
                children = currentColumn,
                x = currentX,
                width = maxWidthInColumn
            })
        end

        for _, column in ipairs(columns) do
            local totalBasis = 0
            local totalSpacing = (#column.children - 1) * spacing
            local totalGrow = 0
            local totalShrink = 0

            for _, item in ipairs(column.children) do
                totalBasis = totalBasis + item.basis
                totalGrow = totalGrow + item.grow
                totalShrink = totalShrink + item.shrink
            end

            local availableHeight = containerHeight - 2 * padding
            local remainingSpace = availableHeight - totalBasis - totalSpacing

            for _, item in ipairs(column.children) do
                if remainingSpace > 0 and totalGrow > 0 then
                    local extraSpace = (remainingSpace * item.grow) / totalGrow
                    item.finalHeight = item.basis + extraSpace
                elseif remainingSpace < 0 and totalShrink > 0 then
                    local reduceSpace = (-remainingSpace * item.shrink) / totalShrink
                    item.finalHeight = math.max(1, item.basis - reduceSpace)
                else
                    item.finalHeight = item.basis
                end

                if not item.hasFlexConfig then
                    item.finalHeight = item.basis
                end
            end

            local columnHeight = 0
            for j, item in ipairs(column.children) do
                columnHeight = columnHeight + item.finalHeight
                if j < #column.children then
                    columnHeight = columnHeight + spacing
                end
            end

            local startY = padding + 1
            if align == "center" then
                startY = padding + 1 + math.floor((containerHeight - 2 * padding - columnHeight) / 2)
            elseif align == "end" then
                startY = containerHeight - padding - columnHeight + 1
            end

            local y = startY
            for _, item in ipairs(column.children) do
                local x = column.x
                if align == "center" then
                    x = column.x + math.floor((column.width - item.width) / 2)
                elseif align == "end" then
                    x = column.x + column.width - item.width
                end

                positions[item.child] = {
                    x = x,
                    y = y,
                    width = item.width,
                    height = math.floor(item.finalHeight)
                }

                y = y + math.floor(item.finalHeight) + spacing
            end
        end
    end

    instance._positions = positions
end

return flow
