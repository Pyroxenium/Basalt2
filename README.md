# Basalt 2.5

A modern, lightweight UI framework for CC: Tweaked — a from-scratch rewrite
of Basalt2, released as its own branch of the Basalt2 repository. Three
priorities: **performance**, **more than 16 colors**, and **no bloat**
— while staying just as easy to use.

(The local development folder and require name are still `Basalt3`; the
official product name is Basalt 2.5.)

## Usage

```lua
local basalt = require("Basalt3")

local frame = basalt.createFrame()
frame:setBackground(basalt.rgb("#1e1e2e")) -- any RGB color!

-- plain properties and chaining are both supported
local label = frame:addLabel({ x = 2, y = 2, text = "Hello" })
label.text = "Hello World"

frame:addButton({ x = 2, y = 4, text = "Click me" })
    :onClick(function(self)
        self.text = "Thanks!"
    end)

basalt.run()
```

Run the demo from the computer root: `Basalt3/example`

## More than 16 colors

`basalt.rgb(...)` registers custom colors (up to 240) and returns a handle
usable anywhere a `colors.*` value is accepted. Accepted formats:
`basalt.rgb("#89b4fa")`, `basalt.rgb(0x89b4fa)`, `basalt.rgb(0.2, 0.5, 0.9)`,
`basalt.rgb(51, 102, 204)`.

At render time the engine assigns the 16 hardware palette slots dynamically
to the colors *actually visible on screen*: native CC colors keep their slot,
custom colors take over unused slots via `term.setPaletteColour`, and if more
than 16 colors are visible at once, the overflow maps to the nearest visible
color. Slot assignments are sticky between frames to avoid flicker.

## Modules

Optional features live in `modules/` and never touch the core — they extend
it through public APIs only. Load them with `basalt.use(name)`:

```lua
local anim = basalt.use("animation")
anim.to(label, { x = 20 }, 0.5, "easeOut")        -- or label:animate({...})

local theme = basalt.use("theme")
theme.set({ Button = { background = basalt.rgb("#89b4fa") } })  -- live defaults
theme.apply(frame, { Label = { foreground = colors.yellow } })  -- subtree

local xml = basalt.use("xml")
xml.load(frame, [[<button text="Save" onClick="save"/>]], { save = fn })

basalt.use("debug")
basalt.debug("value:", x)   -- F12 toggles the log overlay
```

- **animation** — tweens numeric properties (easings: linear, easeIn/Out/InOut),
  driven by a scheduled coroutine; returns a cancellable handle.
- **theme** — `set()` changes class defaults (elements without explicit
  overrides follow live, including existing ones); `apply()` styles a subtree.
  `applyPreset("basalt")` switches on Basalt's signature look (volcanic
  stone + lava accent) and returns its color tokens. Custom themes live in
  JSON files: `theme.applyPreset(theme.load("themes/obsidian.json"))` —
  values may be `"#RRGGBB"`, `"$token"` references into the file's own
  `colors` table, or CC color names like `"lightGray"`; a `states` table
  per element defines hover/focus/... styles. See `themes/obsidian.json`
  for a complete template.
- **xml** — builds UI trees from markup; attributes auto-convert (numbers,
  booleans, `#RRGGBB` colors, reactive `{...}`), `on*` attributes bind
  functions from a scope table.
- **debug** — on-screen log overlay (`basalt.debug(...)`), toggle key
  configurable via `dbg.setToggleKey`.
- **responsive** — breakpoint rules that activate temporary property styles
  and named element states without overwriting authored values.

`List` and `Dropdown` include their own item scrollbars. They support wheel and
thumb scrolling plus Up/Down, Home/End, Page Up/Down and Enter; Dropdown also
supports Escape and keeps keyboard highlighting separate until selection.

Scrollable containers cache their layout and content bounds between geometry
changes. Scrolling only rebuilds the visible-child set; offscreen children are
skipped by rendering and hit-testing. Large retained UI trees therefore do not
need to recreate or virtualize their elements merely to scroll efficiently.

### Collections and entries

Flat item controls (`Collection`, `List`, `Dropdown`, `ComboBox`, `Menu` and
`ContextMenu`) share a Basalt2-compatible collection API. Strings and item
tables passed to `setItems` or `addItem` become `CollectionEntry` objects:

