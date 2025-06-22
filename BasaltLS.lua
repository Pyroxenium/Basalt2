---@meta

---@class ErrorHandler
local ErrorHandler = {}

---Handles an error
---@param errMsg string The error message
function errorHandler.error(errMsg) end

---@class Image : VisualElement
---@field currentFrame number Current animation frame
---@field offsetY number Vertical offset for viewing larger images
---@field bimg table The bimg image data
---@field offsetX number Horizontal offset for viewing larger images
---@field autoResize boolean Whether to automatically resize the image when content exceeds bounds
local Image = {}

---Gets the value of the AutoResize property.
---@param self Image self
---@return boolean false Whether to automatically resize the image when content exceeds bounds
function Image:getAutoResize(self) end

---Gets the value of the OffsetY property.
---@param self Image self
---@return number 0 Vertical offset for viewing larger images
function Image:getOffsetY(self) end

---Gets the value of the OffsetX property.
---@param self Image self
---@return number 0 Horizontal offset for viewing larger images
function Image:getOffsetX(self) end

---Gets the value of the CurrentFrame property.
---@param self Image self
---@return number 1 Current animation frame
function Image:getCurrentFrame(self) end

---Gets pixel information at position
---@param x number X position
---@param y number Y position
---@return number ? fg Foreground color
---@return number ? bg Background color
---@return string ? char Character at position
function Image:getPixelData(x, y) end

