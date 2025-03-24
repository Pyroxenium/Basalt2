# BaseFrame : Container
This is the base frame class. It is the root element of all elements and the only element without a parent.

## Fields

|Field|Type|Description|
|---|---|---|
|_render|`Render`|The render object|
|_renderUpdate|`boolean`|Whether the render object needs to be updated|
|_peripheralName|`string`|The name of a peripheral|

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|term|term|peripheral|term.current()|The terminal or (monitor) peripheral object to render to

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame:dispatchEvent](#baseframe-dispatchevent)|-|
|[BaseFrame:setCursor](#baseframe-setcursor)|-|Sets the cursor position


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|BaseFrame:blit|-|Renders a text with a foreground and background color to the render Object
|BaseFrame:char|-|Handles character events
|BaseFrame:init|table|Initializes the Frame instance
|BaseFrame:key|-|Handles key events
|BaseFrame:key_up|-|Handles key up events
|BaseFrame:monitor_touch|-|Handles monitor touch events
|BaseFrame:mouse_click|-|Handles mouse click events
|BaseFrame:mouse_up|-|Handles mouse up events
|BaseFrame:multiBlit|-|Renders a multiBlit to the render Object
|BaseFrame:render|-|Renders the Frame
|BaseFrame:term_resize|-|Resizes the Frame
|BaseFrame:textBg|-|Renders a text with a background color to the render Object
|BaseFrame:textFg|-|Renders a text with a foreground color to the render Object

## BaseFrame:dispatchEvent()

## BaseFrame:setCursor(x, y, blink)
Sets the cursor position

### Parameters
* `x` `number` The x position to set the cursor to
* `y` `number` The y position to set the cursor to
* `blink` `boolean` Whether the cursor should blink


