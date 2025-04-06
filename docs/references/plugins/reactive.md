# Reactive
This module provides reactive functionality for elements, it adds no new functionality for elements. 
It is used to evaluate expressions in property values and update the element when the expression changes.

### Usage
 ```lua
local button = main:addButton({text="Exit"})
button:setX("{parent.x - 12}")
button:setBackground("{self.clicked and colors.red or colors.green}")
button:setWidth("{self.text:len() + 2}")
```




