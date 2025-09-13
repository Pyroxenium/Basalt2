# PropertySystem
_PropertySystem is a class that allows Elements to have properties that can be observed and updated.
It also allows for properties to have custom getters and setters. This is the base system for all Elements._

## Functions

|Method|Returns|Description|
|---|---|---|
|[PropertySystem.addSetterHook](#propertysystem-addsetterhook-hook)|-|Adds a setter hook to the PropertySystem|
|[PropertySystem.defineProperty](#propertysystem-defineproperty-class-name-config)|-|Defines a property for an element class|
|[PropertySystem.combineProperties](#propertysystem-combineproperties-class-name)|-|Combines multiple properties|
|[PropertySystem.blueprint](#propertysystem-blueprint-elementclass)|table|Creates a blueprint of an element class|
|[PropertySystem.createFromBlueprint](#propertysystem-createfromblueprint-elementclass-blueprint)|table|Creates an element from a blueprint|
|[PropertySystem:__init](#propertysystem---init)|table|Initializes the PropertySystem|
|[PropertySystem:_updateProperty](#propertysystem--updateproperty-name-value)|table|Update call for a property|
|[PropertySystem:observe](#propertysystem-observe-name-callback)|table|Observers a property|
|[PropertySystem:removeObserver](#propertysystem-removeobserver-name-callback)|table|Removes an observer from a property|
|[PropertySystem:removeAllObservers](#propertysystem-removeallobservers-name)|table|Removes all observers from a property|
|[PropertySystem:instanceProperty](#propertysystem-instanceproperty-name-config)|table|Adds a property to the PropertySystem on instance level|
|[PropertySystem:removeProperty](#propertysystem-removeproperty-name)|table|Removes a property from the PropertySystem|
|[PropertySystem:getPropertyConfig](#propertysystem-getpropertyconfig-name)|table|Gets a property configuration|

## PropertySystem.addSetterHook(hook)

Adds a setter hook to the PropertySystem. Setter hooks are functions that are called before a property is set.

### Parameters
* `hook` `function` The hook function to add

## PropertySystem.defineProperty(class, name, config)

Defines a property for an element class

### Parameters
* `class` `table` The element class to define the property for
* `name` `string` The name of the property
* `config` `table` The configuration of the property

## PropertySystem.combineProperties(class, name)

Combines multiple properties into a single getter and setter

### Parameters
* `class` `table` The element class to combine the properties for
* `name` `string` The name of the combined property

## PropertySystem.blueprint(elementClass)

Creates a blueprint of an element class with all its properties

### Parameters
* `elementClass` `table` The element class to create a blueprint from

### Returns
* `table` `blueprint` A table containing all property definitions

## PropertySystem.createFromBlueprint(elementClass, blueprint)

Creates an element from a blueprint

### Parameters
* `elementClass` `table` The element class to create from the blueprint
* `blueprint` `table` The blueprint to create the element from

### Returns
* `table` `element` The created element

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

## PropertySystem:observe(name, callback)

Observers a property

### Parameters
* `name` `string` The name of the property
* `callback` `function` The callback function to call when the property changes

### Returns
* `table` `self` The PropertySystem

## PropertySystem:removeObserver(name, callback)

Removes an observer from a property

### Parameters
* `name` `string` The name of the property
* `callback` `function` The callback function to remove

### Returns
* `table` `self` The PropertySystem

## PropertySystem:removeAllObservers(name?)

Removes all observers from a property

### Parameters
* `name` *(optional)* `string` The name of the property

### Returns
* `table` `self` The PropertySystem

## PropertySystem:instanceProperty(name, config)

Adds a property to the PropertySystem on instance level

### Parameters
* `name` `string` The name of the property
* `config` `table` The configuration of the property

### Returns
* `table` `self` The PropertySystem

## PropertySystem:removeProperty(name)

Removes a property from the PropertySystem on instance level

### Parameters
* `name` `string` The name of the property

### Returns
* `table` `self` The PropertySystem

## PropertySystem:getPropertyConfig(name)

Gets a property configuration

### Parameters
* `name` `string` The name of the property

### Returns
* `table` `config` The configuration of the property
