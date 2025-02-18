# BaseElement
The XML plugin provides XML parsing and UI creation from XML markup

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:fromXML](#BaseElement:fromXML)|BaseElement|Creates element from XML node

## BaseElement:fromXML(self, node)
Creates an element from an XML node

### Parameters
* `self` `BaseElement` The element instance
* `node` `table` The XML node to create from

### Returns
* `BaseElement` `self` The element instance


---
<br>

# Container

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container:loadXML](#Container:loadXML)|Container|Loads UI from XML string

## Container:loadXML(self, content, scope?)
Loads and creates UI elements from XML content
local xml = [[
<Frame>
<Button name="myButton" x="5" y="5"/>
</Frame>
]]
container:loadXML(xml)

### Parameters
* `self` `Container` The container to load into
* `content` `string` The XML content to parse
* `scope` *(optional)* `table` Optional scope for variable resolution

### Returns
* `Container` `self` The container instance

### Usage
 ```lua

```


