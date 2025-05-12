local registeredAnimations = {}
local easings = {
    linear = function(progress)
        return progress
    end,

    easeInQuad = function(progress)
        return progress * progress
    end,

    easeOutQuad = function(progress)
        return 1 - (1 - progress) * (1 - progress)
    end,

    easeInOutQuad = function(progress)
        if progress < 0.5 then
            return 2 * progress * progress
        end
        return 1 - (-2 * progress + 2)^2 / 2
    end
}

---@splitClass

--- This is the AnimationInstance class. It represents a single animation instance
---@class AnimationInstance
---@field element VisualElement The element being animated
---@field type string The type of animation
---@field args table The animation arguments
---@field duration number The duration in seconds
---@field startTime number The animation start time
---@field isPaused boolean Whether the animation is paused
---@field handlers table The animation handlers
---@field easing string The easing function name
local AnimationInstance = {}
AnimationInstance.__index = AnimationInstance

--- Creates a new AnimationInstance
--- @shortDescription Creates a new animation instance
--- @param element VisualElement The element to animate
--- @param animType string The type of animation
--- @param args table The animation arguments
--- @param duration number Duration in seconds
--- @param easing string The easing function name
--- @return AnimationInstance The new animation instance
function AnimationInstance.new(element, animType, args, duration, easing)
    local self = setmetatable({}, AnimationInstance)
    self.element = element
    self.type = animType
    self.args = args
    self.duration = duration or 1
    self.startTime = 0
    self.isPaused = false
    self.handlers = registeredAnimations[animType]
    self.easing = easing
    return self
end

--- Starts the animation
--- @shortDescription Starts the animation
--- @return AnimationInstance self The animation instance
function AnimationInstance:start()
    self.startTime = os.epoch("local") / 1000
    if self.handlers.start then
        self.handlers.start(self)
    end
    return self
end

--- Updates the animation
--- @shortDescription Updates the animation
--- @param elapsed number The elapsed time in seconds
--- @return boolean Whether the animation is finished
function AnimationInstance:update(elapsed)
    local rawProgress = math.min(1, elapsed / self.duration)
    local progress = easings[self.easing](rawProgress)
    return self.handlers.update(self, progress)
end

--- Gets called when the animation is completed
--- @shortDescription Called when the animation is completed
function AnimationInstance:complete()
    if self.handlers.complete then
        self.handlers.complete(self)
    end
end

--- This is the animation plugin. It provides a animation system for visual elements
--- with support for sequences, easing functions, and multiple animation types.
---@class Animation
local Animation = {}
Animation.__index = Animation

