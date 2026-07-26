# xml

XML module: build UI trees from XML markup.

```xml
<frame x="2" y="2" width="20" height="8">
    <label text="Hello" foreground="#89b4fa"/>
    <button text="Save" onClick="save"/>
    <label text="{parent.width}"/> <!-- reactive works -->
</frame>
```

```lua
local xml = basalt.use("xml")
xml.load(frame, xmlSource, { save = function(btn) ... end })
```

Tag names map to `add<Name>()` on the parent (label -> addLabel), so any
registered element works. Attribute values are converted: numbers,
true/false, "#RRGGBB" -> basalt.rgb, "{...}" stays reactive, everything
else is a string. on* attributes bind functions from the scope table.

## Methods

### xml.parse(src)

Parses an XML string into a tree of {tag, attrs, children, text} nodes.

- **src** (`string`) XML source

- **returns** **root** (`table`) Parsed root node

### xml.load(parent, src, scope)

Builds elements from an XML string under `parent`.

- **parent** (`table`) The container the elements are added to
- **src** (`string`) The XML markup
- **scope** (`table|nil`) Functions referenced by on* attributes

- **returns** **elements** (`table`) The top-level created elements

### xml.loadFile(parent, path, scope)

Like xml.load, but reads the markup from a file.

- **parent** (`Container`) Parent container
- **path** (`string`) XML file path
- **scope** (`table|nil`) Event/function lookup scope

- **returns** **elements** (`table`) Top-level created elements
