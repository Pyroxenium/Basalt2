local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
---@configDescription A toast notification element that displays temporary messages.
---@configDefault false

--- A toast notification element that displays temporary messages with optional icons and auto-hide functionality.
--- The element is always visible but only renders content when a message is shown.
---@class Toast : VisualElement
local Toast = setmetatable({}, VisualElement)
Toast.__index = Toast

---@property title string "" The title text of the toast
Toast.defineProperty(Toast, "title", {default = "", type = "string", canTriggerRender = true})

---@property message string "" The message text of the toast
Toast.defineProperty(Toast, "message", {default = "", type = "string", canTriggerRender = true})

---@property duration number 3 Duration in seconds before the toast auto-hides
Toast.defineProperty(Toast, "duration", {default = 3, type = "number"})

---@property toastType string "default" Type of toast: default, success, error, warning, info
Toast.defineProperty(Toast, "toastType", {default = "default", type = "string", canTriggerRender = true})

---@property autoHide boolean true Whether the toast should automatically hide after duration
Toast.defineProperty(Toast, "autoHide", {default = true, type = "boolean"})

---@property active boolean false Whether the toast is currently showing a message
Toast.defineProperty(Toast, "active", {default = false, type = "boolean", canTriggerRender = true})

---@property colorMap table Map of toast types to their colors
Toast.defineProperty(Toast, "colorMap", {
    default = {
        success = colors.green,
        error = colors.red,
        warning = colors.orange,
        info = colors.lightBlue,
        default = colors.gray
    },
    type = "table"
})

Toast.defineEvent(Toast, "timer")

--- Creates a new Toast instance
--- @shortDescription Creates a new Toast instance
--- @return Toast self The newly created Toast instance
--- @private
function Toast.new()
    local self = setmetatable({}, Toast):__init()
    self.class = Toast
    self.set("width", 30)
    self.set("height", 3)
    self.set("z", 100) -- High z-index so it appears on top
    return self
end

--- Initializes a Toast instance
--- @shortDescription Initializes a Toast instance
--- @param props table Initial properties
--- @param basalt table The basalt instance
--- @return Toast self The initialized Toast instance
--- @private
function Toast:init(props, basalt)
    VisualElement.init(self, props, basalt)
    return self
end

--- Shows a toast message
--- @shortDescription Shows a toast message
--- @param titleOrMessage string The title (if message provided) or the message (if no message)
--- @param messageOrDuration? string|number The message (if string) or duration (if number)
--- @param duration? number Duration in seconds
--- @return Toast self The Toast instance
function Toast:show(titleOrMessage, messageOrDuration, duration)
    local title, message, dur
    if type(messageOrDuration) == "string" then
        title = titleOrMessage
        message = messageOrDuration
        dur = duration or self.getResolved("duration")
    elseif type(messageOrDuration) == "number" then
        title = ""
        message = titleOrMessage
        dur = messageOrDuration
    else
        title = ""
        message = titleOrMessage
        dur = self.getResolved("duration")
    end

    self.set("title", title)
    self.set("message", message)
    self.set("active", true)

    if self._hideTimerId then
        os.cancelTimer(self._hideTimerId)
        self._hideTimerId = nil
    end

    if self.getResolved("autoHide") and dur > 0 then
        self._hideTimerId = os.startTimer(dur)
    end

    return self
end

--- Hides the toast
--- @shortDescription Hides the toast
--- @return Toast self The Toast instance
function Toast:hide()
    self.set("active", false)
    self.set("title", "")
    self.set("message", "")

    if self._hideTimerId then
        os.cancelTimer(self._hideTimerId)
        self._hideTimerId = nil
    end
    return self
end

--- Shows a success toast
--- @shortDescription Shows a success toast
--- @param titleOrMessage string The title or message
--- @param messageOrDuration? string|number The message or duration
--- @param duration? number Duration in seconds
--- @return Toast self The Toast instance
function Toast:success(titleOrMessage, messageOrDuration, duration)
    self.set("toastType", "success")
    return self:show(titleOrMessage, messageOrDuration, duration)
end

--- Shows an error toast
--- @shortDescription Shows an error toast
--- @param titleOrMessage string The title or message
--- @param messageOrDuration? string|number The message or duration
--- @param duration? number Duration in seconds
--- @return Toast self The Toast instance
function Toast:error(titleOrMessage, messageOrDuration, duration)
    self.set("toastType", "error")
    return self:show(titleOrMessage, messageOrDuration, duration)
end

--- Shows a warning toast
--- @shortDescription Shows a warning toast
--- @param titleOrMessage string The title or message
--- @param messageOrDuration? string|number The message or duration
--- @param duration? number Duration in seconds
--- @return Toast self The Toast instance
function Toast:warning(titleOrMessage, messageOrDuration, duration)
    self.set("toastType", "warning")
    return self:show(titleOrMessage, messageOrDuration, duration)
end

--- Shows an info toast
--- @shortDescription Shows an info toast
--- @param titleOrMessage string The title or message
--- @param messageOrDuration? string|number The message or duration
--- @param duration? number Duration in seconds
--- @return Toast self The Toast instance
function Toast:info(titleOrMessage, messageOrDuration, duration)
    self.set("toastType", "info")
    return self:show(titleOrMessage, messageOrDuration, duration)
end

--- @shortDescription Dispatches events to the Toast instance
--- @protected
function Toast:dispatchEvent(event, ...)
    VisualElement.dispatchEvent(self, event, ...)
    if event == "timer" then
        local timerId = select(1, ...)
        if timerId == self._hideTimerId then
            self:hide()
        end
    end
end

--- Renders the toast
--- @shortDescription Renders the toast
--- @protected
function Toast:render()
    VisualElement.render(self)
    if not self.getResolved("active") then
        return
    end

    local width = self.getResolved("width")
    local height = self.getResolved("height")
    local title = self.getResolved("title")
    local message = self.getResolved("message")
    local toastType = self.getResolved("toastType")
    local colorMap = self.getResolved("colorMap")

    local typeColor = colorMap[toastType] or colorMap.default
    local fg = self.getResolved("foreground")

    local startX = 1

    local currentY = 1
    if title ~= "" then
        local titleText = title:sub(1, width - startX + 1)
        self:textFg(startX, currentY, titleText, typeColor)
        currentY = currentY + 1
    end

    if message ~= "" and currentY <= height then
        local availableWidth = width - startX + 1
        local words = {}
        for word in message:gmatch("%S+") do
            table.insert(words, word)
        end

        local line = ""
        for _, word in ipairs(words) do
            if #line + #word + 1 > availableWidth then
                if currentY <= height then
                    self:textFg(startX, currentY, line, fg)
                    currentY = currentY + 1
                    line = word
                else
                    break
                end
            else
                line = line == "" and word or line .. " " .. word
            end
        end

        if line ~= "" and currentY <= height then
            self:textFg(startX, currentY, line, fg)
        end
    end
end

return Toast
