# Basalt 2 Migration Reference

Basalt 2.5 keeps the familiar element-tree style of Basalt 2, but it is a
substantial runtime rewrite rather than a drop-in library update. Small
applications may need only a few changes. Applications using plugins, the old
layout helpers, advanced animations, XML extensions, or dynamically loaded
elements need a deliberate migration.

For the shortest path through an ordinary application, begin with the
[Migration Quickstart](./migration-quickstart). This page is the detailed
lookup reference for removed or changed subsystems.

It compares the frozen
[Basalt 2 documentation](https://basalt.madefor.cc/2.0/) with the current
Basalt 2.5 source.

## Before You Replace the Library

Keep the working Basalt 2 application and its library together in a backup or
separate source-control branch. Then install 2.5 under a temporary name:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua minified basalt25.lua
```

Load that file while porting:

```lua
local basalt = require("basalt25")
```

This lets you switch between the old and new runtimes without repeatedly
overwriting `basalt.lua`.

Do not start by rewriting every setter. First make the application load, then
replace removed systems one area at a time.

## What Still Works

These common entry points remain available in 2.5:

- `require("basalt")`
- `basalt.getMainFrame()`
- container factories such as `frame:addButton()`
- property tables passed to `add<Element>({...})`
- direct property access such as `button.text = "Save"`
- generated setters and getters such as `setText()`, `setPosition()`,
  `setSize()`, and `getText()`
- element callbacks such as `onClick()`
- `basalt.schedule()`, `basalt.update()`, `basalt.stop()`, and `basalt.run()`
- `element:destroy()`

This Basalt 2 code is therefore still a valid starting point:

```lua
local basalt = require("basalt")
local main = basalt.getMainFrame()

main:addButton()
    :setText("Click me")
    :setPosition(4, 4)
    :onClick(function(self)
        self:setText("Clicked")
    end)

basalt.run()
```

The preferred 2.5 style puts initial properties together:

```lua
local basalt = require("basalt")
local main = basalt.getMainFrame()

main:addButton({
    x = 4,
    y = 4,
    text = "Click me",
}):onClick(function(self)
    self.text = "Clicked"
end)

basalt.run()
```

Both property styles are supported. Converting every generated setter to
direct assignment is optional.

## Root Frames and Monitors

`basalt.getMainFrame()` is unchanged. Explicit root creation has changed,
however.

Basalt 2 created the frame first and assigned its terminal afterward:

```lua
local monitor = peripheral.find("monitor")
local monitorFrame = basalt.createFrame()
    :setTerm(monitor)
```

Basalt 2.5 accepts the terminal as the first argument:

```lua
local monitor = peripheral.find("monitor")
local monitorFrame = basalt.createFrame(monitor)
```

Do not pass an element property table to `createFrame()`. Its first argument
must be a terminal-like object with methods such as `getSize()` and `blit()`.
Configure the returned frame afterward:

```lua
local monitorFrame = basalt.createFrame(monitor)
monitorFrame.background = colors.black
```

Monitor names are normally detected automatically. Pass one explicitly only
when detection is unavailable:

```lua
local monitorFrame = basalt.createFrame(monitor, "left")
```

## Plugins Became Optional Modules

Basalt 2 exposed plugin APIs through `basalt.getAPI(name)` and some builds
loaded plugin behavior automatically. Basalt 2.5 uses explicit modules:

```lua
local animation = basalt.use("animation")
local responsive = basalt.use("responsive")
local theme = basalt.use("theme")
local xml = basalt.use("xml")
local debug = basalt.use("debug")
```

The exact lowercase module names are:

- `animation`
- `bigfont`
- `charts`
- `debug`
- `image`
- `responsive`
- `theme`
- `xml`

`basalt.use()` caches and returns the module API. The official 2.5 source and
bundled builds contain all of these modules.

Some old elements also moved behind modules:

```lua
basalt.use("bigfont")
basalt.use("charts")
basalt.use("image")

local title = frame:addBigFont()
local graph = frame:addPixelGraph()
local logo = frame:addImage()
```

Load the module before calling its `add<Element>()` factory.

## Element Migration Map

| Basalt 2 | Basalt 2.5 | Migration |
| --- | --- | --- |
| `CheckBox` / `addCheckBox()` | `Checkbox` / `addCheckbox()` | Change the capitalization |
| `DropDown` / `addDropDown()` | `Dropdown` / `addDropdown()` | Change the capitalization and review properties |
| `FlexBox` | `Flex`, `Row`, or `Column` | Replace old flex property names |
| `ScrollFrame` | Any scrollable container | Use `scrollable` and `scrollbar` |
| `ScrollBar` | Built-in container scrollbars | No standalone 2.5 element |
| `SideNav` | `Row` plus `List`/`Menu` and page frames, or `TabControl` | Recompose the navigation |
| `Display` | `Canvas` or `Program` | Choose custom Basalt drawing or a hosted CC program |
| `Timer` | `basalt.schedule()` | Use a yielding loop and a cancellation flag |
| `Accordion` | Buttons plus frames and `visible` state | No direct replacement |
| `Breadcrumb` | A `Row` of Labels or Buttons | No direct replacement |
| `BigFont` | `bigfont` module | Load before `addBigFont()` |
| `Image` | `image` module | Load before `addImage()` |
| `Graph`, `BarChart`, `LineChart` | `charts` module | Load the module and update the data API |

Basalt 2's `BaseElement` and `VisualElement` layers are represented by the
2.5 `Element` API. Normal applications should work through concrete elements
rather than depending on those old internal class names.

### Checkbox and Dropdown Properties

The most visible Checkbox changes are:

| Basalt 2 | Basalt 2.5 |
| --- | --- |
| `addCheckBox()` | `addCheckbox()` |
| `checkedText` | `checkedSymbol` |
| no separate unchecked symbol | `uncheckedSymbol` |

For Dropdown:

| Basalt 2 | Basalt 2.5 |
| --- | --- |
| `addDropDown()` | `addDropdown()` |
| `dropdownHeight` | `dropHeight` |
| `selectedText` placeholder | `text` placeholder |

Check every specialized property against the current API instead of assuming
that capitalization is the only difference.

## Properties and Lifecycle

Basalt 2.5 still generates `set<Property>()` and `get<Property>()` for declared
properties:

```lua
button:setText("Save")
button:setPosition(2, 4)

print(button:getText())
```

Direct access and creation tables remain the clearest option:

```lua
local button = frame:addButton({
    x = 2,
    y = 4,
    width = 12,
    text = "Save",
})

button.disabled = true
```

Replace these older patterns:

| Basalt 2 | Basalt 2.5 |
| --- | --- |
| `element.set("x", 5)` | `element.x = 5` or `element:setX(5)` |
| `element.get("x")` | `element.x` or `element:getX()` |
| `enabled = false` | `disabled = true` |
| `backgroundEnabled = false` | `background = false` |
| generic property `onChange("x", fn)` | a control event, signal subscription, or explicit update function |
| `updateRender()` | Assign the property normally; invalidation is automatic |

`destroy()` remains the normal way to remove an element and its handlers:

```lua
button:destroy()
```

To temporarily remove an element from rendering and input, change
`visible` instead:

```lua
panel.visible = false
panel.visible = true
```

## Layout Migration

The old constraint helpers such as `fillParent()`, `center()`, `rightOf()`,
`widthPercent()`, and `setConstraint()` are not part of the 2.5 Element API.
Use layout tokens, Flex containers, or dynamic properties.

### Filling and Sizing

Basalt 2:

```lua
local content = main:addFrame()
    :setPosition(2, 2)
    :fillParent(1)
```

Basalt 2.5:

```lua
local content = main:addFrame({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
})
```

The primary size values are:

```lua
width = basalt.auto()         -- intrinsic content size
width = basalt.fill()         -- remaining space
width = basalt.fill(2)        -- weighted share inside Flex
width = basalt.percent(0.5)   -- 50 percent
```

Use `minWidth`, `maxWidth`, `minHeight`, and `maxHeight` for constraints.

### Dynamic and Reactive Properties

Reactive expression strings are built into 2.5 and no longer require the old
reactive plugin:

```lua
local centered = frame:addButton({
    width = 12,
    x = "{floor((parent.width - self.width) / 2) + 1}",
    y = "{parent.height - 2}",
    text = "Exit",
})
```

A Lua function can also provide a dynamic value:

```lua
centered.x = function(self)
    return math.floor((self.parent.width - self.width) / 2) + 1
end
```

Use signals for application data rather than putting business logic into
layout expressions.

### FlexBox

Basalt 2 FlexBox properties map as follows:

| Basalt 2 | Basalt 2.5 |
| --- | --- |
| `addFlexBox()` / `addFlexbox()` | `addFlex()` |
| `flexDirection` | `direction` |
| `flexSpacing` | `gap` |
| `flexJustifyContent = "flex-start"` | `justify = "start"` |
| `flexJustifyContent = "space-between"` | `justify = "between"` |
| `flexAlignItems` | `align` |
| `flexCrossPadding` | `padding` |
| child `flexGrow` | `basalt.fill(weight)` on the main-axis size |
| child `flexShrink` | child `shrink` |
| child `flexBasis` | an explicit width or height |
| `flexWrap` | No direct equivalent; compose nested Rows or Columns |

Basalt 2.5 also provides `addRow()` and `addColumn()`:

```lua
local toolbar = frame:addRow({
    width = basalt.fill(),
    height = basalt.auto(),
    gap = 1,
    padding = 1,
    align = "center",
})

toolbar:addButton({
    width = basalt.fill(),
    text = "Save",
})

toolbar:addButton({
    width = basalt.fill(2),
    text = "Deploy",
})
```

### Scrolling

Replace `ScrollFrame` with a normal container:

```lua
local scroller = frame:addFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 10,
    scrollable = true,
    scrollbar = "auto",
})
```

All containers expose `scrollTo()`, `scrollBy()`, `scrollToElement()`, and
`ensureVisible()`. `scrollbar` accepts `"auto"`, `"always"`, or `"hidden"`.

There is no standalone ScrollBar to attach to an arbitrary property. Use a
Slider when the user should edit a numeric value.

## Interaction States and Application State

Basalt 2 used the word *state* for both visual interaction conditions and
application values. Basalt 2.5 separates them.

### Interaction States

Old generated state-property setters:

```lua
button:setBackgroundState("clicked", colors.blue)
button:setTextState("clicked", "Working")
```

New state styles:

```lua
button:setStateStyle("pressed", {
    background = colors.blue,
    text = "Working",
})
```

The built-in button state is named `pressed`, not `clicked`. Common 2.5 states
include `hover`, `focused`, `pressed`, `checked`, `selected`, and `disabled`.

Custom states are activated with a boolean:

```lua
button:setStateStyle("loading", {
    background = colors.orange,
})

