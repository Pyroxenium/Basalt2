# responsive

Optional responsive breakpoints built on element states and layout hooks.

local responsive = basalt.use("responsive")
responsive.apply(panel, {
  { name = "compact", maxWidth = 30,
    props = { direction = "column" } },
  { name = "wide", minWidth = 31,
    props = { direction = "row" } },
})

local sidebar = parent:addFrame()
    :responsive()
        :when("parent.width < 15")
            :apply({ width = 10 })
        :otherwise({ width = 15 })

## Methods

### responsive.apply(element, rules, options)

Attaches ordered responsive breakpoint rules to an element.

- **element** (`Element`) Target element
- **rules** (`table[]`) Responsive rules
- **options** (`table|nil`) Options; exclusive makes only the first match active

- **returns** **element** (`Element`) 

### Builder:when(condition)

Starts the next first-match responsive rule.

- **condition** (`string|function`) Comparison such as "parent.width < 20"

- **returns** **builder** (`ResponsiveBuilder`) 

### Builder:apply(props)

Assigns properties to the preceding when() rule.

- **props** (`table`) Responsive property overrides

- **returns** **builder** (`ResponsiveBuilder`) 

### Builder:otherwise(props)

Adds the fallback rule, installs the finished rules and returns the element.

- **props** (`table`) Responsive property overrides

- **returns** **element** (`Element`) 

### Builder:done()

Installs rules without an otherwise() fallback and returns the element.

- **returns** **element** (`Element`) 

### responsive.builder(element)

Creates a first-match responsive rule builder for an element.

- **element** (`Element`) Target element

- **returns** **builder** (`ResponsiveBuilder`) 

### responsive.get(element)

Returns the responsive controller currently attached to an element.

- **element** (`Element`) Target element

- **returns** **controller** (`table|nil`) 

### Element:setResponsive(rules)

Fluent shortcut for responsive.apply().

- **rules** (`table[]`) Responsive rules

- **returns** (`self`) 

### Element:responsive()

Starts a fluent first-match responsive rule builder.

- **returns** **builder** (`ResponsiveBuilder`) 

```lua
panel:responsive():when("parent.width < 30"):apply({ width = 10 }):otherwise({ width = 20 })
```

### Element:clearResponsive()

Removes responsive rules and their temporary states/styles.

- **returns** (`self`) 
