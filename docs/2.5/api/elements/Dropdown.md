# Dropdown

*extends Collection*

Dropdown: collapsed selection row that expands to an item list.
Fires "select"; closes on selection, on toggle, or when focus moves away.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| text | `any` | `"Select..."` | placeholder while nothing is selected |
| dropHeight | `number` | `6` | maximum visible list rows |
| offset | `number` | `0` | list scroll offset |
| background | `number\|false` | `colors.gray` | Background color (false = transparent) |
| dropBackground | `number` | `colors.black` | open list background |
| width | `number` | `14` | Width in terminal cells |
| scrollbar | `ItemViewScrollbarMode` | `"auto"` | "auto", "always" or "hidden" |
| scrollbarColor | `number` | `colors.gray` | Scrollbar track color |
| scrollbarThumbColor | `number` | `colors.lightGray` | Scrollbar thumb color |
| height | `number` | *dynamic* | Follows the open state; setting it explicitly breaks expansion |
| open | `boolean` | `false` | Whether the list is expanded; the element floats above siblings while open |

## Methods

### Dropdown:getScrollInfo()

Returns the scrollbar geometry of the open list.

- **returns** **geometry** (`ItemViewGeometry`) The itemview geometry

### Dropdown:setOffset(offset)

Scrolls the open list to an absolute offset (clamped).

- **offset** (`number`) Items scrolled past above the viewport

- **returns** (`self`) 

### Dropdown:scrollToItem(index)

Scrolls the given item index into the visible list area.

- **index** (`number`) The item index to make visible

- **returns** (`self`) 

### Dropdown:select(index, emit)

Selects an item, closes the list and fires the select event.

- **index** (`integer`) The item index to select
- **emit** (`boolean`, optional) false suppresses the select event

- **returns** (`self`) 

### Dropdown:setup()

Initializes per-instance state and input handlers.

### Dropdown:clear()

Removes all entries and resets selection, scroll and open state.

- **returns** (`self`) 

### Dropdown:removeItem(index)

Removes an entry and clamps the dropdown scroll offset.

- **index** (`integer|CollectionEntry`) Item index or entry

- **returns** (`self`) 

### Dropdown:handleMouse(event, btn, x, y)

Routes mouse input in local coordinates (wheel scrolling etc.).

- **event** (`string`) The mouse event name
- **btn** (`number`) Button or scroll direction
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **consumer** (`Element|nil`) The consuming element, or nil to pass through

### Dropdown:handleKey(event, a, b)

Handles keyboard input while focused.

- **event** (`string`) The key event name (key, key_up, char, paste)
- **a** (`any`) Key code or typed text
- **b** (`any`, optional) Secondary key-event value

### Dropdown:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)
