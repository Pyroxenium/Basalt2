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
|autoPairEnabled|boolean|true|Whether automatic bracket/quote pairing is enabled|
|autoPairCharacters|table|{|["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing|
|autoPairSkipClosing|boolean|true|Skip inserting a closing char if the same one is already at cursor|
|autoPairOverType|boolean|true|When pressing a closing char that matches the next char, move over it instead of inserting|
|autoPairNewlineIndent|boolean|true|On Enter between matching braces, create blank line and keep closing aligned|
|autoCompleteEnabled|boolean|false|Whether autocomplete suggestions are enabled|
|autoCompleteItems|table|{}|List of suggestions used when no provider is supplied|
|autoCompleteProvider|function|nil|Optional suggestion provider returning a list for the current prefix|
|autoCompleteMinChars|number|1|Minimum characters required before showing suggestions|
|autoCompleteMaxItems|number|6|Maximum number of visible suggestions|
|autoCompleteCaseInsensitive|boolean|true|Whether suggestions should match case-insensitively|
|autoCompleteTokenPattern|string|"[%w_]+"|Pattern used to extract the current token for suggestions|
|autoCompleteOffsetX|number|0|Horizontal offset applied to the popup frame relative to the TextBox|
|autoCompleteOffsetY|number|1|Vertical offset applied to the popup frame relative to the TextBox bottom edge|
|autoCompleteZOffset|number|1|Z-index offset applied to the popup frame|
|autoCompleteMaxWidth|number|0|Maximum width of the autocomplete popup (0 uses the textbox width)|
|autoCompleteShowBorder|boolean|true|Whether to render a character border around the popup|
|autoCompleteBorderColor|color|black|Color of the popup border when enabled|
|autoCompleteBackground|color|lightGray|Background color of the suggestion popup|
|autoCompleteForeground|color|black|Foreground color of the suggestion popup|
|autoCompleteSelectedBackground|color|gray|Background color for the selected suggestion|
|autoCompleteSelectedForeground|color|white|Foreground color for the selected suggestion|
|autoCompleteAcceptOnEnter|boolean|true|Whether pressing Enter accepts the current suggestion|
|autoCompleteAcceptOnClick|boolean|true|Whether clicking a suggestion accepts it immediately|
|autoCompleteCloseOnEscape|boolean|true|Whether pressing Escape closes the popup|

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