button:setStatePriority("loading", 80)
button:setState("loading", true)
button:setState("loading", false)
```

This replaces the Basalt 2 meaning of `setState(name, priority)`.
`registerState()`, `unsetState()`, conditional state registration, and
generated `set<Property>State()` methods are not part of 2.5.

### Reactive Application Values

Replace the old state plugin's `initializeState()`, `getState()`,
`onStateChange()`, and string-named bindings with signals:

```lua
local count = basalt.state(0)
local caption = basalt.computed(function()
    return "Count: " .. count:get()
end)

local label = frame:addLabel({
    text = caption,
})

count:subscribe(function(value, oldValue)
    print("Count changed from", oldValue, "to", value)
end)

count:set(1)
count:update(function(value)
    return value + 1
end)
```

Bind a writable signal to a form control when two-way synchronization is
required:

```lua
local username = basalt.state("")

frame:addInput()
    :bind("text", username, {
        twoWay = true,
        event = "change",
    })
```

The 2.5 state core does not persist values to disk. If the old application
used `initializeState(..., persist, path)`, serialize those values explicitly
with `fs` and `textutils`, then restore them before creating the UI.

## Events and Focus

Element callbacks still receive the element as their first argument:

```lua
button:onClick(function(self, mouseButton, x, y)
    -- x and y are local to the button
end)
```

Basalt 2.5 provides both convenience registrars and generic handlers:

```lua
button:onClick(handleClick)
button:on("click", handleClick)
button:off("click", handleClick)
```

Review these event changes:

| Basalt 2 pattern | Basalt 2.5 |
| --- | --- |
| `onEnter()` / `onLeave()` | `onMouseEnter()` / `onMouseLeave()` |
| generic `onChange("text", fn)` | control-specific `onChange(fn)` |
| global `basalt.onEvent()` | a scheduled coroutine using `os.pullEvent()` |
| global `basalt.removeEvent()` | cancellation logic in that coroutine |
| `element:setFocused(true)` | `element:focus()` |
| `element:isFocused()` | `element:hasState("focused")` or `root:getFocused() == element` |

For example, Input fires `change` with its new text:

```lua
input:onChange(function(self, text)
    status.text = "Length: " .. #text
end)
```

There is no `basalt.removeSchedule()` in 2.5. Make long-running scheduled work
cooperatively cancellable:

```lua
local generation = 0

