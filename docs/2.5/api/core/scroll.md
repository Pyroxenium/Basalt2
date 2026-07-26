# scroll

Shared scrolling and internal scrollbar rendering for all Containers.

## Methods

### scroll.disable(self)

Resets all scroll state when scrolling is disabled.

- **self** (`Container`) Scrollable container

### scroll.setup(self)

Initializes per-instance state and input handlers.

- **self** (`Container`) Scrollable container

### scroll.update(self)

Recomputes content bounds and visible scrollbar state after layout.

- **self** (`Container`) Scrollable container

### scroll.geometry(self)

Returns viewport and scrollbar geometry for a container.

- **self** (`Container`) Scrollable container

- **returns** **geometry** (`ContainerScrollbarGeometry`) 

### scroll.draw(self, buf)

Draws the scrollbar(s) into the buffer.

- **self** (`Container`) Scrollable container
- **buf** (`Render`) Render buffer

### scroll.set(self, x, y, emit)

Applies clamped scroll offsets.

- **self** (`Container`) Scrollable container
- **x** (`number`) Horizontal offset
- **y** (`number`) Vertical offset
- **emit** (`boolean`, optional) Emit the scroll event unless false

- **returns** **changed** (`boolean`) 

### scroll.wheel(self, direction)

Handles a vertical mouse-wheel movement.

- **self** (`Container`) Scrollable container
- **direction** (`number`) Wheel direction

- **returns** **handled** (`boolean`) 

### scroll.isBarPoint(self, x, y)

Hit-tests a point against the visible scrollbars.

- **self** (`Container`) Scrollable container
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **axis** (`'x'|'y'|'corner'|false`) 
- **returns** **geometry** (`ContainerScrollbarGeometry|nil`) 

### scroll.pointerDown(self, x, y)

Starts a thumb drag or performs a scrollbar page step.

- **self** (`Container`) Scrollable container
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **handled** (`boolean`) 

### scroll.drag(self, x, y)

Updates an active scrollbar thumb drag.

- **self** (`Container`) Scrollable container
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **handled** (`boolean`) 