--- Registers a new animation type
--- @shortDescription Registers a custom animation type
--- @param name string The name of the animation
--- @param handlers table Table containing start, update and complete handlers
--- @usage Animation.registerAnimation("fade", {start=function(anim) end, update=function(anim,progress) end})
function Animation.registerAnimation(name, handlers)
    registeredAnimations[name] = handlers

    Animation[name] = function(self, ...)
        local args = {...}
        local easing = "linear"
        if(type(args[#args]) == "string") then
            easing = table.remove(args, #args)
        end
        local duration = table.remove(args, #args)
        return self:addAnimation(name, args, duration, easing)
    end
end

--- Registers a new easing function
--- @shortDescription Adds a custom easing function
--- @param name string The name of the easing function
--- @param func function The easing function (takes progress 0-1, returns modified progress)
function Animation.registerEasing(name, func)
    easings[name] = func
end

--- Creates a new Animation
--- @shortDescription Creates a new animation
--- @param element VisualElement The element to animate
--- @return Animation The new animation
function Animation.new(element)
    local self = {}
    self.element = element
    self.sequences = {{}}
    self.sequenceCallbacks = {}
    self.currentSequence = 1
    self.timer = nil
    setmetatable(self, Animation)
    return self
end

--- Creates a new sequence
--- @shortDescription Creates a new sequence
--- @return Animation self The animation instance
function Animation:sequence()
    table.insert(self.sequences, {})
    self.currentSequence = #self.sequences
    self.sequenceCallbacks[self.currentSequence] = {
        start = nil,
        update = nil,
        complete = nil
    }
    return self
end

--- Registers a callback for the start event
--- @shortDescription Registers a callback for the start event
--- @param callback function The callback function to register
function Animation:onStart(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].start = callback
    return self
end

--- Registers a callback for the update event
--- @shortDescription Registers a callback for the update event
--- @param callback function The callback function to register
--- @return Animation self The animation instance
function Animation:onUpdate(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].update = callback
    return self
end

--- Registers a callback for the complete event
--- @shortDescription Registers a callback for the complete event
--- @param callback function The callback function to register
--- @return Animation self The animation instance
function Animation:onComplete(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].complete = callback
    return self
end

--- Adds a new animation to the sequence
--- @shortDescription Adds a new animation to the sequence
--- @param type string The type of animation
--- @param args table The animation arguments
--- @param duration number The duration in seconds
--- @param easing string The easing function name
function Animation:addAnimation(type, args, duration, easing)
    local anim = AnimationInstance.new(self.element, type, args, duration, easing)
    table.insert(self.sequences[self.currentSequence], anim)
    return self
end

--- Starts the animation
--- @shortDescription Starts the animation
--- @return Animation self The animation instance
function Animation:start()
    self.currentSequence = 1
    self.timer = nil
    if(self.sequenceCallbacks[self.currentSequence])then
        if(self.sequenceCallbacks[self.currentSequence].start) then
            self.sequenceCallbacks[self.currentSequence].start(self.element)
        end
    end
    if #self.sequences[self.currentSequence] > 0 then
        self.timer = os.startTimer(0.05)
        for _, anim in ipairs(self.sequences[self.currentSequence]) do
            anim:start()
        end
    end
    return self
end

--- The event handler for the animation (listens to timer events)
--- @shortDescription The event handler for the animation
--- @param event string The event type
--- @param timerId number The timer ID
function Animation:event(event, timerId)
    if event == "timer" and timerId == self.timer then
        local currentTime = os.epoch("local") / 1000
        local sequenceFinished = true
        local remaining = {}
        local callbacks = self.sequenceCallbacks[self.currentSequence]

        for _, anim in ipairs(self.sequences[self.currentSequence]) do
            local elapsed = currentTime - anim.startTime
            local progress = elapsed / anim.duration
            local finished = anim:update(elapsed)

            if callbacks and callbacks.update then
                callbacks.update(self.element, progress)
            end

            if not finished then
                table.insert(remaining, anim)
                sequenceFinished = false
            else
                anim:complete()
            end
        end

        if sequenceFinished then
            if callbacks and callbacks.complete then
                callbacks.complete(self.element)
            end

            if self.currentSequence < #self.sequences then
                self.currentSequence = self.currentSequence + 1
                remaining = {}

                local nextCallbacks = self.sequenceCallbacks[self.currentSequence]
                if nextCallbacks and nextCallbacks.start then
                    nextCallbacks.start(self.element)
                end

                for _, anim in ipairs(self.sequences[self.currentSequence]) do
                    anim:start()
                    table.insert(remaining, anim)
                end
            end
        end

        if #remaining > 0 then
            self.timer = os.startTimer(0.05)
        end
        return true
    end
end

Animation.registerAnimation("move", {
    start = function(anim)
        anim.startX = anim.element.get("x")
        anim.startY = anim.element.get("y")
    end,

    update = function(anim, progress)
        local x = anim.startX + (anim.args[1] - anim.startX) * progress
        local y = anim.startY + (anim.args[2] - anim.startY) * progress
        anim.element.set("x", math.floor(x))
        anim.element.set("y", math.floor(y))
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set("x", anim.args[1])
        anim.element.set("y", anim.args[2])
    end
})

Animation.registerAnimation("resize", {
    start = function(anim)
        anim.startW = anim.element.get("width")
        anim.startH = anim.element.get("height")
    end,

    update = function(anim, progress)
        local w = anim.startW + (anim.args[1] - anim.startW) * progress
        local h = anim.startH + (anim.args[2] - anim.startH) * progress
        anim.element.set("width", math.floor(w))
        anim.element.set("height", math.floor(h))
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set("width", anim.args[1])
        anim.element.set("height", anim.args[2])
    end
})

Animation.registerAnimation("moveOffset", {
    start = function(anim)
        anim.startX = anim.element.get("offsetX")
        anim.startY = anim.element.get("offsetY")
    end,

    update = function(anim, progress)
        local x = anim.startX + (anim.args[1] - anim.startX) * progress
        local y = anim.startY + (anim.args[2] - anim.startY) * progress
        anim.element.set("offsetX", math.floor(x))
        anim.element.set("offsetY", math.floor(y))
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set("offsetX", anim.args[1])
        anim.element.set("offsetY", anim.args[2])
    end
})

Animation.registerAnimation("number", {
    start = function(anim)
        anim.startValue = anim.element.get(anim.args[1])
        anim.targetValue = anim.args[2]
    end,

    update = function(anim, progress)
        local value = anim.startValue + (anim.targetValue - anim.startValue) * progress
        anim.element.set(anim.args[1], math.floor(value))
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set(anim.args[1], anim.targetValue)
    end
})

Animation.registerAnimation("entries", {
    start = function(anim)
        anim.startColor = anim.element.get(anim.args[1])
        anim.colorList = anim.args[2]
    end,

    update = function(anim, progress)
        local list = anim.colorList
        local index = math.floor(#list * progress) + 1
        if index > #list then
            index = #list
        end
        anim.element.set(anim.args[1], list[index])

    end,

    complete = function(anim)
        anim.element.set(anim.args[1], anim.colorList[#anim.colorList])
    end
})

Animation.registerAnimation("morphText", {
    start = function(anim)
        local startText = anim.element.get(anim.args[1])
        local targetText = anim.args[2]
        local maxLength = math.max(#startText, #targetText)
        local startSpace = string.rep(" ", math.floor(maxLength - #startText)/2)
        anim.startText = startSpace .. startText .. startSpace
        anim.targetText = targetText .. string.rep(" ", maxLength - #targetText)
        anim.length = maxLength
    end,

    update = function(anim, progress)
        local currentText = ""

        for i = 1, anim.length do
            local startChar = anim.startText:sub(i,i)
            local targetChar = anim.targetText:sub(i,i)

            if progress < 0.5 then
                currentText = currentText .. (math.random() > progress*2 and startChar or " ")
            else
                currentText = currentText .. (math.random() > (progress-0.5)*2 and " " or targetChar)
            end
        end

        anim.element.set(anim.args[1], currentText)
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set(anim.args[1], anim.targetText:gsub("%s+$", ""))  -- Entferne trailing spaces
    end
})

Animation.registerAnimation("typewrite", {
    start = function(anim)
        anim.targetText = anim.args[2]
        anim.element.set(anim.args[1], "")
    end,

    update = function(anim, progress)
        local length = math.floor(#anim.targetText * progress)
        anim.element.set(anim.args[1], anim.targetText:sub(1, length))
        return progress >= 1
    end
})

Animation.registerAnimation("fadeText", {
    start = function(anim)
        anim.chars = {}
        for i=1, #anim.args[2] do
            anim.chars[i] = {char = anim.args[2]:sub(i,i), visible = false}
        end
    end,

    update = function(anim, progress)
        local text = ""
        for i, charData in ipairs(anim.chars) do
            if math.random() < progress then
                charData.visible = true
            end
            text = text .. (charData.visible and charData.char or " ")
        end
        anim.element.set(anim.args[1], text)
        return progress >= 1
    end
})

Animation.registerAnimation("scrollText", {
    start = function(anim)
        anim.width = anim.element.get("width")
        anim.targetText = anim.args[2]
        anim.element.set(anim.args[1], "")
    end,

    update = function(anim, progress)
        local offset = math.floor(anim.width * (1-progress))
        local spaces = string.rep(" ", offset)
        anim.element.set(anim.args[1], spaces .. anim.targetText)
        return progress >= 1
    end
})

--- Adds additional methods for VisualElement when adding animation plugin
--- @class VisualElement
local VisualElement = {hooks={}}

---@private
function VisualElement.hooks.handleEvent(self, event, ...)
    if event == "timer" then
        local animation = self.get("animation")
        if animation then
            animation:event(event, ...)
        end
    end
end

---@private
function VisualElement.setup(element)
    element.defineProperty(element, "animation", {default = nil, type = "table"})
    element.defineEvent(element, "timer")
end

--- Creates a new Animation Object
--- @shortDescription Creates a new animation
--- @return Animation animation The new animation
function VisualElement:animate()
    local animation = Animation.new(self)
    self.set("animation", animation)
    return animation
end

return {
    VisualElement = VisualElement
}