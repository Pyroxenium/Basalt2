# BaseElement
This is the theme plugin. It provides a theming system that allows for consistent styling across elements
with support for inheritance, named styles, and dynamic theme switching.

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:applyTheme](#BaseElement:applyTheme)|BaseElement|Applies theme styles to the element
|[BaseElement:getTheme](#BaseElement:getTheme)|table|Gets theme properties for the element


## BaseElement:applyTheme(self)
Applies the current theme to this element

### Parameters
* `self` `BaseElement` The element to apply theme to

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
|[themeAPI.getTheme](#themeAPI.getTheme)|table|Gets the current theme
|[themeAPI.loadTheme](#themeAPI.loadTheme)|-|Loads theme from JSON file
|[themeAPI.setTheme](#themeAPI.setTheme)|-|Sets a new theme


## themeAPI.getTheme()
Gets the current theme configuration

### Returns
* `table` `theme` The current theme configuration

## themeAPI.loadTheme(path)
Loads a theme from a JSON file

### Parameters
* `path` `string` Path to the theme JSON file

## themeAPI.setTheme(newTheme)
Sets the current theme

### Parameters
* `newTheme` `table` The theme configuration to set


