# List

*extends Collection*

List: scrollable item list with single selection, fires "select".

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| offset | `number` | `0` | first visible item index minus one |
| emptyText | `any` | `""` | centered hint while the list is empty |
| emptyTextColor | `number` | `colors.gray` | Color of the empty-list hint |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| width | `number` | `16` | Width in terminal cells |
| height | `number` | `8` | Height in terminal cells |
| scrollbar | `ItemViewScrollbarMode` | `"auto"` | "auto", "always" or "hidden" |
| scrollbarColor | `number` | `colors.gray` | Scrollbar track color |
| scrollbarThumbColor | `number` | `colors.lightGray` | Scrollbar thumb color |

## Methods

### List:getScrollInfo()

Returns the scrollbar geometry (show, offset, thumb size/position, ...).

- **returns** **geometry** (`ItemViewGeometry`) The itemview geometry for the current state

### List:setOffset(offset)

Scrolls to an absolute offset (clamped to the content).

- **offset** (`number`) Items scrolled past above the viewport

- **returns** (`self`) 

### List:scrollToItem(index)

Scrolls the given item index into view.

- **index** (`number`) The item index to make visible

- **returns** (`self`) 

### List:selectItem(value, emit)

Selects an item (index or value) and scrolls it into view.

- **value** (`any`) Item index or item value
- **emit** (`boolean`, optional) false suppresses the select event

- **returns** (`self`) 

### List:setup()

Initializes per-instance state and input handlers.

### List:handleMouse(event, btn, x, y)

The mouse wheel scrolls the list.

- **event** (`string`) The mouse event name
- **btn** (`number`) Button or scroll direction
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **consumer** (`Element|nil`) The consuming element, or nil to pass through

### List:removeItem(index)

Removes an item and keeps the scroll offset valid.

- **index** (`number`) The item index to remove

- **returns** (`self`) 

### List:handleKey(event, a, b)

Keyboard navigation: arrows, home/end, pageUp/pageDown, enter activates.

- **event** (`string`) The key event name
- **a** (`any`) Key code or character
- **b** (`any`, optional) Secondary key-event value

### List:clear()

Removes all items and resets scrolling.

- **returns** (`self`) 

### List:render(buf)

Renders visible items; supports separator items and per-item colors
(item.fg/item.bg/item.selectedFg/item.selectedBg). An item may also
provide iconChar/iconX plus iconForeground/iconBackground colors for a
separately colored 1x1 glyph inside its text.

- **buf** (`Render`) The render buffer
