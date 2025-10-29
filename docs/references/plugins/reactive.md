# Reactive
_This module provides reactive functionality for elements, it adds no new functionality for elements. _
_It is used to evaluate expressions in property values and update the element when the expression changes._

## Usage
```lua run
local button = main:addButton({text="Exit"})
```

```lua run
button:setX("{parent.x - 12}")
```

```lua run
button:setBackground("{self.clicked and colors.red or colors.green}")
```

```lua run
button:setWidth("{#self.text + 2}")
```
