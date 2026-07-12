-- Focused headless regression for combined properties.
local ok, err = pcall(function()
    local basalt = assert(loadfile("/Basalt3/init.lua", nil, _ENV))(
        "Basalt3", "Basalt3/init.lua")
    local frame = basalt.createFrame()
    local element = frame:addButton({ text = "Combined" })

    assert(element:setPosition(4, 5):setSize(12, 3) == element)
    local x, y = element:getPosition()
    local width, height = element:getSize()
    assert(x == 4 and y == 5 and width == 12 and height == 3)

    element:setBounds(6, 7, 14, 2)
    x, y, width, height = element:getBounds()
    assert(x == 6 and y == 7 and width == 14 and height == 2)

    element:setColors(colors.red, false)
    local foreground, background = element:getColors()
    assert(foreground == colors.red and background == false)

    element:setMinSize(3, 2):setMaxSize(20, 8)
    local minWidth, minHeight = element:getMinSize()
    local maxWidth, maxHeight = element:getMaxSize()
    assert(minWidth == 3 and minHeight == 2)
    assert(maxWidth == 20 and maxHeight == 8)

    element:setSize(basalt.fill(), basalt.auto())
    local widthSpec, heightSpec = element:getRawSize()
    assert(type(widthSpec) == "table" and type(heightSpec) == "table")
    assert(not pcall(element.setPosition, element, 1))

    local row = frame:addRow({ x = 1, y = 10, width = 20, height = 1 })
    local managed = row:addLabel({ text = "Layout" }):setPosition(9, 9)
    frame:draw()
    local effectiveX, effectiveY = managed:getPosition()
    local authoredX, authoredY = managed:getRawPosition()
    assert(effectiveX == 1 and effectiveY == 1)
    assert(authoredX == 9 and authoredY == 9)
end)

local file = assert(fs.open("/basalt3_combined_result.txt", "w"))
file.writeLine(ok and "PASS" or ("FAIL: " .. tostring(err)))
file.close()
os.shutdown()
