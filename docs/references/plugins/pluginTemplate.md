-- Will temporary exist so that we don't lose track of how the plugin system works

local VisualElement = {hooks={init={}}}

-- Called on Class level to define properties and setup before instance is created
function VisualElement.setup(element)
    element.defineProperty(element, "testProp", {default = 5, type = "number"})
end

-- Hooks into existing methods (you can also use init.pre or init.post)
function VisualElement.hooks.init(self)
    --self.basalt.LOGGER.debug("VisualElement initialized")
end

-- Adds a new method to the class
function VisualElement:testFunc()
    --self.basalt.LOGGER.debug("Hello World", self.get("testProp"))
end

return {
    VisualElement = VisualElement
}

