# PropertySystem
PropertySystem is a class that allows Elements to have properties that can be observed and updated.
It also allows for properties to have custom getters and setters. This is the base system for all Elements.

## Fields

|Field|Type|Description|
|---|---|---|
|_properties|`table`|A table containing all property configurations|
|_values|`table`|A table containing all property values|
|_observers|`table`|A table containing all property observers|
|set|`function`|A function to set a property value|
|get|`function`|A function to get a property value|

## Functions

|Method|Returns|Description|
|---|---|---|
|[PropertySystem.addSetterHook](#PropertySystem.addSetterHook)|-|Adds a setter hook to the PropertySystem
|[PropertySystem.blueprint](#PropertySystem.blueprint)|table|Creates a blueprint of an element class
|[PropertySystem.combineProperties](#PropertySystem.combineProperties)|-|Combines multiple properties
|[PropertySystem.createFromBlueprint](#PropertySystem.createFromBlueprint)|table|Creates an element from a blueprint
|[PropertySystem.defineProperty](#PropertySystem.defineProperty)|-|Defines a property for an element class
|[PropertySystem:__init](#PropertySystem:__init)|table|Initializes the PropertySystem
|[PropertySystem:_updateProperty](#PropertySystem:_updateProperty)|table|Update call for a property
|[PropertySystem:getPropertyConfig](#PropertySystem:getPropertyConfig)|table|Gets a property configuration
|[PropertySystem:instanceProperty](#PropertySystem:instanceProperty)|table|Adds a property to the PropertySystem on instance level
|[PropertySystem:observe](#PropertySystem:observe)|table|Observers a property
|[PropertySystem:removeAllObservers](#PropertySystem:removeAllObservers)|table|Removes all observers from a property
|[PropertySystem:removeObserver](#PropertySystem:removeObserver)|table|Removes an observer from a property
|[PropertySystem:removeProperty](#PropertySystem:removeProperty)|table|Removes a property from the PropertySystem


## PropertySystem.addSetterHook(hook)
Adds a setter hook to the PropertySystem. Setter hooks are functions that are called before a property is set.

### Parameters
* `hook` `function` The hook function to add

## PropertySystem.blueprint(elementClass)
Creates a blueprint of an element class with all its properties

### Parameters
* `elementClass` `table` The element class to create a blueprint from

### Returns
* `table` `blueprint` A table containing all property definitions

## PropertySystem.combineProperties(class, name...)
Combines multiple properties into a single getter and setter

### Parameters
* `class` `table` The element class to combine the properties for
* `name` `string` The name of the combined property
* `...` *(vararg)* `string` The names of the properties to combine

## PropertySystem.createFromBlueprint(elementClass, blueprint)
Creates an element from a blueprint

### Parameters
* `elementClass` `table` The element class to create from the blueprint
* `blueprint` `table` The blueprint to create the element from

### Returns
* `table` `element` The created element

## PropertySystem.defineProperty(class, name, config)
Defines a property for an element class

### Parameters
* `class` `table` The element class to define the property for
* `name` `string` The name of the property
* `config` `table` The configuration of the property

## PropertySystem:__init()
Initializes the PropertySystem IS USED INTERNALLY

### Returns
* `table` `self` The PropertySystem

## PropertySystem:_updateProperty(name, value)
Update call for a property IS USED INTERNALLY

### Parameters
* `name` `string` The name of the property
* `value` `any` The value of the property

### Returns
* `table` `self` The PropertySystem

## PropertySystem:getPropertyConfig(name)
Gets a property configuration

### Parameters
* `name` `string` The name of the property

### Returns
* `table` `config` The configuration of the property

## PropertySystem:instanceProperty(name, config)
Adds a property to the PropertySystem on instance level

### Parameters
* `name` `string` The name of the property
* `config` `table` The configuration of the property

### Returns
* `table` `self` The PropertySystem

## PropertySystem:observe(name, callback)
Observers a property

### Parameters
* `name` `string` The name of the property
* `callback` `function` The callback function to call when the property changes

### Returns
* `table` `self` The PropertySystem

## PropertySystem:removeAllObservers(name)
Removes all observers from a property

### Parameters
* `name` `string` The name of the property

### Returns
* `table` `self` The PropertySystem

## PropertySystem:removeObserver(name, callback)
Removes an observer from a property

### Parameters
* `name` `string` The name of the property
* `callback` `function` The callback function to remove

### Returns
* `table` `self` The PropertySystem

## PropertySystem:removeProperty(name)
Removes a property from the PropertySystem on instance level

### Parameters
* `name` `string` The name of the property

### Returns
* `table` `self` The PropertySystem


