-- Focused Basalt2 API compatibility regression for Table and Tree.
local ok, err = pcall(function()
    local basalt = assert(loadfile("/Basalt3/init.lua", nil, _ENV))(
        "Basalt3", "Basalt3/init.lua")
    local frame = basalt.createFrame()

    local tbl = frame:addTable({ x = 1, y = 1, width = 30, height = 6 })
    tbl:setColumns({
        "Name",
        { name = "Age", width = "30%", minWidth = 3 },
        { title = "City", width = "auto" },
    })
    assert(tbl.columns[1].title == "Name" and tbl.columns[2].name == "Age")
    local widths = tbl:calculateColumnWidths(tbl.columns, 30)
    assert(#widths == 3 and widths[2].visibleWidth >= 3)

    tbl:addRow("Alice", 30, "Vienna")
        :addRow({ "Bob", 25, "Berlin" })
    assert(#tbl:getData() == 2 and tbl:getRow(1)[1] == "Alice")
    tbl:addColumn("Score", 6)
    assert(#tbl.columns == 4 and tbl.columns[4].title == "Score")

    local changes, rowSelects = 0, 0
    tbl:onChange(function(_, index, row)
        changes = changes + 1
        assert(index == false or row == tbl.data[index])
    end)
    tbl:onRowSelect(function(_, index, row)
        rowSelects = rowSelects + 1
        assert(row == tbl.data[index])
    end)
    tbl:select(2)
    assert(tbl:getSelectedRow() == tbl:getRow(2))
    assert(changes == 1 and rowSelects == 1)

    tbl:setData({ { "ten", 10 }, { "two", 2 } }, {
        [2] = function(value) return value .. " years" end,
    })
    assert(tbl.data[1][2] == "10 years")
    tbl:setSortColumn(2):setSortDirection("asc")
    assert(tbl:getSortColumn() == 2 and tbl:getSortDirection() == "asc")
    tbl:sortByColumn(2)

    local comparatorCalled = false
    tbl:setColumnSortFunction(1, function(rowA, rowB, direction)
        comparatorCalled = direction == "asc" or direction == "desc"
        return tostring(rowA[1]) < tostring(rowB[1])
    end):sortByColumn(1)
    frame:draw()
    assert(comparatorCalled)
    tbl:setHeaderColor(colors.blue)
        :setSelectionColor(colors.white, colors.red)
        :setShowScrollBar(false)
    assert(tbl:getHeaderColor() == colors.blue and not tbl:getShowScrollBar())
    tbl:clearData()
    assert(#tbl.data == 0 and tbl:getSelectedRow() == nil)

    local root = {
        text = "Root with a very long label",
        children = {
            { text = "Child A" },
            { text = "Child B", children = { { text = "Grandchild" } } },
        },
    }
    local tree = frame:addTree({ x = 1, y = 8, width = 12, height = 5 })
    tree:setNodes({ root })
    assert(root.expanded == true)
    local nodeChanges, nodeSelects, toggles = 0, 0, 0
    tree:onChange(function(_, node) nodeChanges = nodeChanges + 1 end)
    tree:onSelect(function(_, node)
        nodeSelects = nodeSelects + 1
        assert(node == root.children[1])
    end)
    tree:onToggle(function(_, node) toggles = toggles + 1 end)

    tree:setSelectedNode(root.children[1])
    assert(tree:getSelectedNode() == root.children[1] and nodeChanges == 1)
    tree:select(root.children[1])
    assert(nodeSelects == 1)
    tree:collapseNode(root):expandNode(root):toggleNode(root)
    assert(toggles == 3 and root.expanded == false)

    tree:setExpandedNodes({ [root] = true, [root.children[2]] = true })
    local expanded = tree:getExpandedNodes()
    assert(expanded[root] and expanded[root.children[2]])
    local nodeWidth, nodeHeight = tree:getNodeSize()
    assert(nodeWidth > tree.width and nodeHeight == 4)
    tree:setHorizontalOffset(999)
    assert(tree.horizontalOffset == nodeWidth - tree.width)
    tree:setSelectedForegroundColor(colors.yellow)
        :setSelectedBackgroundColor(colors.blue)
        :setScrollBarColor(colors.white)
        :setScrollBarBackgroundColor(colors.gray)
    assert(tree:getSelectedForegroundColor() == colors.yellow)
    assert(tree:getSelectedBackgroundColor() == colors.blue)
    assert(tree:getScrollBarColor() == colors.white)
    assert(tree:getScrollBarBackgroundColor() == colors.gray)
    frame:draw()
end)

local file = assert(fs.open("/basalt3_table_tree_result.txt", "w"))
file.writeLine(ok and "PASS" or ("FAIL: " .. tostring(err)))
file.close()
os.shutdown()
