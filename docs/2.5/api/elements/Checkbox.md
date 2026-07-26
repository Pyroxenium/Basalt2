# Checkbox

*extends Element*

Checkbox: "[x] label", toggles on click, fires "change".

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| checked | `boolean` | `false` | Checked state; mirrored to the "checked" element state for styling |
| text | `any` | `""` | label shown right of the box |
| checkedSymbol | `any` | `"x"` | single character inside [ ] |
| uncheckedSymbol | `any` | `" "` | Single character inside [ ] while unchecked |
| width | `number` | *dynamic* | Auto-sizes to the label until set explicitly |

## Events

| Event | Registrar | Description |
| --- | --- | --- |
| change | :onChange(fn) | Fired after every toggle with the new checked state |

## Methods

### Checkbox:setup()

Sets up the checkbox's click handler to toggle its checked state and fire a "change" event.

### Checkbox:render(buf)

Renders the checkbox as "[x] label".

- **buf** (`Render`) The render buffer
