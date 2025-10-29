# ElementManager
_This class manages elements and plugins. It loads elements and plugins from the elements and plugins directories_
_and then applies the plugins to the elements. It also provides a way to get elements and APIs._

## Functions

|Method|Returns|Description|
|---|---|---|
|[ElementManager.configure](#elementmanager-configure-config)|-|Configures the ElementManager|
|[ElementManager.registerDiskMount](#elementmanager-registerdiskmount-mountpath)|-|Registers a disk mount point for loading elements|
|[ElementManager.registerRemoteSource](#elementmanager-registerremotesource-elementname-url)|-|Registers a remote source for an element|
|[ElementManager.tryAutoLoad](#elementmanager-tryautoload-name)|boolean|Tries to load an element from any available source|
|[ElementManager.loadElement](#elementmanager-loadelement-name)|-|Loads an element by name. This will load the element and apply any plugins to it.|
|[ElementManager.getElement](#elementmanager-getelement-name)|table|Gets an element by name. If the element is not loaded, it will try to load it first.|
|[ElementManager.getElementList](#elementmanager-getelementlist)|table|Gets a list of all elements|
|[ElementManager.getAPI](#elementmanager-getapi-name)|table|Gets an Plugin API by name|
|[ElementManager.hasElement](#elementmanager-haselement-name)|boolean|Checks if an element exists (is registered)|
|[ElementManager.isElementLoaded](#elementmanager-iselementloaded-name)|boolean|Checks if an element is loaded|
|[ElementManager.clearGlobalCache](#elementmanager-clearglobalcache)|-|Clears the global cache (_G)|
|[ElementManager.getCacheStats](#elementmanager-getcachestats)|table|Gets cache statistics|
|[ElementManager.preloadElements](#elementmanager-preloadelements-elementnames)|-|Preloads elements into the global cache|

## ElementManager.configure(config)

Configures the ElementManager

### Parameters
* `config` `table` Configuration options

## ElementManager.registerDiskMount(mountPath)

Registers a disk mount point for loading elements

### Parameters
* `mountPath` `string` The path to the disk mount

## ElementManager.registerRemoteSource(elementName, url)

Registers a remote source for an element

### Parameters
* `elementName` `string` The name of the element
* `url` `string` The URL to load the element from

## ElementManager.tryAutoLoad(name)

Tries to load an element from any available source

### Parameters
* `name` `string` The element name

### Returns
* `boolean` `success` Whether the element was loaded

## ElementManager.loadElement(name)

Loads an element by name. This will load the element and apply any plugins to it.

### Parameters
* `name` `string` The name of the element to load

### Usage
```lua run
ElementManager.loadElement("Button")
```

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

## ElementManager.getAPI(name)

Gets an Plugin API by name

### Parameters
* `name` `string` The name of the API to get

### Returns
* `table` `API` The API

## ElementManager.hasElement(name)

Checks if an element exists (is registered)

### Parameters
* `name` `string` The element name

### Returns
* `boolean` `exists` Whether the element exists

## ElementManager.isElementLoaded(name)

Checks if an element is loaded

### Parameters
* `name` `string` The element name

### Returns
* `boolean` `loaded` Whether the element is loaded

## ElementManager.clearGlobalCache()

Clears the global cache (_G)

### Usage
```lua run
ElementManager.clearGlobalCache()
```

## ElementManager.getCacheStats()

Gets cache statistics

### Returns
* `table` `stats` Cache statistics with size and element names

## ElementManager.preloadElements(elementNames)

Preloads elements into the global cache

### Parameters
* `elementNames` `table` List of element names to preload
