local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Flex = require("elements/Flex")

local Row = class.create("Row", Flex)
class.property(Row, "direction", "row")
class.property(Row, "width", layout.fill())
class.property(Row, "height", layout.auto())

return Row
