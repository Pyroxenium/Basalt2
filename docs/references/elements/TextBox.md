# TextBox
_A multi-line text editor component with cursor support and text manipulation features_

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|lines|table|{}|Array of text lines|
|cursorX|number|1|Cursor X position|
|cursorY|number|1|Cursor Y position (line number)|
|scrollX|number|0|Horizontal scroll offset|
|scrollY|number|0|Vertical scroll offset|
|editable|boolean|true|Whether text can be edited|
|syntaxPatterns|table|{}|Syntax highlighting patterns|
|cursorColor|number|nil|Color of the cursor|

## Functions

|Method|Returns|Description|
|---|---|---|
|[TextBox:addSyntaxPattern](#textbox-addsyntaxpattern-pattern-color)|TextBox|Adds a new syntax highlighting pattern|
|[TextBox:removeSyntaxPattern](#textbox-removesyntaxpattern-index)|TextBox|Removes a syntax pattern by index (1-based)|
|[TextBox:clearSyntaxPatterns](#textbox-clearsyntaxpatterns)|TextBox|Clears all syntax highlighting patterns|
|[TextBox:updateViewport](#textbox-updateviewport)|TextBox|Updates the viewport to keep the cursor in view|
|[TextBox:setText](#textbox-settext-text)|TextBox|Sets the text of the TextBox|
|[TextBox:getText](#textbox-gettext)|string|Gets the text of the TextBox|

## TextBox:addSyntaxPattern(pattern, color)

Adds a new syntax highlighting pattern

### Parameters
* `pattern` `string` The regex pattern to match
* `color` `number` The color to apply

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:removeSyntaxPattern(index)

Removes a syntax pattern by index (1-based)

### Parameters
* `index` `number` The index of the pattern to remove

### Returns
* `TextBox` self

## TextBox:clearSyntaxPatterns()

Clears all syntax highlighting patterns

### Returns
* `TextBox` self

## TextBox:updateViewport()

Updates the viewport to keep the cursor in view

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:setText(text)

Sets the text of the TextBox

### Parameters
* `text` `string` The text to set

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:getText()

Gets the text of the TextBox

### Returns
* `string` `text` The text of the TextBox
