# BaseFrame
_This is the base frame class. It is the root element of all elements and the only element without a parent._

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|term|term|peripheral|term.current()|The terminal or (monitor) peripheral object to render to|

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame:setCursor](#baseframe-setcursor-x-y-blink)|-|Sets the cursor position|

## BaseFrame:setCursor(x, y, blink)

Sets the cursor position

### Parameters
* `x` `number` The x position to set the cursor to
* `y` `number` The y position to set the cursor to
* `blink` `boolean` Whether the cursor should blink