local function startPolling()
    generation = generation + 1
    local mine = generation

    basalt.schedule(function()
        while mine == generation do
            updateStatus()
            sleep(1)
        end
    end)
end

local function stopPolling()
    generation = generation + 1
end
```

## Collections and Selection

Lists, Dropdowns, ComboBoxes, and Menus still accept strings or item tables:

```lua
local entry = list:addItem({
    text = "Reactor",
    value = "reactor-1",
})
```

Basalt 2.5 normalizes every item into a stable `CollectionEntry`. Selection
callbacks and getters therefore return entries rather than assuming the
original table or text:

```lua
list:onSelect(function(self, index, entry)
    print(index, entry.text, entry.value)
end)

local selected = list:getSelectedItem()
if selected then
    print(selected:getIndex(), selected.text)
end
```

Audit old code that compares selected tables by identity or expects
`addItem()` to return the collection. In 2.5, `addItem()` returns the created
entry.

## Animation Migration

The old animation chain supported sequences, pause/resume, text effects, and
custom animation types. The 2.5 animation module intentionally focuses on
tweening numeric properties.

Basalt 2:

```lua
local movement = panel:animate()
    :move(20, 5, 0.5)
    :resize(18, 6, 0.5)
    :sequence()
    :move(2, 5, 0.5)
    :start()

