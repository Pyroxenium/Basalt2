# XML Interfaces

Basalt's optional XML module builds ordinary element trees from declarative
markup. XML describes structure and scalar properties; Lua still owns
application state, complex data, event logic, and the event loop.

```xml
<frame
    name="card"
    x="2"
    y="2"
    width="24"
    height="8"
    background="#2E333D"
>
    <label x="2" y="2" text="Project"/>
    <button x="2" y="5" width="10" text="Save" onClick="save"/>
</frame>
```

```lua
local basalt = require("basalt")
local xml = basalt.use("xml")
local frame = basalt.getMainFrame()

xml.load(frame, source, {
    save = function(button)
        button.text = "Saved"
    end,
})

basalt.run()
```

The created controls are the same Frame, Label, and Button objects that Lua
would create with `addFrame()`, `addLabel()`, and `addButton()`.

## Guides in This Section

- [Building Interfaces with XML](./building-with-xml) — create a complete
  file-backed interface, connect handlers and state, populate complex
  controls, and test the markup.
- [`xml` API reference](/api/modules/xml) — concise signatures for `parse`,
  `load`, and `loadFile`.

## When XML Fits

XML is useful when:

- interface structure should be separate from application logic;
- designers should edit positions, dimensions, text, and colors without
  changing Lua control flow;
- several screens share a predictable markup format;
- a UI tree is easier to review as nested tags;
- applications want to load layouts from external files.

Prefer Lua construction when:

- most properties come from runtime tables or signals;
- elements are generated in loops;
- controls need table-valued properties such as List items, Tree nodes, or
  Table columns;
- conditional structure changes frequently;
- the interface is already clearer as a small amount of Lua.

XML and Lua are designed to mix. A common pattern is to declare the shell in
XML, find named controls, and populate them from Lua.

## Loading the Module

XML is optional:

```lua
local basalt = require("basalt")
local xml = basalt.use("xml")
```

Load an inline string under any Container:

```lua
local created = xml.load(frame, [[
    <label x="2" y="2" text="Inline XML"/>
]])
```

Load a file:

```lua
local created = xml.loadFile(frame, "ui/main.xml")
```

Both functions return an array containing the top-level created elements.
Nested elements remain accessible through their returned parent or a stable
`name`.

```lua
local rootPanel = created[1]
local saveButton = frame:find("save_button")
```

`loadFile()` opens the path with `fs.open()` exactly as provided. Relative
paths are resolved from the program's current working directory.

## How Tags Map to Elements

For each tag, the module capitalizes its first character and calls the
matching method on the parent:

```text
frame       -> parent:addFrame()
label       -> parent:addLabel()
button      -> parent:addButton()
tabControl  -> parent:addTabControl()
textBox     -> parent:addTextBox()
comboBox    -> parent:addComboBox()
```

Tags are case-sensitive after the first character. Both `<frame>` and
`<Frame>` map to `addFrame()`, but `<tabcontrol>` maps to the nonexistent
`addTabcontrol()`. Preserve internal capitals for multi-word element names.

Any element registered through Basalt's Container system can be used. An
unknown tag raises:

```text
Basalt XML: unknown element <widget>
```

Only Containers can own child tags:

```xml
<frame>
    <label text="Valid child"/>
</frame>
```

Nesting an element below a Button or another non-container fails because that
element has no `add<Name>()` methods.

## Attribute Conversion

XML attributes become element property assignments. Values are converted in
this order:

| XML value | Lua value |
| --- | --- |
| `"42"`, `"3.5"` | number |
| `"true"` | `true` |
| `"false"` | `false` |
| `"#RGB"` | registered RGB color |
| `"#RRGGBB"` | registered RGB color |
| `"#AARRGGBB"` | RGB color; alpha is ignored |
| `"{parent.width - 2}"` | reactive expression string |
| everything else | string |

Example:

```xml
<frame
    x="2"
    y="3"
    width="30"
    height="10"
    visible="true"
    background="#24262E"
/>
```

Conversion uses `tonumber()` first. Numeric-looking strings such as `"001"`
become numbers. XML does not provide an escape that forces such a value to
remain a string; assign it from Lua after loading when the distinction
matters.

Every value beginning with `#` is treated as a color. Invalid color syntax
raises a Basalt color error.

### Property names are not validated

Basalt permits custom fields on elements. A misspelled XML attribute can
therefore become an unused Lua field instead of producing an error:

```xml
<button widht="12" text="Typo"/>
```

Here `widht` does not change `width`. An arbitrary field that collides with an
element method can cause a later failure, so XML should contain only
documented properties and intentional custom fields. Check the element's API
page when a property appears to be ignored.

## Element Text

Leaf text can be written as an attribute:

```xml
<label text="Hello from XML"/>
```

Or between tags:

```xml
<label>Hello from XML</label>
```

Inner text is applied only when:

- the element has a `text` property;
- no `text` attribute was provided.

When both exist, the attribute wins:

```xml
<label text="Attribute text">Ignored inner text</label>
```

The parser trims inner text and joins separated text chunks with spaces. Use
the explicit `text` attribute for precise whitespace.

## Event Handler Scopes

An attribute beginning with `on` followed by an uppercase character is
treated as an event registrar:

