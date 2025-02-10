# Introduction to Properties

In Basalt, Properties are attributes or characteristics of UI elements that determine their appearance, behavior, and state. They allow you to customize various aspects of UI elements, such as their position, size, color, text content, and more.

A list with all available properties can be found in the [references](../references/main) page.

## Changing properties

Properties are typically modified using setter functions. Setter functions are used to assign values to properties.

For example, to set the background color of a button to red, you would use the `setBackground()` setter function:

```lua
local button = main:addButton():setBackground(colors.red)
```

Using setter functions to manipulate properties offers several advantages:

### Defining properties on element creation

Another way to define properties in Basalt is by passing a table of property-value pairs when creating an element. This method allows you to specify multiple properties at once in a single statement. For example, to create a button with specific position and background color, you would use a property table like this:

```lua
local button = main:addButton({x = 5, y = 2, background = colors.red, text = "Click me!"})
```

Using property tables can be more concise and convenient, especially when initializing multiple properties for an element.

## Accessing properties

### Using Getter Functions

Getter functions provide a straightforward way to retrieve the current value of a specific property directly from a UI element. Here's an example of using getter functions to access properties:

```lua
local button = main:addButton()
local backgroundColor = button:getBackground()
local text = button:getText()
```

### Direct Access

In addition to getter functions, you can directly access properties as attributes of UI elements. This approach is concise and intuitive, especially when you only need to read the current value of a property. Here's how you can directly access properties.

```lua
local button = main:addButton()
local backgroundColor = button.background
local text = button.text
```

::: warning
Sometimes a property can be a function, especially when using dynamic values. The getter function automatically calls the function for you, while directly accessing the
variables does not.
:::

### Using getProperty

Basalt provides the `getProperty` method as an alternative way to access properties of UI elements. This method allows you to retrieve the value of a specific property by passing its name as an argument to the `getProperty` function. Here's how you can use the getProperty method:

```lua
local button = main:addButton()
local text = button:getProperty("text")
local backgroundColor = button:getProperty("background")
```

By using the getProperty method, you can access any property of a UI element without needing to know the specific getter function for each property. This approach simplifies property access, especially when dealing with properties dynamically defined at runtime.

