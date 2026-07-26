-- Debug module: on-screen log overlay, toggled with a key (default F12).
--
--   basalt.use("debug")
--   basalt.debug("value:", x)   -- log; also dbg.log(...)
--
-- Standalone module: builds its overlay out of ordinary elements on the
-- main frame and watches for its toggle key via a scheduled coroutine.

local require = ...
local basalt = require("main")

local dbg = {}

local HEIGHT = 8
local lines = {}
local MAX_LINES = 40
local overlay, header, rowLabels
local toggleKey = keys.f12

local function refresh()
    if not overlay or not overlay.visible then return end
    local rows = HEIGHT - 1
    local offset = math.max(0, #lines - rows)
    for i = 1, rows do
        rowLabels[i].text = lines[offset + i] or ""
    end
end

local function ensureOverlay()
    if overlay then return end
    local main = basalt.getMainFrame()
    overlay = main:addFrame({
        x = 1,
        y = "{parent.height - " .. (HEIGHT - 1) .. "}",
        width = "{parent.width}",
        height = HEIGHT,
        z = 1000,
        visible = false,
        background = colors.black,
        name = "basalt_debug_overlay",
    })
    header = overlay:addLabel({
        x = 2, y = 1,
        text = "Basalt Debug",
        foreground = colors.orange,
    })
    rowLabels = {}
    for i = 1, HEIGHT - 1 do
        rowLabels[i] = overlay:addLabel({
            x = 2, y = i + 1, text = "",
            foreground = colors.lime,
        })
    end
end

--- Logs a message to the overlay (arguments are tostring-ed and joined).
--- Appends a line to the debug overlay log.
---@param ... any Values converted with tostring
function dbg.log(...)
    local parts = {}
    for i = 1, select("#", ...) do
        parts[i] = tostring((select(i, ...)))
    end
    lines[#lines + 1] = table.concat(parts, " ")
    if #lines > MAX_LINES then
        table.remove(lines, 1)
    end
    refresh()
end

--- Shows/hides the overlay (nil toggles).
--- Explicitly shows or hides the debug overlay.
---@param state boolean Visibility
function dbg.show(state)
    ensureOverlay()
    if state == nil then state = not overlay.visible end
    overlay.visible = state
    refresh()
end

--- Changes the toggle key (a keys.* constant).
--- Changes the keyboard key used to toggle the overlay.
---@param key number ComputerCraft key code
function dbg.setToggleKey(key)
    toggleKey = key
end

--- Returns the lazily created overlay frame.
---@return Frame overlay
function dbg.getOverlay()
    ensureOverlay()
    return overlay
end

--- Clears all captured debug lines.
---@return nil
function dbg.clear()
    lines = {}
    refresh()
end

ensureOverlay()

-- watch for the toggle key; scheduled coroutines receive all events
basalt.schedule(function()
    while true do
        local _, key = os.pullEvent("key")
        if key == toggleKey then
            dbg.show()
        end
    end
end)

-- convenience: basalt.debug(...)
basalt.debug = dbg.log

return dbg