```lua
local list = frame:addList()
    :setItems({
        "First",
        { text = "Second", fg = colors.yellow },
    })

local third = list:addItem({
    text = "Third",
    callback = function(collection, entry)
        print(entry:getText())
    end,
})

third:moveToTop():select()

list:onChange(function(self, index, item, oldIndex, oldItem)
    -- selection actually changed
end)

list:onSelect(function(self, index, item)
    -- item was activated by click or Enter
end)
```

The shared methods include `addItem`, `insertItem`, `removeItem`, `clear`,
`getItem`, `getItemCount`, `selectItem`, `unselectItem`, `clearItemSelection`,
`getSelectedItem(s)`, `getSelectedIndex`, `selectNext` and `selectPrevious`.
`addItem` returns the new entry, matching Basalt2. Entries support `setText`,
`getText`, `getIndex`, `moveUp`, `moveDown`, `moveToTop`, `moveToBottom`,
`swapWith`, `select`, `unselect`, `isSelected` and `remove`.

`ComboBox:onChange` remains the inherited text-change event. Use
`ComboBox:onSelectionChange` when only its selected collection entry matters.

### Table and Tree compatibility

`Table` and `Tree` keep their specialized data models, but expose the familiar
Basalt2 API. Tables accept both row tables and variadic cells:

```lua
local people = frame:addTable()
    :setColumns({
        { name = "Name", width = "40%" },
        { name = "Age", width = "auto" },
    })

people:addRow("Alice", 30)
people:addRow({ "Bob", 25 })

people:onRowSelect(function(self, rowIndex, row)
    print(row[1])
end)
```

Compatibility methods include `clearData`, `getSelectedRow`, `addColumn`,
`sortByColumn`, `setColumnSortFunction`, `setHeaderColor` and
`setShowScrollBar`. `setData(data, formatters)` retains original values for
sorting while rendering the formatted cells.

Trees use plain `{ text, children }` node tables and support `expandNode`,
`collapseNode`, `toggleNode`, `setSelectedNode`, `getSelectedNode`,
`setExpandedNodes`, `getExpandedNodes` and `getNodeSize`. The first root node
is expanded when nodes are assigned, matching Basalt2. Long node labels can
be viewed with `setHorizontalOffset`.

## Element states

Every element has named states. Built-in interaction states are managed by the
runtime: `hover`, `focused`, `pressed` and `disabled`. Selection controls also
mirror their properties to `checked` or `selected`.

```lua
button:setState("loading", true)
assert(button:hasState("loading"))

button:setStateStyle("loading", {
    text = "Loading...",
    background = colors.orange,
}, 50) -- optional priority

button:onStateChange(function(self, name, active)
    print(name, active)
end)
```

State styles override ordinary property values while their state is active,
without replacing the stored value. If several active states style the same
property, the higher-priority state wins. Built-in priorities are `hover=10`,
`focused=20`, `checked/selected=30`, `pressed=40`, `disabled=100`; custom
states default to 50. Per-element priorities can be changed with
`element:setStatePriority(name, priority)`.

Themes can define class-wide state styles:

```lua
theme.set({
    Button = {
        background = colors.gray,
        states = {
            hover = { background = colors.lightGray },
            pressed = { background = colors.blue },
            disabled = { foreground = colors.lightGray },
        },
    },
})
```

## Combined properties

Common property groups are exposed as fluent setters and multi-value getters.
They are facades only: values continue to live in the original properties, so
dirty marking, signals, state styles and responsive layout behave normally.

```lua
element:setPosition(2, 4)
element:setSize(20, 6)
element:setBounds(2, 4, 20, 6)
element:setColors(colors.white, colors.gray)

local x, y = element:getPosition()
local width, height = element:getSize()
local x, y, width, height = element:getBounds()
```

Available groups are `Position` (`x`, `y`), `Size` (`width`, `height`),
`Bounds`, `Colors` (`foreground`, `background`), `MinSize`, and `MaxSize`.
Effective getters return resolved layout values. Raw getters preserve authored
signals/layout tokens:

```lua
element:setSize(basalt.fill(), basalt.auto())

local width, height = element:getSize()       -- resolved numbers
local widthSpec, heightSpec = element:getRawSize() -- fill/auto tokens
```

## Application state and signals

Element states describe UI interaction (`hover`, `pressed`, `disabled`). App
state stores changing application data. A signal can be assigned directly to
any element property:

```lua
local count = basalt.state(0)

local label = frame:addLabel({
    width = 20,
    text = count:map(function(value)
        return "Clicks: " .. value
    end),
})

frame:addButton({ text = "Add" }):onClick(function()
    count:update(function(value) return value + 1 end)
end)
```

