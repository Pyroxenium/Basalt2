local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Flex = require("elements/Flex")

---@class Row : Flex
local Row = class.create("Row", Flex)
--- Main axis of this container
class.property(Row, "direction", "row")
--- Width in terminal cells
class.property(Row, "width", layout.fill())
--- Height in terminal cells
class.property(Row, "height", layout.auto())

return Row
