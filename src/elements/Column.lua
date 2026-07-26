local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Flex = require("elements/Flex")

---@class Column : Flex
local Column = class.create("Column", Flex)
--- Main axis of this container
class.property(Column, "direction", "column")
--- Width in terminal cells
class.property(Column, "width", layout.fill())
--- Height in terminal cells
class.property(Column, "height", layout.auto())

return Column
