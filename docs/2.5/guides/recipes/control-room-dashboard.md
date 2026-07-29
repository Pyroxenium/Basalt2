# Building a Complete Control Room Dashboard

This end-to-end recipe combines the main Basalt 2.5 concepts in one small
application.
The result is a service dashboard with:

- persistent Overview, Services, and Settings pages;
- a sortable service table;
- reactive summary values and form bindings;
- a live chart driven by scheduled work;
- confirmation dialogs and toast feedback;
- a single data model shared by every page.

The example uses simulated service data, so it runs in the browser emulator
without peripherals. Replace the simulation with modem, HTTP, inventory, or
machine data in a real application.

## Design the Application Before the Elements

Separate four responsibilities:

| Part | Responsibility |
| --- | --- |
| Model | Stores service records and application settings |
| Derived state | Calculates values shown in several places |
| Views | Render the model and collect user input |
| Actions | Change the model, notify the user, and run background work |

The complete example stays in one file so it is easy to run. The same
boundaries make it straightforward to split into modules later.

## 1. Load Application-Wide Modules First

Themes change class defaults, and optional elements must be registered before
they are created. Load both before building the UI:

```lua
local basalt = require("basalt")

local theme = basalt.use("theme")
basalt.use("charts")

local palette = theme.applyPreset("basalt")
local frame = basalt.getMainFrame()
```

`theme.applyPreset()` returns the preset's color tokens. Reuse those tokens
for application-specific accents instead of repeating color values.

## 2. Keep Domain Data Separate

The service records are ordinary Lua tables:

```lua
local services = {
    { name = "Gateway", status = "ONLINE", load = 32 },
    { name = "Storage", status = "ONLINE", load = 48 },
    { name = "Crafter", status = "OFFLINE", load = 0 },
    { name = "Monitor", status = "ONLINE", load = 27 },
}
```

The Table needs rows, but it should not become the application's database.
Convert the domain records at the view boundary:

```lua
local function makeRows()
    local rows = {}
    for index, service in ipairs(services) do
        rows[index] = {
            service.name,
            service.status,
            service.load .. "%",
        }
    end
    return rows
end
```

This keeps business decisions readable as `service.status` and
`service.load`, rather than scattering table-column numbers through the
application.

## 3. Use Signals for Shared State

Settings and summary values appear on more than one page:

```lua
local pollingEnabled = basalt.state(true)
local refreshSeconds = basalt.state(2)
local operatorName = basalt.state("Alex")

local onlineCount = basalt.state(0)
local averageLoad = basalt.state(0)
```

A small recalculation function is the only place that derives the dashboard
summary from the service model:

```lua
local function recalculate()
    local online = 0
    local load = 0

    for _, service in ipairs(services) do
        if service.status == "ONLINE" then
            online = online + 1
            load = load + service.load
        end
    end

    onlineCount:set(online)
    averageLoad:set(online > 0 and math.floor(load / online) or 0)
end
```

Views can now depend on `onlineCount` and `averageLoad` without knowing how
they were calculated.

## 4. Build One Shell with Persistent Pages

A `TabControl` keeps every page alive while only the active page is visible:

```lua
local tabs = frame:addTabControl({
    x = 1,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
})

local overviewPage = tabs:addTab("Overview")
local servicesPage = tabs:addTab("Services")
local settingsPage = tabs:addTab("Settings")
```

This is useful for dashboards because the selected table row, input cursor,
and page-local state survive tab changes.

Keep global controls outside the TabControl. The title and Exit button stay
available on every page, while root-level Dialog and Toast elements can cover
or notify the complete application.

## 5. Render Output from State

Assign signals and computed values directly to output properties:

```lua
overviewPage:addLabel({
    text = basalt.computed(function()
        return onlineCount:get() .. "/" .. #services .. " services online"
    end),
})

overviewPage:addProgressBar({
    progress = averageLoad,
    showPercentage = true,
})
```

No click handler or refresh loop has to update these elements manually.
Changing the signals invalidates the dependent controls.

## 6. Bind Editable Controls in Both Directions

Inputs are different because users can change them. Bind their writable
property to the source signal:

```lua
local operatorInput = settingsPage:addInput()
operatorInput:bind("text", operatorName)

local intervalSlider = settingsPage:addSlider({
    min = 1,
    max = 5,
    step = 1,
})
intervalSlider:bind("value", refreshSeconds)

local pollingSwitch = settingsPage:addSwitch()
pollingSwitch:bind("checked", pollingEnabled)
```

