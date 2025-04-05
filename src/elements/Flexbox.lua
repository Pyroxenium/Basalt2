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
    local elements = self.get("children")
    local sortedElements = {}
    if not(wrap)then
      local index = 1
      local lineSize = 1
      local lineOffset = 1
      for _,v in pairs(elements)do
          if(sortedElements[index]==nil)then sortedElements[index]={offset=1} end

          local childHeight = direction == "row" and v.get("height") or v.get("width")
          if childHeight > lineSize then
              lineSize = childHeight
          end
          if(v == lineBreakElement)then
              lineOffset = lineOffset + lineSize + spacing
              lineSize = 1
              index = index + 1
              sortedElements[index] = {offset=lineOffset}
          else
              table.insert(sortedElements[index], v)
          end
      end
    elseif(wrap)then
      local lineSize = 1
      local lineOffset = 1

      local maxSize = direction == "row" and self.get("width") or self.get("height")
      local usedSize = 0
      local index = 1

      for _,v in pairs(elements) do
          if(sortedElements[index]==nil) then sortedElements[index]={offset=1} end

          if v:getType() == "lineBreak" then
              lineOffset = lineOffset + lineSize + spacing
              usedSize = 0
              lineSize = 1
              index = index + 1
              sortedElements[index] = {offset=lineOffset}
          else
              local objSize = direction == "row" and v.get("width") or v.get("height")
              if(objSize+usedSize<=maxSize) then
                  table.insert(sortedElements[index], v)
                  usedSize = usedSize + objSize + spacing
              else
                  lineOffset = lineOffset + lineSize + spacing
                  lineSize = direction == "row" and v.get("height") or v.get("width")
                  index = index + 1
                  usedSize = objSize + spacing
                  sortedElements[index] = {offset=lineOffset, v}
              end

              local childHeight = direction == "row" and v.get("height") or v.get("width")
              if childHeight > lineSize then
                  lineSize = childHeight
              end
          end
      end
  end
    return sortedElements
end

local function calculateRow(self, children, spacing, justifyContent)
    local containerWidth = self.get("width")

    local usedSpace = spacing * (#children - 1)
    local totalFlexGrow = 0

    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            usedSpace = usedSpace + child.get("width")
            totalFlexGrow = totalFlexGrow + child.get("flexGrow")
        end
    end

    local remainingSpace = containerWidth - usedSpace
    local extraSpacePerUnit = totalFlexGrow > 0 and (remainingSpace / totalFlexGrow) or 0
    local distributedSpace = 0

    local currentX = 1
    for i, child in ipairs(children) do
        if child ~= lineBreakElement then
            local childWidth = child.get("width")

            if child.get("flexGrow") > 0 then

                if i == #children then
                    local extraSpace = remainingSpace - distributedSpace
                    childWidth = childWidth + extraSpace
                else
                    local extraSpace = math.floor(extraSpacePerUnit * child.get("flexGrow"))
                    childWidth = childWidth + extraSpace
                    distributedSpace = distributedSpace + extraSpace
                end
            end

            child.set("x", currentX)
            child.set("y", children.offset or 1)
            child.set("width", childWidth)
            currentX = currentX + childWidth + spacing
        end
    end

    if justifyContent == "flex-end" then
        local offset = containerWidth - (currentX - spacing - 1)
        for _, child in ipairs(children) do
            child.set("x", child.get("x") + offset)
        end
    elseif justifyContent == "flex-center" or justifyContent == "center" then -- Akzeptiere beide Formate
        local offset = math.floor((containerWidth - (currentX - spacing - 1)) / 2)
        for _, child in ipairs(children) do
            child.set("x", child.get("x") + offset)
        end
    end
end

local function calculateColumn(self, children, spacing, justifyContent)
    local containerHeight = self.get("height")

    local usedSpace = spacing * (#children - 1)
    local totalFlexGrow = 0

    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            usedSpace = usedSpace + child.get("height")
            totalFlexGrow = totalFlexGrow + child.get("flexGrow")
        end
    end

    local remainingSpace = containerHeight - usedSpace
    local extraSpacePerUnit = totalFlexGrow > 0 and (remainingSpace / totalFlexGrow) or 0
    local distributedSpace = 0

    local currentY = 1
    for i, child in ipairs(children) do
        if child ~= lineBreakElement then
            local childHeight = child.get("height")

            if child.get("flexGrow") > 0 then

                if i == #children then
                    local extraSpace = remainingSpace - distributedSpace
                    childHeight = childHeight + extraSpace
                else
                    local extraSpace = math.floor(extraSpacePerUnit * child.get("flexGrow"))
                    childHeight = childHeight + extraSpace
                    distributedSpace = distributedSpace + extraSpace
                end
            end

            child.set("x", children.offset or 1)
            child.set("y", currentY)
            child.set("height", childHeight)
            currentY = currentY + childHeight + spacing
        end
    end

    if justifyContent == "flex-end" then
        local offset = containerHeight - (currentY - spacing - 1)
        for _, child in ipairs(children) do
            child.set("y", child.get("y") + offset)
        end
    elseif justifyContent == "flex-center" or justifyContent == "center" then -- Akzeptiere beide Formate
        local offset = math.floor((containerHeight - (currentY - spacing - 1)) / 2)
        for _, child in ipairs(children) do
            child.set("y", child.get("y") + offset)
        end
    end
end

local function updateLayout(self, direction, spacing, justifyContent, wrap)
  local elements = sortElements(self, direction, spacing, wrap)
    if direction == "row" then
        for _,v in pairs(elements)do
            calculateRow(self, v, spacing, justifyContent)
        end
    else
        for _,v in pairs(elements)do
            calculateColumn(self, v, spacing, justifyContent)
        end
    end
    self.set("flexUpdateLayout", false)
end

--- @shortDescription Creates a new Flexbox instance
--- @return Flexbox object The newly created Flexbox instance
--- @private
function Flexbox.new()
    local self = setmetatable({}, Flexbox):__init()
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