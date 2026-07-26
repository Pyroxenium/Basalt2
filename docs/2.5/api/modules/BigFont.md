# BigFont

*extends Element*

BigFont module: registers the BigFont element (large text via teletext
drawing characters). Font engine by Wojbie (see license below), element
wrapper rewritten for Basalt 2. Font sizes 1-3; colors may be any
colors.* value or basalt.rgb() handle.

  basalt.use("bigfont")
  frame:addBigFont({ x = 2, y = 2, text = "Hi!", fontSize = 2 })

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| text | `string` | `"BigFont"` | Displayed text |
| fontSize | `number` | `1` | Scale 1-3 (one character is 3x3 cells at size 1) |
| width | `number` | *dynamic* | Width in terminal cells |
| height | `number` | *dynamic* | Height in terminal cells |

## Methods

### BigFont:getBigText()

Builds (and caches) the {text, fg, bg} line triples for the current
text, size and colors.

- **returns** **data** (`table`) Text/foreground/background line arrays

### BigFont:measure()

Intrinsic size for basalt.auto().

- **returns** **width** (`number`) The measured width
- **returns** **height** (`number`) The measured height

### BigFont:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)
