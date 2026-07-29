# Building Interfaces with XML

This guide builds a file-backed task interface. XML owns the stable visual
tree; Lua supplies handler functions, collection data, reactive state, and
application behavior.

## Project Structure

Keep markup beside the program:

```text
startup.lua
ui/
└── main.xml
```

The program loads `ui/main.xml` relative to its current working directory.
When a program may be launched elsewhere, resolve a stable path in Lua before
calling `xml.loadFile()`.

## The XML Layout

Create `ui/main.xml`:

```xml
<!-- ui/main.xml -->
<frame
    name="app_shell"
    x="2"
    y="1"
    width="{parent.width - 2}"
    height="{parent.height}"
    background="#17191F"
>
    <label
        x="2"
        y="2"
        text="Task Console"
        foreground="#F38BA8"
    />
    <label
        name="task_count"
        x="16"
        y="2"
        text="Tasks: 0"
        foreground="#A6ADC8"
    />

    <list
        name="task_list"
        x="2"
        y="4"
        width="20"
        height="11"
        emptyText="No tasks"
        scrollbar="auto"
        onChange="showTask"
        onSelect="activateTask"
    />

    <label
        x="24"
        y="4"
        text="Task name"
        foreground="#A6ADC8"
    />
    <input
        name="task_name"
        x="24"
        y="5"
        width="20"
        placeholder="New task"
        onEnter="addTask"
    />
    <label
        x="24"
        y="7"
        text="Priority"
        foreground="#A6ADC8"
    />
    <dropdown
        name="priority"
        x="24"
        y="8"
        width="18"
        text="Choose..."
        dropHeight="4"
        onSelect="priorityChanged"
    />

    <button
        x="24"
        y="11"
        width="10"
        text="Add task"
        onClick="addTask"
    />
    <button
        x="35"
        y="11"
        width="9"
        text="Clear"
        onClick="clearName"
    />

    <label
        name="status"
        x="24"
        y="14"
        width="20"
        height="2"
        text="Ready"
        foreground="#A6ADC8"
    />

    <button
        x="35"
        y="17"
        width="9"
        text="Exit"
        onClick="exit"
    />
</frame>
```

Important details:

- `app_shell`, `task_list`, and other names create the Lua connection points;
- number, boolean, and color attributes are converted automatically;
- the shell dimensions remain reactive as the root terminal changes;
- event attributes contain scope function names, not Lua code;
- List and Dropdown data are intentionally absent because they require Lua
  tables.

## The Lua Application

Create `startup.lua`:

```lua
local basalt = require("basalt")
local xml = basalt.use("xml")

local frame = basalt.getMainFrame()
local taskCount = basalt.state(0)

local tasks = {
    {
        title = "Mine iron",
        priority = "Normal",
    },
    {
        title = "Craft tools",
        priority = "High",
    },
}

local taskList
local taskName
local priority
local status
local taskCountLabel

local function selectedPriority()
    local item = priority:getSelectedItem()
    return item and item.value or "Normal"
end

local function showSelectedTask(item)
    if not item then
        status.text = "No task selected"
        status.foreground = colors.lightGray
        return
    end

    local task = item.value
    status.text = task.title .. "\n" .. task.priority
    status.foreground = colors.lightBlue
end

local function refreshTasks(selectedIndex)
    local items = {}

    for index, task in ipairs(tasks) do
        items[index] = {
            text = task.title,
            value = task,
            selected = index == (selectedIndex or 1),
        }
    end

    taskList.items = items
    taskCount:set(#tasks)
    showSelectedTask(taskList:getSelectedItem())
end

local scope = {}

function scope.showTask(self, index, item)
    showSelectedTask(item)
end

function scope.activateTask(self, index, item)
    status.text = "Activated:\n" .. item.value.title
    status.foreground = colors.lime
end

function scope.priorityChanged(self, index, item)
    status.text = "Priority:\n" .. tostring(item)
    status.foreground = colors.lightBlue
end

function scope.clearName()
    taskName.text = ""
    status.text = "Name cleared"
    status.foreground = colors.lightGray
    taskName:focus()
end

function scope.addTask()
    local title = taskName.text:match("^%s*(.-)%s*$")

    if title == "" then
        status.text = "Enter a task name"
        status.foreground = colors.red
        taskName:focus()
        return
    end

    tasks[#tasks + 1] = {
        title = title,
        priority = selectedPriority(),
    }

    refreshTasks(#tasks)
    taskList:scrollToBottom()
    taskName.text = ""
    status.text = "Task added"
    status.foreground = colors.lime
    taskName:focus()
end

function scope.exit()
    basalt.stop()
end

local created = xml.loadFile(frame, "ui/main.xml", scope)
local appShell = assert(created[1], "XML did not create an app shell")

taskList = assert(
    appShell:find("task_list"),
    "XML is missing task_list"
)
taskName = assert(
    appShell:find("task_name"),
    "XML is missing task_name"
)
priority = assert(
    appShell:find("priority"),
    "XML is missing priority"
)
status = assert(
    appShell:find("status"),
    "XML is missing status"
)
taskCountLabel = assert(
    appShell:find("task_count"),
    "XML is missing task_count"
)

taskCountLabel.text = function()
    return "Tasks: " .. taskCount:get()
end

priority.items = {
    { text = "Low", value = "Low" },
    { text = "Normal", value = "Normal", selected = true },
    { text = "High", value = "High" },
}

refreshTasks()
taskName:focus()

basalt.run()
```

