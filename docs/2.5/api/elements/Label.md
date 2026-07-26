# Label

*extends Element*

Label: text display. Auto-sizes to its text until width is set manually;
with a manual width the text word-wraps and the height auto-grows until
height is set manually too.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| text | `any` | `""` | Displayed text; numbers and dynamic values are tostring-ed |
| width | `number` | `1` | Setting a width manually disables auto-sizing and enables word wrap |
| height | `number` | `1` | Grows with the wrapped text until set manually |

## Methods

### Label:setup()

Initializes per-instance state and input handlers.

### Label:render(buf)

Renders the label (single line, or word-wrapped with a manual width).

- **buf** (`Render`) The render buffer

### Label:measure()

Intrinsic size for basalt.auto(): text length x 1.

- **returns** **width** (`number`) The measured width
- **returns** **height** (`number`) The measured height
