# ContextMenu

*extends Collection*

ContextMenu: floating menu opened at a position (e.g. on right-click).

  local cm = frame:addContextMenu()
  cm:setItems({ "Copy", "Paste", { separator = true }, "Delete" })
  someElement:onClick(function(_, btn, x, y)
      if btn == 2 then cm:openAt(ax, ay) end   -- parent-local coordinates
  end)
  cm:onSelect(function(_, index, item) ... end)

Closes on selection, focus loss or escape.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| separatorColor | `number` | `colors.gray` | Color of separator entries |
| visible | `boolean` | `false` | Whether the element is shown and hit by events |
| width | `number` | *dynamic* | Width in terminal cells |
| height | `number` | *dynamic* | Height in terminal cells |

## Methods

### ContextMenu:setup()

Initializes per-instance state and input handlers.

### ContextMenu:openAt(x, y)

Opens the menu at parent-local coordinates, clamped into the parent.

- **x** (`number`) Parent-local x position
- **y** (`number`) Parent-local y position

- **returns** (`self`) 

### ContextMenu:close()

Hides the menu.

- **returns** (`self`) 

### ContextMenu:handleKey(event, a, b)

Handles keyboard input while focused.

- **event** (`string`) The key event name (key, key_up, char, paste)
- **a** (`any`) Key code or typed text
- **b** (`any`, optional) Secondary key-event value

### ContextMenu:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)
