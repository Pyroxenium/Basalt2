local Animation = {}
Animation.__index = Animation

local registeredAnimations = {}

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

function Animation.registerEasing(name, func)
    easings[name] = func
end

local AnimationInstance = {}
AnimationInstance.__index = AnimationInstance

function AnimationInstance.new(element, animType, args, duration, easing)
    local self = setmetatable({}, AnimationInstance)
    self.element = element
    self.type = animType
    self.args = args
    self.duration = duration
    self.startTime = 0
    self.isPaused = false
    self.handlers = registeredAnimations[animType]
    self.easing = easing
    return self
end

function AnimationInstance:start()
    self.startTime = os.epoch("local") / 1000
    if self.handlers.start then
        self.handlers.start(self)
    end
end

function AnimationInstance:update(elapsed)
    local rawProgress = math.min(1, elapsed / self.duration)
    local progress = easings[self.easing](rawProgress)
    return self.handlers.update(self, progress)
end

function AnimationInstance:complete()
    if self.handlers.complete then
        self.handlers.complete(self)
    end
end

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

function Animation:onStart(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].start = callback
    return self
end

function Animation:onUpdate(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].update = callback
    return self
end

function Animation:onComplete(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].complete = callback
    return self
end

function Animation:addAnimation(type, args, duration, easing)
    local anim = AnimationInstance.new(self.element, type, args, duration, easing)
    table.insert(self.sequences[self.currentSequence], anim)
    return self
end

function Animation:start()

    self.currentSequence = 1
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

local VisualElement = {hooks={}}

function VisualElement.hooks.dispatchEvent(self, event, ...)
    if event == "timer" then
        local animation = self.get("animation")
        if animation then
            animation:event(event, ...)
        end
    end
end

function VisualElement.setup(element)
    VisualElementBaseDispatchEvent = element.dispatchEvent
    element.defineProperty(element, "animation", {default = nil, type = "table"})
    element.listenTo(element, "timer")
end

function VisualElement:animate()
    local animation = Animation.new(self)
    self.set("animation", animation)
    return animation
end

return {
    VisualElement = VisualElement
}