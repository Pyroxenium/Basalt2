---@generic Element: Animal
---@class Animal
---@field setName fun(self: Element, name: string): Element
local Animal = {}

---@class Dog : Animal
---@field setSpeed fun(self: Dog, speed: number): Dog
local Dog = setmetatable({}, { __index = Animal })

---@generic Element: Animal
---@param self Element
---@param length string
---@return Element
function Animal:setLength(length)
    self.length = length
    return self
end

function Dog:setSpeed(speed)
    self.speed = speed
    return self
end

---@return Dog
function Dog.new()
    return setmetatable({}, { __index = Dog })
end

local dog = Dog.new()
dog:setName("Rex")
   :setSpeed(10)
