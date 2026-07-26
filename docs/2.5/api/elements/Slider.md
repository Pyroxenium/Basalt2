# Slider

*extends Element*

Slider: value picker (horizontal or vertical); click, drag or scroll.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| min | `number` | `0` | lowest selectable value |
| max | `number` | `100` | highest selectable value |
| step | `number` | `1` | rounding step for clicks/drags/wheel |
| value | `number` | `0` | current value |
| horizontal | `boolean` | `true` | false = vertical (uses height) |
| barColor | `number` | `colors.gray` | track color |
| knobColor | `number` | `colors.blue` | Color of the knob |
| width | `number` | `10` | Width in terminal cells |

## Events

| Event | Registrar | Description |
| --- | --- | --- |
| change | :onChange(fn) | Fired whenever the value changes through user interaction |

## Methods

### Slider:setup()

Initializes per-instance state and input handlers.

### Slider:handleMouse(event, btn, x, y)

The mouse wheel adjusts the value by one step.

- **event** (`string`) The mouse event name
- **btn** (`number`) Button or scroll direction
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **consumer** (`Element|nil`) The consuming element, or nil to pass through

### Slider:render(buf)

Renders the track and knob (horizontal or vertical).

- **buf** (`Render`) The render buffer
