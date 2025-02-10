# Getting Started

Basalt is designed to make it easier for Lua programmers to create graphical user interfaces (GUIs) within the popular Minecraft mod, [CC:Tweaked](https://tweaked.cc/). Before diving into Basalt, it's important to have a basic understanding of [Lua](https://www.lua.org/manual/5.1/) programming and how to use [CC:Tweaked](https://tweaked.cc/).

## How to Install

Download Basalt: Visit the [Download Page](download) and choose the version of Basalt you want to install: source or packaged.

::: info
Basalt is a library and does not execute any code by itself. You need to write Lua scripts that import and use Basalt to create user interfaces for your projects.
:::

## Setting up Basalt

The next step is to create your own program. You can call it whatever you want. The command for it is:

```
edit fileName
```

In your Lua script, use the require function to include Basalt. Here's an example of how to do it:

```lua
local basalt = require("basalt") -- Here we're including the Library and storing it to a variable called "basalt"
```

Merely loading Basalt is insufficient. It's essential to initiate the event and draw handlers. To facilitate this, Basalt offers the [basalt.run()](../references/basalt#basalt-run) function.

Here is an example:

```lua
local basalt = require("basalt")

-- your UI code is here

basalt.run() -- starts a infinite-loop to listen to all incoming events
```


## Create your first UI with Basalt

Now that you have Basalt installed, let's dive into creating a simple user interface (UI).

### The Baseframe

The Baseframe serves as the foundation for building user interfaces in Basalt. It acts as the root container for all other UI elements and is essential for creating your UI layout. Check out [basalt.addFrame](../references/basalt#basalt-addframe) to learn more about how to create Baseframes.

```lua
local basalt = require("basalt")
local main = basalt.getMainFrame() -- Returns or creates a new Baseframe

basalt.run() -- lets start the event listener (should be on the bottom)
```

### Adding Elements

After creating your Baseframe, you can start adding elements to it. Basalt offers a variety of UI elements that you can integrate into your interface. Below is an outline of how you can add elements to your Baseframe:

1. **Choose the Right Element:** Before adding an element, decide which UI component suits your requirements best. Refer to the [reference](../references/main) page to explore the available elements and their functionalities.
2. **Use the [add{Element}](../references/container#add-element) Method:** To add an element, utilize the [add{Element}](../references/container#add-element) method, where {Element} corresponds to the specific UI component you wish to include. For example, to add a [button](../references/button), you would use addButton(), and for [labels](../references/label), you would use addLabel().
3. **Customize as Needed:** Once added, you can customize the properties and appearance of each element according to your preferences. Basalt provides a range of options for customization, including text, colors, size, position, and more.

Let us add a button to our example:


```lua
local basalt = require("basalt")
local main = basalt.getMainFrame()
local button = main:addButton() -- a simple button with default properties

basalt.run()
```

### Modifying Properties

Once you've added elements to your UI, you can customize their appearance and behavior by modifying their properties. If you're new to working with properties in Basalt, it's recommended to check out our [property guide](/guides/properties) for a detailed overview.

To begin modifying properties, you first need to identify which properties are available for a specific element. For example, let's consider the [Button](../references/button) element. In the reference page for the [Button](../references/button), you'll find a list of properties available for that element. However, keep in mind that Button inherits properties from [VisualElement](../references/visualelement), which expands the available properties further. For instance, [VisualElement](../references/visualelement) includes properties like background, foreground, x, y, width, height, and visibility.

To modify these properties, you'll use corresponding setter functions. Each property has its own setter function, such as `setBackground()` for background color, `setX()` for horizontal position, and so on. Here's an example demonstrating how to set properties for a button:

```lua
local basalt = require("basalt")
local main = basalt.getMainFrame()

-- Create a button and set its properties
local button = main:addButton():setX(5):setY(3):setBackground(colors.red)

basalt.run()
```

In this example, we create a button, set its horizontal and vertical positions using `setX()` and `setY()`, and change its background color to red using `setBackground()`. Experiment with different property values to achieve the desired appearance and behavior for your UI elements.

### Attaching Events to Elements

Events allow you to define actions that should be performed when a specific user interaction occurs, such as clicking a button or typing in an input field. While some events are specific to certain elements, many general events are inherited from the [VisualElement](../references/visualelement) class. Let's explore how to attach events to elements, using a `onClick` event as an example.

First, let's clarify that while certain events may appear to be associated with specific elements like input, many general events are inherited from the VisualElement class. This means that you can attach these events to any UI element, not just buttons. Common events include `onClick`, `onClickUp`, `onScroll`, `onDrag`, `onKey`, `onKeyUp`, `onChar`,... - a full list can be found on the [VisualElement](../references/visualelement#events) page.

To attach an event to an element, you'll use a function definition that specifies the action to be performed when the event occurs. Here's how you can attach an onClick event to a button:

```lua
local basalt = require("basalt")
local main = basalt.getMainFrame()

-- Create a button
local button = main:addButton():setText("Click me")

-- Attach an onClick event to the button
button:onClick(function()
    basalt.debug("Button clicked!")
end)

basalt.run()
```

In this example, we create a button and use the `onClick` function to attach an `mouse_click` event. When the button is clicked, the specified function is executed, which prints "Button clicked!" to the console. Experiment with different events and actions to add interactivity to your UI elements.