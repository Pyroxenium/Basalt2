-- TabControl: header row of tab titles, one content container per tab.
-- addTab(title) returns the tab's container; fires "change" on switch.

local require = ...
local class = require("core/class")
local Container = require("core/container")
local Frame = require("elements/Frame")

---@alias TabControlSpan [number, number, string]

---@class TabControlEntry
---@field title string Header title
---@field frame Frame Content container

---@class TabControl : Container
---@field public active integer Active tab index, or zero when empty
---@field public headerBackground number Inactive header background
---@field public activeBackground number Active header background
---@field public activeForeground number Active header foreground
---@field private _tabs TabControlEntry[] Registered tabs
local TabControl = class.create("TabControl", Container)

--- Index of the active tab; switching updates the tab containers' visibility
class.property(TabControl, "active", 0, {
    onChange = function(self)
        local tabs = rawget(self, "_tabs")
        if not tabs then return end
        local active = self.active
        for i = 1, #tabs do
            tabs[i].frame.visible = (i == active)
        end
    end,
})
class.property(TabControl, "headerBackground", colors.gray) -- inactive header row
class.property(TabControl, "activeBackground", colors.blue) -- active tab title
--- Text color of the active tab title
class.property(TabControl, "activeForeground", colors.white)
--- Background color (false = transparent)
class.property(TabControl, "background", colors.black)
--- Width in terminal cells
class.property(TabControl, "width", 24)
--- Height in terminal cells
class.property(TabControl, "height", 10)

--- Fired after a tab switch with (index, title)
class.event(TabControl, "change")

--- Returns {x1, x2, label} for every tab title, in local coordinates.
---@param self TabControl
---@return TabControlSpan[] spans
local function spans(self)
    local out = {}
    local x = 1
    for i, tab in ipairs(rawget(self, "_tabs")) do
        local label = " " .. tab.title .. " "
        out[i] = { x, x + #label - 1, label }
        x = x + #label
    end
    return out
end

--- Initializes per-instance state and input handlers.
function TabControl:setup()
    Container.setup(self)
    rawset(self, "_tabs", {})

    self:on("click", function(s, _, x, y)
        if y ~= 1 then return end
        for i, span in ipairs(spans(s)) do
            if x >= span[1] and x <= span[2] then
                s:setActiveTab(i)
                return
            end
        end
    end)
end

--- Adds a tab and returns its content container (fills the area below the
--- header). The first tab becomes active automatically.
---@param title string The tab title shown in the header
---@return Frame tab The tab's content container
---@usage local settings = tc:addTab("Settings")
function TabControl:addTab(title)
    local tab = Frame.new({
        x = 1, y = 2,
        width = function(s)
            local p = rawget(s, "parent")
            return p and p.width or 1
        end,
        height = function(s)
            local p = rawget(s, "parent")
            return p and math.max(1, p.height - 1) or 1
        end,
        background = false,
        visible = false,
    })
    self:addChild(tab)
    local tabs = rawget(self, "_tabs")
    tabs[#tabs + 1] = { title = tostring(title), frame = tab }
    if self.active == 0 then
        self.active = #tabs
    end
    self:markDirty()
    return tab
end

--- Switches to a tab and fires the change event.
---@param index integer The tab index
---@param emit? boolean false suppresses the change event
---@return self
function TabControl:setActiveTab(index, emit)
    local tabs = rawget(self, "_tabs")
    if not tabs[index] or self.active == index then return self end
    self.active = index
    if emit ~= false then
        self:fire("change", index, tabs[index].title)
    end
    return self
end

--- Returns a tab's content container.
---@param index integer The tab index
---@return Frame|nil tab The tab container, or nil
function TabControl:getTab(index)
    local tab = rawget(self, "_tabs")[index]
    return tab and tab.frame or nil
end

--- Returns the number of registered tabs.
---@return integer count
function TabControl:getTabCount()
    return #rawget(self, "_tabs")
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function TabControl:handleKey(event, a, b)
    if event == "key" then
        local count = #rawget(self, "_tabs")
        if count > 0 then
            if a == keys.left then
                self:setActiveTab(math.max(1, self.active - 1))
            elseif a == keys.right then
                self:setActiveTab(math.min(count, self.active + 1))
            end
        end
    end
    Container.handleKey(self, event, a, b)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function TabControl:render(buf)
    Container.render(self, buf)
    -- header goes last so it always sits on top
    buf:fill(1, 1, self.width, 1, " ", self.foreground, self.headerBackground)
    local active = self.active
    for i, span in ipairs(spans(self)) do
        if i == active then
            buf:blit(span[1], 1, span[3],
                self.activeForeground, self.activeBackground)
        else
            buf:blit(span[1], 1, span[3],
                self.foreground, self.headerBackground)
        end
    end
end

return TabControl
