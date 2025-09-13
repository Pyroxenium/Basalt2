# Display
_The Display is a special element where you can use the window (term) API to draw on the display, useful when you need to use external APIs._

Extends: `VisualElement`

## Functions

|Method|Returns|Description|
|---|---|---|
|[Display.new](#display-new)|table|Creates a new Display instance|
|[Display:Display](#display-display-props-basalt)|-|Initializes the Display instance|
|[Display:Display](#display-display)|table|Returns the current window object|
|[Display:Display](#display-display-x-y-text-fg-bg)|Display|Writes text to the display|
|[Display:Display](#display-display)|-|Renders the Display|

## Display.new()
### Returns
* `table` `self` The created instance

## Display:Display(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Display:Display()

Returns the current window object

### Returns
* `table` `window` The current window object

## Display:Display(x, y, text, fg?, bg?)

Writes text to the display at the given position with the given foreground and background colors

### Parameters
* `x` `number` The x position to write to
* `y` `number` The y position to write to
* `text` `string` The text to write
* `fg` *(optional)* `colors` The foreground color (optional)
* `bg` *(optional)* `colors` The background color (optional)

### Returns
* `Display` `self` The display instance

## Display:Display()