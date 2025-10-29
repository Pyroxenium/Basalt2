# BaseFrame
_This is the root frame class that serves as the foundation for the UI hierarchy. It manages the rendering context and acts as the top-level container for all other elements. Unlike other elements, it renders directly to a terminal or monitor and does not require a parent element._

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
