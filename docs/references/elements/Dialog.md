# Dialog
_A dialog overlay system that provides common dialog types such as alert, confirm, and prompt._

Extends: `Frame`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|title|string|""|The dialog title|
|primaryColor|color|lime|Primary button color (OK, confirm actions)|
|secondaryColor|color|lightGray|Secondary button color (Cancel, dismiss actions)|
|buttonForeground|color|black|Foreground color for buttons|
|modal|boolean|true|If true, blocks all events outside the dialog|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Dialog:show](#dialog-show)|Dialog|Shows the dialog|
|[Dialog:close](#dialog-close)|Dialog|Closes the dialog|
|[Dialog:alert](#dialog-alert-title-message-callback)|Dialog|Creates a simple alert dialog|
|[Dialog:confirm](#dialog-confirm-title-message-callback)|Dialog|Creates a confirm dialog|
|[Dialog:prompt](#dialog-prompt-title-message-default-callback)|Dialog|Creates a prompt dialog with input|

## Dialog:show()

Shows the dialog

### Returns
* `Dialog` `self` The Dialog instance

## Dialog:close()

Closes the dialog

### Returns
* `Dialog` `self` The Dialog instance

## Dialog:alert(title, message, callback?)

Creates a simple alert dialog

### Parameters
* `title` `string` The alert title
* `message` `string` The alert message
* `callback` *(optional)* `function` Callback when OK is clicked

### Returns
* `Dialog` `self` The Dialog instance

## Dialog:confirm(title, message, callback)

Creates a confirm dialog

### Parameters
* `title` `string` The dialog title
* `message` `string` The confirmation message
* `callback` `function` Callback (receives boolean result)

### Returns
* `Dialog` `self` The Dialog instance

## Dialog:prompt(title, message, default?, callback?)

Creates a prompt dialog with input

### Parameters
* `title` `string` The dialog title
* `message` `string` The prompt message
* `default` *(optional)* `string` Default input value
* `callback` *(optional)* `function` Callback (receives input text or nil if cancelled)

### Returns
* `Dialog` `self` The Dialog instance
