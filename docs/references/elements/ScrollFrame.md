# ScrollFrame
_A container that provides automatic scrolling capabilities with visual scrollbars. Displays vertical and/or horizontal scrollbars when child content exceeds the container's dimensions._

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|showScrollBar|boolean|true|Whether to show scrollbars|
|scrollBarSymbol|string|"|" The symbol used for the scrollbar handle|
|scrollBarBackground|string|"\127"|The symbol used for the scrollbar background|
|scrollBarColor|color|lightGray|Color of the scrollbar handle|
|scrollBarBackgroundColor|color|gray|Background color of the scrollbar|
|contentWidth|number|0|The total width of the content (calculated from children)|
|contentHeight|number|0|The total height of the content (calculated from children)|