Changing a signal only marks UI trees that have read it as dirty. Derived
values are lazy and automatically track every signal read inside them:

```lua
local first = basalt.state("Ada")
local last = basalt.state("Lovelace")

label.text = basalt.computed(function()
    return first:get() .. " " .. last:get()
end)
```

Writable signals provide `get`, `set`, `update`, `touch`, `map` and
`subscribe`. `touch()` is useful after mutating a table stored in a signal in
place. `subscribe(fn, true)` invokes the listener immediately and returns an
unsubscribe function. `basalt.signal` is an alias for `basalt.state`.

### Property bindings

`element:bind(property, state)` keeps a property connected to application
state. Inputs and selection controls automatically write their `change` or
`select` event back to writable state:

```lua
local username = basalt.state("Alex")
local enabled = basalt.state(true)

frame:addInput({ width = 16 }):bind("text", username)
frame:addCheckbox({ text = "Enabled" }):bind("checked", enabled)
```

Bindings can transform values in either direction:

```lua
label:bind("text", count, function(value)
    return "Clicks: " .. value
end)

input:bind("text", age, {
    fromState = tostring,
    toState = function(text) return tonumber(text) or 0 end,
})
```

The default write-back events are `change` for `text`, `checked` and `value`,
and `select` for `selected`. Override them with `event`, or use
`twoWay = false` for a one-way binding. `element:unbind(property)` removes a
binding while retaining its current displayed value; passing `false` restores
the class default.

## Responsive layout

Numeric `x`, `y`, `width` and `height` remain absolute and fully compatible.
Responsive layout is opt-in through layout values and Row/Column containers:

```lua
local page = frame:addColumn({
    x = 1, y = 1,
    width = basalt.fill(),
    height = basalt.fill(),
    padding = 1,
    gap = 1,
})

local form = page:addRow({
    width = basalt.fill(),
    height = basalt.auto(),
    gap = 1,
    align = "center",
})

form:addLabel({ text = "Name:", width = basalt.auto() })
form:addInput({ width = basalt.fill() })
form:addButton({ text = "Save", width = basalt.auto() })
```

Layout values:

- `basalt.auto()` measures the element's intrinsic content size.
- `basalt.fill()` consumes remaining space on a Row/Column main axis.
- `basalt.fill(weight)` distributes remaining space proportionally.
- `basalt.percent(0.5)` uses 50 percent of the available size.

Rows lay out children horizontally; Columns lay them out vertically. Both
support `padding`, `gap`, `align` (`start`, `center`, `end`, `stretch`) and
`justify` (`start`, `center`, `end`, `spaceBetween`). A child can override the
cross-axis alignment with `alignSelf`.

```lua
row:addButton({
    width = basalt.fill(2),
    minWidth = 8,
    maxWidth = 24,
    alignSelf = "end",
})
```

Available constraints are `minWidth`, `maxWidth`, `minHeight` and `maxHeight`.
When content does not fit, `auto`/`fill` children shrink by default while
numeric fixed sizes do not. Override this with `shrink = 0` or a positive
weight; minimum constraints are always respected. Remaining overflow is
clipped by the container.

Children normally participate in layout flow. An overlay can opt out:

```lua
row:addLabel({
    position = "absolute",
    x = 2, y = 1,
    text = "Overlay",
})
```

Layout is recalculated on dirty renders and terminal/monitor resize. Rendering,
clipping, hover and mouse hit-testing all use the same resolved geometry.
Run `Basalt3/layout_example` for a complete example.

### Responsive breakpoints

Load the optional responsive strategy after the core layout is available:

```lua
local responsive = basalt.use("responsive")

responsive.apply(form, {
    {
        name = "compact",
        maxWidth = 30,
        props = { direction = "column", gap = 1 },
    },
    {
        name = "wide",
        minWidth = 31,
        props = { direction = "row", gap = 2 },
    },
})
```

Loading the module also adds fluent `container:setResponsive(rules)` and
`container:clearResponsive()` methods. Rules support `minWidth`, `maxWidth`,
`minHeight`, `maxHeight`, and `when(element, width, height)`. Multiple matching
rules cascade in declaration order, with later rules winning for properties
they define.

A named rule activates a normal element state, so application code and themes
can query or style it:

```lua
if form:hasState("compact") then ... end

form:setStateStyle("compact", {
    padding = 0,
})
```

