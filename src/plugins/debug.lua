local log = require("log")
local tHex = require("libraries/colorHex")

local maxLines = 10
local isVisible = false

local DEBUG_LEVELS = {
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4
}

local function createDebugger(element)
    local elementInfo = {
        renderCount = 0,
        eventCount = {},
        lastRender = os.epoch("utc"),
        properties = {},
        children = {}
    }

    return {
        trackProperty = function(name, value)
            elementInfo.properties[name] = value
        end,

        trackRender = function()
            elementInfo.renderCount = elementInfo.renderCount + 1
            elementInfo.lastRender = os.epoch("utc")
        end,

        trackEvent = function(event)
            elementInfo.eventCount[event] = (elementInfo.eventCount[event] or 0) + 1
        end,

        dump = function()
            return {
                type = element.get("type"),
                id = element.get("id"),
                stats = elementInfo
            }
        end
    }
end

--- No Description
--- @class BaseElement
local BaseElement = {}

--- Enables debugging for this element
--- @shortDescription Enables debugging for this element
--- @param self BaseElement The element to debug
--- @param level number The debug level
function BaseElement.debug(self, level)
    self._debugger = createDebugger(self)
    self._debugLevel = level or DEBUG_LEVELS.INFO
    return self
end

--- Dumps debug information for this element
--- @shortDescription Dumps debug information
--- @param self BaseElement The element to dump debug info for
function BaseElement.dumpDebug(self)
    if not self._debugger then return end
    return self._debugger.dump()
end

---@class BaseFrame
local BaseFrame = {}

--- Shows the debug log frame
--- @shortDescription Shows the debug log frame
--- @param self BaseFrame The frame to show debug log in
function BaseFrame.openConsole(self)
    if not self._debugFrame then
        local width = self.get("width")
        local height = self.get("height")
        self._debugFrame = self:addFrame("basaltDebugLog")
            :setWidth(width)
            :setHeight(height)
            :listenEvent("mouse_scroll", true)

        self._debugFrame:addButton("basaltDebugLogClose")
        :setWidth(9)
        :setHeight(1)
        :setX(width - 8)
        :setY(height)
        :setText("Close")
        :onClick(function()
            self:closeConsole()
        end)

        self._debugFrame._scrollOffset = 0
        self._debugFrame._processedLogs = {}

        local function wrapText(text, width)
            local lines = {}
            while #text > 0 do
                local line = text:sub(1, width)
                table.insert(lines, line)
                text = text:sub(width + 1)
            end
            return lines
        end

        local function processLogs()
            local processed = {}
            local width = self._debugFrame.get("width")

            for _, entry in ipairs(log._logs) do
                local lines = wrapText(entry.message, width)
                for _, line in ipairs(lines) do
                    table.insert(processed, {
                        text = line,
                        level = entry.level
                    })
                end
            end
            return processed
        end

        local totalLines = #processLogs() - self.get("height")
        self._scrollOffset = totalLines

        local originalRender = self._debugFrame.render
        self._debugFrame.render = function(frame)
            originalRender(frame)
            frame._processedLogs = processLogs()

            local height = frame.get("height")-2
            local totalLines = #frame._processedLogs
            local maxScroll = math.max(0, totalLines - height)
            frame._scrollOffset = math.min(frame._scrollOffset, maxScroll)

            for i = 1, height-2 do
                local logIndex = i + frame._scrollOffset
                local entry = frame._processedLogs[logIndex]

                if entry then
                    local color = entry.level == log.LEVEL.ERROR and colors.red
                        or entry.level == log.LEVEL.WARN and colors.yellow
                        or entry.level == log.LEVEL.DEBUG and colors.lightGray
                        or colors.white

                    frame:textFg(2, i, entry.text, color)
                end
            end
        end

        local baseDispatchEvent = self._debugFrame.dispatchEvent
        self._debugFrame.dispatchEvent = function(self, event, direction, ...)
            if(event == "mouse_scroll") then
                self._scrollOffset = math.max(0, self._scrollOffset + direction)
                self:updateRender()
                return true
            else
                return baseDispatchEvent(self, event, direction, ...)
            end
        end
    end
    self._debugFrame.set("width", self.get("width"))
    self._debugFrame.set("height", self.get("height"))
    self._debugFrame.set("visible", true)
    return self
end

--- Hides the debug log frame
--- @shortDescription Hides the debug log frame
--- @param self BaseFrame The frame to hide debug log for
function BaseFrame.closeConsole(self)
    if self._debugFrame then
        self._debugFrame.set("visible", false)
    end
    return self
end

--- Toggles the debug log frame
--- @shortDescription Toggles the debug log frame
--- @param self BaseFrame The frame to toggle debug log for
function BaseFrame.toggleConsole(self)
    if self._debugFrame and self._debugFrame:getVisible() then
        self:closeConsole()
    else
        self:openConsole()
    end
    return self
end

---@class Container
local Container = {}

--- Enables debugging for this container and all its children
--- @shortDescription Debug container and children
--- @param self Container The container to debug
--- @param level number The debug level
function Container.debugChildren(self, level)
    self:debug(level)
    for _, child in pairs(self.get("children")) do
        if child.debug then
            child:debug(level)
        end
    end
    return self
end

return {
    BaseElement = BaseElement,
    Container = Container,
    BaseFrame = BaseFrame,
}
