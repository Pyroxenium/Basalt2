# Switch

*extends Element*

Switch: sliding on/off toggle, fires "change".

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| checked | `boolean` | `false` | Checked state; mirrored to the "checked" element state for styling |
| onColor | `number` | `colors.green` | track color while on |
| offColor | `number` | `colors.gray` | track color while off |
| knobColor | `number` | `colors.white` | Color of the knob |
| width | `number` | `4` | Width in terminal cells |

## Events

| Event | Registrar | Description |
| --- | --- | --- |
| change | :onChange(fn) | Fired after every toggle with the new checked state |

## Methods

### Switch:setup()

Registers the click handler that toggles the switch.

### Switch:render(buf)

Renders the track and the sliding knob.

- **buf** (`Render`) The render buffer
