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
    -- Pre-allocate tables to reduce dynamic expansion
    local elements = self.get("children")
    local sortedElements = {}
    local visibleElements = {}
    local childCount = 0
    
    -- First calculate the number of visible elements, pre-allocate space
    for _, elem in pairs(elements) do
        if elem ~= lineBreakElement and elem:getVisible() then
            childCount = childCount + 1
        end
    end
    
    -- Use known size to pre-allocate array
    if not wrap then
        -- No-wrap mode, all elements in one row/column
        sortedElements[1] = {offset=1}
        
        for _, elem in pairs(elements) do
            if elem == lineBreakElement then
                -- Create new line
                local nextIndex = #sortedElements + 1
                if sortedElements[nextIndex] == nil then
                    sortedElements[nextIndex] = {offset=1}
                end
            else
                table.insert(sortedElements[#sortedElements], elem)
            end
        end
    else
        -- Wrap mode, need to calculate rows/columns
        local index = 1
        local containerSize = direction == "row" and self.get("width") or self.get("height")
        local remainingSpace = containerSize
        sortedElements[index] = {offset=1}
        
        for _, elem in pairs(elements) do
            if elem == lineBreakElement then
                -- Create new line
                index = index + 1
                sortedElements[index] = {offset=1}
                remainingSpace = containerSize
            else
                local elemSize = direction == "row" and elem.get("width") or elem.get("height")
                if elemSize + spacing <= remainingSpace then
                    -- Element fits in current line
                    table.insert(sortedElements[index], elem)
                    remainingSpace = remainingSpace - elemSize - spacing
                else
                    -- Need new line
                    index = index + 1
                    sortedElements[index] = {offset=1, elem}
                    remainingSpace = containerSize - elemSize - spacing
                end
            end
        end
    end
    
    return sortedElements
end

local function calculateRow(self, children, spacing, justifyContent)
    local containerWidth = self.get("width")
    local containerHeight = self.get("height")
    local alignItems = self.get("flexAlignItems")
    local crossPadding = self.get("flexCrossPadding")
    
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
    
    -- Fixed elements
    local fixedElements = {}
    -- Flexible elements
    local flexElements = {}
    -- Total flex coefficient
    local totalFlexGrow = 0
    -- Pre-allocate capacity
    local fixedCount = 0
    local flexCount = 0
    
    -- First calculate element counts to pre-allocate space
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            local grow = child.get("flexGrow") or 0
            if grow > 0 then
                flexCount = flexCount + 1
            else
                fixedCount = fixedCount + 1
            end
        end
    end
    
    -- Pre-allocate table space
    for i = 1, fixedCount do fixedElements[i] = nil end
    
    -- Step 1: Categorize elements and collect information
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            local grow = child.get("flexGrow") or 0
            if grow > 0 then
                totalFlexGrow = totalFlexGrow + grow
                table.insert(flexElements, {element = child, grow = grow})
            else
                table.insert(fixedElements, child)
            end
        end
    end
    
    -- Step 2: Pre-processing before layout
    -- First calculate the total width needed for all fixed elements
    local fixedWidthSum = 0
    for _, element in ipairs(fixedElements) do
        fixedWidthSum = fixedWidthSum + element.get("width")
    end
    
    -- Calculate total width of gaps
    local totalElements = #fixedElements + #flexElements
    local totalGaps = totalElements > 1 and (totalElements - 1) or 0
    local gapsWidth = spacing * totalGaps
    
    -- Calculate total available space for flexible elements
    local flexAvailableSpace = max(0, containerWidth - fixedWidthSum - gapsWidth)
    
    -- Safety check: If not enough space, force compress fixed elements
    if flexAvailableSpace < 0 then
        -- Set gaps to zero
        gapsWidth = 0
        flexAvailableSpace = containerWidth - fixedWidthSum
        
        -- If still not enough, need to shrink fixed elements
        if flexAvailableSpace < 0 and #fixedElements > 0 then
            local reductionPerElement = ceil(-flexAvailableSpace / #fixedElements)
            for _, element in ipairs(fixedElements) do
                local currentWidth = element.get("width")
                local newWidth = max(1, currentWidth - reductionPerElement)
                element.set("width", newWidth)
                flexAvailableSpace = flexAvailableSpace + (currentWidth - newWidth)
                if flexAvailableSpace >= 0 then
                    break
                end
            end
        end
        
        -- If still not enough, may need to set minimum width
        flexAvailableSpace = max(0, flexAvailableSpace)
    end
    
    -- Step 3: Allocate space for flexible elements
    -- Pre-allocate table to avoid dynamic expansion
    local allocatedWidths = {}
    for i = 1, flexCount do
        allocatedWidths[flexElements[i].element] = nil
    end
    
    -- If there are flexible elements and available space
    if #flexElements > 0 and flexAvailableSpace > 0 and totalFlexGrow > 0 then
        -- Reserve some safety margin (e.g., 5% of space) to ensure no overflow due to rounding
        local safeFlexSpace = floor(flexAvailableSpace * 0.95)
        
        -- Allocate base width for each element (conservative strategy)
        for _, item in ipairs(flexElements) do
            -- Determine this element's share
            local proportion = item.grow / totalFlexGrow
            -- Determine width to allocate (floor to ensure safety)
            local extraWidth = floor(safeFlexSpace * proportion)
            -- Set final width
            allocatedWidths[item.element] = item.element.get("width") + extraWidth
        end
    end
    
    -- Step 4: Strictly validate final widths
    -- Calculate total width after allocation (including gaps)
    local finalTotalWidth = gapsWidth
    for _, element in ipairs(fixedElements) do
        finalTotalWidth = finalTotalWidth + element.get("width")
    end
    for _, item in ipairs(flexElements) do
        local width = allocatedWidths[item.element] or item.element.get("width")
        finalTotalWidth = finalTotalWidth + width
    end
    
    -- If total width exceeds container, proportionally reduce all elements
    if finalTotalWidth > containerWidth then
        local excessWidth = finalTotalWidth - containerWidth
        local reductionFactor = excessWidth / (finalTotalWidth - gapsWidth)
        
        -- First reduce flexible elements
        if #flexElements > 0 then
            for _, item in ipairs(flexElements) do
                local width = allocatedWidths[item.element] or item.element.get("width")
                local reduction = ceil(width * reductionFactor)
                allocatedWidths[item.element] = max(1, width - reduction)
            end
        end
        
        -- If still not enough, reduce fixed elements
        finalTotalWidth = gapsWidth
        for _, element in ipairs(fixedElements) do
            finalTotalWidth = finalTotalWidth + element.get("width")
        end
        for _, item in ipairs(flexElements) do
            finalTotalWidth = finalTotalWidth + (allocatedWidths[item.element] or item.element.get("width"))
        end
        
        if finalTotalWidth > containerWidth and #fixedElements > 0 then
            excessWidth = finalTotalWidth - containerWidth
            reductionFactor = excessWidth / (finalTotalWidth - gapsWidth)
            
            for _, element in ipairs(fixedElements) do
                local width = element.get("width")
                local reduction = ceil(width * reductionFactor)
                element.set("width", max(1, width - reduction))
            end
        end
    end
    
    -- Step 5: Apply layout
    local currentX = 1
    
    -- Place all elements
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            -- Apply X coordinate
            child.set("x", currentX)
            
            -- Apply Y coordinate (based on vertical alignment)
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
            
            -- If flexible element, apply calculated width
            if allocatedWidths[child] then
                child.set("width", allocatedWidths[child])
            end
            
            -- Final safety check (using cached math functions)
            local rightEdge = currentX + child.get("width") - 1
            if rightEdge > containerWidth then
                child.set("width", max(1, containerWidth - currentX + 1))
            end
            
            -- Final safety check height doesn't exceed container
            local bottomEdge = child.get("y") + child.get("height") - 1
            if bottomEdge > containerHeight then
                child.set("height", max(1, containerHeight - child.get("y") + 1))
            end
            
            -- Update position for next element
            currentX = currentX + child.get("width") + spacing
            
            -- Ensure won't exceed container right edge
            if currentX > containerWidth + 1 then
                currentX = containerWidth + 1
            end
        end
    end
    
    -- Apply alignment (only when remaining space is positive)
    local usedWidth = min(containerWidth, currentX - spacing - 1)
    local remainingSpace = containerWidth - usedWidth
    
    if remainingSpace > 0 then
        if justifyContent == "flex-end" then
            for _, child in ipairs(children) do
                if child ~= lineBreakElement then
                    child.set("x", child.get("x") + remainingSpace)
                end
            end
        elseif justifyContent == "flex-center" or justifyContent == "center" then
            local offset = floor(remainingSpace / 2)
            for _, child in ipairs(children) do
                if child ~= lineBreakElement then
                    child.set("x", child.get("x") + offset)
                end
            end
        end
    end
end

local function calculateColumn(self, children, spacing, justifyContent)
    local containerWidth = self.get("width")
    local containerHeight = self.get("height")
    local alignItems = self.get("flexAlignItems")
    local crossPadding = self.get("flexCrossPadding")
    
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
    
    -- Fixed elements
    local fixedElements = {}
    -- Flexible elements
    local flexElements = {}
    -- Total flex coefficient
    local totalFlexGrow = 0
    -- Pre-allocate capacity
    local fixedCount = 0
    local flexCount = 0
    
    -- First calculate element counts to pre-allocate space
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            local grow = child.get("flexGrow") or 0
            if grow > 0 then
                flexCount = flexCount + 1
            else
                fixedCount = fixedCount + 1
            end
        end
    end
    
    -- Pre-allocate table space
    for i = 1, fixedCount do fixedElements[i] = nil end
    
    -- Step 1: Categorize elements and collect information
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            local grow = child.get("flexGrow") or 0
            if grow > 0 then
                totalFlexGrow = totalFlexGrow + grow
                table.insert(flexElements, {element = child, grow = grow})
            else
                table.insert(fixedElements, child)
            end
        end
    end
    
    -- Step 2: Pre-processing before layout
    
    -- First calculate the total height needed for all fixed elements
    local fixedHeightSum = 0
    for _, element in ipairs(fixedElements) do
        fixedHeightSum = fixedHeightSum + element.get("height")
    end
    
    -- Calculate total height of gaps
    local totalElements = #fixedElements + #flexElements
    local totalGaps = totalElements > 1 and (totalElements - 1) or 0
    local gapsHeight = spacing * totalGaps
    
    -- Calculate total available space for flexible elements
    local flexAvailableSpace = max(0, containerHeight - fixedHeightSum - gapsHeight)
    
    -- Safety check: If not enough space, force compress fixed elements
    if flexAvailableSpace < 0 then
        -- Set gaps to zero
        gapsHeight = 0
        flexAvailableSpace = containerHeight - fixedHeightSum
        
        -- If still not enough, need to shrink fixed elements
        if flexAvailableSpace < 0 and #fixedElements > 0 then
            local reductionPerElement = ceil(-flexAvailableSpace / #fixedElements)
            for _, element in ipairs(fixedElements) do
                local currentHeight = element.get("height")
                local newHeight = max(1, currentHeight - reductionPerElement)
                element.set("height", newHeight)
                flexAvailableSpace = flexAvailableSpace + (currentHeight - newHeight)
                if flexAvailableSpace >= 0 then
                    break
                end
            end
        end
        
        -- If still not enough, may need to set minimum height
        flexAvailableSpace = max(0, flexAvailableSpace)
    end
    
    -- Step 3: Allocate space for flexible elements
    -- Pre-allocate table to avoid dynamic expansion
    local allocatedHeights = {}
    for i = 1, flexCount do
        allocatedHeights[flexElements[i].element] = nil
    end
    
    -- If there are flexible elements and available space
    if #flexElements > 0 and flexAvailableSpace > 0 and totalFlexGrow > 0 then
        -- Reserve some safety margin (e.g., 5% of space) to ensure no overflow due to rounding
        local safeFlexSpace = floor(flexAvailableSpace * 0.95)
        
        -- Allocate base height for each element (conservative strategy)
        for _, item in ipairs(flexElements) do
            -- Determine this element's share
            local proportion = item.grow / totalFlexGrow
            -- Determine height to allocate (floor to ensure safety)
            local extraHeight = floor(safeFlexSpace * proportion)
            -- Set final height
            allocatedHeights[item.element] = item.element.get("height") + extraHeight
        end
    end
    
    -- Step 4: Strictly validate final heights
    -- Calculate total height after allocation (including gaps)
    local finalTotalHeight = gapsHeight
    for _, element in ipairs(fixedElements) do
        finalTotalHeight = finalTotalHeight + element.get("height")
    end
    for _, item in ipairs(flexElements) do
        local height = allocatedHeights[item.element] or item.element.get("height")
        finalTotalHeight = finalTotalHeight + height
    end
    
    -- If total height exceeds container, proportionally reduce all elements
    if finalTotalHeight > containerHeight then
        local excessHeight = finalTotalHeight - containerHeight
        local reductionFactor = excessHeight / (finalTotalHeight - gapsHeight)
        
        -- First reduce flexible elements
        if #flexElements > 0 then
            for _, item in ipairs(flexElements) do
                local height = allocatedHeights[item.element] or item.element.get("height")
                local reduction = ceil(height * reductionFactor)
                allocatedHeights[item.element] = max(1, height - reduction)
            end
        end
        
        -- If still not enough, reduce fixed elements
        finalTotalHeight = gapsHeight
        for _, element in ipairs(fixedElements) do
            finalTotalHeight = finalTotalHeight + element.get("height")
        end
        for _, item in ipairs(flexElements) do
            finalTotalHeight = finalTotalHeight + (allocatedHeights[item.element] or item.element.get("height"))
        end
        
        if finalTotalHeight > containerHeight and #fixedElements > 0 then
            excessHeight = finalTotalHeight - containerHeight
            reductionFactor = excessHeight / (finalTotalHeight - gapsHeight)
            
            for _, element in ipairs(fixedElements) do
                local height = element.get("height")
                local reduction = ceil(height * reductionFactor)
                element.set("height", max(1, height - reduction))
            end
        end
    end
    
    -- Step 5: Apply layout
    local currentY = 1
    
    -- Place all elements
    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            -- Apply Y coordinate
            child.set("y", currentY)
            
            -- Apply X coordinate (based on horizontal alignment)
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
            
            -- If flexible element, apply calculated height
            if allocatedHeights[child] then
                child.set("height", allocatedHeights[child])
            end
            
            -- Final safety check (using cached math functions)
            local bottomEdge = currentY + child.get("height") - 1
            if bottomEdge > containerHeight then
                child.set("height", max(1, containerHeight - currentY + 1))
            end
            
            -- Final safety check width doesn't exceed container
            local rightEdge = child.get("x") + child.get("width") - 1
            if rightEdge > containerWidth then
                child.set("width", max(1, containerWidth - child.get("x") + 1))
            end
            
            -- Update position for next element
            currentY = currentY + child.get("height") + spacing
            
            -- Ensure won't exceed container bottom edge
            if currentY > containerHeight + 1 then
                currentY = containerHeight + 1
            end
        end
    end
    
    -- Apply alignment (only when remaining space is positive)
    local usedHeight = min(containerHeight, currentY - spacing - 1)
    local remainingSpace = containerHeight - usedHeight
    
    if remainingSpace > 0 then
        if justifyContent == "flex-end" then
            for _, child in ipairs(children) do
                if child ~= lineBreakElement then
                    child.set("y", child.get("y") + remainingSpace)
                end
            end
        elseif justifyContent == "flex-center" or justifyContent == "center" then
            local offset = floor(remainingSpace / 2)
            for _, child in ipairs(children) do
                if child ~= lineBreakElement then
                    child.set("y", child.get("y") + offset)
                end
            end
        end
    end
end

-- Optimize updateLayout function
local function updateLayout(self, direction, spacing, justifyContent, wrap)
    -- Get all elements that need layout
    local elements = sortElements(self, direction, spacing, wrap)
    
    -- Based on direction, select layout function, avoid checking every iteration
    local layoutFunction = direction == "row" and calculateRow or calculateColumn
    
    -- Apply layout calculation
    for _, rowOrColumn in pairs(elements) do
        layoutFunction(self, rowOrColumn, spacing, justifyContent)
    end
    
    -- Reset layout update flag
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
    self:observe("width", function() self.set("flexUpdateLayout", true) end)
    self:observe("height", function() self.set("flexUpdateLayout", true) end)
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