movement:stop()
```

Basalt 2.5:

```lua
basalt.use("animation")

local movement = panel:animate(
    {
        x = 20,
        y = 5,
        width = 18,
        height = 6,
    },
    0.5,
    "easeOut",
    function(element)
        element:animate({ x = 2 }, 0.5, "easeIn")
    end
)

movement:cancel()
```

The available easing names are `linear`, `easeIn`, `easeOut`, and
`easeInOut`.

There is no direct 2.5 equivalent for `pause()`, `resume()`, `morphText()`,
`typewrite()`, `fadeText()`, `scrollText()`, `entries()`, or custom animation
registration. Change non-numeric values with callbacks or scheduled logic,
and build sequences by starting the next animation in `onDone`.

## Charts and Images

### Charts

Load the module before creating any chart:

```lua
basalt.use("charts")
```

The named-series API now accepts an options table.

Basalt 2:

```lua
graph:addSeries(
    "cpu",
    " ",
    colors.green,
    colors.green,
    30
)
```

Basalt 2.5:

```lua
graph:addSeries("cpu", {
    symbol = " ",
    fg = colors.green,
    bg = colors.green,
    pointCount = 30,
})
```

The available `Graph` option keys are `symbol`, `fg`, `bg`, `pointCount`, and
`visible`. `PixelGraph` instead uses `color`, `pointCount`, and `visible`.

Use `setSeriesVisible(name, visible)` instead of
`changeSeriesVisibility()`. `focusSeries()` and `setSeriesPointCount()` do not
have direct methods in 2.5; define the required point count when adding the
series.

`Graph` and the new `PixelGraph` support named streaming series.
`BarChart` and `LineChart` now use a simple `data` array:

```lua
local bars = frame:addBarChart({
    data = { 24, 58, 36, 81 },
    minValue = 0,
    maxValue = 100,
})
```

Do not port old multi-series BarChart or LineChart code mechanically. Choose
`Graph` or `PixelGraph` when multiple streaming series must remain visible.

### Images

Load image data through the returned module:

```lua
local image = basalt.use("image")

