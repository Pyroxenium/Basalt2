# palette

Color engine for Basalt: more than 16 colors on a 16-color terminal.

Every color that can appear on screen is an entry in a global registry
(index 0-255). Indices 0-15 are the native CC colors; palette.rgb()
registers custom colors above that. The render buffer stores registry
indices as raw bytes. At flush time a per-terminal Mapper assigns the 16
hardware palette slots to whatever registry colors are actually visible:
 * native colors always keep their own slot,
 * custom colors take over the slots of native colors that are NOT
   currently on screen (via term.setPaletteColour),
 * anything beyond 16 simultaneous colors falls back to the nearest
   currently-assigned color.
Slot assignments are sticky between frames to avoid palette flicker.

## Types

### `PaletteTranslationMap`

```lua
PaletteTranslationMap = table<string, string>
```

### `PaletteUsedColors`

```lua
PaletteUsedColors = table<integer, boolean>
```

### `PaletteTerminal`

| Field | Type | Description |
| --- | --- | --- |
| setPaletteColour *(optional)* | `fun(color: number, r: number, g: number, b: number)` |  |
| setPaletteColor *(optional)* | `fun(color: number, r: number, g: number, b: number)` |  |
| getPaletteColour *(optional)* | `fun(color: number): number, number, number` |  |
| getPaletteColor *(optional)* | `fun(color: number): number, number, number` |  |

### `Mapper`

-------------------------------------------------------------------------

| Field | Type | Description |
| --- | --- | --- |
| term | `PaletteTerminal` | Terminal controlled by this mapper |
| overridden | `table<integer, integer>` | Registry index loaded into each overridden slot |
| prevSlot | `table<integer, integer>` | Previous hardware slot per registry index |
| prevMap | `PaletteTranslationMap` | Previous byte-to-blit translation |

## Methods

### palette.getRGB(value)

Resolves a registry byte/index or public color handle to RGB floats.

- **value** (`string|number`) Registry byte, registry index, or colors.* handle

- **returns** **r** (`number`) 
- **returns** **g** (`number`) 
- **returns** **b** (`number`) 

### palette.rgb(r, g, b)

Registers or resolves an RGB color for use by the render buffer.

- **r** (`number|string`) Red component or #RRGGBB string
- **g** (`number`, optional) Green component
- **b** (`number`, optional) Blue component

- **returns** **color** (`number`) 

### palette.hasVirtual()

Returns whether custom palette colors are currently registered.

- **returns** **hasCustomColors** (`boolean`) 

### palette.windowTranslation(win)

Builds a blit-hex -> registry-byte translation for a hosted CC window.
Returns nil when the window palette is untouched (identity is cheaper).

- **win** (`PaletteTerminal`) CC window or compatible terminal

- **returns** **translate** (`PaletteTranslationMap|nil`) 

### palette.newMapper(t)

Creates a palette mapper for one terminal.

- **t** (`PaletteTerminal`) Terminal-like object

- **returns** **mapper** (`Mapper`) 

### Mapper:build(used)

Assigns hardware palette slots for the colors used by this frame.

- **used** (`PaletteUsedColors`) Registry indices used by this frame

- **returns** **map** (`PaletteTranslationMap`) Registry byte to terminal blit character
- **returns** **changed** (`boolean`) 

### Mapper:restore()

Restores terminal palette colors changed by this mapper.
