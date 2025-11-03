# VisualElement
_This is the visual element class. It serves as the base class for all visual UI elements_
_and provides core functionality for positioning, sizing, colors, and rendering._

Extends: `BaseElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|x|number|1|The horizontal position relative to parent|
|y|number|1|The vertical position relative to parent|
|z|number|1|The z-index for layering elements|
|width|number|1|The width of the element|
|height|number|1|The height of the element|
|background|color|black|The background color|
|foreground|color|white|The text/foreground color|
|backgroundEnabled|boolean|true|Whether to render the background|
|borderTop|boolean|false|Draw top border|
|borderBottom|boolean|false|Draw bottom border|
|borderLeft|boolean|false|Draw left border|
|borderRight|boolean|false|Draw right border|
|borderColor|color|white|Border color|
|visible|boolean|true|Whether the element is visible|
|ignoreOffset|boolean|false|Whether to ignore the parent's offset|
|layoutConfig|table|{}|Configuration for layout systems (grow, shrink, alignSelf, etc.)|

## Events

|Event|Parameters|Description|
|---|---|---|
|onClick|`button string, x number, y number`|Fired on mouse click|

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement:setConstraint](#visualelement-setconstraint-property-targetelement-targetproperty-offset)|VisualElement|Sets a constraint on a property relative to another element's property|
|[VisualElement:setLayoutConfigProperty](#visualelement-setlayoutconfigproperty-key-value)|VisualElement|Updates a single layout config property without replacing the entire table|
|[VisualElement:getLayoutConfigProperty](#visualelement-getlayoutconfigproperty-key)|any|Gets a single layout config property|
|[VisualElement:resolveAllConstraints](#visualelement-resolveallconstraints)|VisualElement|Resolves all constraints for the element|
|[VisualElement:removeConstraint](#visualelement-removeconstraint-property)|VisualElement|Removes a constraint from the element|
|[VisualElement:updateConstraints](#visualelement-updateconstraints)|VisualElement|Updates all constraints, recalculating positions and sizes|
|[VisualElement:alignRight](#visualelement-alignright-target-offset)|VisualElement|Aligns the element's right edge to the target's right edge with optional offset|
|[VisualElement:alignLeft](#visualelement-alignleft-target-offset)|VisualElement|Aligns the element's left edge to the target's left edge with optional offset|
|[VisualElement:alignTop](#visualelement-aligntop-target-offset)|VisualElement|Aligns the element's top edge to the target's top edge with optional offset|
|[VisualElement:alignBottom](#visualelement-alignbottom-target-offset)|VisualElement|Aligns the element's bottom edge to the target's bottom edge with optional offset|
|[VisualElement:centerHorizontal](#visualelement-centerhorizontal-target-offset)|VisualElement|Centers the element horizontally relative to the target with optional offset|
|[VisualElement:centerVertical](#visualelement-centervertical-target-offset)|VisualElement|Centers the element vertically relative to the target with optional offset|
|[VisualElement:centerIn](#visualelement-centerin-target)|VisualElement|Centers the element both horizontally and vertically relative to the target|
|[VisualElement:rightOf](#visualelement-rightof-target-gap)|VisualElement|Positions the element to the right of the target with optional gap|
|[VisualElement:leftOf](#visualelement-leftof-target-gap)|VisualElement|Positions the element to the left of the target with optional gap|
|[VisualElement:below](#visualelement-below-target-gap)|VisualElement|Positions the element below the target with optional gap|
|[VisualElement:above](#visualelement-above-target-gap)|VisualElement|Positions the element above the target with optional gap|
|[VisualElement:stretchWidth](#visualelement-stretchwidth-target-margin)|VisualElement|Stretches the element to match the target's width with optional margin|
|[VisualElement:stretchHeight](#visualelement-stretchheight-target-margin)|VisualElement|Stretches the element to match the target's height with optional margin|
|[VisualElement:stretch](#visualelement-stretch-target-margin)|VisualElement|Stretches the element to match the target's width and height with optional margin|
|[VisualElement:widthPercent](#visualelement-widthpercent-target-percent)|VisualElement|Sets the element's width as a percentage of the target's width|
|[VisualElement:heightPercent](#visualelement-heightpercent-target-percent)|VisualElement|Sets the element's height as a percentage of the target's height|
|[VisualElement:matchWidth](#visualelement-matchwidth-target-offset)|VisualElement|Matches the element's width to the target's width with optional offset|
|[VisualElement:matchHeight](#visualelement-matchheight-target-offset)|VisualElement|Matches the element's height to the target's height with optional offset|
|[VisualElement:fillParent](#visualelement-fillparent-margin)|VisualElement|Stretches the element to fill its parent's width and height with optional margin|
|[VisualElement:fillWidth](#visualelement-fillwidth-margin)|VisualElement|Stretches the element to fill its parent's width with optional margin|
|[VisualElement:fillHeight](#visualelement-fillheight-margin)|VisualElement|Stretches the element to fill its parent's height with optional margin|
|[VisualElement:center](#visualelement-center)|VisualElement|Centers the element within its parent both horizontally and vertically|
|[VisualElement:toRight](#visualelement-toright-gap)|VisualElement|Aligns the element's right edge to its parent's right edge with optional gap|
|[VisualElement:toLeft](#visualelement-toleft-gap)|VisualElement|Aligns the element's left edge to its parent's left edge with optional gap|
|[VisualElement:toTop](#visualelement-totop-gap)|VisualElement|Aligns the element's top edge to its parent's top edge with optional gap|
|[VisualElement:toBottom](#visualelement-tobottom-gap)|VisualElement|Aligns the element's bottom edge to its parent's bottom edge with optional gap|
|[VisualElement:isInBounds](#visualelement-isinbounds-x-y)|boolean|Checks if point is within bounds|
|[VisualElement:setFocused](#visualelement-setfocused-focused-internal)|VisualElement|Sets focus state|
|[VisualElement:isFocused](#visualelement-isfocused)|boolean|Checks if element is focused|
|[VisualElement:isFocused](#visualelement-isfocused)|boolean|Checks if element is focused|
|[VisualElement:addBorder](#visualelement-addborder-colororoptions-sideoptions)|VisualElement|Adds or updates a drawable character border around the element. The border will automatically adapt to size/background changes because the command reads current properties each render.|
|[VisualElement:removeBorder](#visualelement-removeborder)|VisualElement|Removes the previously added border (if any)|
|[VisualElement:calculatePosition](#visualelement-calculateposition)|number, number|Calculates the position of the element|
|[VisualElement:getAbsolutePosition](#visualelement-getabsoluteposition-x-y)|number, number|Returns the absolute position of the element|
|[VisualElement:getRelativePosition](#visualelement-getrelativeposition-x-y)|number, number|Returns the relative position of the element|
|[VisualElement:prioritize](#visualelement-prioritize)|VisualElement|Prioritizes the element by moving it to the top of its parent's children|

## VisualElement:setConstraint(property, targetElement, targetProperty, offset)

Sets a constraint on a property relative to another element's property

### Parameters
* `property` `string` The property to constrain (x, y, width, height, left, right, top, bottom, centerX, centerY)
* `targetElement` `BaseElement|string` The target element or "parent"
* `targetProperty` `string` The target property to constrain to (left, right, top, bottom, centerX, centerY, width, height)
* `offset` `number` The offset to apply (negative = inside, positive = outside, fractional = percentage)

### Returns
* `VisualElement` `self` The element instance

## VisualElement:setLayoutConfigProperty(key, value)

Updates a single property in the layoutConfig table

### Parameters
* `key` `string` The layout config property to update (grow, shrink, basis, alignSelf, order, etc.)
* `value` `any` The value to set for the property

### Returns
* `VisualElement` `self` The element instance

## VisualElement:getLayoutConfigProperty(key)

Gets a single property from the layoutConfig table

### Parameters
* `key` `string` The layout config property to get

### Returns
* `any` `value` The value of the property, or nil if not set

## VisualElement:resolveAllConstraints()

Resolves all constraints for the element

### Returns
* `VisualElement` `self` The element instance

## VisualElement:removeConstraint(property)

Removes a constraint from the element

### Parameters
* `property` `string` The property of the constraint to remove

### Returns
* `VisualElement` `self` The element instance

## VisualElement:updateConstraints()

Updates all constraints, recalculating positions and sizes

### Returns
* `VisualElement` `self` The element instance

## VisualElement:alignRight(target, offset?)

Aligns the element's right edge to the target's right edge with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Offset from the edge (negative = inside, positive = outside, default: 0)

### Returns
* `VisualElement` self

## VisualElement:alignLeft(target, offset?)

Aligns the element's left edge to the target's left edge with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Offset from the edge (negative = inside, positive = outside, default: 0)

### Returns
* `VisualElement` self

## VisualElement:alignTop(target, offset?)

Aligns the element's top edge to the target's top edge with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Offset from the edge (negative = inside, positive = outside, default: 0)

### Returns
* `VisualElement` self

## VisualElement:alignBottom(target, offset?)

Aligns the element's bottom edge to the target's bottom edge with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Offset from the edge (negative = inside, positive = outside, default: 0)

### Returns
* `VisualElement` self

## VisualElement:centerHorizontal(target, offset?)

Centers the element horizontally relative to the target with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Horizontal offset from center (default: 0)

### Returns
* `VisualElement` self

## VisualElement:centerVertical(target, offset?)

Centers the element vertically relative to the target with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Vertical offset from center (default: 0)

### Returns
* `VisualElement` self

## VisualElement:centerIn(target)

Centers the element both horizontally and vertically relative to the target

### Parameters
* `target` `BaseElement|string` The target element or "parent"

### Returns
* `VisualElement` self

## VisualElement:rightOf(target, gap?)

Positions the element to the right of the target with optional gap

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `gap` *(optional)* `number` Gap between elements (default: 0)

### Returns
* `VisualElement` self

## VisualElement:leftOf(target, gap?)

Positions the element to the left of the target with optional gap

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `gap` *(optional)* `number` Gap between elements (default: 0)

### Returns
* `VisualElement` self

## VisualElement:below(target, gap?)

Positions the element below the target with optional gap

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `gap` *(optional)* `number` Gap between elements (default: 0)

### Returns
* `VisualElement` self

## VisualElement:above(target, gap?)

Positions the element above the target with optional gap

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `gap` *(optional)* `number` Gap between elements (default: 0)

### Returns
* `VisualElement` self

## VisualElement:stretchWidth(target, margin?)

Stretches the element to match the target's width with optional margin

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `margin` *(optional)* `number` Margin on each side (default: 0)

### Returns
* `VisualElement` self

## VisualElement:stretchHeight(target, margin?)

Stretches the element to match the target's height with optional margin

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `margin` *(optional)* `number` Margin on top and bottom (default: 0)

### Returns
* `VisualElement` self

## VisualElement:stretch(target, margin?)

Stretches the element to match the target's width and height with optional margin

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `margin` *(optional)* `number` Margin on all sides (default: 0)

### Returns
* `VisualElement` self

## VisualElement:widthPercent(target, percent)

Sets the element's width as a percentage of the target's width

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `percent` `number` Percentage of target's width (0-100)

### Returns
* `VisualElement` self

## VisualElement:heightPercent(target, percent)

Sets the element's height as a percentage of the target's height

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `percent` `number` Percentage of target's height (0-100)

### Returns
* `VisualElement` self

## VisualElement:matchWidth(target, offset?)

Matches the element's width to the target's width with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Offset to add to target's width (default: 0)

### Returns
* `VisualElement` self

## VisualElement:matchHeight(target, offset?)

Matches the element's height to the target's height with optional offset

### Parameters
* `target` `BaseElement|string` The target element or "parent"
* `offset` *(optional)* `number` Offset to add to target's height (default: 0)

### Returns
* `VisualElement` self

## VisualElement:fillParent(margin?)

Stretches the element to fill its parent's width and height with optional margin

### Parameters
* `margin` *(optional)* `number` Margin on all sides (default: 0)

### Returns
* `VisualElement` self

## VisualElement:fillWidth(margin?)

Stretches the element to fill its parent's width with optional margin

### Parameters
* `margin` *(optional)* `number` Margin on left and right (default: 0)

### Returns
* `VisualElement` self

## VisualElement:fillHeight(margin?)

Stretches the element to fill its parent's height with optional margin

### Parameters
* `margin` *(optional)* `number` Margin on top and bottom (default: 0)

### Returns
* `VisualElement` self

## VisualElement:center()

Centers the element within its parent both horizontally and vertically

### Returns
* `VisualElement` self

## VisualElement:toRight(gap?)

Aligns the element's right edge to its parent's right edge with optional gap

### Parameters
* `gap` *(optional)* `number` Gap from the edge (default: 0)

### Returns
* `VisualElement` self

## VisualElement:toLeft(gap?)

Aligns the element's left edge to its parent's left edge with optional gap

### Parameters
* `gap` *(optional)* `number` Gap from the edge (default: 0)

### Returns
* `VisualElement` self

## VisualElement:toTop(gap?)

Aligns the element's top edge to its parent's top edge with optional gap

### Parameters
* `gap` *(optional)* `number` Gap from the edge (default: 0)

### Returns
* `VisualElement` self

## VisualElement:toBottom(gap?)

Aligns the element's bottom edge to its parent's bottom edge with optional gap

### Parameters
* `gap` *(optional)* `number` Gap from the edge (default: 0)

### Returns
* `VisualElement` self

## VisualElement:isInBounds(x, y)

Checks if the specified coordinates are within the bounds of the element

### Parameters
* `x` `number` The x position to check
* `y` `number` The y position to check

### Returns
* `boolean` `isInBounds` Whether the coordinates are within the bounds of the element

## VisualElement:setFocused(focused, internal?)

Sets or removes focus from this element

### Parameters
* `focused` `boolean` Whether to focus or blur
* `internal` *(optional)* `boolean` Internal flag to prevent parent notification

### Returns
* `VisualElement` self

## VisualElement:isFocused()

Gets whether this element is focused

### Returns
* `boolean` isFocused

## VisualElement:isFocused()

Gets whether this element is focused

### Returns
* `boolean` isFocused

## VisualElement:addBorder(colorOrOptions, sideOptions?)

Adds or updates a drawable character border around the element. The border will automatically adapt to size/background changes because the command reads current properties each render.

### Parameters
* `colorOrOptions` `any` Border color or options table
* `sideOptions` *(optional)* `table` Side options table (if color is provided as first argument)

### Returns
* `VisualElement` self

## VisualElement:removeBorder()

Removes the previously added border (if any)

### Returns
* `VisualElement` self

## VisualElement:calculatePosition()

Calculates the position of the element relative to its parent

### Returns
* `number` `x` The x position
* `number` `y` The y position

## VisualElement:getAbsolutePosition(x?, y?)

Returns the absolute position of the element or the given coordinates.

### Parameters
* `x` *(optional)* `number` x position
* `y` *(optional)* `number` y position

### Returns
* `number` `x` The absolute x position
* `number` `y` The absolute y position

## VisualElement:getRelativePosition(x?, y?)

Returns the relative position of the element or the given coordinates.

### Parameters
* `x` *(optional)* `number` x position
* `y` *(optional)* `number` y position

### Returns
* `number` `x` The relative x position
* `number` `y` The relative y position

## VisualElement:prioritize()

This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.

### Returns
* `VisualElement` `self` The VisualElement instance
