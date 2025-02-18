# ElementManager
This class manages elements and plugins. It loads elements and plugins from the elements and plugins directories
and then applies the plugins to the elements. It also provides a way to get elements and APIs.

## Functions

|Method|Returns|Description|
|---|---|---|
|[ElementManager.getAPI](#ElementManager.getAPI)|table|
|[ElementManager.getElement](#ElementManager.getElement)|table|
|[ElementManager.getElementList](#ElementManager.getElementList)|table|
|[ElementManager.loadElement](#ElementManager.loadElement)|-|

## ElementManager.getAPI(name)
Gets an Plugin API by name

### Parameters
* `name` `string` The name of the API to get

### Returns
* `table` `API` The API

## ElementManager.getElement(name)
Gets an element by name. If the element is not loaded, it will try to load it first.

### Parameters
* `name` `string` The name of the element to get

### Returns
* `table` `Element` The element class

## ElementManager.getElementList()
Gets a list of all elements

### Returns
* `table` `ElementList` A list of all elements

## ElementManager.loadElement(name)
Loads an element by name. This will load the element and apply any plugins to it.

### Parameters
* `name` `string` The name of the element to load

### Usage
 ```lua
ElementManager.loadElement("Button")
```