The controls read the initial values and write user changes back. Other pages
then see those changes through their own computed properties.

## 7. Keep Model Changes in Actions

The Table's selected value is a stable data index, including after the view is
sorted. It can therefore address the corresponding record in `services`.

When a service changes, update the domain object first and then refresh the
affected cells:

```lua
service.status = "OFFLINE"
service.load = 0

serviceTable:updateCell(index, 2, service.status)
serviceTable:updateCell(index, 3, service.load .. "%")
recalculate()
```

Use a Dialog before an intentional state change and a Toast after it
completes. Add both overlays to the root Frame so the dialog is modal across
all tabs.

## 8. Schedule Background Work

Do not put a permanent loop directly in the main chunk or a click handler.
Schedule it so `sleep()` yields to Basalt's event loop:

```lua
basalt.schedule(function()
    while true do
        sleep(refreshSeconds:get())
        if pollingEnabled:get() then
            refreshMetrics()
        end
    end
end)
```

The next sleep uses the current interval. Disabling polling leaves the
coroutine alive but skips data updates, so the setting can be changed again
without starting another worker.

In a real dashboard, `refreshMetrics()` is the boundary where you would read
a peripheral, consume modem messages, or process an HTTP result.

## Complete Runnable Application

The interface is designed for the standard 51 by 19 browser computer. Try
sorting the table, toggling a selected service, changing the refresh interval,
and disabling live polling.

