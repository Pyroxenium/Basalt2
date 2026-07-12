-- Toast: transient notification. One element shows one toast at a time.
--
--   local toast = frame:addToast()
--   toast:success("Saved!")
--   toast:error("Oh no", 5)          -- custom duration in seconds
--   toast:show("Plain message")
--
-- Auto-positions in the parent's top-right corner unless x/y are set
-- manually. Auto-hides after `duration` seconds (0 disables). Fires "hide".

local require = ...
local class = require("core/class")
local Element = require("core/element")
local textutil = require("core/text")

local Toast = class.create("Toast", Element)

class.property(Toast, "message", "")
class.property(Toast, "duration", 3)
class.property(Toast, "maxWidth", 24)
class.property(Toast, "visible", false)
class.property(Toast, "toastColors", false) -- type -> {bg, fg}; setup default
class.property(Toast, "width", function(self)
    local w = 1
    for _, line in ipairs(rawget(self, "_lines") or { "" }) do
        w = math.max(w, #line)
    end
    return w + 2
end)
class.property(Toast, "height", function(self)
    return math.max(1, #(rawget(self, "_lines") or { "" }))
end)
class.property(Toast, "x", function(self)
    local parent = rawget(self, "parent")
    return parent and math.max(1, parent.width - self.width) or 1
end)
class.property(Toast, "y", 2)

class.event(Toast, "hide")

function Toast:setup()
    Element.setup(self)
    self.z = 900
    rawget(self, "_p").toastColors = {
        default = { bg = colors.gray, fg = colors.white },
        success = { bg = colors.green, fg = colors.white },
        error = { bg = colors.red, fg = colors.white },
        warning = { bg = colors.orange, fg = colors.black },
        info = { bg = colors.blue, fg = colors.white },
    }
    self:on("click", function(s) s:hide() end)
end

--- Shows a toast. toastType picks the color pair (default/success/error/
--- warning/info); duration overrides self.duration for this toast.
function Toast:show(message, toastType, duration)
    self.message = tostring(message)
    rawset(self, "_lines", textutil.wrap(self.message, self.maxWidth - 2))
    local palette = self.toastColors[toastType or "default"]
        or self.toastColors.default
    self.background = palette.bg
    self.foreground = palette.fg
    self.visible = true
    self:markDirty()

    duration = duration or self.duration
    local token = (rawget(self, "_showToken") or 0) + 1
    rawset(self, "_showToken", token)
    if duration and duration > 0 then
        local basalt = require("main")
        basalt.schedule(function()
            sleep(duration)
            if rawget(self, "_showToken") == token then
                self:hide()
            end
        end)
    end
    return self
end

function Toast:hide()
    if not self.visible then return self end
    self.visible = false
    self:fire("hide")
    return self
end

function Toast:success(message, duration)
    return self:show(message, "success", duration)
end

function Toast:error(message, duration)
    return self:show(message, "error", duration)
end

function Toast:warning(message, duration)
    return self:show(message, "warning", duration)
end

function Toast:info(message, duration)
    return self:show(message, "info", duration)
end

function Toast:render(buf)
    Element.render(self, buf)
    local lines = rawget(self, "_lines") or { "" }
    for i = 1, #lines do
        buf:blit(2, i, lines[i], self.foreground, self.background)
    end
end

return Toast