Breakpoint property overrides are temporary state styles. The original
`direction`, sizes and spacing return automatically when a rule stops matching.

## Scrollable containers

Every Frame, Flex, Row and Column can opt into scrolling. It is disabled by
default, so existing containers retain their current behavior:

```lua
local content = frame:addColumn({
    width = basalt.fill(),
    height = 8,
    scrollable = true,
    scrollbar = "auto",
    scrollXEnabled = false,
    scrollYEnabled = true,
})
```

`scrollbar` accepts `auto` (only on overflow), `always`, or `hidden` (scrolling
without a visible bar). Scrollbars overlay the final row/column and are drawn
internally, so they never appear in `getChildren()` or participate in layout.

```lua
content:scrollTo(0, 10)
content:scrollBy(0, 3)
content:scrollToElement(button)
content:ensureVisible(input)

local x, y = content:getScroll()
local contentWidth, contentHeight = content:getContentSize()
local info = content:getScrollInfo() -- showX/showY/maxX/maxY etc.
```

Mouse-wheel scrolling, track clicks and thumb dragging are built in. Disable a
container at runtime with `container:setScrollable(false)`; this resets offsets,
hides bars and ignores further scroll input. `scrollStep` controls wheel speed,
while `scrollbarColor` and `scrollbarThumbColor` style the internal bars.

Run `Basalt3/scroll_example` for an interactive scrolling example with 30
items, hover feedback, scrollbar dragging and a runtime enable/disable toggle.

## Architecture

The framework lives in `src/`; everything in the repository root is
tooling (examples, tests, the dev loader shim, later the bundler).

```
init.lua                dev shim: forwards require("Basalt3") into src/
bundle.lua, installer.lua, manifest.txt   distribution tooling
bundle/basalt.lua       current single-file release
example.lua, gallery.lua, *_example.lua, test_smoke.lua

src/init.lua            tiny module loader (no package.path pollution)
src/main.lua            runtime: event loop, frames, scheduling, basalt.use()
src/core/class.lua      class & property system
src/core/palette.lua    color registry + palette slot allocator
src/core/render.lua     diff render buffer (byte-encoded colors, line diffing)
src/core/element.lua    base element (properties, events, mouse/key handling)
src/core/container.lua  child management, z-sorting, event routing
src/core/baseframe.lua  root frame: term binding, focus, mouse capture
src/core/errors.lua     structured error screen
src/core/reactive.lua   "{...}" expression compiler
src/core/state.lua      application signals + lazy computed values
src/core/layout.lua     layout tokens, measurement and geometry constraints
src/core/scroll.lua     container scrolling, offsets and internal scrollbars
src/core/itemview.lua   shared item-list scrollbars
src/core/text.lua       word wrapping
src/elements/           Label, Button, Input, Frame, Checkbox, Switch,
                        ProgressBar, Slider, List, Dropdown, Flex, Row,
                        Column, TextBox, Menu, TabControl, Tree, Table,
                        Program, ComboBox, ContextMenu, Dialog, Toast
src/modules/            optional: animation, theme, xml, debug, responsive,
                        charts (Graph/BarChart/LineChart), image (bimg),
                        bigfont (Wojbie's font engine)
```

`gallery.lua` shows every element in action: run `Basalt3/gallery`.

### Performance design (vs. Basalt2)

| | Basalt2 | Basalt3 |
|---|---|---|
| Metatables | one per instance, closure-based | **one shared per class** |
| Property read | several function calls + state resolution | one `_p` lookup |
| Property defaults | deep-copied into every instance | shared defaults table |
| Rendering | renders on every event | **only when dirty** |
| Terminal IO | dirty rects, O(n²) merging | line diff, changed lines only |
| Loading | fs scanning, lazy blueprints, remote sources | static requires |

### Installing

`installer.lua` works like Basalt2's installer: run it without arguments
and it bootstraps Basalt itself first — from the local repository, or by
downloading `bundle/basalt.lua` via http and load()ing it in-memory — and
then renders a **GUI wizard** (variant list, target input, progress bar).

```
Basalt3/installer                      -- GUI wizard
Basalt3/installer minified basalt.lua  -- non-interactive
Basalt3/installer source basalt        -- editable folder install
Basalt3/installer --make-manifest      -- regenerate manifest.txt
```

- **source**: copies `src/` plus the loader shim into a folder
  (remote: downloads everything listed in `manifest.txt`)