```lua run title="Control room dashboard"
local basalt = require("basalt")

local theme = basalt.use("theme")
basalt.use("charts")

local palette = theme.applyPreset("basalt")
local frame = basalt.getMainFrame()

-- Domain model --------------------------------------------------------------

local services = {
    { name = "Gateway", status = "ONLINE", load = 32 },
    { name = "Storage", status = "ONLINE", load = 48 },
    { name = "Crafter", status = "OFFLINE", load = 0 },
    { name = "Monitor", status = "ONLINE", load = 27 },
}

local pollingEnabled = basalt.state(true)
local refreshSeconds = basalt.state(2)
local operatorName = basalt.state("Alex")
local onlineCount = basalt.state(0)
local averageLoad = basalt.state(0)
local lastUpdate = basalt.state("Waiting for first sample")

local function makeRows()
    local rows = {}
    for index, service in ipairs(services) do
        rows[index] = {
            service.name,
            service.status,
            service.load .. "%",
        }
    end
    return rows
end

local function recalculate()
    local online = 0
    local load = 0

    for _, service in ipairs(services) do
        if service.status == "ONLINE" then
            online = online + 1
            load = load + service.load
        end
    end

    onlineCount:set(online)
    averageLoad:set(online > 0 and math.floor(load / online) or 0)
end

recalculate()

-- Application shell ---------------------------------------------------------

frame:addLabel({
    x = 2,
    y = 1,
    text = "BASALT CONTROL ROOM",
    foreground = palette.lava,
})

frame:addButton({
    x = 45,
    y = 1,
    width = 6,
    height = 1,
    text = "Exit",
    foreground = palette.bg,
    background = palette.danger,
}):onClick(function()
    basalt.stop()
end)

local tabs = frame:addTabControl({
    x = 1,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
})

local overviewPage = tabs:addTab("Overview")
local servicesPage = tabs:addTab("Services")
local settingsPage = tabs:addTab("Settings")

-- Overview page -------------------------------------------------------------

overviewPage:addLabel({
    x = 2,
    y = 2,
    text = "SYSTEM OVERVIEW",
    foreground = palette.muted,
})

overviewPage:addLabel({
    x = 2,
    y = 4,
    width = 31,
    text = basalt.computed(function()
        return onlineCount:get() .. "/" .. #services .. " services online"
    end),
})

overviewPage:addProgressBar({
    x = 2,
    y = 5,
    width = 31,
    progress = averageLoad,
    showPercentage = true,
})

local loadGraph = overviewPage:addPixelGraph({
    x = 2,
    y = 7,
    width = 31,
    height = 8,
    minValue = 0,
    maxValue = 100,
    background = palette.surface,
})
loadGraph:addSeries("load", {
    color = palette.lava,
    pointCount = 62,
})
loadGraph:addPoint("load", averageLoad:get())

overviewPage:addLabel({
    x = 36,
    y = 2,
    text = "LIVE STATUS",
    foreground = palette.muted,
})

overviewPage:addLabel({
    x = 36,
    y = 4,
    width = 14,
    text = basalt.computed(function()
        return pollingEnabled:get() and "POLLING ON" or "POLLING OFF"
    end),
    foreground = basalt.computed(function()
        return pollingEnabled:get() and palette.success or palette.warning
    end),
})

overviewPage:addLabel({
    x = 36,
    y = 6,
    width = 14,
    height = 2,
    text = operatorName:map(function(value)
        return "Operator:\n" .. (value ~= "" and value or "Unknown")
    end),
})

overviewPage:addLabel({
    x = 36,
    y = 10,
    width = 14,
    height = 3,
    text = lastUpdate,
    foreground = palette.muted,
})

overviewPage:addLabel({
    x = 2,
    y = 15,
    width = 31,
    text = "Average load history",
    foreground = palette.muted,
})

-- Services page -------------------------------------------------------------

local serviceTable = servicesPage:addTable({
    x = 2,
    y = 2,
    width = 34,
    height = 12,
    columns = {
        { name = "Service", width = 14 },
        { name = "Status", width = 10 },
        { name = "Load", width = 7 },
    },
    data = makeRows(),
    sortable = true,
})

local selectionText = basalt.state("Select a service to manage it.")

servicesPage:addLabel({
    x = 2,
    y = 15,
    width = 47,
    height = 2,
    text = selectionText,
    foreground = palette.muted,
})

servicesPage:addLabel({
    x = 38,
    y = 2,
    text = "ACTIONS",
    foreground = palette.muted,
})

local toggleButton = servicesPage:addButton({
    x = 38,
    y = 4,
    width = 12,
    height = 3,
    text = "Toggle",
})

local refreshButton = servicesPage:addButton({
    x = 38,
    y = 8,
    width = 12,
    height = 3,
    text = "Refresh",
})

serviceTable:onSelect(function(_, index)
    local service = services[index]
    selectionText:set(
        service.name .. ": " .. service.status
            .. ", load " .. service.load .. "%"
    )
end)

-- Settings page -------------------------------------------------------------

settingsPage:addLabel({
    x = 2,
    y = 2,
    text = "DASHBOARD SETTINGS",
    foreground = palette.muted,
})

settingsPage:addLabel({
    x = 2,
    y = 5,
    text = "Operator",
})

local operatorInput = settingsPage:addInput({
    x = 15,
    y = 5,
    width = 20,
    placeholder = "Operator name",
})
operatorInput:bind("text", operatorName)

settingsPage:addLabel({
    x = 2,
    y = 8,
    width = 12,
    text = refreshSeconds:map(function(value)
        return "Refresh: " .. value .. "s"
    end),
})

local intervalSlider = settingsPage:addSlider({
    x = 15,
    y = 8,
    width = 20,
    min = 1,
    max = 5,
    step = 1,
})
intervalSlider:bind("value", refreshSeconds)

settingsPage:addLabel({
    x = 2,
    y = 11,
    text = "Live polling",
})

local pollingSwitch = settingsPage:addSwitch({
    x = 15,
    y = 11,
})
pollingSwitch:bind("checked", pollingEnabled)

local saveButton = settingsPage:addButton({
    x = 15,
    y = 14,
    width = 14,
    height = 2,
    text = "Save",
    foreground = palette.bg,
    background = palette.lava,
})

settingsPage:addLabel({
    x = 37,
    y = 5,
    width = 13,
    height = 7,
    text = basalt.computed(function()
        local name = operatorName:get()
        if name == "" then name = "Unknown" end

        local mode = pollingEnabled:get() and "Live" or "Paused"
        return "PREVIEW\n\n" .. name .. "\n" .. mode .. "\nEvery "
            .. refreshSeconds:get() .. "s"
    end),
    foreground = palette.muted,
})

-- Root overlays and application actions ------------------------------------

local toast = frame:addToast({
    duration = 2,
    maxWidth = 24,
})

local dialog = frame:addDialog({
    boxWidth = 34,
})

local sample = 0
local wave = { 7, -4, 9, -6, 3, -8, 5 }

local function refreshMetrics()
    sample = sample + 1

    for index, service in ipairs(services) do
        if service.status == "ONLINE" then
            local change = wave[(sample + index - 2) % #wave + 1]
            service.load = math.max(5, math.min(95, service.load + change))
            serviceTable:updateCell(index, 3, service.load .. "%")
        end
    end

    recalculate()
    loadGraph:addPoint("load", averageLoad:get())
    lastUpdate:set("Sample #" .. sample .. "\nAverage: "
        .. averageLoad:get() .. "%")
end

toggleButton:onClick(function()
    local index = serviceTable.selected
    if not index then
        toast:warning("Select a service first")
        return
    end

    local service = services[index]
    local nextStatus = service.status == "ONLINE" and "OFFLINE" or "ONLINE"

    dialog:confirm(
        "Change service?",
        "Set " .. service.name .. " to " .. nextStatus .. "?",
        function(confirmed)
            if confirmed then
                service.status = nextStatus
                service.load = nextStatus == "ONLINE" and 20 or 0

                serviceTable:updateCell(index, 2, service.status)
                serviceTable:updateCell(index, 3, service.load .. "%")
                recalculate()

                selectionText:set(
                    service.name .. ": " .. service.status
                        .. ", load " .. service.load .. "%"
                )
                toast:success(service.name .. " is now " .. service.status)
            else
                toast:info("No changes made")
            end
            toggleButton:focus()
        end
    )
    dialog:focus()
end)

refreshButton:onClick(function()
    refreshMetrics()
    toast:info("Metrics refreshed")
end)

saveButton:onClick(function()
    local name = operatorName:get()
    if name:match("^%s*$") then
        toast:warning("Enter an operator name")
        operatorInput:focus()
        return
    end

    toast:success("Settings saved")
end)

basalt.schedule(function()
    while true do
        sleep(refreshSeconds:get())
        if pollingEnabled:get() then
            refreshMetrics()
        end
    end
end)

serviceTable:focus()
basalt.run()
```

