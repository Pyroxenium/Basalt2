-- Generic flat collection. Primarily serves as the shared public API base;
-- concrete controls such as List decide how entries are rendered.

local require = ...
local class = require("core/class")
local Element = require("core/element")
local collection = require("core/collection")

---@class Collection : Element, CollectionMixin
local Collection = class.create("Collection", Element)
collection.install(Collection)

--- Initializes per-instance state and input handlers.
function Collection:setup()
    Element.setup(self)
    collection.setup(self)
end

return Collection