```xml
<button
    name="save_button"
    text="Save"
    onClick="save"
    onFocus="logFocus"
/>
```

Pass the referenced functions as the third argument:

```lua
local scope = {}

function scope.save(button, mouseButton, x, y)
    button.text = "Saved"
end

function scope.logFocus(element)
    print("Focused:", element.name)
end

xml.loadFile(frame, "ui/main.xml", scope)
```

Handlers receive the same arguments as normal `onClick()`, `onChange()`, and
other Basalt registrations. The element remains the first argument.

The scope is only a function lookup table for `on*` attributes. Its state
values are not available inside reactive expressions.

A missing or non-function scope entry raises a descriptive error:

```text
Basalt XML: scope has no handler 'save' for onClick on <button>
```

## Reactive Attributes

Strings that start with `{` and end with `}` pass through XML conversion and
are compiled by Basalt's normal reactive property system:

```xml
<frame
    x="2"
    y="2"
    width="{parent.width - 2}"
    height="{parent.height - 2}"
>
    <input name="project_name" x="2" y="2" width="20"/>
    <label
        x="2"
        y="4"
        text="{project_name.text}"
        foreground="{colors.lightBlue}"
    />
</frame>
```

Expressions can access:

- `self`;
- `parent`;
- elements found by `name` from the root;
- `colors`, `math`, `rgb`, `tostring`, and `tonumber`;
- `clamp`, `round`, `floor`, `ceil`, `abs`, `min`, and `max`.

Named element references are resolved dynamically, so an expression can
refer to an element declared later in the file.

Scope fields and local Lua variables are not part of this expression
environment. Bind a signal or computed value after loading when application
state must drive a property.

## Connecting XML to Lua

Use `name` as the stable bridge:

```xml
<frame name="settings_panel">
    <input name="computer_name" x="2" y="2" width="20"/>
    <label name="status" x="2" y="5" text="Ready"/>
</frame>
```

```lua
xml.loadFile(frame, "ui/settings.xml")

local input = assert(
    frame:find("computer_name"),
    "XML is missing computer_name"
)
local status = assert(
    frame:find("status"),
    "XML is missing status"
)

input:onChange(function(self, text)
    status.text = text == "" and "Name required" or "Ready"
end)
```

Assertions turn a renamed or missing control into an immediate, useful
startup error.

## Complex Properties Stay in Lua

The XML converter supports only scalar attribute values. It cannot express
Lua tables, functions, signals, computed values, or layout tokens.

Declare the control in XML:

```xml
<list
    name="tasks"
    x="2"
    y="2"
    width="24"
    height="8"
/>
```

Populate it in Lua:

```lua
local tasks = assert(frame:find("tasks"))

tasks.items = {
    { text = "Mine iron", value = "mine" },
    { text = "Craft tools", value = "craft" },
}
```

Use the same approach for:

- List, Dropdown, and ComboBox `items`;
- Tree `nodes`;
- Table `columns` and `data`;
- state-style tables;
- signal and computed bindings;
- `basalt.auto()`, `basalt.fill()`, and `basalt.percent()`.

## The Supported XML Subset

The module is a compact Basalt-specific parser. It supports:

- opening, closing, and self-closing tags;
- single-quoted and double-quoted attributes;
- attribute names made from letters, digits, and underscores;
- comments using `<!-- ... -->`;
- multiple top-level elements;
- trimmed inner text.

It does not implement:

- `<?xml ...?>` declarations;
- document types, CDATA, namespaces, or processing instructions;
- XML entity decoding such as `&amp;`;
- unquoted attributes;
- hyphens in tag or attribute names;
- a general-purpose XML DOM;
- escaped `>` handling inside quoted values.

Keep markup deliberately simple and omit an XML declaration.

## Parsing Without Building

`xml.parse()` returns an array of parsed top-level node tables:

```lua
local nodes = xml.parse([[
    <frame name="root">
        <label text="Hello"/>
    </frame>
]])

assert(#nodes == 1)
assert(nodes[1].tag == "frame")
assert(nodes[1].attrs.name == "root")
assert(nodes[1].children[1].tag == "label")
```

Each node contains:

```text
tag       string
attrs     table of raw string values
children  array of child nodes
text      optional trimmed inner text
```

Parsing does not convert attribute values and does not create elements. This
makes it suitable for fast markup tests.

## Common XML Errors

### Unexpected closing tag

```xml
<frame>
    <label/>
</panel>
```

Basalt reports the closing tag and currently open tag.

### Unclosed tag

```xml
<frame>
    <label/>
```

Basalt reports the remaining open tag.

### Unknown element

Check spelling and internal capitalization:

```xml
<tabControl/>
```

### Missing handler

Ensure every `on*` value exists as a function in the supplied scope.

### Property appears unchanged

Check the attribute name against the element API. Unknown properties can
exist as unused custom fields.

## Related API

- [`xml` module](/api/modules/xml)
- [`Container`](/api/elements/Container)
- [`Element`](/api/elements/Element)
- [Elements and Properties](../foundations/elements-and-properties)
- [Reactive State](../foundations/reactive-state)
- [Debugging](../development/debugging)
- [Testing](../development/testing)

## Next Steps

Continue with [Building Interfaces with XML](./building-with-xml) for a
complete file-backed application.
