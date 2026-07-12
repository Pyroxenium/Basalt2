local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Flex = require("elements/Flex")

local Column = class.create("Column", Flex)
class.property(Column, "direction", "column")
class.property(Column, "width", layout.fill())
class.property(Column, "height", layout.auto())

return Column