---Sets the value of the Bimg property.
---@param self Image self
---@param Bimg table The bimg image data
function Image:setBimg(self, Bimg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Image:render() end

---Gets the size of the image
---@return number width The width of the image
---@return number height The height of the image
function Image:getImageSize() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Image self The initialized instance
---@protected
function Image:init(props, basalt) end

---Gets the specified frame
---@param frameIndex number The index of the frame to get
---@return table frame The frame data
function Image:getFrame(frameIndex) end

---Sets the metadata of the image
---@param key string The key of the metadata to set
---@param value string The value of the metadata to set
---@return Image self The Image instance
function Image:setMetadata(key, value) end

---Sets the value of the CurrentFrame property.
---@param self Image self
---@param CurrentFrame number Current animation frame
function Image:setCurrentFrame(self, CurrentFrame) end

---Updates the specified frame with the provided data
---@param frameIndex number The index of the frame to update
---@param frame table The new frame data
---@return Image self The Image instance
function Image:updateFrame(frameIndex, frame) end

---Gets the value of the Bimg property.
---@param self Image self
---@return table {} The bimg image data
function Image:getBimg(self) end

---Adds a new frame to the image
---@return Image self The Image instance
function Image:addFrame() end

---Sets the value of the OffsetX property.
---@param self Image self
---@param OffsetX number Horizontal offset for viewing larger images
function Image:setOffsetX(self, OffsetX) end

---Advances to the next frame in the animation
---@return Image self The Image instance
function Image:nextFrame() end

---Sets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The background color pattern
---@return Image self The Image instance
function Image:setBg(x, y, pattern) end

---Sets the value of the OffsetY property.
---@param self Image self
---@param OffsetY number Vertical offset for viewing larger images
function Image:setOffsetY(self, OffsetY) end

---Gets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the background color pattern to get
---@return string bg The background color pattern
function Image:getBg(x, y, length) end

---Sets the pixel at the specified position
---@param x number The x position
---@param y number The y position
---@param char string The character to set
---@param fg string The foreground color pattern
---@param bg string The background color pattern
---@return Image self The Image instance
function Image:setPixel(x, y, char, fg, bg) end

---Gets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the foreground color pattern to get
---@return string fg The foreground color pattern
function Image:getFg(x, y, length) end

---Sets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The foreground color pattern
---@return Image self The Image instance
function Image:setFg(x, y, pattern) end

---Sets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param text string The text to set
---@return Image self The Image instance
function Image:setText(x, y, text) end

---Sets the value of the AutoResize property.
---@param self Image self
---@param AutoResize boolean Whether to automatically resize the image when content exceeds bounds
function Image:setAutoResize(self, AutoResize) end

---Gets the metadata of the image
---@return table metadata The metadata of the image
function Image:getMetadata() end

---Resizes the image to the specified width and height
---@param width number The new width of the image
---@param height number The new height of the image
---@return Image self The Image instance
function Image:resizeImage(width, height) end

---Gets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the text to get
---@return string text The text at the specified position
function Image:getText(x, y, length) end

---@class VisualElement : BaseElement
---@field hover boolean Whether the mouse is currently hover over the element (Craftos-PC only)
---@field visible boolean Whether the element is visible
---@field height number The height of the element
---@field ignoreOffset boolean Whether to ignore the parent's offset
---@field foreground color The text/foreground color
---@field backgroundEnabled boolean Whether to render the background
---@field y number The vertical position relative to parent
---@field width number The width of the element
---@field clicked boolean Whether the element is currently clicked
---@field focused boolean Whether the element has input focus
---@field z number The z-index for layering elements
---@field background color The background color
---@field x number The horizontal position relative to parent
local VisualElement = {}

---Sets the value of the IgnoreOffset property.
---@param self VisualElement self
---@param IgnoreOffset boolean Whether to ignore the parent's offset
function VisualElement:setIgnoreOffset(self, IgnoreOffset) end

---Calculates the position of the element relative to its parent
---@return number x The x position
---@return number y The y position
function VisualElement:calculatePosition() end

---Registers a function to handle the onLeave event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnLeave(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@return boolean hover Whether the mouse has moved over the element
---@protected
function VisualElement:mouse_move(_, x, y) end

---Registers a function to handle the onScroll event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnScroll(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param width number The width of the area to draw
---@param height number The height of the area to draw
---@param text string The text to draw
---@param fg string The foreground color
---@param bg string The background color
---@protected
function VisualElement:multiBlit(x, y, width, height, text, fg, bg) end

---Creates a new Animation Object
---@return Animation animation The new animation
function VisualElement:animate() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:render() end

---Registers a function to handle the onMouseUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnMouseUp(self, func) end

---Gets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@return boolean true Whether to render the background
function VisualElement:getBackgroundEnabled(self) end

---Gets the value of the Hover property.
---@param self VisualElement self
---@return boolean false Whether the mouse is currently hover over the element (Craftos-PC only)
function VisualElement:getHover(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg string The foreground color
---@param bg string The background color
---@protected
function VisualElement:blit(x, y, text, fg, bg) end

---Sets the value of the Y property.
---@param self VisualElement self
---@param Y number The vertical position relative to parent
function VisualElement:setY(self, Y) end

---Registers a function to handle the onRelease event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnRelease(self, func) end

---Gets the value of the Visible property.
---@param self VisualElement self
---@return boolean true Whether the element is visible
function VisualElement:getVisible(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function VisualElement:key(key) end

---Registers a function to handle the onDrag event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnDrag(self, func) end

function VisualElement:drawText() end

---Sets the value of the Foreground property.
---@param self VisualElement self
---@param Foreground color The text/foreground color
function VisualElement:setForeground(self, Foreground) end

---Registers a function to handle the onKeyUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKeyUp(self, func) end

---Sets the value of the Z property.
---@param self VisualElement self
---@param Z number The z-index for layering elements
function VisualElement:setZ(self, Z) end

---Registers a function to handle the onFocus event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnFocus(self, func) end

---Gets the value of the Height property.
---@param self VisualElement self
---@return number 1 The height of the element
function VisualElement:getHeight(self) end

---Gets the value of the Z property.
---@param self VisualElement self
---@return number 1 The z-index for layering elements
function VisualElement:getZ(self) end

---Gets the value of the Width property.
---@param self VisualElement self
---@return number 1 The width of the element
function VisualElement:getWidth(self) end

---Gets the value of the Foreground property.
---@param self VisualElement self
---@return color white The text/foreground color
function VisualElement:getForeground(self) end

function VisualElement:drawFg() end

---Registers a function to handle the onEnter event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnEnter(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@protected
function VisualElement:mouse_release(button, x, y) end

function VisualElement:drawBg() end

---Sets the value of the Focused property.
---@param self VisualElement self
---@param Focused boolean Whether the element has input focus
function VisualElement:setFocused(self, Focused) end

---Sets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@param BackgroundEnabled boolean Whether to render the background
function VisualElement:setBackgroundEnabled(self, BackgroundEnabled) end

---Returns the relative position of the element or the given coordinates.
---@return number x The relative x position
---@return number y The relative y position
function VisualElement:getRelativePosition() end

---Sets the value of the Width property.
---@param self VisualElement self
---@param Width number The width of the element
function VisualElement:setWidth(self, Width) end

---Gets the value of the Clicked property.
---@param self VisualElement self
---@return boolean false Whether the element is currently clicked
function VisualElement:getClicked(self) end

---Registers a function to handle the onClick event.
---@param button string
---@param x number
---@param y number
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnClick(self, func) end

---Checks if the specified coordinates are within the bounds of the element
---@param x number The x position to check
---@param y number The y position to check
---@return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y) end

---Gets the value of the IgnoreOffset property.
---@param self VisualElement self
---@return boolean false Whether to ignore the parent's offset
function VisualElement:getIgnoreOffset(self) end

---Sets the value of the Background property.
---@param self VisualElement self
---@param Background color The background color
function VisualElement:setBackground(self, Background) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param bg color The background color
---@protected
function VisualElement:textBg(x, y, text, bg) end

---This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.
---@return VisualElement self The VisualElement instance
function VisualElement:prioritize() end

---Registers a function to handle the onKey event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKey(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean release Whether the element was released on the element
---@protected
function VisualElement:mouse_up(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function VisualElement:key_up(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked while dragging
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean drag Whether the element was dragged
---@protected
function VisualElement:mouse_drag(button, x, y) end

---Gets the value of the X property.
---@param self VisualElement self
---@return number 1 The horizontal position relative to parent
function VisualElement:getX(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function VisualElement:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg color The foreground color
---@protected
function VisualElement:textFg(x, y, text, fg) end

---Gets the value of the Y property.
---@param self VisualElement self
---@return number 1 The vertical position relative to parent
function VisualElement:getY(self) end

---Gets the value of the Focused property.
---@param self VisualElement self
---@return boolean false Whether the element has input focus
function VisualElement:getFocused(self) end

---Returns the absolute position of the element or the given coordinates.
---@return number x The absolute x position
---@return number y The absolute y position
function VisualElement:getAbsolutePosition() end

---Registers a function to handle the onBlur event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnBlur(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean scroll Whether the element was scrolled
---@protected
function VisualElement:mouse_scroll(direction, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean clicked Whether the element was clicked
---@protected
function VisualElement:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:blur() end

---Sets the value of the Visible property.
---@param self VisualElement self
---@param Visible boolean Whether the element is visible
function VisualElement:setVisible(self, Visible) end

---Sets the value of the Height property.
---@param self VisualElement self
---@param Height number The height of the element
function VisualElement:setHeight(self, Height) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:postRender() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:focus() end

---Sets the value of the Hover property.
---@param self VisualElement self
---@param Hover boolean Whether the mouse is currently hover over the element (Craftos-PC only)
function VisualElement:setHover(self, Hover) end

---Gets the value of the Background property.
---@param self VisualElement self
---@return color black The background color
function VisualElement:getBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
---@return VisualElement self The VisualElement instance
---@protected
function VisualElement:setCursor(x, y, blink, color) end

---Sets the value of the X property.
---@param self VisualElement self
---@param X number The horizontal position relative to parent
function VisualElement:setX(self, X) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function VisualElement:init(props, basalt) end

---Registers a function to handle the onChar event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnChar(self, func) end

---Sets the value of the Clicked property.
---@param self VisualElement self
---@param Clicked boolean Whether the element is currently clicked
function VisualElement:setClicked(self, Clicked) end

---@class Label : VisualElement
---@field autoSize boolean Whether the label should automatically resize its width based on the text content
---@field text string The text content to display. Can be a string or a function that returns a string
local Label = {}

---Gets the wrapped lines of the Label
---@return table wrappedText The wrapped lines of the Label
function Label:getWrappedText() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Label:render() end

---Sets the value of the AutoSize property.
---@param self Label self
---@param AutoSize boolean Whether the label should automatically resize its width based on the text content
function Label:setAutoSize(self, AutoSize) end

---Sets the value of the Text property.
---@param self Label self
---@param Text string The text content to display. Can be a string or a function that returns a string
function Label:setText(self, Text) end

---Gets the value of the AutoSize property.
---@param self Label self
---@return boolean true Whether the label should automatically resize its width based on the text content
function Label:getAutoSize(self) end

---Gets the value of the Text property.
---@param self Label self
---@return string Label The text content to display. Can be a string or a function that returns a string
function Label:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Label self The initialized instance
---@protected
function Label:init(props, basalt) end

---@class Switch : VisualElement
---@field checked boolean switch is checked
local Switch = {}

---Sets the value of the Checked property.
---@param self Switch self
---@param Checked boolean switch is checked
function Switch:setChecked(self, Checked) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Switch:render() end

---Gets the value of the Checked property.
---@param self Switch self
---@return boolean Whether switch is checked
function Switch:getChecked(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Switch:init(props, basalt) end

---@class BigFontText
local BigFontText = {}

---@class Input : VisualElement
---@field pattern string nil Regular expression pattern for input validation
---@field maxLength number nil Maximum length of input text (optional)
---@field placeholder string Text to display when input is empty
---@field placeholderColor color Color of the placeholder text
---@field focusedForeground color Foreground color when input is focused
---@field replaceChar string Character to replace the input with (for password fields)
---@field text string The current text content of the input
---@field cursorColor number Color of the cursor
---@field cursorPos number The current cursor position in the text
---@field focusedBackground color Background color when input is focused
---@field viewOffset number The horizontal scroll offset for viewing long text
local Input = {}

---Sets the value of the ViewOffset property.
---@param self Input self
---@param ViewOffset number The horizontal scroll offset for viewing long text
function Input:setViewOffset(self, ViewOffset) end

---Gets the value of the ReplaceChar property.
---@param self Input self
---@return string nil Character to replace the input with (for password fields)
function Input:getReplaceChar(self) end

---Gets the value of the FocusedBackground property.
---@param self Input self
---@return color blue Background color when input is focused
function Input:getFocusedBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:paste() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Input:mouse_click(button, x, y) end

---Sets the value of the CursorPos property.
---@param self Input self
---@param CursorPos number The current cursor position in the text
function Input:setCursorPos(self, CursorPos) end

---Updates the input's viewport
---@return Input self The updated instance
function Input:updateViewport() end

---Sets the value of the FocusedBackground property.
---@param self Input self
---@param FocusedBackground color Background color when input is focused
function Input:setFocusedBackground(self, FocusedBackground) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:blur() end

---Gets the value of the Pattern property.
---@param self Input self
---@return string ? nil Regular expression pattern for input validation
function Input:getPattern(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Input:key(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function Input:char(char) end

---Gets the value of the PlaceholderColor property.
---@param self Input self
---@return color gray Color of the placeholder text
function Input:getPlaceholderColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Input self The initialized instance
---@protected
function Input:init(props, basalt) end

---Gets the value of the CursorPos property.
---@param self Input self
---@return number 1 The current cursor position in the text
function Input:getCursorPos(self) end

---Gets the value of the ViewOffset property.
---@param self Input self
---@return number 0 The horizontal scroll offset for viewing long text
function Input:getViewOffset(self) end

---Sets the value of the Placeholder property.
---@param self Input self
---@param Placeholder string Text to display when input is empty
function Input:setPlaceholder(self, Placeholder) end

---Sets the cursor position and color
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
function Input:setCursor(x, y, blink, color) end

---Gets the value of the FocusedForeground property.
---@param self Input self
---@return color white Foreground color when input is focused
function Input:getFocusedForeground(self) end

---Gets the value of the MaxLength property.
---@param self Input self
---@return number ? nil Maximum length of input text (optional)
function Input:getMaxLength(self) end

---Sets the value of the CursorColor property.
---@param self Input self
---@param CursorColor number Color of the cursor
function Input:setCursorColor(self, CursorColor) end

---Gets the value of the CursorColor property.
---@param self Input self
---@return number nil Color of the cursor
function Input:getCursorColor(self) end

---Gets the value of the Text property.
---@param self Input self
---@return string - The current text content of the input
function Input:getText(self) end

---Sets the value of the Text property.
---@param self Input self
---@param Text string The current text content of the input
function Input:setText(self, Text) end

---Sets the value of the Pattern property.
---@param self Input self
---@param Pattern string nil Regular expression pattern for input validation
function Input:setPattern(self, Pattern) end

---Sets the value of the PlaceholderColor property.
---@param self Input self
---@param PlaceholderColor color Color of the placeholder text
function Input:setPlaceholderColor(self, PlaceholderColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:focus() end

---Sets the value of the ReplaceChar property.
---@param self Input self
---@param ReplaceChar string Character to replace the input with (for password fields)
function Input:setReplaceChar(self, ReplaceChar) end

---Sets the value of the MaxLength property.
---@param self Input self
---@param MaxLength number nil Maximum length of input text (optional)
function Input:setMaxLength(self, MaxLength) end

---Gets the value of the Placeholder property.
---@param self Input self
---@return string ... Text to display when input is empty
function Input:getPlaceholder(self) end

---Sets the value of the FocusedForeground property.
---@param self Input self
---@param FocusedForeground color Foreground color when input is focused
function Input:setFocusedForeground(self, FocusedForeground) end

---@class Display : VisualElement
local Display = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Display:render() end

---Returns the current window object
---@return table window The current window object
function Display:getWindow() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Display:init(props, basalt) end

---Writes text to the display at the given position with the given foreground and background colors
---@param x number The x position to write to
---@param y number The y position to write to
---@param text string The text to write
---@return Display self The display instance
function Display:write(x, y, text) end

---@class Graph : VisualElement
---@field minValue number The minimum value of the graph
---@field maxValue number The maximum value of the graph
---@field series table The series of the graph
local Graph = {}

---@param name string The name of the series
---@return table ? series The series
function Graph:getSeries(name) end

---Sets the value of the MaxValue property.
---@param self Graph self
---@param MaxValue number The maximum value of the graph
function Graph:setMaxValue(self, MaxValue) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Graph:render() end

---@param name string The name of the series
---@param symbol string The symbol of the series
---@param bgCol number The background color of the series
---@param fgCol number The foreground color of the series
---@param pointCount number The number of points in the series
---@return Graph self The graph instance
function Graph:addSeries(name, symbol, bgCol, fgCol, pointCount) end

---@param name string The name of the series
---@param count number The number of points in the series
---@return Graph self The graph instance
function Graph:setSeriesPointCount(name, count) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:focusSeries(name) end

---Gets the value of the MinValue property.
---@param self Graph self
---@return number 0 The minimum value of the graph
function Graph:getMinValue(self) end

---Sets the value of the Series property.
---@param self Graph self
---@param Series table The series of the graph
function Graph:setSeries(self, Series) end

---Gets the value of the MaxValue property.
---@param self Graph self
---@return number 100 The maximum value of the graph
function Graph:getMaxValue(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Graph self The initialized instance
---@protected
function Graph:init(props, basalt) end

---@param name string The name of the series
---@param value number The value of the point
---@return Graph self The graph instance
function Graph:addPoint(name, value) end

---@param name string The name of the series
---@param visible boolean Whether the series should be visible
---@return Graph self The graph instance
function Graph:changeSeriesVisibility(name, visible) end

---Clears all points from a series
---@return Graph self The graph instance
function Graph:clear() end

---Sets the value of the MinValue property.
---@param self Graph self
---@param MinValue number The minimum value of the graph
function Graph:setMinValue(self, MinValue) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:removeSeries(name) end

---@class AnimationInstance
local AnimationInstance = {}

---Updates the animation
---@param elapsed number The elapsed time in seconds
---@return boolean Whether the animation is finished
function AnimationInstance:update(elapsed) end

---Starts the animation
---@return AnimationInstance self The animation instance
function AnimationInstance:start() end

---Creates a new AnimationInstance
---@param element VisualElement The element to animate
---@param animType string The type of animation
---@param args table The animation arguments
---@param duration number Duration in seconds
---@param easing string The easing function name
---@return AnimationInstance The new animation instance
function AnimationInstance.new(element, animType, args, duration, easing) end

---Gets called when the animation is completed
function AnimationInstance:complete() end

---@class ElementManager
local ElementManager = {}

---Loads an element by name. This will load the element and apply any plugins to it.
---@param name string The name of the element to load
function ElementManager.loadElement(name) end

---Gets a list of all elements
---@return table ElementList A list of all elements
function ElementManager.getElementList() end

---Gets an Plugin API by name
---@param name string The name of the API to get
---@return table API The API
function ElementManager.getAPI(name) end

---Gets an element by name. If the element is not loaded, it will try to load it first.
---@param name string The name of the element to get
---@return table Element The element class
function ElementManager.getElement(name) end

---@class PropertySystem
local PropertySystem = {}

---Gets a property configuration
---@param name string The name of the property
---@return table config The configuration of the property
function PropertySystem:getPropertyConfig(name) end

---Defines a property for an element class
---@param class table The element class to define the property for
---@param name string The name of the property
---@param config table The configuration of the property
function PropertySystem.defineProperty(class, name, config) end

---Update call for a property IS USED INTERNALLY
---@param name string The name of the property
---@param value any The value of the property
---@return table self The PropertySystem
function PropertySystem:_updateProperty(name, value) end

---Adds a setter hook to the PropertySystem. Setter hooks are functions that are called before a property is set.
---@param hook function The hook function to add
function PropertySystem.addSetterHook(hook) end

---Adds a property to the PropertySystem on instance level
---@param name string The name of the property
---@param config table The configuration of the property
---@return table self The PropertySystem
function PropertySystem:instanceProperty(name, config) end

---Creates an element from a blueprint
---@param elementClass table The element class to create from the blueprint
---@param blueprint table The blueprint to create the element from
---@return table element The created element
function PropertySystem.createFromBlueprint(elementClass, blueprint) end

---Removes a property from the PropertySystem on instance level
---@param name string The name of the property
---@return table self The PropertySystem
function PropertySystem:removeProperty(name) end

---Observers a property
---@param name string The name of the property
---@param callback function The callback function to call when the property changes
---@return table self The PropertySystem
function PropertySystem:observe(name, callback) end

---Removes an observer from a property
---@param name string The name of the property
---@param callback function The callback function to remove
---@return table self The PropertySystem
function PropertySystem:removeObserver(name, callback) end

---Initializes the PropertySystem IS USED INTERNALLY
---@return table self The PropertySystem
function PropertySystem:__init() end

---Removes all observers from a property
---@return table self The PropertySystem
function PropertySystem:removeAllObservers() end

---Creates a blueprint of an element class with all its properties
---@param elementClass table The element class to create a blueprint from
---@return table blueprint A table containing all property definitions
function PropertySystem.blueprint(elementClass) end

---Combines multiple properties into a single getter and setter
---@param class table The element class to combine the properties for
---@param name string The name of the combined property
function PropertySystem.combineProperties(class, name) end

---@class BaseFrame : Container
---@field term term term.current() The terminal or (monitor) peripheral object to render to
local BaseFrame = {}

---Sets the value of the Term property.
---@param self BaseFrame self
---@param Term term term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:setTerm(self, Term) end

---Hides the debug log frame
---@param self BaseFrame The frame to hide debug log for
function BaseFrame.closeConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param bg colors The background color
---@protected
function BaseFrame:drawText(x, y, text, bg) end

---Shows the debug log frame
---@param self BaseFrame The frame to show debug log in
function BaseFrame.openConsole(self) end

---Gets the value of the Term property.
---@param self BaseFrame self
---@return term |peripheral term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:getTerm(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_up(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param width number The width of the text
---@param height number The height of the text
---@param text string The text to render
---@param fg string The foreground color
---@param bg string The background color
---@protected
function BaseFrame:multiBlit(x, y, width, height, text, fg, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function BaseFrame:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function BaseFrame:key_up(key) end

---Initializes a new state for this element
---@param self BaseFrame The element to initialize state for
---@param name string The name of the state
---@param default any The default value of the state
---@return BaseFrame self The element instance
function BaseFrame:initializeState(self, name, default) end

function BaseFrame.setup() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseFrame:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:term_resize() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param bg colors The background color
---@protected
function BaseFrame:textBg(x, y, text, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function BaseFrame:key(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg colors The foreground color
---@protected
function BaseFrame:textFg(x, y, text, fg) end

function BaseFrame:drawBg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg string The foreground color
---@param bg string The background color
---@protected
function BaseFrame:blit(x, y, text, fg, bg) end

---Toggles the debug log frame
---@param self BaseFrame The frame to toggle debug log for
function BaseFrame.toggleConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param name string The name of the monitor that was touched
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:monitor_touch(name, x, y) end

---Sets the cursor position
---@param x number The x position to set the cursor to
---@param y number The y position to set the cursor to
---@param blink boolean Whether the cursor should blink
function BaseFrame:setCursor(x, y, blink) end

function BaseFrame:dispatchEvent() end

function BaseFrame:drawFg() end

---@class Dropdown : List
---@field selectedText string The text to show when no item is selected
---@field dropdownHeight number Maximum height of the dropdown menu when open
---@field isOpen boolean Whether the dropdown menu is currently open
---@field dropSymbol string The symbol to show for dropdown indication
local Dropdown = {}

---Gets the value of the DropSymbol property.
---@param self Dropdown self
---@return string "\31" The symbol to show for dropdown indication
function Dropdown:getDropSymbol(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Dropdown:mouse_click(button, x, y) end

---Gets the value of the DropdownHeight property.
---@param self Dropdown self
---@return number 5 Maximum height of the dropdown menu when open
function Dropdown:getDropdownHeight(self) end

---Gets the value of the IsOpen property.
---@param self Dropdown self
---@return boolean false Whether the dropdown menu is currently open
function Dropdown:getIsOpen(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dropdown:render() end

---Sets the value of the SelectedText property.
---@param self Dropdown self
---@param SelectedText string The text to show when no item is selected
function Dropdown:setSelectedText(self, SelectedText) end

---Sets the value of the DropSymbol property.
---@param self Dropdown self
---@param DropSymbol string The symbol to show for dropdown indication
function Dropdown:setDropSymbol(self, DropSymbol) end

---Sets the value of the IsOpen property.
---@param self Dropdown self
---@param IsOpen boolean Whether the dropdown menu is currently open
function Dropdown:setIsOpen(self, IsOpen) end

---Sets the value of the DropdownHeight property.
---@param self Dropdown self
---@param DropdownHeight number Maximum height of the dropdown menu when open
function Dropdown:setDropdownHeight(self, DropdownHeight) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Dropdown self The initialized instance
---@protected
function Dropdown:init(props, basalt) end

---Gets the value of the SelectedText property.
---@param self Dropdown self
---@return string "" The text to show when no item is selected
function Dropdown:getSelectedText(self) end

---@class Animation
local Animation = {}

---Creates a new Animation
---@param element VisualElement The element to animate
---@return Animation The new animation
function Animation.new(element) end

---Registers a callback for the complete event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onComplete(callback) end

---Registers a new animation type
---@param name string The name of the animation
---@param handlers table Table containing start, update and complete handlers
function Animation.registerAnimation(name, handlers) end

---Registers a new easing function
---@param name string The name of the easing function
---@param func function The easing function (takes progress 0-1, returns modified progress)
function Animation.registerEasing(name, func) end

---Starts the animation
---@return Animation self The animation instance
function Animation:start() end

---Registers a callback for the update event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onUpdate(callback) end

---Creates a new sequence
---@return Animation self The animation instance
function Animation:sequence() end

---The event handler for the animation (listens to timer events)
---@param event string The event type
---@param timerId number The timer ID
function Animation:event(event, timerId) end

---Registers a callback for the start event
---@param callback function The callback function to register
function Animation:onStart(callback) end

---Adds a new animation to the sequence
---@param type string The type of animation
---@param args table The animation arguments
---@param duration number The duration in seconds
---@param easing string The easing function name
function Animation:addAnimation(type, args, duration, easing) end

---@class ProgressBar : VisualElement
---@field direction string The direction of the progress bar ("up", "down", "left", "right")
---@field showPercentage boolean Whether to show the percentage text in the center
---@field progress number Current progress value (0-100)
---@field progressColor color The color used for the filled portion of the progress bar
local ProgressBar = {}

---Gets the value of the Progress property.
---@param self ProgressBar self
---@return number 0 Current progress value (0-100)
function ProgressBar:getProgress(self) end

---Sets the value of the Direction property.
---@param self ProgressBar self
---@param Direction string The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:setDirection(self, Direction) end

---Gets the value of the ShowPercentage property.
---@param self ProgressBar self
---@return boolean false Whether to show the percentage text in the center
function ProgressBar:getShowPercentage(self) end

---Gets the value of the ProgressColor property.
---@param self ProgressBar self
---@return color lime The color used for the filled portion of the progress bar
function ProgressBar:getProgressColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ProgressBar:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ProgressBar self The initialized instance
---@protected
function ProgressBar:init(props, basalt) end

---Sets the value of the ShowPercentage property.
---@param self ProgressBar self
---@param ShowPercentage boolean Whether to show the percentage text in the center
function ProgressBar:setShowPercentage(self, ShowPercentage) end

---Sets the value of the ProgressColor property.
---@param self ProgressBar self
---@param ProgressColor color The color used for the filled portion of the progress bar
function ProgressBar:setProgressColor(self, ProgressColor) end

---Sets the value of the Progress property.
---@param self ProgressBar self
---@param Progress number Current progress value (0-100)
function ProgressBar:setProgress(self, Progress) end

---Gets the value of the Direction property.
---@param self ProgressBar self
---@return string right The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:getDirection(self) end

---@class Checkbox : VisualElement
---@field autoSize boolean Whether to automatically size the checkbox
---@field checked boolean checkbox is checked
---@field checkedText string when checked
---@field text string Text to display
local Checkbox = {}

---Sets the value of the AutoSize property.
---@param self Checkbox self
---@param AutoSize boolean Whether to automatically size the checkbox
function Checkbox:setAutoSize(self, AutoSize) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Checkbox:init(props, basalt) end

---Gets the value of the AutoSize property.
---@param self Checkbox self
---@return boolean true Whether to automatically size the checkbox
function Checkbox:getAutoSize(self) end

---Gets the value of the Text property.
---@param self Checkbox self
---@return string empty Text to display
function Checkbox:getText(self) end

---Gets the value of the Checked property.
---@param self Checkbox self
---@return boolean Whether checkbox is checked
function Checkbox:getChecked(self) end

---Sets the value of the Text property.
---@param self Checkbox self
---@param Text string Text to display
function Checkbox:setText(self, Text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Clicked Whether the event was handled
---@protected
function Checkbox:mouse_click(button, x, y) end

---Sets the value of the CheckedText property.
---@param self Checkbox self
---@param CheckedText string when checked
function Checkbox:setCheckedText(self, CheckedText) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return Checkbox self The created instance
---@protected
function Checkbox.new() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Checkbox:render() end

---Sets the value of the Checked property.
---@param self Checkbox self
---@param Checked boolean checkbox is checked
function Checkbox:setChecked(self, Checked) end

---Gets the value of the CheckedText property.
---@param self Checkbox self
---@return string Text when checked
function Checkbox:getCheckedText(self) end

---@class LineChart : Graph
local LineChart = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return LineChart self The initialized instance
---@protected
function LineChart:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function LineChart:render() end

---@class Reactive
local Reactive = {}

---@class Slider : VisualElement
---@field step number Current position of the slider handle (1 to width/height)
---@field barColor color Color of the slider track
---@field max number Maximum value for value conversion (maps slider position to this range)
---@field sliderColor color Color of the slider handle
---@field horizontal boolean Whether the slider is horizontal (false for vertical)
local Slider = {}

---Gets the value of the SliderColor property.
---@param self Slider self
---@return color blue Color of the slider handle
function Slider:getSliderColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Slider:render() end

---Sets the value of the SliderColor property.
---@param self Slider self
---@param SliderColor color Color of the slider handle
function Slider:setSliderColor(self, SliderColor) end

---Sets the value of the Step property.
---@param self Slider self
---@param Step number Current position of the slider handle (1 to width/height)
function Slider:setStep(self, Step) end

---Sets the value of the Horizontal property.
---@param self Slider self
---@param Horizontal boolean Whether the slider is horizontal (false for vertical)
function Slider:setHorizontal(self, Horizontal) end

---Sets the value of the Max property.
---@param self Slider self
---@param Max number Maximum value for value conversion (maps slider position to this range)
function Slider:setMax(self, Max) end

---Gets the value of the BarColor property.
---@param self Slider self
---@return color gray Color of the slider track
function Slider:getBarColor(self) end

---Gets the value of the Step property.
---@param self Slider self
---@return number 1 Current position of the slider handle (1 to width/height)
function Slider:getStep(self) end

---Registers a function to handle the onChange event.
---@param value number
---@param self Slider self
---@param func function The function to be called when the event fires
function Slider:onOnChange(self, func) end

---Sets the value of the BarColor property.
---@param self Slider self
---@param BarColor color Color of the slider track
function Slider:setBarColor(self, BarColor) end

---Gets the value of the Horizontal property.
---@param self Slider self
---@return boolean true Whether the slider is horizontal (false for vertical)
function Slider:getHorizontal(self) end

---Gets the current value of the slider
---@return number value The current value (0 to max)
function Slider:getValue() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Slider self The initialized instance
---@protected
function Slider:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_scroll(button, x, y) end

---Gets the value of the Max property.
---@param self Slider self
---@return number 100 Maximum value for value conversion (maps slider position to this range)
function Slider:getMax(self) end

---@class basalt
local basalt = {}

---Returns a Plugin API
---@param name string The name of the plugin
---@return table Plugin The plugin API
function basalt.getAPI(name) end

---Returns an element's class without creating a instance
---@param name string The name of the element
---@return table Element The element class
function basalt.getElementClass(name) end

---Gets or creates the main frame
---@return BaseFrame BaseFrame The main frame instance
function basalt.getMainFrame() end

---Sets the active frame
---@param frame BaseFrame The frame to set as active
function basalt.setActiveFrame(frame) end

---Starts the Basalt runtime
function basalt.run() end

---Schedules a function to run in a coroutine
---@param func function The function to schedule
---@return thread func The scheduled function
function basalt.schedule(func) end

---Stops the Basalt runtime
function basalt.stop() end

---Creates and returns a new UI element of the specified type.
---@param type string The type of element to create (e.g. "Button", "Label", "BaseFrame")
---@return table element The created element instance
function basalt.create(type) end

---Creates and returns a new BaseFrame
---@return BaseFrame BaseFrame The created frame instance
function basalt.createFrame() end

---Sets a frame as focused
---@param frame BaseFrame The frame to set as focused
function basalt.setFocus(frame) end

---Returns the focused frame
---@return BaseFrame ? BaseFrame The focused frame
function basalt.getFocus() end

---Returns the element manager instance
---@return table ElementManager The element manager
function basalt.getElementManager() end

---Returns the error manager instance
---@return table ErrorManager The error manager
function basalt.getErrorManager() end

---Runs basalt once, can be used to update the UI manually, but you have to feed it the events
function basalt.update() end

---Returns the active frame
---@return BaseFrame ? BaseFrame The frame to set as active
function basalt.getActiveFrame() end

---Removes a scheduled update
---@param func thread The scheduled function to remove
---@return boolean success Whether the scheduled function was removed
function basalt.removeSchedule(func) end

---@class TextBox : VisualElement
---@field cursorX number Cursor X position
---@field editable boolean Whether text can be edited
---@field syntaxPatterns table Syntax highlighting patterns
---@field cursorY number Cursor Y position (line number)
---@field lines table Array of text lines
---@field scrollX number Horizontal scroll offset
---@field cursorColor number Color of the cursor
---@field scrollY number Vertical scroll offset
local TextBox = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_scroll(direction, x, y) end

---Gets the value of the CursorY property.
---@param self TextBox self
---@return number 1 Cursor Y position (line number)
function TextBox:getCursorY(self) end

---Updates the viewport to keep the cursor in view
---@return TextBox self The TextBox instance
function TextBox:updateViewport() end

---Sets the value of the Editable property.
---@param self TextBox self
---@param Editable boolean Whether text can be edited
function TextBox:setEditable(self, Editable) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:char(char) end

---Gets the text of the TextBox
---@return string text The text of the TextBox
function TextBox:getText() end

---Sets the text of the TextBox
---@param text string The text to set
---@return TextBox self The TextBox instance
function TextBox:setText(text) end

---Sets the value of the ScrollX property.
---@param self TextBox self
---@param ScrollX number Horizontal scroll offset
function TextBox:setScrollX(self, ScrollX) end

---Sets the value of the ScrollY property.
---@param self TextBox self
---@param ScrollY number Vertical scroll offset
function TextBox:setScrollY(self, ScrollY) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TextBox:render() end

---Gets the value of the ScrollY property.
---@param self TextBox self
---@return number 0 Vertical scroll offset
function TextBox:getScrollY(self) end

---Gets the value of the Editable property.
---@param self TextBox self
---@return boolean true Whether text can be edited
function TextBox:getEditable(self) end

---Sets the value of the SyntaxPatterns property.
---@param self TextBox self
---@param SyntaxPatterns table Syntax highlighting patterns
function TextBox:setSyntaxPatterns(self, SyntaxPatterns) end

---Gets the value of the CursorX property.
---@param self TextBox self
---@return number 1 Cursor X position
function TextBox:getCursorX(self) end

---Adds a new syntax highlighting pattern
---@param pattern string The regex pattern to match
---@param color colors The color to apply
---@return TextBox self The TextBox instance
function TextBox:addSyntaxPattern(pattern, color) end

---Gets the value of the Lines property.
---@param self TextBox self
---@return table {} Array of text lines
function TextBox:getLines(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:key(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TextBox:paste() end

---Gets the value of the ScrollX property.
---@param self TextBox self
---@return number 0 Horizontal scroll offset
function TextBox:getScrollX(self) end

---Sets the value of the Lines property.
---@param self TextBox self
---@param Lines table Array of text lines
function TextBox:setLines(self, Lines) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return TextBox self The initialized instance
---@protected
function TextBox:init(props, basalt) end

---Gets the value of the SyntaxPatterns property.
---@param self TextBox self
---@return table {} Syntax highlighting patterns
function TextBox:getSyntaxPatterns(self) end

---Sets the value of the CursorX property.
---@param self TextBox self
---@param CursorX number Cursor X position
function TextBox:setCursorX(self, CursorX) end

---Sets the value of the CursorY property.
---@param self TextBox self
---@param CursorY number Cursor Y position (line number)
function TextBox:setCursorY(self, CursorY) end

---Gets the value of the CursorColor property.
---@param self TextBox self
---@return number nil Color of the cursor
function TextBox:getCursorColor(self) end

---Sets the value of the CursorColor property.
---@param self TextBox self
---@param CursorColor number Color of the cursor
function TextBox:setCursorColor(self, CursorColor) end

---@class BarChart : Graph
local BarChart = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return BarChart self The initialized instance
---@protected
function BarChart:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BarChart:render() end

---@class Program : VisualElement
---@field program table The program instance
---@field errorCallback function The error callback function
---@field path string The path to the program
---@field doneCallback function The done callback function
---@field running boolean Whether the program is running
local Program = {}

---Sets the value of the Program property.
---@param self Program self
---@param Program table The program instance
function Program:setProgram(self, Program) end

---Gets the value of the DoneCallback property.
---@param self Program self
---@return function nil The done callback function
function Program:getDoneCallback(self) end

---Sets the value of the Path property.
---@param self Program self
---@param Path string The path to the program
function Program:setPath(self, Path) end

---Gets the value of the Path property.
---@param self Program self
---@return string "" The path to the program
function Program:getPath(self) end

---Gets the value of the ErrorCallback property.
---@param self Program self
---@return function nil The error callback function
function Program:getErrorCallback(self) end

---Stops the program
---@return Program self The Program instance
function Program:stop() end

---Gets the value of the Program property.
---@param self Program self
---@return table nil The program instance
function Program:getProgram(self) end

---Registers a callback for the program's error event, if the function returns false, the program won't stop
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onError(fn) end

---Gets the value of the Running property.
---@param self Program self
---@return boolean false Whether the program is running
function Program:getRunning(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:focus() end

---Sets the value of the ErrorCallback property.
---@param self Program self
---@param ErrorCallback function The error callback function
function Program:setErrorCallback(self, ErrorCallback) end

---Sets the value of the DoneCallback property.
---@param self Program self
---@param DoneCallback function The done callback function
function Program:setDoneCallback(self, DoneCallback) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Program self The initialized instance
---@protected
function Program:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:render() end

---Sends an event to the program
---@param event string The event to send
---@return Program self The Program instance
function Program:sendEvent(event) end

---Registers a callback for the program's done event
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onDone(fn) end

function BasaltProgram:setArgs() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return any result The event result
---@protected
function Program:dispatchEvent(event) end

---Sets the value of the Running property.
---@param self Program self
---@param Running boolean Whether the program is running
function Program:setRunning(self, Running) end

---Executes a program
---@param path string The path to the program
---@return Program self The Program instance
function Program:execute(path) end

---@class Tree : VisualElement
---@field expandedNodes table Table of nodes that are currently expanded
---@field nodes table The tree structure containing node objects with {text, children} properties
---@field selectedColor color Background color of selected node
---@field horizontalOffset number Current horizontal scroll position
---@field selectedNode table nil Currently selected node
---@field scrollOffset number Current vertical scroll position
---@field nodeColor color Color of unselected nodes
local Tree = {}

---Expands a node
---@param node table The node to expand
---@return Tree self The Tree instance
function Tree:expandNode(node) end

---Sets the value of the SelectedColor property.
---@param self Tree self
---@param SelectedColor color Background color of selected node
function Tree:setSelectedColor(self, SelectedColor) end

---Gets the value of the ExpandedNodes property.
---@param self Tree self
---@return table {} Table of nodes that are currently expanded
function Tree:getExpandedNodes(self) end

---Gets the value of the Nodes property.
---@param self Tree self
---@return table {} The tree structure containing node objects with {text, children} properties
function Tree:getNodes(self) end

---Gets the size of the tree
---@return number width The width of the tree
---@return number height The height of the tree
function Tree:getNodeSize() end

---Gets the value of the ScrollOffset property.
---@param self Tree self
---@return number 0 Current vertical scroll position
function Tree:getScrollOffset(self) end

---Initializes the Tree instance
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Tree self The initialized instance
---@protected
function Tree:init(props, basalt) end

---Toggles a node's expanded state
---@param node table The node to toggle
---@return Tree self The Tree instance
function Tree:toggleNode(node) end

---Gets the value of the HorizontalOffset property.
---@param self Tree self
---@return number 0 Current horizontal scroll position
function Tree:getHorizontalOffset(self) end

---Sets the value of the ExpandedNodes property.
---@param self Tree self
---@param ExpandedNodes table Table of nodes that are currently expanded
function Tree:setExpandedNodes(self, ExpandedNodes) end

---Sets the value of the Nodes property.
---@param self Tree self
---@param Nodes table The tree structure containing node objects with {text, children} properties
function Tree:setNodes(self, Nodes) end

---Gets the value of the NodeColor property.
---@param self Tree self
---@return color white Color of unselected nodes
function Tree:getNodeColor(self) end

---Sets the value of the NodeColor property.
---@param self Tree self
---@param NodeColor color Color of unselected nodes
function Tree:setNodeColor(self, NodeColor) end

---Gets the value of the SelectedColor property.
---@param self Tree self
---@return color lightBlue Background color of selected node
function Tree:getSelectedColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_scroll(direction, x, y) end

---Sets the value of the SelectedNode property.
---@param self Tree self
---@param SelectedNode table nil Currently selected node
function Tree:setSelectedNode(self, SelectedNode) end

---Sets the value of the HorizontalOffset property.
---@param self Tree self
---@param HorizontalOffset number Current horizontal scroll position
function Tree:setHorizontalOffset(self, HorizontalOffset) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Tree:render() end

---Collapses a node
---@param node table The node to collapse
---@return Tree self The Tree instance
function Tree:collapseNode(node) end

---Gets the value of the SelectedNode property.
---@param self Tree self
---@return table ? nil Currently selected node
function Tree:getSelectedNode(self) end

---Registers a callback for when a node is selected
---@param callback function The callback function
---@return Tree self The Tree instance
function Tree:onSelect(callback) end

---Sets the value of the ScrollOffset property.
---@param self Tree self
---@param ScrollOffset number Current vertical scroll position
function Tree:setScrollOffset(self, ScrollOffset) end

---Handles mouse click events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_click(button, x, y) end

---@class ThemeAPI
local ThemeAPI = {}

---Loads a theme from a JSON file
---@param path string Path to the theme JSON file
function ThemeAPI.loadTheme(path) end

---Gets the current theme configuration
---@return table theme The current theme configuration
function ThemeAPI.getTheme() end

---Sets the current theme
---@param newTheme table The theme configuration to set
function ThemeAPI.setTheme(newTheme) end

---@class Render
local Render = {}

---Blits text to the screen with multiple lines
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param width number The width of the text
---@param height number The height of the text
---@param text string The text to blit
---@param fg colors The foreground color of the text
---@param bg colors The background color of the text
---@return Render 
function Render:multiBlit(x, y, width, height, text, fg, bg) end

---Blits text to the screen with a background color
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param bg colors The background color of the text
---@return Render 
function Render:textBg(x, y, text, bg) end

---Blits text to the screen
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Render 
function Render:blit(x, y, text, fg, bg) end

---Sets the cursor position
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@return Render 
function Render:setCursor(x, y, blink) end

---Adds a dirty rectangle to the buffer
---@param x number The x position of the rectangle
---@param y number The y position of the rectangle
---@param width number The width of the rectangle
---@param height number The height of the rectangle
---@return Render 
function Render:addDirtyRect(x, y, width, height) end

---Sets the size of the render
---@param width number The width of the render
---@param height number The height of the render
---@return Render 
function Render:setSize(width, height) end

---Gets the size of the render
---@return number , number
function Render:getSize() end

---Merges two rectangles
---@param target table The target rectangle
---@param source table The source rectangle
---@return Render 
function Render:mergeRects(target, source) end

---Blits a foreground color to the screen
---@param x number The x position
---@param y number The y position
---@param fg string The foreground color to blit
---@return Render 
function Render:fg(x, y, fg) end

---Checks if two rectangles overlap
---@param r1 table The first rectangle
---@param r2 table The second rectangle
---@return boolean 
function Render:rectOverlaps(r1, r2) end

---Blits text to the screen
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@return Render 
function Render:text(x, y, text) end

---Clears the screen
---@param bg colors The background color to clear the screen with
---@return Render 
function Render:clear(bg) end

---Blits text to the screen with a foreground color
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param fg colors The foreground color of the text
---@return Render 
function Render:textFg(x, y, text, fg) end

---Clears an area of the screen
---@param x number The x position of the area
---@param y number The y position of the area
---@param width number The width of the area
---@param height number The height of the area
---@param bg colors The background color to clear the area with
---@return Render 
function Render:clearArea(x, y, width, height, bg) end

---Blits a background color to the screen
---@param x number The x position
---@param y number The y position
---@param bg string The background color to blit
---@return Render 
function Render:bg(x, y, bg) end

---Renders the buffer to the screen
---@return Render 
function Render:render() end

---Creates a new Render object
---@param terminal table The terminal object to render to
---@return Render 
function Render.new(terminal) end

---@class Table : VisualElement
---@field selectedColor color Background color of selected row
---@field sortDirection string Sort direction ("asc" or "desc")
---@field headerColor color Color of the column headers
---@field columns table List of column definitions with {name, width} properties
---@field sortColumn number nil Currently sorted column index
---@field scrollOffset number Current scroll position
---@field data table The table data as array of row arrays
---@field gridColor color Color of grid lines
---@field selectedRow number nil Currently selected row index
local Table = {}

---Gets the value of the ScrollOffset property.
---@param self Table self
---@return number 0 Current scroll position
function Table:getScrollOffset(self) end

---Gets the value of the SelectedRow property.
---@param self Table self
---@return number ? nil Currently selected row index
function Table:getSelectedRow(self) end

---Sets the value of the SelectedRow property.
---@param self Table self
---@param SelectedRow number nil Currently selected row index
function Table:setSelectedRow(self, SelectedRow) end

---Adds a new row of data to the table
---@return Table self The Table instance
function Table:addData() end

---Gets the value of the Columns property.
---@param self Table self
---@return table {} List of column definitions with {name, width} properties
function Table:getColumns(self) end

---Gets the value of the HeaderColor property.
---@param self Table self
---@return color blue Color of the column headers
function Table:getHeaderColor(self) end

function Table:onSelect() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Table self The initialized instance
---@protected
function Table:init(props, basalt) end

---Gets the value of the Data property.
---@param self Table self
---@return table {} The table data as array of row arrays
function Table:getData(self) end

---Sets the value of the GridColor property.
---@param self Table self
---@param GridColor color Color of grid lines
function Table:setGridColor(self, GridColor) end

---Sorts the table data by column
---@param columnIndex number The index of the column to sort by
---@param fn function ? Optional custom sorting function
---@return Table self The Table instance
function Table:sortData(columnIndex, fn) end

---Gets the value of the SortColumn property.
---@param self Table self
---@return number ? nil Currently sorted column index
function Table:getSortColumn(self) end

---Sets the value of the ScrollOffset property.
---@param self Table self
---@param ScrollOffset number Current scroll position
function Table:setScrollOffset(self, ScrollOffset) end

---Gets the value of the GridColor property.
---@param self Table self
---@return color gray Color of grid lines
function Table:getGridColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (-1 up, 1 down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Table:mouse_scroll(direction, x, y) end

---Sets the value of the SortColumn property.
---@param self Table self
---@param SortColumn number nil Currently sorted column index
function Table:setSortColumn(self, SortColumn) end

---Adds a new column to the table
---@param name string The name of the column
---@param width number The width of the column
---@return Table self The Table instance
function Table:addColumn(name, width) end

---Sets the value of the SortDirection property.
---@param self Table self
---@param SortDirection string Sort direction ("asc" or "desc")
function Table:setSortDirection(self, SortDirection) end

---Sets the value of the SelectedColor property.
---@param self Table self
---@param SelectedColor color Background color of selected row
function Table:setSelectedColor(self, SelectedColor) end

---Sets the value of the Columns property.
---@param self Table self
---@param Columns table List of column definitions with {name, width} properties
function Table:setColumns(self, Columns) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Table:mouse_click(button, x, y) end

---Sets the value of the HeaderColor property.
---@param self Table self
---@param HeaderColor color Color of the column headers
function Table:setHeaderColor(self, HeaderColor) end

---Gets the value of the SelectedColor property.
---@param self Table self
---@return color lightBlue Background color of selected row
function Table:getSelectedColor(self) end

---Sets the value of the Data property.
---@param self Table self
---@param Data table The table data as array of row arrays
function Table:setData(self, Data) end

---Gets the value of the SortDirection property.
---@param self Table self
---@return string "asc" Sort direction ("asc" or "desc")
function Table:getSortDirection(self) end

---@class Benchmark
local Benchmark = {}

---Starts a custom benchmark
---@param name string The name of the benchmark
function API.start(name) end

---Stops a custom benchmark
---@param name string The name of the benchmark to stop
function API.stop(name) end

---Gets statistics for a benchmark
---@param name string The name of the benchmark
---@return table ? stats The benchmark statistics or nil
function API.getStats(name) end

---Clears all custom benchmarks
function API.clearAll() end

---Clears a specific benchmark
---@param name string The name of the benchmark to clear
function API.clear(name) end

---@class Menu : List
---@field separatorColor color The color used for separator items in the menu
local Menu = {}

---Gets the value of the SeparatorColor property.
---@param self Menu self
---@return color gray The color used for separator items in the menu
function Menu:getSeparatorColor(self) end

---Sets the menu items
---@param items table [] List of items with {text, separator, callback, foreground, background} properties
---@return Menu self The Menu instance
function Menu:setItems(items) end

---Sets the value of the SeparatorColor property.
---@param self Menu self
---@param SeparatorColor color The color used for separator items in the menu
function Menu:setSeparatorColor(self, SeparatorColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function Menu:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Menu:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Menu self The initialized instance
---@protected
function Menu:init(props, basalt) end

---@class Button : VisualElement
---@field text string Button text
local Button = {}

---Sets the value of the Text property.
---@param self Button self
---@param Text string Button text
function Button:setText(self, Text) end

---Gets the value of the Text property.
---@param self Button self
---@return string Button Button text
function Button:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Button:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Button:init(props, basalt) end

---@class Frame : Container
---@field draggingMap table The map of dragging positions
---@field draggable boolean Whether the frame is draggable
local Frame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_up(button, x, y) end

---Gets the value of the DraggingMap property.
---@param self Frame self
---@return table {} The map of dragging positions
function Frame:getDraggingMap(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Frame self The initialized instance
---@protected
function Frame:init(props, basalt) end

---Sets the value of the Draggable property.
---@param self Frame self
---@param Draggable boolean Whether the frame is draggable
function Frame:setDraggable(self, Draggable) end

---Gets the value of the Draggable property.
---@param self Frame self
---@return boolean false Whether the frame is draggable
function Frame:getDraggable(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the drag position
---@param y number The y position of the drag position
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_drag(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_click(button, x, y) end

---Sets the value of the DraggingMap property.
---@param self Frame self
---@param DraggingMap table The map of dragging positions
function Frame:setDraggingMap(self, DraggingMap) end

---@class ScrollBar : VisualElement
---@field step number Step size for scroll operations
---@field maxValue number 100 Maximum value or function that returns it
---@field orientation string Orientation of the ScrollBar ("vertical" or "horizontal")
---@field symbol string " Symbol used for the ScrollBar handle
---@field dragMultiplier number How fast the ScrollBar moves when dragging
---@field handleSize number Size of the ScrollBar handle in characters
---@field min number Minimum scroll value
---@field minValue number 0 Minimum value or function that returns it
---@field value number Current scroll value
---@field attachedProperty string nil The property being controlled
---@field attachedElement table nil The element this ScrollBar is attached to
---@field max number Maximum scroll value
---@field symbolBackgroundColor color Background color of the ScrollBar handle
---@field backgroundSymbol string Symbol used for the ScrollBar background
local ScrollBar = {}

---Gets the value of the Max property.
---@param self ScrollBar self
---@return number 100 Maximum scroll value
function ScrollBar:getMax(self) end

---Gets the value of the Symbol property.
---@param self ScrollBar self
---@return string " " Symbol used for the ScrollBar handle
function ScrollBar:getSymbol(self) end

---Gets the value of the Step property.
---@param self ScrollBar self
---@return number 1 Step size for scroll operations
function ScrollBar:getStep(self) end

---Gets the value of the BackgroundSymbol property.
---@param self ScrollBar self
---@return string "\127" Symbol used for the ScrollBar background
function ScrollBar:getBackgroundSymbol(self) end

---Gets the value of the HandleSize property.
---@param self ScrollBar self
---@return number 2 Size of the ScrollBar handle in characters
function ScrollBar:getHandleSize(self) end

---Sets the value of the Orientation property.
---@param self ScrollBar self
---@param Orientation string Orientation of the ScrollBar ("vertical" or "horizontal")
function ScrollBar:setOrientation(self, Orientation) end

---Updates the attached element's property based on the ScrollBar value
---@return ScrollBar self The ScrollBar instance
function ScrollBar:updateAttachedElement() end

---Sets the value of the MaxValue property.
---@param self ScrollBar self
---@param MaxValue number 100 Maximum value or function that returns it
function ScrollBar:setMaxValue(self, MaxValue) end

---Gets the value of the Value property.
---@param self ScrollBar self
---@return number 0 Current scroll value
function ScrollBar:getValue(self) end

---Attaches the ScrollBar to an element's property
---@param element BaseElement The element to attach to
---@param config table Configuration {property = "propertyName", min = number|function, max = number|function}
---@return ScrollBar self The ScrollBar instance
function ScrollBar:attach(element, config) end

---Sets the value of the AttachedProperty property.
---@param self ScrollBar self
---@param AttachedProperty string nil The property being controlled
function ScrollBar:setAttachedProperty(self, AttachedProperty) end

---Sets the value of the SymbolBackgroundColor property.
---@param self ScrollBar self
---@param SymbolBackgroundColor color Background color of the ScrollBar handle
function ScrollBar:setSymbolBackgroundColor(self, SymbolBackgroundColor) end

---Sets the value of the BackgroundSymbol property.
---@param self ScrollBar self
---@param BackgroundSymbol string Symbol used for the ScrollBar background
function ScrollBar:setBackgroundSymbol(self, BackgroundSymbol) end

---Sets the value of the DragMultiplier property.
---@param self ScrollBar self
---@param DragMultiplier number How fast the ScrollBar moves when dragging
function ScrollBar:setDragMultiplier(self, DragMultiplier) end

---Sets the value of the Value property.
---@param self ScrollBar self
---@param Value number Current scroll value
function ScrollBar:setValue(self, Value) end

---Gets the value of the DragMultiplier property.
---@param self ScrollBar self
---@return number 1 How fast the ScrollBar moves when dragging
function ScrollBar:getDragMultiplier(self) end

---Gets the value of the Orientation property.
---@param self ScrollBar self
---@return string vertical Orientation of the ScrollBar ("vertical" or "horizontal")
function ScrollBar:getOrientation(self) end

---Sets the value of the MinValue property.
---@param self ScrollBar self
---@param MinValue number 0 Minimum value or function that returns it
function ScrollBar:setMinValue(self, MinValue) end

---Gets the value of the Min property.
---@param self ScrollBar self
---@return number 0 Minimum scroll value
function ScrollBar:getMin(self) end

---Gets the value of the AttachedElement property.
---@param self ScrollBar self
---@return table ? nil The element this ScrollBar is attached to
function ScrollBar:getAttachedElement(self) end

---Sets the value of the Symbol property.
---@param self ScrollBar self
---@param Symbol string " Symbol used for the ScrollBar handle
function ScrollBar:setSymbol(self, Symbol) end

---Sets the value of the Max property.
---@param self ScrollBar self
---@param Max number Maximum scroll value
function ScrollBar:setMax(self, Max) end

---Sets the value of the Min property.
---@param self ScrollBar self
---@param Min number Minimum scroll value
function ScrollBar:setMin(self, Min) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_scroll(direction, x, y) end

---Sets the value of the HandleSize property.
---@param self ScrollBar self
---@param HandleSize number Size of the ScrollBar handle in characters
function ScrollBar:setHandleSize(self, HandleSize) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ScrollBar:render() end

---Gets the value of the MinValue property.
---@param self ScrollBar self
---@return number |function 0 Minimum value or function that returns it
function ScrollBar:getMinValue(self) end

---Gets the value of the SymbolBackgroundColor property.
---@param self ScrollBar self
---@return color black Background color of the ScrollBar handle
function ScrollBar:getSymbolBackgroundColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_drag(button, x, y) end

---Sets the value of the Step property.
---@param self ScrollBar self
---@param Step number Step size for scroll operations
function ScrollBar:setStep(self, Step) end

---Sets the value of the AttachedElement property.
---@param self ScrollBar self
---@param AttachedElement table nil The element this ScrollBar is attached to
function ScrollBar:setAttachedElement(self, AttachedElement) end

---Gets the value of the AttachedProperty property.
---@param self ScrollBar self
---@return string ? nil The property being controlled
function ScrollBar:getAttachedProperty(self) end

---Gets the value of the MaxValue property.
---@param self ScrollBar self
---@return number |function 100 Maximum value or function that returns it
function ScrollBar:getMaxValue(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ScrollBar self The initialized instance
---@protected
function ScrollBar:init(props, basalt) end

---@class BigFont : VisualElement
---@field fontSize number The font size of the BigFont
---@field text string BigFont text
local BigFont = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function BigFont:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BigFont:render() end

---Sets the value of the FontSize property.
---@param self BigFont self
---@param FontSize number The font size of the BigFont
function BigFont:setFontSize(self, FontSize) end

---Gets the value of the FontSize property.
---@param self BigFont self
---@return number 1 The font size of the BigFont
function BigFont:getFontSize(self) end

---Sets the value of the Text property.
---@param self BigFont self
---@param Text string BigFont text
function BigFont:setText(self, Text) end

---Gets the value of the Text property.
---@param self BigFont self
---@return string BigFont BigFont text
function BigFont:getText(self) end

---@class Log
local Log = {}

---Sends a warning message to the logger.
function Log.warn() end

---Sends an info message to the logger.
function Log.info() end

---Sets if the logger should log to a file.
function Log.setLogToFile() end

---Sets if the logger should log
function Log.setEnabled() end

---Sends an error message to the logger.
function Log.error() end

---Sends a debug message to the logger.
function Log.debug() end

---@class List : VisualElement
---@field multiSelection boolean Whether multiple items can be selected at once
---@field selectedForeground color Text color for selected items
---@field selectable boolean Whether items in the list can be selected
---@field offset number Current scroll offset for viewing long lists
---@field items table List of items to display. Items can be tables with properties including selected state
---@field selectedBackground color Background color for selected items
local List = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return List self The initialized instance
---@protected
function List:init(props, basalt) end

---Adds an item to the list
---@param text string |table The item to add (string or item table)
---@return List self The List instance
function List:addItem(text) end

---Gets the value of the MultiSelection property.
---@param self List self
---@return boolean false Whether multiple items can be selected at once
function List:getMultiSelection(self) end

---Clears all items from the list
---@return List self The List instance
function List:clear() end

---Gets the value of the Selectable property.
---@param self List self
---@return boolean true Whether items in the list can be selected
function List:getSelectable(self) end

---Removes an item from the list
---@param index number The index of the item to remove
---@return List self The List instance
function List:removeItem(index) end

---Sets the value of the Selectable property.
---@param self List self
---@param Selectable boolean Whether items in the list can be selected
function List:setSelectable(self, Selectable) end

---Gets the value of the SelectedForeground property.
---@param self List self
---@return color white Text color for selected items
function List:getSelectedForeground(self) end

---Sets the value of the MultiSelection property.
---@param self List self
---@param MultiSelection boolean Whether multiple items can be selected at once
function List:setMultiSelection(self, MultiSelection) end

---Gets the value of the SelectedBackground property.
---@param self List self
---@return color blue Background color for selected items
function List:getSelectedBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function List:render() end

---Scrolls the list to the top
---@return List self The List instance
function List:scrollToTop() end

---Gets the value of the Items property.
---@param self List self
---@return table {} List of items to display. Items can be tables with properties including selected state
function List:getItems(self) end

---Scrolls the list to the bottom
---@return List self The List instance
function List:scrollToBottom() end

---Registers a callback for the select event
---@param callback function The callback function to register
---@return List self The List instance
function List:onSelect(callback) end

---Sets the value of the Items property.
---@param self List self
---@param Items table List of items to display. Items can be tables with properties including selected state
function List:setItems(self, Items) end

---Selects an item by index
---@param index number The index of the item to select
---@return List self The List instance
function List:selectItem(index) end

---Gets the value of the Offset property.
---@param self List self
---@return number 0 Current scroll offset for viewing long lists
function List:getOffset(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll (1 for down, -1 for up)
---@param x number The x-coordinate of the scroll
---@param y number The y-coordinate of the scroll
---@return boolean Whether the event was handled
---@protected
function List:mouse_scroll(direction, x, y) end

---Registers a function to handle the onSelect event.
---@param index number
---@param item table
---@param self List self
---@param func function The function to be called when the event fires
function List:onOnSelect(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x-coordinate of the click
---@param y number The y-coordinate of the click
---@return boolean Whether the event was handled
---@protected
function List:mouse_click(button, x, y) end

---Gets first selected item
---@return table ? selected The first item
function List:getSelectedItem() end

---Sets the value of the Offset property.
---@param self List self
---@param Offset number Current scroll offset for viewing long lists
function List:setOffset(self, Offset) end

---Gets the currently selected items
---@return table selected List of selected items
function List:getSelectedItems() end

---Sets the value of the SelectedBackground property.
---@param self List self
---@param SelectedBackground color Background color for selected items
function List:setSelectedBackground(self, SelectedBackground) end

---Sets the value of the SelectedForeground property.
---@param self List self
---@param SelectedForeground color Text color for selected items
function List:setSelectedForeground(self, SelectedForeground) end

---@class Timer : BaseElement
---@field interval number The interval in seconds at which the timer will trigger its action.
---@field running boolean Indicates whether the timer is currently running or not.
---@field amount number The amount of time the timer should run.
---@field action function The action to be performed when the timer triggers.
local Timer = {}

---Sets the value of the Interval property.
---@param self Timer self
---@param Interval number The interval in seconds at which the timer will trigger its action.
function Timer:setInterval(self, Interval) end

---Gets the value of the Action property.
---@param self Timer self
---@return function function The action to be performed when the timer triggers.
function Timer:getAction(self) end

---Sets the value of the Action property.
---@param self Timer self
---@param Action function The action to be performed when the timer triggers.
function Timer:setAction(self, Action) end

---Sets the value of the Amount property.
---@param self Timer self
---@param Amount number The amount of time the timer should run.
function Timer:setAmount(self, Amount) end

---Gets the value of the Running property.
---@param self Timer self
---@return boolean false Indicates whether the timer is currently running or not.
function Timer:getRunning(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Timer:dispatchEvent() end

---Gets the value of the Interval property.
---@param self Timer self
---@return number 1 The interval in seconds at which the timer will trigger its action.
function Timer:getInterval(self) end

---Stops the timer if it is currently running.
---@param self Timer The Timer instance to stop
---@return Timer self The Timer instance
function Timer:stop(self) end

---Starts the timer with the specified interval.
---@param self Timer The Timer instance to start
---@return Timer self The Timer instance
function Timer:start(self) end

---Gets the value of the Amount property.
---@param self Timer self
---@return number -1 The amount of time the timer should run.
function Timer:getAmount(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Timer:init(props, basalt) end

---Sets the value of the Running property.
---@param self Timer self
---@param Running boolean Indicates whether the timer is currently running or not.
function Timer:setRunning(self, Running) end

---@class Flexbox : Container
---@field flexJustifyContent string The alignment of flex items along the main axis
---@field flexAlignItems string The alignment of flex items along the cross axis
---@field flexWrap boolean Whether to wrap flex items onto multiple lines
---@field flexSpacing number The spacing between flex items
---@field flexUpdateLayout boolean Whether to update the layout of the flexbox
---@field flexDirection string The direction of the flexbox layout "row" or "column"
---@field flexCrossPadding number The padding on both sides of the cross axis
local Flexbox = {}

---Sets the value of the FlexSpacing property.
---@param self Flexbox self
---@param FlexSpacing number The spacing between flex items
function Flexbox:setFlexSpacing(self, FlexSpacing) end

---Gets the value of the FlexDirection property.
---@param self Flexbox self
---@return string "row" The direction of the flexbox layout "row" or "column"
function Flexbox:getFlexDirection(self) end

---Gets the value of the FlexCrossPadding property.
---@param self Flexbox self
---@return number 0 The padding on both sides of the cross axis
function Flexbox:getFlexCrossPadding(self) end

---Sets the value of the FlexUpdateLayout property.
---@param self Flexbox self
---@param FlexUpdateLayout boolean Whether to update the layout of the flexbox
function Flexbox:setFlexUpdateLayout(self, FlexUpdateLayout) end

---Sets the value of the FlexJustifyContent property.
---@param self Flexbox self
---@param FlexJustifyContent string The alignment of flex items along the main axis
function Flexbox:setFlexJustifyContent(self, FlexJustifyContent) end

---Gets the value of the FlexSpacing property.
---@param self Flexbox self
---@return number 1 The spacing between flex items
function Flexbox:getFlexSpacing(self) end

---Sets the value of the FlexDirection property.
---@param self Flexbox self
---@param FlexDirection string The direction of the flexbox layout "row" or "column"
function Flexbox:setFlexDirection(self, FlexDirection) end

---Sets the value of the FlexWrap property.
---@param self Flexbox self
---@param FlexWrap boolean Whether to wrap flex items onto multiple lines
function Flexbox:setFlexWrap(self, FlexWrap) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Flexbox self The initialized instance
---@protected
function Flexbox:init(props, basalt) end

---Sets the value of the FlexAlignItems property.
---@param self Flexbox self
---@param FlexAlignItems string The alignment of flex items along the cross axis
function Flexbox:setFlexAlignItems(self, FlexAlignItems) end

---Gets the value of the FlexJustifyContent property.
---@param self Flexbox self
---@return string "flex-start" The alignment of flex items along the main axis
function Flexbox:getFlexJustifyContent(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Flexbox:render() end

---Sets the value of the FlexCrossPadding property.
---@param self Flexbox self
---@param FlexCrossPadding number The padding on both sides of the cross axis
function Flexbox:setFlexCrossPadding(self, FlexCrossPadding) end

---Adds a new line break to the flexbox
---@param self Flexbox The element itself
---@return Flexbox 
function Flexbox:addLineBreak(self) end

---Gets the value of the FlexAlignItems property.
---@param self Flexbox self
---@return string "flex-start" The alignment of flex items along the cross axis
function Flexbox:getFlexAlignItems(self) end

---Removes a child element from the flexbox
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param element Element The child element to remove
---@return Flexbox self The flexbox instance
---@protected
function Flexbox:removeChild(element) end

---Gets the value of the FlexWrap property.
---@param self Flexbox self
---@return boolean false Whether to wrap flex items onto multiple lines
function Flexbox:getFlexWrap(self) end

---Gets the value of the FlexUpdateLayout property.
---@param self Flexbox self
---@return boolean false Whether to update the layout of the flexbox
function Flexbox:getFlexUpdateLayout(self) end

---Adds a child element to the flexbox
---@param element Element The child element to add
---@return Flexbox self The flexbox instance
function Flexbox:addChild(element) end

---@class BaseElement : PropertySystem
---@field name string The name of the element
---@field enabled boolean Whether the element is enabled or not
---@field id string The unique identifier for the element
---@field eventCallbacks table The event callbacks for the element
---@field type string The type identifier of the element
local BaseElement = {}

---Triggers an event and calls all registered callbacks
---@param event string The event to fire
---@return table self The BaseElement instance
function BaseElement:fireEvent(event) end

---Gets the value of the Id property.
---@param self BaseElement self
---@return string BaseElement The unique identifier for the element
function BaseElement:getId(self) end

---Sets the value of the Id property.
---@param self BaseElement self
---@param Id string The unique identifier for the element
function BaseElement:setId(self, Id) end

---Starts profiling a method
---@param methodName string The name of the method to profile
---@return BaseElement self The element instance
function BaseElement:startProfile(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseElement:init(props, basalt) end

---Registers a callback function for an event
---@param event string The event to register the callback for
---@param callback function The callback function to register
---@return table self The BaseElement instance
function BaseElement:registerCallback(event, callback) end

---Ends profiling a method
---@param methodName string The name of the method to stop profiling
---@return BaseElement self The element instance
function BaseElement:endProfile(methodName) end

---Enables debugging for this element
---@param self BaseElement The element to debug
---@param level number The debug level
function BaseElement.debug(self, level) end

function BaseElement:computed() end

---Gets the value of a state
---@param self BaseElement The element to get state from
---@param name string The name of the state
---@return any value The current state value
function BaseElement:getState(self, name) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return table self The BaseElement instance
---@protected
function BaseElement:postInit() end

---Requests a render update for this element
---@return table self The BaseElement instance
function BaseElement:updateRender() end

---Gets the theme properties for this element
---@param self BaseElement The element to get theme for
---@return table styles The theme properties
function BaseElement:getTheme(self) end

---Sets the value of the Enabled property.
---@param self BaseElement self
---@param Enabled boolean Whether the element is enabled or not
function BaseElement:setEnabled(self, Enabled) end

---Observes a property and calls a callback when it changes
---@param property string The property to observe
---@param callback function The callback to call when the property changes
---@return table self The BaseElement instance
function BaseElement:onChange(property, callback) end

---Gets the value of the Name property.
---@param self BaseElement self
---@return string BaseElement The name of the element
function BaseElement:getName(self) end

---Sets the value of the EventCallbacks property.
---@param self BaseElement self
---@param EventCallbacks table The event callbacks for the element
function BaseElement:setEventCallbacks(self, EventCallbacks) end

---Gets the value of the Type property.
---@param self BaseElement self
---@return string BaseElement The type identifier of the element
function BaseElement:getType(self) end

---Enables or disables event listening for a specific event
---@param eventName string The name of the event to listen for
---@return table self The BaseElement instance
function BaseElement:listenEvent(eventName) end

---Gets the value of the Enabled property.
---@param self BaseElement self
---@return boolean BaseElement Whether the element is enabled or not
function BaseElement:getEnabled(self) end

---Sets the value of the Name property.
---@param self BaseElement self
---@param Name string The name of the element
function BaseElement:setName(self, Name) end

---Returns the base frame of the element
---@return BaseFrame BaseFrame The base frame of the element
function BaseElement:getBaseFrame() end

---Stops benchmarking for a method
---@param methodName string The name of the method to stop benchmarking
---@return BaseElement self The element instance
function BaseElement:stopBenchmark(methodName) end

---Registers a new event callback for the element (on class level)
---@param class table The class to register
---@param callbackName string The name of the callback to register
function BaseElement.registerEventCallback(class, callbackName) end

---Applies the current theme to this element
---@param self BaseElement The element to apply theme to
---@param applyToChildren boolean ? Whether to apply theme to child elements (default: true)
---@return BaseElement self The element instance
function BaseElement:applyTheme(self, applyToChildren) end

---Checks if the element is a specific type
---@param type string The type to check for
---@return boolean isType Whether the element is of the specified type
function BaseElement:isType(type) end

---Logs benchmark statistics for a method
---@param methodName string The name of the method to log
---@return BaseElement self The element instance
function BaseElement:logBenchmark(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:handleEvent(event) end

---Sets the value of a state
---@param self BaseElement The element to set state for
---@param name string The name of the state
---@param value any The new value for the state
---@return BaseElement self The element instance
function BaseElement:setState(self, name, value) end

---Gets benchmark statistics for a method
---@param methodName string The name of the method to get statistics for
---@return table ? stats The benchmark statistics or nil
function BaseElement:getBenchmarkStats(methodName) end

---Binds a property to a state
---@param self BaseElement The element to bind
---@param propertyName string The property to bind
---@param stateName string The state to bind to (optional, uses propertyName if not provided)
---@return BaseElement self The element instance
function BaseElement:bind(self, propertyName, stateName) end

---Removes a state change observer
---@param self BaseElement The element to remove observer from
---@param stateName string The state to remove observer from
---@param callback function The callback function to remove
---@return BaseElement self The element instance
function BaseElement:removeStateChange(self, stateName, callback) end

---Registers a callback for state changes
---@param self BaseElement The element to watch
---@param stateName string The state to watch
---@param callback function Called with (element, newValue, oldValue)
---@return BaseElement self The element instance
function BaseElement:onStateChange(self, stateName, callback) end

---Enables benchmarking for a method
---@param methodName string The name of the method to benchmark
---@return BaseElement self The element instance
function BaseElement:benchmark(methodName) end

---Registers a new event listener for the element (on class level)
---@param class table The class to register
---@param eventName string The name of the event to register
function BaseElement.defineEvent(class, eventName) end

---Dumps debug information for this element
---@param self BaseElement The element to dump debug info for
function BaseElement.dumpDebug(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:dispatchEvent(event) end

---Destroys the element and cleans up all references
function BaseElement:destroy() end

---Gets the value of the EventCallbacks property.
---@param self BaseElement self
---@return table BaseElement The event callbacks for the element
function BaseElement:getEventCallbacks(self) end

---Sets the value of the Type property.
---@param self BaseElement self
---@param Type string The type identifier of the element
function BaseElement:setType(self, Type) end

---@class Container : VisualElement
---@field eventListenerCount table The event listener count of the container
---@field childrenEventsSorted boolean Whether the children events are sorted
---@field children table The children of the container
---@field offsetY number Vertical content offset
---@field childrenEvents table The children events of the container
---@field childrenSorted boolean Whether the children are sorted
---@field focusedChild table The focused child of the container
---@field offsetX number Horizontal content offset
---@field visibleChildrenEvents table The visible children events of the container
---@field visibleChildren table The visible children of the container
local Container = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param width number The width of the text
---@param height number The height of the text
---@param text string The text to draw
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Container self The container instance
---@protected
function Container:multiBlit(x, y, width, height, text, fg, bg) end

---Sets the value of the OffsetX property.
---@param self Container self
---@param OffsetX number Horizontal content offset
function Container:setOffsetX(self, OffsetX) end

---Sets the value of the VisibleChildrenEvents property.
---@param self Container self
---@param VisibleChildrenEvents table The visible children events of the container
function Container:setVisibleChildrenEvents(self, VisibleChildrenEvents) end

---Registers the children events of the container
---@param child table The child to register events for
---@param eventName string The event name to register
---@return Container self The container instance
function Container:registerChildEvent(child, eventName) end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@return Container self The container instance
function Container:removeChildrenEvents(child) end

function Container:drawText() end

---Creates a new BigFont element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BigFont element A new BigFont element.
function Container:addBigFont(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Container:render() end

---Sets the value of the EventListenerCount property.
---@param self Container self
---@param EventListenerCount table The event listener count of the container
function Container:setEventListenerCount(self, EventListenerCount) end

---Gets the value of the OffsetX property.
---@param self Container self
---@return number 0 Horizontal content offset
function Container:getOffsetX(self) end

---Creates a new Flexbox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Flexbox element A new Flexbox element.
function Container:addFlexbox(self, props) end

---Removes a child from the container
---@param child table The child to remove
---@return Container self The container instance
function Container:removeChild(child) end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@param eventName string The event name to unregister
---@return Container self The container instance
function Container:unregisterChildEvent(child, eventName) end

---Creates a new Scrollbar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Scrollbar element A new Scrollbar element.
function Container:addScrollbar(self, props) end

---Clears the container
---@return Container self The container instance
function Container:clear() end

---Enables benchmarking for a container and all its children
---@param methodName string The method to benchmark
---@return Container self The container instance
function Container:benchmarkContainer(methodName) end

---Sets the value of the VisibleChildren property.
---@param self Container self
---@param VisibleChildren table The visible children of the container
function Container:setVisibleChildren(self, VisibleChildren) end

---Creates a new Program element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Program element A new Program element.
function Container:addProgram(self, props) end

---Gets the value of the ChildrenSorted property.
---@param self Container self
---@return boolean true Whether the children are sorted
function Container:getChildrenSorted(self) end

---Sets the value of the OffsetY property.
---@param self Container self
---@param OffsetY number Vertical content offset
function Container:setOffsetY(self, OffsetY) end

---Gets the value of the ChildrenEvents property.
---@param self Container self
---@return table {} The children events of the container
function Container:getChildrenEvents(self) end

---Creates a new Slider element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Slider element A new Slider element.
function Container:addSlider(self, props) end

---Creates a new LineChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return LineChart element A new LineChart element.
function Container:addLineChart(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg color The foreground color of the text
---@return Container self The container instance
---@protected
function Container:textFg(x, y, text, fg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_scroll(direction, x, y) end

---Returns whether a child is visible
---@param child table The child to check
---@return boolean boolean the child is visible
function Container:isChildVisible(child) end

---Creates a new Table element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Table element A new Table element.
function Container:addTable(self, props) end

---Creates a new Frame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Frame element A new Frame element.
function Container:addFrame(self, props) end

---Creates a new Button element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Button element A new Button element.
function Container:addButton(self, props) end

---Creates a new BaseElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseElement element A new BaseElement element.
function Container:addBaseElement(self, props) end

---Creates a new ProgressBar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ProgressBar element A new ProgressBar element.
function Container:addProgressBar(self, props) end

---Creates a new Container element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Container element A new Container element.
function Container:addContainer(self, props) end

---Stops benchmarking for a container and all its children
---@param methodName string The method to stop benchmarking
---@return Container self The container instance
function Container:stopContainerBenchmark(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_move(_, x, y) end

---Sets the value of the ChildrenEventsSorted property.
---@param self Container self
---@param ChildrenEventsSorted boolean Whether the children events are sorted
function Container:setChildrenEventsSorted(self, ChildrenEventsSorted) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean handled Whether the event was handled
---@protected
function Container:handleEvent(event) end

function Container:drawBg() end

---Sets the value of the FocusedChild property.
---@param self Container self
---@param FocusedChild table The focused child of the container
function Container:setFocusedChild(self, FocusedChild) end

---Calls a event on all children
---@param visibleOnly boolean Whether to only call the event on visible children
---@param event string The event to call
---@return boolean handled Whether the event was handled
---@return table ? child The child that handled the event
function Container:callChildrenEvent(visibleOnly, event) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@protected
function Container:mouse_release(button, x, y) end

---Gets the value of the OffsetY property.
---@param self Container self
---@return number 0 Vertical content offset
function Container:getOffsetY(self) end

---Creates a new Graph element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Graph element A new Graph element.
function Container:addGraph(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@return boolean handled Whether the event was handled
---@protected
function Container:key_up(key) end

---Creates a new Timer element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Timer element A new Timer element.
function Container:addTimer(self, props) end

---Creates a new Checkbox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Checkbox element A new Checkbox element.
function Container:addCheckbox(self, props) end

---Creates a new Menu element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Menu element A new Menu element.
function Container:addMenu(self, props) end

---Creates a new List element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return List element A new List element.
function Container:addList(self, props) end

---Creates a new Display element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Display element A new Display element.
function Container:addDisplay(self, props) end

---Sets the value of the Children property.
---@param self Container self
---@param Children table The children of the container
function Container:setChildren(self, Children) end

---Gets the value of the ChildrenEventsSorted property.
---@param self Container self
---@return boolean true Whether the children events are sorted
function Container:getChildrenEventsSorted(self) end

---Adds a child to the container
---@param child table The child to add
---@return Container self The container instance
function Container:addChild(child) end

---Creates a new VisualElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return VisualElement element A new VisualElement element.
function Container:addVisualElement(self, props) end

---Creates a new Input element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Input element A new Input element.
function Container:addInput(self, props) end

---Creates a new Dropdown element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Dropdown element A new Dropdown element.
function Container:addDropdown(self, props) end

---Removes a child from the container
---@param path string The path to the child to remove
---@return Container ? self The container instance
function Container:getChild(path) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param bg color The background color of the text
---@return Container self The container instance
---@protected
function Container:textBg(x, y, text, bg) end

---Gets the value of the VisibleChildren property.
---@param self Container self
---@return table {} The visible children of the container
function Container:getVisibleChildren(self) end

---Creates a new BaseFrame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseFrame element A new BaseFrame element.
function Container:addBaseFrame(self, props) end

---Creates a new Image element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Image element A new Image element.
function Container:addImage(self, props) end

---Sets the value of the ChildrenEvents property.
---@param self Container self
---@param ChildrenEvents table The children events of the container
function Container:setChildrenEvents(self, ChildrenEvents) end

function Container:drawFg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:key(key) end

---Creates a new BarChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BarChart element A new BarChart element.
function Container:addBarChart(self, props) end

---Registers the children events of the container
---@param child table The child to register events for
---@return Container self The container instance
function Container:registerChildrenEvents(child) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Container:init(props, basalt) end

---Sorts the children of the container
---@return Container self The container instance
function Container:sortChildren() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:char(char) end

---Gets the value of the FocusedChild property.
---@param self Container self
---@return table nil The focused child of the container
function Container:getFocusedChild(self) end

---Gets the value of the Children property.
---@param self Container self
---@return table {} The children of the container
function Container:getChildren(self) end

---Sorts the children events of the container
---@param eventName string The event name to sort
---@return Container self The container instance
function Container:sortChildrenEvents(eventName) end

---Creates a new Label element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Label element A new Label element.
function Container:addLabel(self, props) end

---Creates a new Switch element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Switch element A new Switch element.
function Container:addSwitch(self, props) end

---Creates a new Tree element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Tree element A new Tree element.
function Container:addTree(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Container self The container instance
---@protected
function Container:blit(x, y, text, fg, bg) end

---Gets the value of the EventListenerCount property.
---@param self Container self
---@return table {} The event listener count of the container
function Container:getEventListenerCount(self) end

---Gets the value of the VisibleChildrenEvents property.
---@param self Container self
---@return table {} The visible children events of the container
function Container:getVisibleChildrenEvents(self) end

---Enables debugging for this container and all its children
---@param self Container The container to debug
---@param level number The debug level
function Container.debugChildren(self, level) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_up(button, x, y) end

---Sets the value of the ChildrenSorted property.
---@param self Container self
---@param ChildrenSorted boolean Whether the children are sorted
function Container:setChildrenSorted(self, ChildrenSorted) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_click(button, x, y) end

---Logs benchmark statistics for a container and all its children
---@param methodName string The method to log
---@return Container self The container instance
function Container:logContainerBenchmarks(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_drag(button, x, y) end

---Creates a new TextBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return TextBox element A new TextBox element.
function Container:addTextBox(self, props) end