Scope functions are defined before loading because XML registers them during
the build. They may safely reference controls assigned after loading: the
handlers run later, when the user interacts.

## Separate Structure from Behavior

The example uses a clear ownership boundary:

| XML owns | Lua owns |
| --- | --- |
| element hierarchy | application data |
| fixed and reactive geometry | collection item tables |
| names | signals and computed values |
| scalar properties | validation |
| handler references | handler implementations |
| static colors and text | navigation and lifecycle |

This boundary keeps XML readable. Avoid moving business rules into long
reactive expressions merely to keep them out of Lua.

## Load Under a Dedicated Host

Loading directly under the root is simple, but a dedicated host Frame makes
replacement and cleanup easier:

```lua
local host = frame:addFrame({
    x = 1,
    y = 1,
    width = basalt.percent(1),
    height = basalt.percent(1),
    background = false,
})

local created = xml.loadFile(host, "ui/main.xml", scope)
```

All top-level XML elements become children of `host`. Destroying the host
recursively destroys the loaded interface:

```lua
host:destroy()
```

This is useful for route-specific XML views and development-time reloads.

## Work with Returned Roots

An XML file can contain one or several top-level elements:

```xml
<label name="title" x="2" y="2" text="Dashboard"/>
<button name="refresh" x="2" y="4" text="Refresh"/>
```

```lua
local elements = xml.loadFile(frame, "ui/toolbar.xml", scope)

local title = elements[1]
local refreshButton = elements[2]
```

For application screens, one top-level Frame is easier to move, hide, or
destroy:

```lua
local roots = xml.loadFile(host, "ui/settings.xml", scope)
assert(#roots == 1, "settings.xml must have exactly one root element")

local settingsPage = roots[1]
```

## Use Names as a Contract

Treat required element names like an interface between markup and Lua:

```lua
local function requireElement(root, name)
    return assert(
        root:find(name),
        "XML contract missing element '" .. name .. "'"
    )
end

local saveButton = requireElement(appShell, "save_button")
local statusLabel = requireElement(appShell, "status")
```

Keep names stable even when layout changes. Use names for controls that Lua
must read, mutate, bind, populate, or focus. Decorative labels do not need
names.

Duplicate names are legal but ambiguous: `find()` returns the first
depth-first match. Use unique names within a loaded screen.

## Bind State After Loading

XML cannot receive a Signal through an attribute. Assign it to a named
element in Lua:

```xml
<label name="connection_status" text="Connecting..."/>
```

```lua
local connected = basalt.state(false)
local connectionLabel = assert(
    frame:find("connection_status")
)

connectionLabel.text = basalt.computed(function()
    return connected:get() and "Connected" or "Offline"
end)

connectionLabel.foreground = basalt.computed(function()
    return connected:get() and colors.lime or colors.red
end)
```

This preserves normal Basalt dependency tracking and redraw behavior.

Use an XML reactive expression when the value depends only on elements or
geometry:

```xml
<input name="query" width="20"/>
<label text="{query.text}" width="{parent.width - 2}"/>
```

Use a Signal or computed value when the dependency is application state.

## Populate Complex Controls

Declare geometry and scalar presentation in XML:

```xml
<table
    name="machines"
    x="2"
    y="3"
    width="40"
    height="10"
    sortable="true"
/>
```

Assign table-valued properties from Lua:

```lua
local machines = assert(frame:find("machines"))

machines.columns = {
    { title = "Machine", width = 18 },
    { title = "Status", width = 12 },
}

machines.data = {
    { "Crusher", "Online" },
    { "Furnace", "Idle" },
}
```

The same pattern applies to List items, Tree nodes, Dropdown choices, and
state-style tables.

## Reusable XML Views

Wrap loading and root validation:

```lua
local function loadView(parent, path, scope)
    local roots = xml.loadFile(parent, path, scope)
    assert(
        #roots == 1,
        path .. " must create exactly one top-level element"
    )
    return roots[1]
end

local dashboard = loadView(host, "ui/dashboard.xml", dashboardScope)
local settings = loadView(host, "ui/settings.xml", settingsScope)

settings.visible = false
```

Different scope tables may reuse the same handler names without sharing
implementations:

```lua
local adminScope = {
    save = saveAdminSettings,
}

local userScope = {
    save = saveUserSettings,
}
```

The scope belongs to one `load()` or `loadFile()` call and is applied to all
descendant nodes built by that call.

