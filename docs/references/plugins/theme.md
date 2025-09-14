# BaseElement
_This is the theme plugin. It provides a theming system that allows for consistent styling across elements_
_with support for inheritance, named styles, and dynamic theme switching._

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.____getElementPath](#baseelement-----getelementpath)|-||
|[BaseElement:applyTheme](#baseelement-applytheme-self-applytochildren)|BaseElement|Applies theme styles to the element|
|[BaseElement:getTheme](#baseelement-gettheme-self)|table|Gets theme properties for the element|

## BaseElement.____getElementPath()
## BaseElement:applyTheme(self, applyToChildren)

Applies the current theme to this element

### Parameters
* `self` `BaseElement` The element to apply theme to
* `applyToChildren` `boolean` ? Whether to apply theme to child elements (default: true)

### Returns
* `BaseElement` `self` The element instance

## BaseElement:getTheme(self)

Gets the theme properties for this element

### Parameters
* `self` `BaseElement` The element to get theme for

### Returns
* `table` `styles` The theme properties

# ThemeAPI
_The Theme API provides methods for managing themes globally_

## Functions

|Method|Returns|Description|
|---|---|---|
|[ThemeAPI.setTheme](#themeapi-settheme-newtheme)|-|Sets a new theme|
|[ThemeAPI.getTheme](#themeapi-gettheme)|table|Gets the current theme|
|[ThemeAPI.loadTheme](#themeapi-loadtheme-path)|-|Loads theme from JSON file|

## ThemeAPI.setTheme(newTheme)

Sets the current theme

### Parameters
* `newTheme` `table` The theme configuration to set

## ThemeAPI.getTheme()

Gets the current theme configuration

### Returns
* `table` `theme` The current theme configuration

## ThemeAPI.loadTheme(path)

Loads a theme from a JSON file

### Parameters
* `path` `string` Path to the theme JSON file