## Why This Structure Scales

The example has deliberate dependency directions:

```text
user input / scheduled worker
            |
            v
      actions change model
            |
            v
  summary signals are recalculated
            |
            v
 computed properties redraw the views
```

Views never search other views for the current value. The Overview page does
not read labels from Settings, and the worker does not update summary labels
directly. They communicate through the model and signals.

## Splitting the Application into Files

Once the single file becomes difficult to scan, preserve the same boundaries:

```text
control-room/
|-- startup.lua
|-- app/
|   |-- model.lua
|   |-- actions.lua
|   `-- worker.lua
`-- ui/
    |-- shell.lua
    |-- overview.lua
    |-- services.lua
    `-- settings.lua
```

A practical split is:

- `model.lua` returns services and signals;
- `actions.lua` receives the model and exposes named operations;
- each page module receives its parent and the small state it needs;
- `startup.lua` loads modules, creates the shell, starts workers, and calls
  `basalt.run()`.

Avoid creating a second Basalt event loop in a page or worker module.

## Replacing the Simulation

Keep UI code unchanged and replace only `refreshMetrics()`:

```lua
local function refreshMetrics()
    local tank = peripheral.wrap("left")
    local amount = tank.getFluidAmount()

    services[1].load = math.floor(amount / tank.getCapacity() * 100)
    serviceTable:updateCell(1, 3, services[1].load .. "%")
    recalculate()
    loadGraph:addPoint("load", averageLoad:get())
end
```

Peripheral APIs differ, so validate missing peripherals and failed calls in
production. If a request can block for a long time, use events or a scheduled
worker and surface failures through persistent status plus a Toast.

## Production Checklist

Before turning a recipe into a deployed application:

- keep the domain model independent from element instances;
- make repeated operations idempotent where possible;
- validate peripherals and network responses;
- cancel or supersede obsolete scheduled tasks;
- restore focus after dialogs;
- test the smallest supported terminal and monitor size;
- keep essential status visible without relying only on color;
- run error paths as deliberately as success paths.

## Related Guides and API

- [Reactive State](../foundations/reactive-state)
- [Page Navigation](../building-interfaces/page-navigation)
- [Tabs](../building-interfaces/tabs)
- [Tables and Trees](../building-interfaces/tables-and-trees)
- [Feedback and Progress](../building-interfaces/feedback-and-progress)
- [Dialogs](../building-interfaces/dialogs)
- [Optional Modules](../modules/)
- [Debugging](../development/debugging)
- [Testing](../development/testing)
- [`TabControl`](/api/elements/TabControl)
- [`Table`](/api/elements/Table)
- [`Dialog`](/api/elements/Dialog)
- [`Toast`](/api/elements/Toast)
- [`PixelGraph`](/api/modules/PixelGraph)

## Next Steps

Continue with [Canvas](../building-interfaces/canvas) or
[Hosted Programs](../building-interfaces/hosted-programs)
to add a custom-painted surface or an embedded CC application, then use
[Multiple Roots and Monitors](../building-interfaces/multiple-roots-and-monitors)
to distribute an application across displays. Finish with
[Performance Tuning](../development/performance-tuning) to measure and reduce
the dashboard's update cost on its target hardware.
