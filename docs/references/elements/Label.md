# Label
_This is the label class. It provides a simple text display element that automatically
resizes its width based on the text content._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|Label|The text content to display. Can be a string or a function that returns a string|
|autoSize|boolean|true|Whether the label should automatically resize its width based on the text content|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Label.new](#label-new)|Label|Creates a new Label instance|
|[Label:Label](#label-label-props-basalt)|Label|Initializes the Label instance|
|[Label:Label](#label-label)|table|Gets the wrapped lines of the Label|
|[Label:Label](#label-label)|-|Renders the Label by drawing its text content|

## Label.new()

Creates a new Label instance

### Returns
* `Label` `self` The newly created Label instance

## Label:Label(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Label` `self` The initialized instance

## Label:Label()

Gets the wrapped lines of the Label

### Returns
* `table` `wrappedText` The wrapped lines of the Label

## Label:Label()