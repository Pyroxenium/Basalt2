# ComboBox

*extends Input, CollectionMixin*

ComboBox: an Input with an attached dropdown list.
With autoComplete = true the list filters while typing (case-insensitive
prefix match). Fires "select"(itemIndex, item) plus everything Input fires.

## Types

### `ComboBoxDisplayEntry`

| Field | Type | Description |
| --- | --- | --- |
| index | `integer` | Original collection index |
| text | `string` | Display text |
| item | `CollectionEntry` | Original collection entry |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| dropHeight | `number` | `6` | maximum visible list rows |
| autoComplete | `boolean` | `false` | filter the list while typing |
| offset | `number` | `0` | list scroll offset |
| dropBackground | `number` | `colors.black` | open list background |
| dropForeground | `number` | `colors.white` | Text color of the expanded list |
| scrollbar | `ItemViewScrollbarMode` | `"auto"` | "auto", "always" or "hidden" |
| scrollbarColor | `number` | `colors.gray` | Scrollbar track color |
| scrollbarThumbColor | `number` | `colors.lightGray` | Scrollbar thumb color |
| width | `number` | `14` | Width in terminal cells |
| height | `number` | *dynamic* | Follows the open state; setting it explicitly breaks expansion |
| open | `boolean` | `false` | Whether the list is expanded; floats above siblings while open |

## Methods

### ComboBox:getDisplayItems()

The list as displayed: filtered while typing with autoComplete,
otherwise all items.

- **returns** **entries** (`ComboBoxDisplayEntry[]`) 

### ComboBox:selectDisplayed(displayIndex)

Accepts an entry of the displayed (possibly filtered) list: fills the
text, closes the list and activates the underlying item.

- **displayIndex** (`integer`) Row in the displayed list

- **returns** (`self`) 

### ComboBox:clear()

Removes all suggestions and closes the dropdown.

- **returns** (`self`) 

### ComboBox:setup()

Initializes per-instance state and input handlers.

### ComboBox:handleMouse(event, btn, x, y)

Routes mouse input in local coordinates (wheel scrolling etc.).

- **event** (`string`) The mouse event name
- **btn** (`number`) Button or scroll direction
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **consumer** (`Element|nil`) The consuming element, or nil to pass through

### ComboBox:handleKey(event, a, b)

Handles keyboard input while focused.

- **event** (`string`) The key event name (key, key_up, char, paste)
- **a** (`any`) Key code or typed text
- **b** (`any`, optional) Secondary key-event value

### ComboBox:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)