- **bundled**: single readable file (remote: downloads the prebuilt
  `bundle/basalt.lua`; local: builds it fresh)
- **minified**: same, with comments stripped

The download URLs at the top of the file still point at Basalt2's release
as a stand-in — swap them once Basalt3 is published (remote GUI mode needs
a real Basalt3 bundle, the APIs are not compatible).

### Bundling a release

`bundle.lua` (a tool in the repository root, not part of the framework)
packs everything under `src/` into a single file. The current release
lives in `bundle/basalt.lua` (like Basalt2's `release/` folder):

```
Basalt3/bundle                      -- bundle/basalt.lua, comments stripped
Basalt3/bundle out.lua --no-minify  -- verbatim sources (line numbers match src/)
```

Every file is embedded with its own chunk name, so error screens still
report `basalt3/core/render.lua:123` with per-file line numbers. The
bundle is used exactly like the repository: `local basalt = require("basalt")`.

### Testing

Headless regression test (writes `/basalt3_test_result.txt`, expects `PASS`):

```
CraftOS-PC_console.exe --headless --id 0 --script <path-to>/Basalt3/test_smoke.lua
```

## Dynamic values

Any property can hold a function instead of a value; it is evaluated with the
element on every read. Because Basalt3 redraws the tree from the buffer on
every change, dynamic values stay current without any observer wiring:

```lua
local btn = frame:addButton({
    text = "Centered",
    x = function(self) return math.floor((self.parent.width - self.width) / 2) end,
})
-- btn.x evaluates the function; btn:raw("x") returns the function itself;
-- assigning a plain value (btn.x = 5) replaces it again.
```

Note: `onChange` hooks don't fire for dynamic assignments (they would receive
the function, not a value).

## Reactive expressions

Strings of the form `"{...}"` are shorthand for a dynamic value — the braces
contain a plain Lua expression, compiled once and re-evaluated on every read:

```lua
button.x = "{parent.width - self.width - 1}"   -- right-aligned, stays aligned
label.width = "{#self.text + 2}"
box.y = "{clamp(header.y + 2, 1, parent.height)}"
```

Available inside expressions: `self`, `parent`, any element by its `name`
property (searched from the root), `colors`, `math`, `rgb(...)`,
`tostring`, `tonumber`, `clamp`, `round`, `floor`, `ceil`, `abs`, `min`, `max`.

Properties holding user-entered text (like `Input.text`) are declared with
`rawString = true` and never compile — typed braces stay literal text.

## Error handling

When an error escapes an event handler (or a scheduled coroutine), Basalt3
first restores the terminal and palette, then shows a structured error
screen: the message, the first stack frame in *your* code with the source
line quoted, and a compact traceback (hide it with `basalt.traceback =
false`). Coroutine tracebacks are captured before the stack is lost.
`basalt.errors` exposes `parse` / `show` / `wrap` for advanced use.

## Monitors

Pass a wrapped monitor to `createFrame`; touch events are routed automatically
(a touch fires as click + release):

```lua
local mon = basalt.createFrame(peripheral.wrap("right"))
mon:addButton({ x = 2, y = 2, text = "Touch" }):onClick(...)
```

## Roadmap

- [x] Input (with cursor, scrolling, placeholder, onChange/onEnter)
- [x] Cursor/blink support for text input elements
- [x] Monitor support (monitor_touch / monitor_resize routing)
- [x] Theme, animation, XML and debug as standalone modules (basalt.use)
- [x] Checkbox, Switch, ProgressBar, Slider, List, Dropdown
- [x] TextBox (multiline editor with selection: shift+keys, mouse drag,
      ctrl+a/c/x with a Basalt-internal clipboard)
- [x] Menu (incl. submenus/separators), TabControl, Tree, Table
- [x] Program (embed other CC programs: window buffer, event pump,
      onDone/onError, cursor passthrough)
- [x] ComboBox (editable dropdown + autocomplete), ContextMenu,
      Dialog (alert/confirm/prompt, modal), Toast
- [x] Basalt2 parity: paste events, password inputs (replaceChar),
      input patterns, label word-wrap, draggable frames, list multi-
      selection, table cell updates/custom sort, vertical sliders,
      progress bar directions
- [x] charts / image / bigfont as optional modules
- [x] Scrollable containers (opt-in on every Container, internal scrollbars)
- [x] Single-file bundler (bundle.lua, per-file chunk names, optional
      comment stripping)
- [x] Installer (source/bundled/minified, local + http via manifest.txt)
