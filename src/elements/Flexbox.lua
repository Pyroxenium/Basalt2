local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
---@configDescription A flexbox container that arranges its children in a flexible layout.

--- This is the Flexbox class. It is a container that arranges its children in a flexible layout.
--- @usage local flex = main:addFlexbox({background=colors.black, width=30, height=10})
--- @usage flex:addButton():setFlexGrow(1)
--- @usage flex:addButton():setFlexGrow(1)
--- @usage flex:addButton():setFlexGrow(1)
--- The flexbox element adds the following properties to its children:
--- 
--- @usage flex:addButton():setFlexGrow(1) -- The flex-grow property defines the ability for a flex item to grow if necessary.
--- @usage flex:addButton():setFlexShrink(1) -- The flex-shrink property defines the ability for a flex item to shrink if necessary.
--- @usage flex:addButton():setFlexBasis(1) -- The flex-basis property defines the default size of an element before the remaining space is distributed.
---@class Flexbox : Container
local Flexbox = setmetatable({}, Container)
Flexbox.__index = Flexbox

---@property flexDirection string "row" The direction of the flexbox layout "row" or "column"
Flexbox.defineProperty(Flexbox, "flexDirection", {default = "row", type = "string"})
---@property flexSpacing number 1 The spacing between flex items
Flexbox.defineProperty(Flexbox, "flexSpacing", {default = 1, type = "number"})
---@property flexJustifyContent string "flex-start" The alignment of flex items along the main axis
Flexbox.defineProperty(Flexbox, "flexJustifyContent", {
    default = "flex-start",
    type = "string",
    setter = function(self, value)
        if not value:match("^flex%-") then
            value = "flex-" .. value
        end
        return value
    end
})
---@property flexAlignItems string "flex-start" The alignment of flex items along the cross axis
Flexbox.defineProperty(Flexbox, "flexAlignItems", {
    default = "flex-start",
    type = "string",
    setter = function(self, value)
        if not value:match("^flex%-") and value ~= "stretch" then
            value = "flex-" .. value
        end
        return value
    end
})
---@property flexCrossPadding number 0 The padding on both sides of the cross axis
Flexbox.defineProperty(Flexbox, "flexCrossPadding", {default = 0, type = "number"})
---@property flexWrap boolean false Whether to wrap flex items onto multiple lines
---@property flexUpdateLayout boolean false Whether to update the layout of the flexbox
Flexbox.defineProperty(Flexbox, "flexWrap", {default = false, type = "boolean"})
Flexbox.defineProperty(Flexbox, "flexUpdateLayout", {default = false, type = "boolean"})

local lineBreakElement = {
  getHeight = function(self) return 0 end,
  getWidth = function(self) return 0 end,
  getZ = function(self) return 1 end,
  getPosition = function(self) return 0, 0 end,
  getSize = function(self) return 0, 0 end,
  isType = function(self) return false end,
  getType = function(self) return "lineBreak" end,
  getName = function(self) return "lineBreak" end,
  setPosition = function(self) end,
  setParent = function(self) end,
  setSize = function(self) end,
  getFlexGrow = function(self) return 0 end,
  getFlexShrink = function(self) return 0 end,
  getFlexBasis = function(self) return 0 end,
  init = function(self) end,
  getVisible = function(self) return true end,
}

