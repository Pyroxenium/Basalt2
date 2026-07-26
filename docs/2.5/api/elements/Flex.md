# Flex

*extends Container*

Shared flex-style layout container used by Row and Column.

## Types

### `FlexDirection`

```lua
FlexDirection = "row"|"column"
```

### `FlexJustify`

```lua
FlexJustify = "start"|"center"|"end"|"spaceBetween"
```

### `FlexOverflow`

```lua
FlexOverflow = "clip"
```

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| direction | `FlexDirection` | `"row"` | "row" or "column" |
| gap | `number` | `0` | cells between children on the main axis |
| padding | `number` | `0` | inner spacing on all sides |
| align | `ElementAlignment` | `"start"` | cross axis: start, center, end, stretch |
| justify | `FlexJustify` | `"start"` | main axis: start, center, end, between |
| overflow | `FlexOverflow` | `"clip"` | how overflowing children behave |
| background | `number\|false` | `false` | Background color (false = transparent) |

## Methods

### Flex:measure(availableWidth, availableHeight)

Intrinsic size: sum of the children along the main axis plus gaps
and padding (used by basalt.auto()).

- **availableWidth** (`number`, optional) Space offered by the parent
- **availableHeight** (`number`, optional) Space offered by the parent

- **returns** **width** (`number`) The measured width
- **returns** **height** (`number`) The measured height

### Flex:layoutChildren()

Positions all children according to direction/gap/align/justify;
called automatically before every render pass.
