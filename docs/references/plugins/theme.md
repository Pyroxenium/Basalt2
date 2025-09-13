# BaseElement
This is the theme plugin. It provides a theming system that allows for consistent styling across elements
with support for inheritance, named styles, and dynamic theme switching.

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:applyTheme](#baseelement-applytheme)|BaseElement|Applies theme styles to the element
|[BaseElement:getTheme](#baseelement-gettheme)|table|Gets theme properties for the element


## BaseElement:applyTheme(self, applyToChildren)
Applies the current theme to this element

### Parameters
* `self` `BaseElement` The element to apply theme to
* `applyToChildren` `boolean?` Whether to apply theme to child elements (default: true)

### Returns
* `BaseElement` `self` The element instance

## BaseElement:getTheme(self)
Gets the theme properties for this element

### Parameters
* `self` `BaseElement` The element to get theme for

### Returns
* `table` `styles` The theme properties


---
<br>

# ThemeAPI
The Theme API provides methods for managing themes globally

## Functions

|Method|Returns|Description|
|---|---|---|
|[ThemeAPI.getTheme](#themeapi-gettheme)|table|Gets the current theme
|[ThemeAPI.loadTheme](#themeapi-loadtheme)|-|Loads theme from JSON file
|[ThemeAPI.setTheme](#themeapi-settheme)|-|Sets a new theme


## ThemeAPI.getTheme()
Gets the current theme configuration

### Returns
* `table` `theme` The current theme configuration

## ThemeAPI.loadTheme(path)
Loads a theme from a JSON file

### Parameters
* `path` `string` Path to the theme JSON file

## ThemeAPI.setTheme(newTheme)
Sets the current theme

### Parameters
* `newTheme` `table` The theme configuration to set


