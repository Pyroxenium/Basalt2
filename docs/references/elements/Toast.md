# Toast
_A toast notification element that displays temporary messages with optional icons and auto-hide functionality._
_The element is always visible but only renders content when a message is shown._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|title|string|""|The title text of the toast|
|message|string|""|The message text of the toast|
|duration|number|3|Duration in seconds before the toast auto-hides|
|toastType|string|"default"|Type of toast: default, success, error, warning, info|
|callback|function|nil|Callback function to call when the toast hides|
|autoHide|boolean|true|Whether the toast should automatically hide after duration|
|active|boolean|false|Whether the toast is currently showing a message|
|colorMap|table|Map|of toast types to their colors|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Toast:show](#toast-show-titleormessage-messageorduration-duration-callback)|Toast|Shows a toast message|
|[Toast:hide](#toast-hide)|Toast|Hides the toast|
|[Toast:success](#toast-success-titleormessage-messageorduration-duration-callback)|Toast|Shows a success toast|
|[Toast:error](#toast-error-titleormessage-messageorduration-duration-callback)|Toast|Shows an error toast|
|[Toast:warning](#toast-warning-titleormessage-messageorduration-duration-callback)|Toast|Shows a warning toast|
|[Toast:info](#toast-info-titleormessage-messageorduration-duration-callback)|Toast|Shows an info toast|

## Toast:show(titleOrMessage, messageOrDuration?, duration?, callback?)

Shows a toast message

### Parameters
* `titleOrMessage` `string` The title (if message provided) or the message (if no message)
* `messageOrDuration` *(optional)* `string|number` The message (if string) or duration (if number)
* `duration` *(optional)* `number` Duration in seconds
* `callback` *(optional)* `function` Callback function to call when the toast hides

### Returns
* `Toast` `self` The Toast instance

## Toast:hide()

Hides the toast

### Returns
* `Toast` `self` The Toast instance

## Toast:success(titleOrMessage, messageOrDuration?, duration?, callback?)

Shows a success toast

### Parameters
* `titleOrMessage` `string` The title or message
* `messageOrDuration` *(optional)* `string|number` The message or duration
* `duration` *(optional)* `number` Duration in seconds
* `callback` *(optional)* `function` Callback function to call when the toast hides

### Returns
* `Toast` `self` The Toast instance

## Toast:error(titleOrMessage, messageOrDuration?, duration?, callback?)

Shows an error toast

### Parameters
* `titleOrMessage` `string` The title or message
* `messageOrDuration` *(optional)* `string|number` The message or duration
* `duration` *(optional)* `number` Duration in seconds
* `callback` *(optional)* `function` Callback function to call when the toast hides

### Returns
* `Toast` `self` The Toast instance

## Toast:warning(titleOrMessage, messageOrDuration?, duration?, callback?)

Shows a warning toast

### Parameters
* `titleOrMessage` `string` The title or message
* `messageOrDuration` *(optional)* `string|number` The message or duration
* `duration` *(optional)* `number` Duration in seconds
* `callback` *(optional)* `function` Callback function to call when the toast hides

### Returns
* `Toast` `self` The Toast instance

## Toast:info(titleOrMessage, messageOrDuration?, duration?, callback?)

Shows an info toast

### Parameters
* `titleOrMessage` `string` The title or message
* `messageOrDuration` *(optional)* `string|number` The message or duration
* `duration` *(optional)* `number` Duration in seconds
* `callback` *(optional)* `function` Callback function to call when the toast hides

### Returns
* `Toast` `self` The Toast instance
