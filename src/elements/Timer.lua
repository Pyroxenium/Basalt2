local elementManager = require("elementManager")
local BaseElement = elementManager.getElement("BaseElement")
---@cofnigDescription The Timer is a non-visual element that can be used to perform actions at specific intervals.

--- The Timer is a non-visual element that can be used to perform actions at specific intervals.
---@class Timer : BaseElement
local Timer = setmetatable({}, BaseElement)
Timer.__index = Timer

---@property interval number 1 The interval in seconds at which the timer will trigger its action.
Timer.defineProperty(Timer, "interval", {default = 1, type = "number"})
---@property action function function The action to be performed when the timer triggers.
Timer.defineProperty(Timer, "action", {default = function() end, type = "function"})
---@property running boolean false Indicates whether the timer is currently running or not.
Timer.defineProperty(Timer, "running", {default = false, type = "boolean"})
---@property amount number -1 The amount of time the timer should run.
Timer.defineProperty(Timer, "amount", {default = -1, type = "number"})

Timer.defineEvent(Timer, "timer")

--- @shortDescription Creates a new Timer instance
--- @return table self The created instance
--- @private
function Timer.new()
    local self = setmetatable({}, Timer):__init()
    self.class = Timer
    return self
end

--- @shortDescription Initializes the Timer instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function Timer:init(props, basalt)
    BaseElement.init(self, props, basalt)
    self.set("type", "Timer")
end

--- Starts the timer with the specified interval.
--- @shortDescription Starts the timer
--- @param self Timer The Timer instance to start
--- @return Timer self The Timer instance
function Timer:start()
    if not self.running then
        self.running = true
        local time = self.get("interval")
        self.timerId = os.startTimer(time)
    end
    return self
end

--- Stops the timer if it is currently running.
--- @shortDescription Stops the timer
--- @param self Timer The Timer instance to stop
--- @return Timer self The Timer instance
function Timer:stop()
    if self.running then
        self.running = false
        os.cancelTimer(self.timerId)
    end
    return self
end

--- @protected
--- @shortDescription Dispatches events to the Timer instance
function Timer:dispatchEvent(event, ...)
    BaseElement.dispatchEvent(self, event, ...)
    if event == "timer" then
        local timerId = select(1, ...)
        if timerId == self.timerId then
            self.action()
            local amount = self.get("amount")
            if amount > 0 then
                self.set("amount", amount - 1)
            end
            if amount ~= 0 then
                self.timerId = os.startTimer(self.get("interval"))
            end
        end
    end
end

return Timer