local function sortElements(self, direction, spacing, wrap)
    local sortedElements = {}
    local visibleElements = {}
    local childCount = 0
    
    -- We can't use self.get("visibleChildren") here 
    --because it would exclude elements that are obscured
    for _, elem in pairs(self.get("children")) do
        if elem.get("visible") then
            table.insert(visibleElements, elem)
            if elem ~= lineBreakElement then
                childCount = childCount + 1
            end
        end
    end
    
    
    if childCount == 0 then
        return sortedElements
    end
    
    if not wrap then
        sortedElements[1] = {offset=1}
        
        for _, elem in ipairs(visibleElements) do
            if elem == lineBreakElement then
                local nextIndex = #sortedElements + 1
                if sortedElements[nextIndex] == nil then
                    sortedElements[nextIndex] = {offset=1}
                end
            else
                table.insert(sortedElements[#sortedElements], elem)
            end
        end
    else
        local containerSize = direction == "row" and self.get("width") or self.get("height")
        
        local segments = {{}}
        local currentSegment = 1
        
        for _, elem in ipairs(visibleElements) do
            if elem == lineBreakElement then
                currentSegment = currentSegment + 1
                segments[currentSegment] = {}
            else
                table.insert(segments[currentSegment], elem)
            end
        end
        
        for segmentIndex, segment in ipairs(segments) do
            if #segment == 0 then
                sortedElements[#sortedElements + 1] = {offset=1}
            else
                local rows = {}
                local currentRow = {}
                local currentWidth = 0
                
                for _, elem in ipairs(segment) do
                    local intrinsicSize = 0
                    local currentSize = direction == "row" and elem.get("width") or elem.get("height")
                    
                    local hasIntrinsic = false
                    if direction == "row" then
                        local ok, intrinsicWidth = pcall(function() return elem.get("intrinsicWidth") end)
                        if ok and intrinsicWidth then
                            intrinsicSize = intrinsicWidth
                            hasIntrinsic = true
                        end
                    else
                        local ok, intrinsicHeight = pcall(function() return elem.get("intrinsicHeight") end)
                        if ok and intrinsicHeight then
                            intrinsicSize = intrinsicHeight
                            hasIntrinsic = true
                        end
                    end
                    
                    local elemSize = hasIntrinsic and intrinsicSize or currentSize
                    
                    local spaceNeeded = elemSize
                    
                    if #currentRow > 0 then
                        spaceNeeded = spaceNeeded + spacing
                    end
                    
                    if currentWidth + spaceNeeded <= containerSize or #currentRow == 0 then
                        table.insert(currentRow, elem)
                        currentWidth = currentWidth + spaceNeeded
                    else
                        table.insert(rows, currentRow)
                        currentRow = {elem}
                        currentWidth = elemSize
                    end
                end
                
                if #currentRow > 0 then
                    table.insert(rows, currentRow)
                end
                
                for _, row in ipairs(rows) do
                    sortedElements[#sortedElements + 1] = {offset=1}
                    for _, elem in ipairs(row) do
                        table.insert(sortedElements[#sortedElements], elem)
                    end
                end
            end
        end
    end
    
    local filteredElements = {}
    for i, rowOrColumn in ipairs(sortedElements) do
        if #rowOrColumn > 0 then
            table.insert(filteredElements, rowOrColumn)
        end
    end
    
    return filteredElements
end

local function calculateRow(self, children, spacing, justifyContent)
    -- Make a copy of children that filters out lineBreak elements
    local filteredChildren = {}
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            table.insert(filteredChildren, child)
        end
    end
    
    -- Skip processing if no children
    if #filteredChildren == 0 then
        return
    end
    
    local containerWidth = self.get("width")
    local containerHeight = self.get("height")
    local alignItems = self.get("flexAlignItems")
    local crossPadding = self.get("flexCrossPadding")
    local wrap = self.get("flexWrap")
    
    -- Safety check
    if containerWidth <= 0 then return end
    
    -- Calculate available cross axis space (considering padding)
    local availableCrossAxisSpace = containerHeight - (crossPadding * 2)
    if availableCrossAxisSpace < 1 then
        availableCrossAxisSpace = containerHeight
        crossPadding = 0
    end
    
    -- Cache local variables to reduce function calls
    local max = math.max
    local min = math.min
    local floor = math.floor
    local ceil = math.ceil
    
    -- Categorize elements and calculate their minimal widths and flexibilities
    local totalFixedWidth = 0
    local totalFlexGrow = 0
    local minWidths = {}
    local flexGrows = {}
    local flexShrinks = {}
    
    -- First pass: collect fixed widths and flex properties
    for _, child in ipairs(filteredChildren) do
        local grow = child.get("flexGrow") or 0
        local shrink = child.get("flexShrink") or 0
        local width = child.get("width")
        
        -- Track element properties
        flexGrows[child] = grow
        flexShrinks[child] = shrink
        minWidths[child] = width
        
        -- Calculate total flex grow factor
        if grow > 0 then
            totalFlexGrow = totalFlexGrow + grow
        else
            -- If not flex grow, it's a fixed element
            totalFixedWidth = totalFixedWidth + width
        end
    end
    
    -- Calculate total spacing
    local elementsCount = #filteredChildren
    local totalSpacing = (elementsCount > 1) and ((elementsCount - 1) * spacing) or 0
    
    -- Calculate available space for flex items
    local availableSpace = containerWidth - totalFixedWidth - totalSpacing
    
    -- Second pass: distribute available space to flex-grow items
    if availableSpace > 0 and totalFlexGrow > 0 then
        -- Container has extra space - distribute according to flex-grow
        for _, child in ipairs(filteredChildren) do
            local grow = flexGrows[child]
            if grow > 0 then
                -- Calculate flex basis (never less than minWidth)
                local minWidth = minWidths[child]
                local flexWidth = floor((grow / totalFlexGrow) * availableSpace)
                
                -- Set calculated width, ensure it's at least 1
                child.set("width", max(flexWidth, 1))
            end
        end
    elseif availableSpace < 0 then
        -- Container doesn't have enough space - check for shrinkable items
        local totalFlexShrink = 0
        local shrinkableItems = {}
        
        -- Find shrinkable items
        for _, child in ipairs(filteredChildren) do
            local shrink = flexShrinks[child]
            if shrink > 0 then
                totalFlexShrink = totalFlexShrink + shrink
                table.insert(shrinkableItems, child)
            end
        end
        
        -- If we have shrinkable items, shrink them proportionally
        if totalFlexShrink > 0 and #shrinkableItems > 0 then
            local excessWidth = -availableSpace
            
            for _, child in ipairs(shrinkableItems) do
                local width = child.get("width")
                local shrink = flexShrinks[child]
                local proportion = shrink / totalFlexShrink
                local reduction = ceil(excessWidth * proportion)
                
                -- Ensure width doesn't go below 1
                child.set("width", max(1, width - reduction))
            end
        end
        
        -- Recalculate fixed widths after shrinking
        totalFixedWidth = 0
        for _, child in ipairs(filteredChildren) do
            totalFixedWidth = totalFixedWidth + child.get("width")
        end
        
        -- If we still have flex-grow items, ensure they have proportional space
        if totalFlexGrow > 0 then
            local growableItems = {}
            local totalGrowableInitialWidth = 0
            
            -- Find growable items
            for _, child in ipairs(filteredChildren) do
                if flexGrows[child] > 0 then
                    table.insert(growableItems, child)
                    totalGrowableInitialWidth = totalGrowableInitialWidth + child.get("width")
                end
            end
            
            -- Ensure flexGrow items get at least some width, even if space is tight
            if #growableItems > 0 and totalGrowableInitialWidth > 0 then
                -- Minimum guaranteed width for flex items (at least 20% of container)
                local minFlexSpace = max(floor(containerWidth * 0.2), #growableItems)
                
                -- Reserve space for flex items
                local reservedFlexSpace = min(minFlexSpace, containerWidth - totalSpacing)
                
                -- Distribute among flex items
                for _, child in ipairs(growableItems) do
                    local grow = flexGrows[child]
                    local proportion = grow / totalFlexGrow
                    local flexWidth = max(1, floor(reservedFlexSpace * proportion))
                    child.set("width", flexWidth)
                end
            end
        end
    end
    
    -- Step 3: Position elements (never allow overlapping)
    local currentX = 1
    
    -- Place all elements sequentially
    for _, child in ipairs(filteredChildren) do
        -- Apply X coordinate
        child.set("x", currentX)
        
        -- Apply Y coordinate (based on vertical alignment) ONLY if not in wrapped mode
        if not wrap then
            if alignItems == "stretch" then
                -- Vertical stretch to fill container, considering padding
                child.set("height", availableCrossAxisSpace)
                child.set("y", 1 + crossPadding)
            else
                local childHeight = child.get("height")
                local y = 1
                
                if alignItems == "flex-end" then
                    -- Bottom align
                    y = containerHeight - childHeight + 1
                elseif alignItems == "flex-center" or alignItems == "center" then
                    -- Center align
                    y = floor((containerHeight - childHeight) / 2) + 1
                end
                
                -- Ensure Y value is not less than 1
                child.set("y", max(1, y))
            end
        end
        
        -- Final safety check height doesn't exceed container - only for elements with flexShrink
        local bottomEdge = child.get("y") + child.get("height") - 1
        if bottomEdge > containerHeight and (child.get("flexShrink") or 0) > 0 then
            child.set("height", max(1, containerHeight - child.get("y") + 1))
        end
        
        -- Update position for next element - advance by element width + spacing
        currentX = currentX + child.get("width") + spacing
    end
    
    -- Apply justifyContent only if there's remaining space
    local lastChild = filteredChildren[#filteredChildren]
    local usedWidth = 0
    if lastChild then
        usedWidth = lastChild.get("x") + lastChild.get("width") - 1
    end
    
    local remainingSpace = containerWidth - usedWidth
    
    if remainingSpace > 0 then
        if justifyContent == "flex-end" then
            for _, child in ipairs(filteredChildren) do
                child.set("x", child.get("x") + remainingSpace)
            end
        elseif justifyContent == "flex-center" or justifyContent == "center" then
            local offset = floor(remainingSpace / 2)
            for _, child in ipairs(filteredChildren) do
                child.set("x", child.get("x") + offset)
            end
        end
    end
end

local function calculateColumn(self, children, spacing, justifyContent)
    -- Make a copy of children that filters out lineBreak elements
    local filteredChildren = {}
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            table.insert(filteredChildren, child)
        end
    end
    
    -- Skip processing if no children
    if #filteredChildren == 0 then
        return
    end
    
    local containerWidth = self.get("width")
    local containerHeight = self.get("height")
    local alignItems = self.get("flexAlignItems")
    local crossPadding = self.get("flexCrossPadding")
    local wrap = self.get("flexWrap")
    
    -- Safety check
    if containerHeight <= 0 then return end
    
    -- Calculate available cross axis space (considering padding)
    local availableCrossAxisSpace = containerWidth - (crossPadding * 2)
    if availableCrossAxisSpace < 1 then
        availableCrossAxisSpace = containerWidth
        crossPadding = 0
    end
    
    -- Cache local variables to reduce function calls
    local max = math.max
    local min = math.min
    local floor = math.floor
    local ceil = math.ceil
    
    -- Categorize elements and calculate their minimal heights and flexibilities
    local totalFixedHeight = 0
    local totalFlexGrow = 0
    local minHeights = {}
    local flexGrows = {}
    local flexShrinks = {}
    
    -- First pass: collect fixed heights and flex properties
    for _, child in ipairs(filteredChildren) do
        local grow = child.get("flexGrow") or 0
        local shrink = child.get("flexShrink") or 0
        local height = child.get("height")
        
        -- Track element properties
        flexGrows[child] = grow
        flexShrinks[child] = shrink
        minHeights[child] = height
        
        -- Calculate total flex grow factor
        if grow > 0 then
            totalFlexGrow = totalFlexGrow + grow
        else
            -- If not flex grow, it's a fixed element
            totalFixedHeight = totalFixedHeight + height
        end
    end
    
    -- Calculate total spacing
    local elementsCount = #filteredChildren
    local totalSpacing = (elementsCount > 1) and ((elementsCount - 1) * spacing) or 0
    
    -- Calculate available space for flex items
    local availableSpace = containerHeight - totalFixedHeight - totalSpacing
    
    -- Second pass: distribute available space to flex-grow items
    if availableSpace > 0 and totalFlexGrow > 0 then
        -- Container has extra space - distribute according to flex-grow
        for _, child in ipairs(filteredChildren) do
            local grow = flexGrows[child]
            if grow > 0 then
                -- Calculate flex basis (never less than minHeight)
                local minHeight = minHeights[child]
                local flexHeight = floor((grow / totalFlexGrow) * availableSpace)
                
                -- Set calculated height, ensure it's at least 1
                child.set("height", max(flexHeight, 1))
            end
        end
    elseif availableSpace < 0 then
        -- Container doesn't have enough space - check for shrinkable items
        local totalFlexShrink = 0
        local shrinkableItems = {}
        
        -- Find shrinkable items
        for _, child in ipairs(filteredChildren) do
            local shrink = flexShrinks[child]
            if shrink > 0 then
                totalFlexShrink = totalFlexShrink + shrink
                table.insert(shrinkableItems, child)
            end
        end
        
        -- If we have shrinkable items, shrink them proportionally
        if totalFlexShrink > 0 and #shrinkableItems > 0 then
            local excessHeight = -availableSpace
            
            for _, child in ipairs(shrinkableItems) do
                local height = child.get("height")
                local shrink = flexShrinks[child]
                local proportion = shrink / totalFlexShrink
                local reduction = ceil(excessHeight * proportion)
                
                -- Ensure height doesn't go below 1
                child.set("height", max(1, height - reduction))
            end
        end
        
        -- Recalculate fixed heights after shrinking
        totalFixedHeight = 0
        for _, child in ipairs(filteredChildren) do
            totalFixedHeight = totalFixedHeight + child.get("height")
        end
        
        -- If we still have flex-grow items, ensure they have proportional space
        if totalFlexGrow > 0 then
            local growableItems = {}
            local totalGrowableInitialHeight = 0
            
            -- Find growable items
            for _, child in ipairs(filteredChildren) do
                if flexGrows[child] > 0 then
                    table.insert(growableItems, child)
                    totalGrowableInitialHeight = totalGrowableInitialHeight + child.get("height")
                end
            end
            
            -- Ensure flexGrow items get at least some height, even if space is tight
            if #growableItems > 0 and totalGrowableInitialHeight > 0 then
                -- Minimum guaranteed height for flex items (at least 20% of container)
                local minFlexSpace = max(floor(containerHeight * 0.2), #growableItems)
                
                -- Reserve space for flex items
                local reservedFlexSpace = min(minFlexSpace, containerHeight - totalSpacing)
                
                -- Distribute among flex items
                for _, child in ipairs(growableItems) do
                    local grow = flexGrows[child]
                    local proportion = grow / totalFlexGrow
                    local flexHeight = max(1, floor(reservedFlexSpace * proportion))
                    child.set("height", flexHeight)
                end
            end
        end
    end
    
    -- Step 3: Position elements (never allow overlapping)
    local currentY = 1
    
    -- Place all elements sequentially
    for _, child in ipairs(filteredChildren) do
        -- Apply Y coordinate
        child.set("y", currentY)
        
        -- Apply X coordinate (based on horizontal alignment)
        if not wrap then 
            if alignItems == "stretch" then
                -- Horizontal stretch to fill container, considering padding
                child.set("width", availableCrossAxisSpace)
                child.set("x", 1 + crossPadding)
            else
                local childWidth = child.get("width")
                local x = 1
                
                if alignItems == "flex-end" then
                    -- Right align
                    x = containerWidth - childWidth + 1
                elseif alignItems == "flex-center" or alignItems == "center" then
                    -- Center align
                    x = floor((containerWidth - childWidth) / 2) + 1
                end
                
                -- Ensure X value is not less than 1
                child.set("x", max(1, x))
            end
        end
        
        -- Final safety check width doesn't exceed container - only for elements with flexShrink
        local rightEdge = child.get("x") + child.get("width") - 1
        if rightEdge > containerWidth and (child.get("flexShrink") or 0) > 0 then
            child.set("width", max(1, containerWidth - child.get("x") + 1))
        end
        
        -- Update position for next element - advance by element height + spacing
        currentY = currentY + child.get("height") + spacing
    end
    
    -- Apply justifyContent only if there's remaining space
    local lastChild = filteredChildren[#filteredChildren]
    local usedHeight = 0
    if lastChild then
        usedHeight = lastChild.get("y") + lastChild.get("height") - 1
    end
    
    local remainingSpace = containerHeight - usedHeight
    
    if remainingSpace > 0 then
        if justifyContent == "flex-end" then
            for _, child in ipairs(filteredChildren) do
                child.set("y", child.get("y") + remainingSpace)
            end
        elseif justifyContent == "flex-center" or justifyContent == "center" then
            local offset = floor(remainingSpace / 2)
            for _, child in ipairs(filteredChildren) do
                child.set("y", child.get("y") + offset)
            end
        end
    end
end

-- Optimize updateLayout function
local function updateLayout(self, direction, spacing, justifyContent, wrap)
    if self.get("width") <= 0 or self.get("height") <= 0 then
        return
    end
    
    direction = (direction == "row" or direction == "column") and direction or "row"
    
    local currentWidth, currentHeight = self.get("width"), self.get("height")
    local sizeChanged = currentWidth ~= self._lastLayoutWidth or currentHeight ~= self._lastLayoutHeight
    
    self._lastLayoutWidth = currentWidth
    self._lastLayoutHeight = currentHeight
    
    if wrap and sizeChanged and (currentWidth > self._lastLayoutWidth or currentHeight > self._lastLayoutHeight) then
        for _, child in pairs(self.get("children")) do
            if child ~= lineBreakElement and child:getVisible() and child.get("flexGrow") and child.get("flexGrow") > 0 then
                if direction == "row" then
                    local ok, value = pcall(function() return child.get("intrinsicWidth") end)
                    if ok and value then
                        child.set("width", value)
                    end
                else
                    local ok, value = pcall(function() return child.get("intrinsicHeight") end)
                    if ok and value then
                        child.set("height", value)
                    end
                end
            end
        end
    end
    
    local elements = sortElements(self, direction, spacing, wrap)
    if #elements == 0 then return end
    
    local layoutFunction = direction == "row" and calculateRow or calculateColumn
    
    if direction == "row" and wrap then
        local currentY = 1
        for i, rowOrColumn in ipairs(elements) do
            if #rowOrColumn > 0 then
                for _, element in ipairs(rowOrColumn) do
                    if element ~= lineBreakElement then
                        element.set("y", currentY)
                    end
                end
                
                layoutFunction(self, rowOrColumn, spacing, justifyContent)
                
                local rowHeight = 0
                for _, element in ipairs(rowOrColumn) do
                    if element ~= lineBreakElement then
                        rowHeight = math.max(rowHeight, element.get("height"))
                    end
                end
                
                if i < #elements then
                    currentY = currentY + rowHeight + spacing
                else
                    currentY = currentY + rowHeight
                end
            end
        end
    elseif direction == "column" and wrap then
        local currentX = 1
        for i, rowOrColumn in ipairs(elements) do
            if #rowOrColumn > 0 then
                for _, element in ipairs(rowOrColumn) do
                    if element ~= lineBreakElement then
                        element.set("x", currentX)
                    end
                end
                
                layoutFunction(self, rowOrColumn, spacing, justifyContent)
                
                local columnWidth = 0
                for _, element in ipairs(rowOrColumn) do
                    if element ~= lineBreakElement then
                        columnWidth = math.max(columnWidth, element.get("width"))
                    end
                end
                
                if i < #elements then
                    currentX = currentX + columnWidth + spacing
                else
                    currentX = currentX + columnWidth
                end
            end
        end
    else
        for _, rowOrColumn in ipairs(elements) do
            layoutFunction(self, rowOrColumn, spacing, justifyContent)
        end
    end
    self:sortChildren()
    self.set("childrenEventsSorted", false)
    self.set("flexUpdateLayout", false)
end

--- @shortDescription Creates a new Flexbox instance
--- @return Flexbox object The newly created Flexbox instance
--- @private
function Flexbox.new()
    local self = setmetatable({}, Flexbox):__init()
    self.class = Flexbox
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.blue)
    self.set("z", 10)
    
    self._lastLayoutWidth = 0
    self._lastLayoutHeight = 0
    
    self:observe("width", function() self.set("flexUpdateLayout", true) end)
    self:observe("height", function() self.set("flexUpdateLayout", true) end)
    self:observe("flexDirection", function() self.set("flexUpdateLayout", true) end)
    self:observe("flexSpacing", function() self.set("flexUpdateLayout", true) end)
    self:observe("flexWrap", function() self.set("flexUpdateLayout", true) end)
    self:observe("flexJustifyContent", function() self.set("flexUpdateLayout", true) end)
    self:observe("flexAlignItems", function() self.set("flexUpdateLayout", true) end)
    self:observe("flexCrossPadding", function() self.set("flexUpdateLayout", true) end)

    return self
end

--- @shortDescription Initializes the Flexbox instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Flexbox self The initialized instance
--- @protected
function Flexbox:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Flexbox")
    return self
end

--- Adds a child element to the flexbox
--- @shortDescription Adds a child element to the flexbox
--- @param element Element The child element to add
--- @return Flexbox self The flexbox instance
function Flexbox:addChild(element)
    Container.addChild(self, element)

    if(element~=lineBreakElement)then
        element:instanceProperty("flexGrow", {default = 0, type = "number"})
        element:instanceProperty("flexShrink", {default = 0, type = "number"})
        element:instanceProperty("flexBasis", {default = 0, type = "number"})
        element:instanceProperty("intrinsicWidth", {default = element.get("width"), type = "number"})
        element:instanceProperty("intrinsicHeight", {default = element.get("height"), type = "number"})
        
        element:observe("flexGrow", function() self.set("flexUpdateLayout", true) end)
        element:observe("flexShrink", function() self.set("flexUpdateLayout", true) end)
        
        element:observe("width", function(_, newValue, oldValue) 
            if element.get("flexGrow") == 0 then 
                element.set("intrinsicWidth", newValue) 
            end
            self.set("flexUpdateLayout", true)
        end)
        element:observe("height", function(_, newValue, oldValue) 
            if element.get("flexGrow") == 0 then 
                element.set("intrinsicHeight", newValue) 
            end
            self.set("flexUpdateLayout", true)
        end)
    end

    self.set("flexUpdateLayout", true)
    return self
end

--- @shortDescription Removes a child element from the flexbox
--- @param element Element The child element to remove
--- @return Flexbox self The flexbox instance
--- @protected
function Flexbox:removeChild(element)
  Container.removeChild(self, element)

  if(element~=lineBreakElement)then
    element.setFlexGrow = nil
    element.setFlexShrink = nil
    element.setFlexBasis = nil
    element.getFlexGrow = nil
    element.getFlexShrink = nil
    element.getFlexBasis = nil
    element.set("flexGrow", nil)
    element.set("flexShrink", nil)
    element.set("flexBasis", nil)
  end

  self.set("flexUpdateLayout", true)
  return self
end

--- Adds a new line break to the flexbox
--- @shortDescription Adds a new line break to the flexbox.
---@param self Flexbox The element itself
---@return Flexbox
function Flexbox:addLineBreak()
  self:addChild(lineBreakElement)
  return self
end

--- @shortDescription Renders the flexbox and its children
--- @protected
function Flexbox:render()
  if(self.get("flexUpdateLayout"))then
    updateLayout(self, self.get("flexDirection"), self.get("flexSpacing"), self.get("flexJustifyContent"), self.get("flexWrap"))
  end
  Container.render(self)
end

return Flexbox