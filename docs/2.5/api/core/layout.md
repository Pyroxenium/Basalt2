# layout

Responsive layout primitives and shared geometry helpers.

## Types

### `LayoutValueKind`

```lua
LayoutValueKind = "auto"|"fill"|"percent"
```

### `LayoutAxis`

```lua
LayoutAxis = "width"|"height"
```

### `LayoutSpecification`

```lua
LayoutSpecification = number|string|LayoutValue
```

### `LayoutValue`

| Field | Type | Description |
| --- | --- | --- |
| kind | `LayoutValueKind` | Layout behavior |
| value *(optional)* | `number` | Fill weight or parent-size fraction |

## Methods

### layout.auto()

Creates an intrinsic-size layout value.

- **returns** **value** (`LayoutValue`) 

### layout.fill(weight)

Creates a weighted fill layout value.

- **weight** (`number`, optional) Fill weight, default 1

- **returns** **value** (`LayoutValue`) 

### layout.percent(amount)

Creates a fractional parent-size layout value (1 = 100%).

- **amount** (`number`) Fraction of available size

- **returns** **value** (`LayoutValue`) 

### layout.is(value)

Tests whether a value is a Basalt layout token.

- **value** (`any`) Candidate value

- **returns** **isLayoutValue** (`boolean`) 

### layout.spec(el, propName)

Returns an authored/resolved property before token-to-number conversion.

- **el** (`Element`) Element
- **propName** (`string`) Property name

- **returns** **specification** (`any`) 

### layout.constrain(el, axis, value)

Applies min/max constraints and integer rounding to an axis size.

- **el** (`Element`) Element
- **axis** (`LayoutAxis`) Axis
- **value** (`number`) Proposed value

- **returns** **size** (`integer`) 

### layout.measure(el, availableWidth, availableHeight)

Intrinsic size for basalt.auto().

- **el** (`Element`) Element to measure
- **availableWidth** (`number`, optional) Available width
- **availableHeight** (`number`, optional) Available height

- **returns** **width** (`number`) The measured width
- **returns** **height** (`number`) The measured height

### layout.resolveSize(el, axis, spec, availableWidth, availableHeight)

Resolves one authored size specification to terminal cells.

- **el** (`Element`) Element being measured
- **axis** (`LayoutAxis`) Axis to resolve
- **spec** (`LayoutSpecification`) Numeric size or layout token
- **availableWidth** (`number`) Available width
- **availableHeight** (`number`) Available height

- **returns** **size** (`integer`) 

### layout.resolveToken(value, el, propName)

Resolves a token read before a formal layout pass (useful for inspection).

- **value** (`LayoutValue`) Layout token
- **el** (`Element`) Owning element
- **propName** (`LayoutAxis`) Property being resolved

- **returns** **value** (`integer`) 

### layout.resolveFreeChild(parent, child)

Resolves auto/fill/percent for a child of an ordinary absolute container.

- **parent** (`Container`) Parent container
- **child** (`Element`) Child element

### layout.resolveFreeChildren(parent)

Resolves layout tokens for every child of an absolute container.

- **parent** (`Container`) Parent container

### layout.setBox(el, x, y, width, height)

Stores a resolved layout box and invalidates changed nested layouts.

- **el** (`Element`) Element to update
- **x** (`number`) Resolved x position
- **y** (`number`) Resolved y position
- **width** (`number`) Resolved width
- **height** (`number`) Resolved height