local logo = frame:addImage({
    x = 2,
    y = 2,
    autoSize = true,
})

logo.bimg = image.load("assets/logo.bimg")
logo:play()
```

`autoResize` became `autoSize` and now defaults to `true`. Basalt 2.5 renders
BIMG and FLIMG data and supports frame navigation and playback. The old
in-place image editing, palette, offset, frame-construction, and pixel getter
methods are not present. Modify the source image data before assigning it, or
use Canvas for generated graphics.

## XML Migration

Basalt 2 XML was loaded through a frame method and supported several extension
features. Basalt 2.5 XML is a smaller, explicit module.

Basalt 2:

```lua
local xml = basalt.getAPI("xml")

main:loadXML([[
    <button
        text="${buttonText}"
        onClick="save"
    />
]], {
    buttonText = "Save",
    save = save,
})
```

Basalt 2.5:

```lua
local xml = basalt.use("xml")

xml.load(main, [[
    <button
        text="Save"
        onClick="save"
    />
]], {
    save = save,
})
```

The 2.5 scope table is a handler lookup, not a general XML template
environment. Review these removed Basalt 2 XML features:

- `${...}` scope interpolation
- CDATA event functions
- nested `<state>` declarations
- `propertyState:name` attributes
- custom XML attributes stored on the element
- custom tag handler registration
- calling `loadXML()` directly on a container

In 2.5:

- tags map to registered `add<Element>()` methods;
- ordinary attributes become properties;
- `onClick="save"` resolves `save` from the scope table;
- `"{...}"` attribute values use Basalt's reactive property expressions;
- `xml.loadFile(parent, path, scope)` loads a file.

Move data preparation, conditional structure, and complex handler logic into
Lua. Keep XML responsible for the element tree and static properties.

## Theme Migration

Basalt 2 theme code commonly used `getAPI("theme")`, `setTheme()`, and
`element:applyTheme()`.

Basalt 2.5 loads the module and applies styles by class name:

```lua
local theme = basalt.use("theme")

