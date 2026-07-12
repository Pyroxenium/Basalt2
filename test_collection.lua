-- Focused headless regression for the shared Collection API.
local ok, err = pcall(function()
    local basalt = assert(loadfile("/Basalt3/init.lua", nil, _ENV))(
        "Basalt3", "Basalt3/init.lua")
    local frame = basalt.createFrame()

    local list = frame:addList({ width = 14, height = 4 })
    local changes, selects = 0, 0
    list:onChange(function(_, index, item)
        changes = changes + 1
        assert(index == false or item == list.items[index])
    end)
    list:onSelect(function(_, index, item)
        selects = selects + 1
        assert(item == list.items[index])
    end)

    list:setItems({ "One", { text = "Two", fg = colors.yellow }, "Three" })
    assert(list:getItemCount() == 3 and tostring(list:getItem(2)) == "Two")
    assert(list:getItems()[2].fg == colors.yellow)

    local four = list:addItem("Four")
    assert(tostring(four) == "Four" and four:getParent() == list)
    four:setText("Fourth")
    assert(tostring(list:getItem(4)) == "Fourth")

    list:selectItem(2)
    assert(changes == 1 and selects == 0)
    assert(list:getSelectedIndex() == 2 and list:getSelectedItem() == list.items[2])
    assert(list.items[2]:isSelected() and list.selected == 2)
    list:activateItem(2)
    assert(changes == 1 and selects == 1)

    local selected = list:getSelectedItem()
    selected:moveToBottom()
    assert(list:getSelectedItem() == selected and list:getSelectedIndex() == 4)
    selected:moveToTop()
    assert(list:getSelectedIndex() == 1)
    selected:remove()
    assert(list:getSelectedItem() == nil and list:getItemCount() == 3)

    list:setMultiSelection(true):clearItemSelection(false)
    list:selectItem(1):selectItem(3)
    local indices = list:getSelection()
    assert(#indices == 2 and indices[1] == 1 and indices[2] == 3)
    list.items[1].selected = false
    assert(not list.items[1]:isSelected() and list.items[3]:isSelected())

    list:clear()
    local first = list:addItem("A")
    local second = first:addItem("B")
    assert(list:getItemCount() == 2 and tostring(second) == "B")

    local dropdown = frame:addDropdown():setItems({ "Red", "Green" })
    local menu = frame:addMenu():setItems({ "File", "Help" })
    local context = frame:addContextMenu():setItems({ "Copy", "Paste" })
    local combo = frame:addComboBox():setItems({ "Apple", "Pear" })
    for _, element in ipairs({ dropdown, menu, context, combo }) do
        assert(element:getItemCount() == 2)
        assert(type(element.getSelectedItem) == "function")
        assert(type(element.clearItemSelection) == "function")
    end

    local selectionChanges = 0
    combo:onSelectionChange(function(_, index, item)
        selectionChanges = selectionChanges + 1
        assert(index == 2 and tostring(item) == "Pear")
    end)
    combo:selectDisplayed(2)
    assert(combo.text == "Pear" and combo:getSelectedIndex() == 2)
    assert(selectionChanges == 1)

    local generic = frame:addCollection()
    local entry = generic:addItem({ text = "Generic", selected = true })
    assert(generic:getSelectedItem() == entry and entry.selected)
    generic:setSelectionColor(colors.black, colors.white)
    local fg, bg = generic:getSelectionColor()
    assert(fg == colors.black and bg == colors.white)
    generic:setSelectedForeground(colors.red):setSelectedBackground(colors.blue)
    assert(generic.selectionForeground == colors.red)
    assert(generic.selectionBackground == colors.blue)
end)

local file = assert(fs.open("/basalt3_collection_result.txt", "w"))
file.writeLine(ok and "PASS" or ("FAIL: " .. tostring(err)))
file.close()
os.shutdown()
