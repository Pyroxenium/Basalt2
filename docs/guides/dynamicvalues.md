# Dynamic Values

Dynamic Values allow you to incorporate more complex logic into the properties of UI elements by dynamically updating values based on other variables or conditions. They provide a powerful way to customize the appearance and behavior of UI elements in response to changing conditions or user interactions.

## How Dynamic Values Work

Dynamic Values are defined as strings enclosed in curly braces `{}` within the properties of UI elements. These strings can contain conditional expressions, mathematical operations, or references to other variables or properties.

## Special Variables

In addition to element properties, Dynamic Values support special variables that provide context or reference points for calculations:

- **self:** Refers to the current element, allowing you to access its properties within the Dynamic Value expression.
- **parent:** Refers to the parent container of the current element, useful for relative positioning or sizing adjustments.
- **elementID:** Allows you to reference a specific element by its ID within the Dynamic Value expression.

## Examples

Let's explore some examples of how Dynamic Values can be used:

### 1. Conditional Expressions:

```lua
-- Change background color based on a condition
main:addButton():setBackground("{self.clicked ? red : green}")
```

In this example, the background color of the button changes dynamically based on whether it has been clicked. If clicked, the background color becomes red; otherwise, it remains green.

### 2. Positioning Elements:

```lua
-- Centering a button horizontally
main:addButton():setX("{parent.w / 2 - self.w / 2}")
```

This example centers the button horizontally within its parent container by dynamically adjusting its X position based on the width of the parent and the width of the button itself.

### 3. Dynamic Sizing:

```lua
-- Adjusting the width of a button relative to its parent container
main:addButton():setWidth("{parent.w - 20}")
```

In this example, the width of the button is dynamically set to be 20 pixels less than the width of its parent container.

### 4. Dynamic Styling:

```lua
-- Changing input background color when focused
main:addInput():setBackground("{self.focused ? cyan : black}")
```

Here, the background color of the input field changes dynamically based on whether it is currently focused. If focused, the background color becomes cyan; otherwise, it remains black.