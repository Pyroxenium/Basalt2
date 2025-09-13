# Label : VisualElement
This is the label class. It provides a simple text display element that automatically
resizes its width based on the text content.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|Label|The text content to display. Can be a string or a function that returns a string
|autoSize|boolean|true|Whether the label should automatically resize its width based on the text content

## Functions

|Method|Returns|Description|
|---|---|---|
|[Label:getWrappedText](#label-getwrappedtext)|table|Gets the wrapped lines of the Label


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Label:init|Label|Initializes the Label instance
|Label:render|-|Renders the Label by drawing its text content

## Label:getWrappedText()
Gets the wrapped lines of the Label

### Returns
* `table` `wrappedText` The wrapped lines of the Label


