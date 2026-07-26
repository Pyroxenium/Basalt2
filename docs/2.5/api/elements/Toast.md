# Toast

*extends Element*

Toast: transient notification. One element shows one toast at a time.

  local toast = frame:addToast()
  toast:success("Saved!")
  toast:error("Oh no", 5)          -- custom duration in seconds
  toast:show("Plain message")

Auto-positions in the parent's top-right corner unless x/y are set
manually. Auto-hides after `duration` seconds (0 disables). Fires "hide".

## Types

### `ToastColorMap`

```lua
ToastColorMap = table<string, ToastColorPair>
```

### `ToastColorPair`

| Field | Type | Description |
| --- | --- | --- |
| bg | `number` | Background color |
| fg | `number` | Foreground color |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| message | `string` | `""` | Current toast text |
| duration | `number` | `3` | Default auto-hide time in seconds (0 = stay) |
| maxWidth | `number` | `24` | Wrap width including padding |
| visible | `boolean` | `false` | Whether the element is shown and hit by events |
| toastColors | `ToastColorMap` | `false` | type -> {bg, fg}; setup default |
| width | `number` | *dynamic* | Width in terminal cells |
| height | `number` | *dynamic* | Height in terminal cells |
| x | `number` | *dynamic* | Horizontal position, parent-local, 1-based |
| y | `number` | `2` | Vertical position, parent-local, 1-based |

## Events

| Event | Registrar | Description |
| --- | --- | --- |
| hide | :onHide(fn) | Fired when the toast hides |

## Methods

### Toast:setup()

Initializes per-instance state and input handlers.

### Toast:show(message, toastType, duration)

Shows a toast. toastType picks the color pair (default/success/error/
warning/info); duration overrides self.duration for this toast.

- **message** (`string`) The message (word-wrapped to maxWidth)
- **toastType** (`string`, optional) Color scheme name, default "default"
- **duration** (`number`, optional) Seconds until auto-hide, 0 disables

- **returns** (`self`) 

### Toast:hide()

Hides the toast and fires the hide event.

- **returns** (`self`) 

### Toast:success(message, duration)

Shows a success toast.

- **message** (`string`) Message
- **duration** (`number`, optional) Duration in seconds

- **returns** (`self`) 

### Toast:error(message, duration)

Shows an error toast.

- **message** (`string`) Message
- **duration** (`number`, optional) Duration in seconds

- **returns** (`self`) 

### Toast:warning(message, duration)

Shows a warning toast.

- **message** (`string`) Message
- **duration** (`number`, optional) Duration in seconds

- **returns** (`self`) 

### Toast:info(message, duration)

Shows an informational toast.

- **message** (`string`) Message
- **duration** (`number`, optional) Duration in seconds

- **returns** (`self`) 

### Toast:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)
