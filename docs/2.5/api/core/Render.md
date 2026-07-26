# Render

Render buffer for Basalt.

Holds the screen as three string arrays (text / fg / bg). Colors are stored
as raw bytes (registry indices from core/palette), which is what allows
more than 16 colors in the buffer. On flush, only lines that actually
differ from what the terminal currently shows are blitted, and color bytes
are translated to blit hex chars through the palette mapper.

## Types

### `RenderLineBuffer`

```lua
RenderLineBuffer = string[]
```

### `RenderPixelRows`

```lua
RenderPixelRows = string[]
```

### `RenderPixelPalette`

```lua
RenderPixelPalette = table<integer, string>
```

### `RenderTerminal`

*extends PaletteTerminal*

| Field | Type | Description |
| --- | --- | --- |
| getSize | `fun(): integer, integer` |  |
| setCursorPos | `fun(x: number, y: number)` |  |
| setCursorBlink | `fun(blink: boolean)` |  |
| setTextColor | `fun(color: number)` |  |
| blit | `fun(text: string, foreground: string, background: string)` |  |

## Methods

### Render.new(t)

Creates a retained terminal render buffer.

- **t** (`RenderTerminal`) Terminal-like target

- **returns** **buffer** (`Render`) 

### Render:resize(w, h)

Resizes and clears the retained buffer.

- **w** (`integer`) Width
- **h** (`integer`) Height

- **returns** (`self`) 

### Render:push(x, y, w, h)

Pushes a child region: translates the origin to (x, y) in the current
space and intersects the clip rect with the w*h area.

- **x** (`number`) Child x position
- **y** (`number`) Child y position
- **w** (`number`) Child width
- **h** (`number`) Child height

- **returns** (`self`) 

### Render:pop()

Restores the previous origin and clipping rectangle.

- **returns** (`self`) 

### Render:write(x, y, str, fgChar, bgChar)

Core write. fgChar/bgChar are single-byte strings or nil (keep existing).

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text to write
- **fgChar** (`string|nil`) Encoded foreground bytes
- **bgChar** (`string|nil`) Encoded background bytes

- **returns** (`self`) 

### Render:blit(x, y, str, fg, bg)

Writes text with optional fg/bg colors (public color values, nil = keep).

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text to write
- **fg** (`number|nil`) Foreground color
- **bg** (`number|nil`) Background color

- **returns** (`self`) 

### Render:colorBlit(x, y, str, foregrounds, backgrounds)

Writes a row whose cells may each use a different public color value.
This is the efficient path for custom-painted editors and charts: it
performs one clipped line splice instead of one splice per cell.

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text to write
- **foregrounds** (`number[]`) Foreground color for each character
- **backgrounds** (`number[]`) Background color for each character

- **returns** (`self`) 

### Render:drawText(x, y, str)

Writes plain text, keeping the colors underneath.
(named drawText because .text is the buffer's line array)

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text to write

- **returns** (`self`) 

### Render:rawBlit(x, y, str, fgStr, bgStr)

Writes a pre-encoded span: fgStr/bgStr are byte strings (registry
indices) with the same length as str, or nil to keep existing colors.

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text to write
- **fgStr** (`string|nil`) Encoded foreground bytes
- **bgStr** (`string|nil`) Encoded background bytes

- **returns** (`self`) 

### Render:maskedBlit(x, y, str, fgStr, bgStr, textMask, fgMask, bgMask)

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text plane
- **fgStr** (`string`, optional) Encoded foreground plane
- **bgStr** (`string`, optional) Encoded background plane
- **textMask** (`string`, optional) Text visibility mask
- **fgMask** (`string`, optional) Foreground visibility mask
- **bgMask** (`string`, optional) Background visibility mask

- **returns** (`self`) 

### Render:drawPixels(x, y, pixelWidth, pixelHeight, rows, paletteBytes)

- **x** (`number`) X position in terminal cells
- **y** (`number`) Y position in terminal cells
- **pixelWidth** (`integer`) Source width in virtual pixels
- **pixelHeight** (`integer`) Source height in virtual pixels
- **rows** (`RenderPixelRows`) Palette-index rows; byte zero is transparent
- **paletteBytes** (`RenderPixelPalette`) Palette index to registry byte

- **returns** (`self`) 

### Render:drawBlit(x, y, str, fgHex, bgHex)

Writes a blit triple with hex color strings ("0"-"f"), e.g. straight
from window.getLine() — used to embed foreign terminal content.

- **x** (`number`) X position
- **y** (`number`) Y position
- **str** (`string`) Text to write
- **fgHex** (`string|nil`) Foreground blit string
- **bgHex** (`string|nil`) Background blit string

- **returns** (`self`) 

### Render:fill(x, y, w, h, ch, fg, bg)

Fills a w*h area with a character and optional colors.

- **x** (`number`) X position
- **y** (`number`) Y position
- **w** (`number`) Width
- **h** (`number`) Height
- **ch** (`string`) Fill character
- **fg** (`number|nil`) Foreground color
- **bg** (`number|nil`) Background color

- **returns** (`self`) 

### Render:setCursor(x, y, blink, color)

Stores the cursor state to present during the next flush.

- **x** (`number`) Cursor x
- **y** (`number`) Cursor y
- **blink** (`boolean`) Blink state
- **color** (`number|nil`) Cursor color

- **returns** (`self`) 

### Render:flush()

Diffs the buffer against the terminal state and blits changed lines only.

- **returns** (`self`) 