## Development-Time Reloading

Replace a loaded root by destroying it and loading the file again:

```lua
local currentView

local function reloadView()
    if currentView then
        currentView:destroy()
    end

    currentView = loadView(host, "ui/main.xml", scope)
end
```

After reloading:

- reacquire named controls;
- repopulate table-valued properties;
- recreate signal bindings and temporary subscriptions;
- restore any application state that lived only in controls.

The XML module does not watch files or reload automatically.

## Test Markup Before Building

Parse files in a small validation program:

```lua
local basalt = require("basalt")
local xml = basalt.use("xml")

for _, path in ipairs(fs.find("ui/*.xml")) do
    local file = assert(fs.open(path, "r"))
    local source = file.readAll()
    file.close()

    local ok, result = pcall(xml.parse, source)
    assert(ok, path .. ": " .. tostring(result))
    assert(#result > 0, path .. ": no top-level elements")

    print("parsed", path, #result)
end
```

This catches malformed, mismatched, and unclosed tags without creating a
terminal interface.

### Validate handler references

Walk parsed nodes and check the scope contract:

```lua
local function validateHandlers(nodes, scope, path)
    local function visit(node)
        for attribute, handlerName in pairs(node.attrs) do
            if attribute:find("^on%u") then
                assert(
                    type(scope[handlerName]) == "function",
                    path .. ": missing handler " .. handlerName
                )
            end
        end

        for _, child in ipairs(node.children) do
            visit(child)
        end
    end

    for _, node in ipairs(nodes) do
        visit(node)
    end
end

local nodes = xml.parse(source)
validateHandlers(nodes, scope, "ui/main.xml")
```

`xml.parse()` keeps attribute values as raw strings, which is exactly what
this contract check needs.

## Smoke-Test the Built Interface

Use a hidden terminal and `basalt.update()`:

```lua
local basalt = require("basalt")
local xml = basalt.use("xml")

local width, height = term.getSize()
local testTerm = window.create(
    term.current(),
    1,
    1,
    width,
    height,
    false
)

local frame = basalt.createFrame(testTerm)
local clicked = false

local scope = {
    save = function()
        clicked = true
    end,
}

xml.load(frame, [[
    <button
        name="save_button"
        x="2"
        y="2"
        width="10"
        text="Save"
        onClick="save"
    />
]], scope)

basalt.update()

local button = assert(frame:find("save_button"))
assert(frame:findAt(2, 2) == button)

basalt.update("mouse_click", 1, 2, 2)
basalt.update("mouse_up", 1, 2, 2)

assert(clicked)
print("XML interface test passed")
```

Run each interface test in a fresh program because Basalt retains created
root Frames for the lifetime of the module.

## Debug XML Failures

Load the debug module before parsing or building:

```lua
local dbg = basalt.use("debug")

local ok, result = pcall(function()
    return xml.loadFile(host, "ui/main.xml", scope)
end)

if not ok then
    dbg.log("XML load failed", result)
    dbg.show(true)
end
```

During startup, this occurs before `basalt.run()` and therefore before
Basalt's protected event loop. Either allow the normal CC error to stop the
program or handle the expected failure explicitly.

Useful checks include:

```lua
dbg.log("roots", #created)
dbg.log("task_list", tostring(frame:find("task_list")))
dbg.log("shell width", appShell.width)
```

See [Debugging](../development/debugging) for element
bounds, focus, hit testing, and event injection.

## Common Mistakes

### Putting Lua expressions in event attributes

`onClick="save()"` looks for a scope function literally named `save()`.
Reference its key instead:

```xml
<button onClick="save"/>
```

### Using all-lowercase multi-word tags

Use `<tabControl>`, `<textBox>`, and `<comboBox>`, preserving internal
capitals.

### Encoding a Lua table as an attribute

Strings such as `items="{...}"` become reactive Lua expressions, not
declarative item tables. Populate complex controls from Lua.

### Expecting scope state in reactive expressions

Scope is only used for `on*` handler lookup. Bind state after loading.

### Forgetting to reacquire controls after reload

Destroyed elements must not be reused. Find the new named elements and rebuild
their bindings.

### Ignoring an attribute typo

Unknown properties can become unused custom fields, while a collision with an
element method can break later behavior. Compare spelling and capitalization
with the element API.

### Adding an XML declaration

The compact parser does not support `<?xml ...?>`. Start directly with the
first Basalt element or a comment.

## Related API

- [`xml` module](/api/modules/xml)
- [`Container`](/api/elements/Container)
- [`Element`](/api/elements/Element)
- [`Collection`](/api/elements/Collection)
- [`Table`](/api/elements/Table)
- [XML Interfaces](./)
- [Reactive State](../foundations/reactive-state)
- [Debugging](../development/debugging)
- [Testing](../development/testing)

## Next Steps

Split larger applications into one XML file and scope per screen, then apply
the normal navigation, state, styling, and testing guides to the created
element trees.