theme.set({
    Button = {
        background = colors.gray,
        foreground = colors.white,
        states = {
            hover = {
                background = colors.lightGray,
            },
        },
    },
})
```

`theme.set()` changes class defaults. Existing elements that have not
explicitly overridden a property follow the new default.

Apply explicit values to an existing subtree with:

```lua
theme.apply(frame, {
    Label = {
        foreground = colors.yellow,
    },
})
```

Theme files are still supported, but loading and activation are separate:

```lua
local name = theme.load("themes/control-room.json")
local palette = theme.applyPreset(name)
```

There is no direct `getTheme()` or per-element `getTheme()` equivalent. Keep
the selected preset name and color tokens in application state when the UI
needs to display or persist that choice.

## Removed Runtime and Loading APIs

Basalt 2.5 intentionally has a smaller public runtime. These Basalt 2
application APIs are not available:

- `basalt.create(type, properties)`
- `basalt.getElementManager()`
- `basalt.getErrorManager()`
- `basalt.setActiveFrame()` and `basalt.getActiveFrame()`
- global `basalt.setFocus()` and `basalt.getFocus()`
- `basalt.removeSchedule()`
- `basalt.getElementClass()`
- `basalt.getAPI()`
- `basalt.onEvent()`, `basalt.removeEvent()`, and `basalt.triggerEvent()`
- `basalt.requireElements()`
- `basalt.setRenderThrottleTime()`
- `basalt.loadManifest()`
- `basalt.install()`
- `basalt.configure()`

Use parent factories such as `frame:addButton()`, explicit
`basalt.use()` calls, element-local events, and the current root-frame APIs.

The remote/disk element loader, manifests, and global element cache do not
have a 2.5 compatibility layer. Applications depending on dynamically loaded
third-party elements must replace them with built-in 2.5 controls or keep
using the matching Basalt 2 runtime.

## A Complete Small Port

The following 2.5 example uses creation tables, signals, current events,
layout tokens, and state styles. It can replace the structure of a typical
small Basalt 2 settings screen.

```lua run title="Migrated Basalt 2.5 settings screen"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local enabled = basalt.state(false)
local statusText = basalt.computed(function()
    return enabled:get() and "Feature enabled" or "Feature disabled"
end)

local page = frame:addColumn({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
    gap = 1,
    padding = 1,
    background = colors.gray,
})

page:addLabel({
    text = "Settings",
    foreground = colors.orange,
})

local toggle = page:addCheckbox({
    text = "Enable feature",
})

toggle:bind("checked", enabled, {
    twoWay = true,
    event = "change",
})

page:addLabel({
    text = statusText,
    foreground = function()
        return enabled:get() and colors.lime or colors.lightGray
    end,
})

local exit = page:addButton({
    width = 12,
    text = "Exit",
})

exit:setStateStyle("hover", {
    background = colors.lightGray,
})

exit:onClick(function()
    basalt.stop()
end)

basalt.run()
```

## Migration Checklist

1. Install 2.5 beside the old library and make the smallest application load.
2. Keep ordinary property setters until the application is stable.
3. Change monitor roots to `basalt.createFrame(terminal)`.
4. Replace `getAPI()` and implicit plugins with explicit `basalt.use()`.
5. Load `bigfont`, `charts`, and `image` before their element factories.
6. Rename Checkbox, Dropdown, and Flex usage.
7. Replace removed composite elements with current containers and controls.
8. Replace old layout constraints with tokens, Flex, or dynamic properties.
9. Separate interaction states from reactive application signals.
10. Review property observers, event names, focus code, and scheduled
    cancellation.
11. Review every collection callback for `CollectionEntry` values.
12. Rewrite old animation chains and chart series calls.
13. Simplify XML to the supported 2.5 subset.
14. Replace old global managers, manifests, and element-loading APIs.
15. Test resize, focus, selection, scheduled work, and error paths before
    replacing the production Basalt 2 library.

## Related Guides

- [Installation](./foundations/installation)
- [Getting Started](./getting-started)
- [How Basalt Works](./foundations/mental-model)
- [Layout Basics](./foundations/layout-basics)
- [Flex Layouts](./foundations/flex-layouts)
- [Reactive State](./foundations/reactive-state)
- [Styling, States, and Themes](./foundations/styling-states-and-themes)
- [Events and Focus](./foundations/events-and-focus)
- [Lists and Selection](./building-interfaces/lists-and-selection)
- [Dropdowns and Suggestions](./building-interfaces/dropdowns-and-suggestions)
- [XML Interfaces](./xml/)
- [Optional Modules](./modules/)
- [Debugging](./development/debugging)
- [Testing](./development/testing)
- [Basalt 2.5 API Reference](/api/)
