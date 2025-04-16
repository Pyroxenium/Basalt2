---@meta

---@class Image : VisualElement
---@field currentFrame number Current animation frame
---@field offsetY number Vertical offset for viewing larger images
---@field offsetX number Horizontal offset for viewing larger images
---@field bimg table The bimg image data
---@field autoResize boolean Whether to automatically resize the image when content exceeds bounds
local Image = {}

---Gets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the background color pattern to get
---@return string bg The background color pattern
function Image:getBg(x, y, length) end

---Gets pixel information at position
---@param x number X position
---@param y number Y position
---@return number ? fg Foreground color
---@return number ? bg Background color
---@return string ? char Character at position
function Image:getPixelData(x, y) end

---Gets the value of the OffsetX property.
---@param self Image self
---@return number 0 Horizontal offset for viewing larger images
function Image:getOffsetX(self) end

---Sets the value of the OffsetX property.
---@param self Image self
---@param OffsetX number Horizontal offset for viewing larger images
function Image:setOffsetX(self, OffsetX) end

---Gets the specified frame
---@param frameIndex number The index of the frame to get
---@return table frame The frame data
function Image:getFrame(frameIndex) end

---Sets the value of the Bimg property.
---@param self Image self
---@param Bimg table The bimg image data
function Image:setBimg(self, Bimg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Image:render() end

---Gets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the text to get
---@return string text The text at the specified position
function Image:getText(x, y, length) end

---Gets the value of the OffsetY property.
---@param self Image self
---@return number 0 Vertical offset for viewing larger images
function Image:getOffsetY(self) end

---Sets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The foreground color pattern
---@return Image self The Image instance
function Image:setFg(x, y, pattern) end

---Gets the value of the AutoResize property.
---@param self Image self
---@return boolean false Whether to automatically resize the image when content exceeds bounds
function Image:getAutoResize(self) end

---Sets the metadata of the image
---@param key string The key of the metadata to set
---@param value string The value of the metadata to set
---@return Image self The Image instance
function Image:setMetadata(key, value) end

---Gets the metadata of the image
---@return table metadata The metadata of the image
function Image:getMetadata() end

---Updates the specified frame with the provided data
---@param frameIndex number The index of the frame to update
---@param frame table The new frame data
---@return Image self The Image instance
function Image:updateFrame(frameIndex, frame) end

---Sets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param text string The text to set
---@return Image self The Image instance
function Image:setText(x, y, text) end

---Adds a new frame to the image
---@return Image self The Image instance
function Image:addFrame() end

---Advances to the next frame in the animation
---@return Image self The Image instance
function Image:nextFrame() end

---Sets the pixel at the specified position
---@param x number The x position
---@param y number The y position
---@param char string The character to set
---@param fg string The foreground color pattern
---@param bg string The background color pattern
---@return Image self The Image instance
function Image:setPixel(x, y, char, fg, bg) end

---Gets the value of the CurrentFrame property.
---@param self Image self
---@return number 1 Current animation frame
function Image:getCurrentFrame(self) end

---Sets the value of the CurrentFrame property.
---@param self Image self
---@param CurrentFrame number Current animation frame
function Image:setCurrentFrame(self, CurrentFrame) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Image self The initialized instance
---@protected
function Image:init(props, basalt) end

---Sets the value of the OffsetY property.
---@param self Image self
---@param OffsetY number Vertical offset for viewing larger images
function Image:setOffsetY(self, OffsetY) end

---Resizes the image to the specified width and height
---@param width number The new width of the image
---@param height number The new height of the image
---@return Image self The Image instance
function Image:resizeImage(width, height) end

---Sets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The background color pattern
---@return Image self The Image instance
function Image:setBg(x, y, pattern) end

---Gets the value of the Bimg property.
---@param self Image self
---@return table {} The bimg image data
function Image:getBimg(self) end

---Sets the value of the AutoResize property.
---@param self Image self
---@param AutoResize boolean Whether to automatically resize the image when content exceeds bounds
function Image:setAutoResize(self, AutoResize) end

---Gets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the foreground color pattern to get
---@return string fg The foreground color pattern
function Image:getFg(x, y, length) end

---Gets the size of the image
---@return number width The width of the image
---@return number height The height of the image
function Image:getImageSize() end

---@class Button : VisualElement
---@field text string Button text
local Button = {}

---Gets the value of the Text property.
---@param self Button self
---@return string Button Button text
function Button:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Button:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Button:render() end

---Sets the value of the Text property.
---@param self Button self
---@param Text string Button text
function Button:setText(self, Text) end

---@class Container : VisualElement
---@field childrenEventsSorted boolean Whether the children events are sorted
---@field children table The children of the container
---@field visibleChildrenEvents table The visible children events of the container
---@field offsetX number Horizontal content offset
---@field visibleChildren table The visible children of the container
---@field offsetY number Vertical content offset
---@field childrenSorted boolean Whether the children are sorted
---@field childrenEvents table The children events of the container
---@field focusedChild table The focused child of the container
---@field eventListenerCount table The event listener count of the container
local Container = {}

---Registers the children events of the container
---@param child table The child to register events for
---@return Container self The container instance
function Container:registerChildrenEvents(child) end

---Gets the value of the VisibleChildren property.
---@param self Container self
---@return table {} The visible children of the container
function Container:getVisibleChildren(self) end

---Gets the value of the ChildrenEventsSorted property.
---@param self Container self
---@return boolean true Whether the children events are sorted
function Container:getChildrenEventsSorted(self) end

---Sets the value of the ChildrenEventsSorted property.
---@param self Container self
---@param ChildrenEventsSorted boolean Whether the children events are sorted
function Container:setChildrenEventsSorted(self, ChildrenEventsSorted) end

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

---Creates a new Slider element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Slider element A new Slider element.
function Container:addSlider(self, props) end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@return Container self The container instance
function Container:removeChildrenEvents(child) end

function Container:drawText() end

---Sets the value of the OffsetY property.
---@param self Container self
---@param OffsetY number Vertical content offset
function Container:setOffsetY(self, OffsetY) end

---Creates a new Menu element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Menu element A new Menu element.
function Container:addMenu(self, props) end

---Sets the value of the EventListenerCount property.
---@param self Container self
---@param EventListenerCount table The event listener count of the container
function Container:setEventListenerCount(self, EventListenerCount) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:key(key) end

---Gets the value of the VisibleChildrenEvents property.
---@param self Container self
---@return table {} The visible children events of the container
function Container:getVisibleChildrenEvents(self) end

---Creates a new Display element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Display element A new Display element.
function Container:addDisplay(self, props) end

---Creates a new BigFont element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BigFont element A new BigFont element.
function Container:addBigFont(self, props) end

---Creates a new List element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return List element A new List element.
function Container:addList(self, props) end

---Creates a new Image element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Image element A new Image element.
function Container:addImage(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_up(button, x, y) end

---Creates a new Frame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Frame element A new Frame element.
function Container:addFrame(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean handled Whether the event was handled
---@protected
function Container:handleEvent(event) end

---Creates a new Input element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Input element A new Input element.
function Container:addInput(self, props) end

---Sorts the children events of the container
---@param eventName string The event name to sort
---@return Container self The container instance
function Container:sortChildrenEvents(eventName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@protected
function Container:mouse_release(button, x, y) end

---Sets the value of the VisibleChildrenEvents property.
---@param self Container self
---@param VisibleChildrenEvents table The visible children events of the container
function Container:setVisibleChildrenEvents(self, VisibleChildrenEvents) end

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

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@param eventName string The event name to unregister
---@return Container self The container instance
function Container:unregisterChildEvent(child, eventName) end

---Creates a new Flexbox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Flexbox element A new Flexbox element.
function Container:addFlexbox(self, props) end

---Creates a new BarChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BarChart element A new BarChart element.
function Container:addBarChart(self, props) end

---Gets the value of the EventListenerCount property.
---@param self Container self
---@return table {} The event listener count of the container
function Container:getEventListenerCount(self) end

---Sets the value of the ChildrenSorted property.
---@param self Container self
---@param ChildrenSorted boolean Whether the children are sorted
function Container:setChildrenSorted(self, ChildrenSorted) end

---Sets the value of the VisibleChildren property.
---@param self Container self
---@param VisibleChildren table The visible children of the container
function Container:setVisibleChildren(self, VisibleChildren) end

---Creates a new Dropdown element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Dropdown element A new Dropdown element.
function Container:addDropdown(self, props) end

---Creates a new Program element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Program element A new Program element.
function Container:addProgram(self, props) end

---Sets the value of the ChildrenEvents property.
---@param self Container self
---@param ChildrenEvents table The children events of the container
function Container:setChildrenEvents(self, ChildrenEvents) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_drag(button, x, y) end

---Creates a new Checkbox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Checkbox element A new Checkbox element.
function Container:addCheckbox(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_move(_, x, y) end

---Gets the value of the ChildrenSorted property.
---@param self Container self
---@return boolean true Whether the children are sorted
function Container:getChildrenSorted(self) end

---Creates a new TextBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return TextBox element A new TextBox element.
function Container:addTextBox(self, props) end

---Gets the value of the ChildrenEvents property.
---@param self Container self
---@return table {} The children events of the container
function Container:getChildrenEvents(self) end

---Creates a new VisualElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return VisualElement element A new VisualElement element.
function Container:addVisualElement(self, props) end

---Creates a new BaseFrame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseFrame element A new BaseFrame element.
function Container:addBaseFrame(self, props) end

---Enables debugging for this container and all its children
---@param self Container The container to debug
---@param level number The debug level
function Container.debugChildren(self, level) end

---Registers the children events of the container
---@param child table The child to register events for
---@param eventName string The event name to register
---@return Container self The container instance
function Container:registerChildEvent(child, eventName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg color The foreground color of the text
---@return Container self The container instance
---@protected
function Container:textFg(x, y, text, fg) end

---Removes a child from the container
---@param path string The path to the child to remove
---@return Container ? self The container instance
function Container:getChild(path) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:char(char) end

---Gets the value of the FocusedChild property.
---@param self Container self
---@return table nil The focused child of the container
function Container:getFocusedChild(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Container:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param bg color The background color of the text
---@return Container self The container instance
---@protected
function Container:textBg(x, y, text, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_scroll(direction, x, y) end

---Adds a child to the container
---@param child table The child to add
---@return Container self The container instance
function Container:addChild(child) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Container self The container instance
---@protected
function Container:blit(x, y, text, fg, bg) end

---Creates a new Table element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Table element A new Table element.
function Container:addTable(self, props) end

---Sets the value of the FocusedChild property.
---@param self Container self
---@param FocusedChild table The focused child of the container
function Container:setFocusedChild(self, FocusedChild) end

---Logs benchmark statistics for a container and all its children
---@param methodName string The method to log
---@return Container self The container instance
function Container:logContainerBenchmarks(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@return boolean handled Whether the event was handled
---@protected
function Container:key_up(key) end

---Gets the value of the OffsetX property.
---@param self Container self
---@return number 0 Horizontal content offset
function Container:getOffsetX(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Container:init(props, basalt) end

function Container:drawBg() end

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

---Creates a new BaseElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseElement element A new BaseElement element.
function Container:addBaseElement(self, props) end

---Clears the container
---@return Container self The container instance
function Container:clear() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_click(button, x, y) end

---Creates a new Tree element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Tree element A new Tree element.
function Container:addTree(self, props) end

---Sets the value of the OffsetX property.
---@param self Container self
---@param OffsetX number Horizontal content offset
function Container:setOffsetX(self, OffsetX) end

---Creates a new LineChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return LineChart element A new LineChart element.
function Container:addLineChart(self, props) end

---Creates a new Button element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Button element A new Button element.
function Container:addButton(self, props) end

---Sets the value of the Children property.
---@param self Container self
---@param Children table The children of the container
function Container:setChildren(self, Children) end

---Sorts the children of the container
---@return Container self The container instance
function Container:sortChildren() end

---Gets the value of the Children property.
---@param self Container self
---@return table {} The children of the container
function Container:getChildren(self) end

---Removes a child from the container
---@param child table The child to remove
---@return Container self The container instance
function Container:removeChild(child) end

---Stops benchmarking for a container and all its children
---@param methodName string The method to stop benchmarking
---@return Container self The container instance
function Container:stopContainerBenchmark(methodName) end

---Enables benchmarking for a container and all its children
---@param methodName string The method to benchmark
---@return Container self The container instance
function Container:benchmarkContainer(methodName) end

---Calls a event on all children
---@param visibleOnly boolean Whether to only call the event on visible children
---@param event string The event to call
---@return boolean handled Whether the event was handled
---@return table ? child The child that handled the event
function Container:callChildrenEvent(visibleOnly, event) end

---Creates a new Scrollbar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Scrollbar element A new Scrollbar element.
function Container:addScrollbar(self, props) end

---Gets the value of the OffsetY property.
---@param self Container self
---@return number 0 Vertical content offset
function Container:getOffsetY(self) end

---Returns whether a child is visible
---@param child table The child to check
---@return boolean boolean the child is visible
function Container:isChildVisible(child) end

---Creates a new Graph element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Graph element A new Graph element.
function Container:addGraph(self, props) end

function Container:drawFg() end

---@class Benchmark
local Benchmark = {}

---Starts a custom benchmark
---@param name string The name of the benchmark
function API.start(name) end

---Gets statistics for a benchmark
---@param name string The name of the benchmark
---@return table ? stats The benchmark statistics or nil
function API.getStats(name) end

---Clears a specific benchmark
---@param name string The name of the benchmark to clear
function API.clear(name) end

---Stops a custom benchmark
---@param name string The name of the benchmark to stop
function API.stop(name) end

---Clears all custom benchmarks
function API.clearAll() end

---@class Switch : VisualElement
---@field checked boolean switch is checked
local Switch = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Switch:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Switch:init(props, basalt) end

---Gets the value of the Checked property.
---@param self Switch self
---@return boolean Whether switch is checked
function Switch:getChecked(self) end

---Sets the value of the Checked property.
---@param self Switch self
---@param Checked boolean switch is checked
function Switch:setChecked(self, Checked) end

---@class Slider : VisualElement
---@field sliderColor color Color of the slider handle
---@field max number Maximum value for value conversion (maps slider position to this range)
---@field step number Current position of the slider handle (1 to width/height)
---@field barColor color Color of the slider track
---@field horizontal boolean Whether the slider is horizontal (false for vertical)
local Slider = {}

---Gets the value of the SliderColor property.
---@param self Slider self
---@return color blue Color of the slider handle
function Slider:getSliderColor(self) end

---Sets the value of the Step property.
---@param self Slider self
---@param Step number Current position of the slider handle (1 to width/height)
function Slider:setStep(self, Step) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Slider:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_scroll(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Slider self The initialized instance
---@protected
function Slider:init(props, basalt) end

---Registers a function to handle the onChange event.
---@param value number
---@param self Slider self
---@param func function The function to be called when the event fires
function Slider:onOnChange(self, func) end

---Sets the value of the SliderColor property.
---@param self Slider self
---@param SliderColor color Color of the slider handle
function Slider:setSliderColor(self, SliderColor) end

---Sets the value of the Max property.
---@param self Slider self
---@param Max number Maximum value for value conversion (maps slider position to this range)
function Slider:setMax(self, Max) end

---Gets the value of the Step property.
---@param self Slider self
---@return number 1 Current position of the slider handle (1 to width/height)
function Slider:getStep(self) end

---Gets the value of the Max property.
---@param self Slider self
---@return number 100 Maximum value for value conversion (maps slider position to this range)
function Slider:getMax(self) end

---Sets the value of the Horizontal property.
---@param self Slider self
---@param Horizontal boolean Whether the slider is horizontal (false for vertical)
function Slider:setHorizontal(self, Horizontal) end

---Gets the current value of the slider
---@return number value The current value (0 to max)
function Slider:getValue() end

---Gets the value of the Horizontal property.
---@param self Slider self
---@return boolean true Whether the slider is horizontal (false for vertical)
function Slider:getHorizontal(self) end

---Sets the value of the BarColor property.
---@param self Slider self
---@param BarColor color Color of the slider track
function Slider:setBarColor(self, BarColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_click(button, x, y) end

---Gets the value of the BarColor property.
---@param self Slider self
---@return color gray Color of the slider track
function Slider:getBarColor(self) end

---@class List : VisualElement
---@field items table List of items to display. Items can be tables with properties including selected state
---@field offset number Current scroll offset for viewing long lists
---@field selectedBackground color Background color for selected items
---@field selectable boolean Whether items in the list can be selected
---@field multiSelection boolean Whether multiple items can be selected at once
---@field selectedForeground color Text color for selected items
local List = {}

---Gets the value of the Offset property.
---@param self List self
---@return number 0 Current scroll offset for viewing long lists
function List:getOffset(self) end

---Gets the value of the Selectable property.
---@param self List self
---@return boolean true Whether items in the list can be selected
function List:getSelectable(self) end

---Sets the value of the MultiSelection property.
---@param self List self
---@param MultiSelection boolean Whether multiple items can be selected at once
function List:setMultiSelection(self, MultiSelection) end

---Gets the value of the Items property.
---@param self List self
---@return table {} List of items to display. Items can be tables with properties including selected state
function List:getItems(self) end

---Registers a callback for the select event
---@param callback function The callback function to register
---@return List self The List instance
function List:onSelect(callback) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return List self The initialized instance
---@protected
function List:init(props, basalt) end

---Clears all items from the list
---@return List self The List instance
function List:clear() end

---Sets the value of the Offset property.
---@param self List self
---@param Offset number Current scroll offset for viewing long lists
function List:setOffset(self, Offset) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll (1 for down, -1 for up)
---@param x number The x-coordinate of the scroll
---@param y number The y-coordinate of the scroll
---@return boolean Whether the event was handled
---@protected
function List:mouse_scroll(direction, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x-coordinate of the click
---@param y number The y-coordinate of the click
---@return boolean Whether the event was handled
---@protected
function List:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function List:render() end

---Scrolls the list to the top
---@return List self The List instance
function List:scrollToTop() end

---Scrolls the list to the bottom
---@return List self The List instance
function List:scrollToBottom() end

---Gets the currently selected items
---@return table selected List of selected items
function List:getSelectedItems() end

---Gets first selected item
---@return table ? selected The first item
function List:getSelectedItem() end

---Sets the value of the Selectable property.
---@param self List self
---@param Selectable boolean Whether items in the list can be selected
function List:setSelectable(self, Selectable) end

---Sets the value of the SelectedForeground property.
---@param self List self
---@param SelectedForeground color Text color for selected items
function List:setSelectedForeground(self, SelectedForeground) end

---Removes an item from the list
---@param index number The index of the item to remove
---@return List self The List instance
function List:removeItem(index) end

---Gets the value of the SelectedBackground property.
---@param self List self
---@return color blue Background color for selected items
function List:getSelectedBackground(self) end

---Sets the value of the Items property.
---@param self List self
---@param Items table List of items to display. Items can be tables with properties including selected state
function List:setItems(self, Items) end

---Sets the value of the SelectedBackground property.
---@param self List self
---@param SelectedBackground color Background color for selected items
function List:setSelectedBackground(self, SelectedBackground) end

---Gets the value of the SelectedForeground property.
---@param self List self
---@return color white Text color for selected items
function List:getSelectedForeground(self) end

---Gets the value of the MultiSelection property.
---@param self List self
---@return boolean false Whether multiple items can be selected at once
function List:getMultiSelection(self) end

---Adds an item to the list
---@param text string |table The item to add (string or item table)
---@return List self The List instance
function List:addItem(text) end

---Registers a function to handle the onSelect event.
---@param index number
---@param item table
---@param self List self
---@param func function The function to be called when the event fires
function List:onOnSelect(self, func) end

---@class Log
local Log = {}

---Sends an info message to the logger.
function Log.info() end

---Sends a debug message to the logger.
function Log.debug() end

---Sets if the logger should log to a file.
function Log.setLogToFile() end

---Sends an error message to the logger.
function Log.error() end

---Sets if the logger should log
function Log.setEnabled() end

---Sends a warning message to the logger.
function Log.warn() end

---@class BigFontText
local BigFontText = {}

---@class Render
local Render = {}

---Sets the size of the render
---@param width number The width of the render
---@param height number The height of the render
---@return Render 
function Render:setSize(width, height) end

---Clears an area of the screen
---@param x number The x position of the area
---@param y number The y position of the area
---@param width number The width of the area
---@param height number The height of the area
---@param bg colors The background color to clear the area with
---@return Render 
function Render:clearArea(x, y, width, height, bg) end

---Checks if two rectangles overlap
---@param r1 table The first rectangle
---@param r2 table The second rectangle
---@return boolean 
function Render:rectOverlaps(r1, r2) end

---Clears the screen
---@param bg colors The background color to clear the screen with
---@return Render 
function Render:clear(bg) end

---Blits a foreground color to the screen
---@param x number The x position
---@param y number The y position
---@param fg string The foreground color to blit
---@return Render 
function Render:fg(x, y, fg) end

---Blits text to the screen
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@return Render 
function Render:text(x, y, text) end

---Adds a dirty rectangle to the buffer
---@param x number The x position of the rectangle
---@param y number The y position of the rectangle
---@param width number The width of the rectangle
---@param height number The height of the rectangle
---@return Render 
function Render:addDirtyRect(x, y, width, height) end

---Blits text to the screen with a foreground color
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param fg colors The foreground color of the text
---@return Render 
function Render:textFg(x, y, text, fg) end

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

---Renders the buffer to the screen
---@return Render 
function Render:render() end

---Creates a new Render object
---@param terminal table The terminal object to render to
---@return Render 
function Render.new(terminal) end

---Merges two rectangles
---@param target table The target rectangle
---@param source table The source rectangle
---@return Render 
function Render:mergeRects(target, source) end

---Sets the cursor position
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@return Render 
function Render:setCursor(x, y, blink) end

---Gets the size of the render
---@return number , number
function Render:getSize() end

---Blits a background color to the screen
---@param x number The x position
---@param y number The y position
---@param bg string The background color to blit
---@return Render 
function Render:bg(x, y, bg) end

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

---@class Scrollbar : VisualElement
---@field orientation string Orientation of the scrollbar ("vertical" or "horizontal")
---@field attachedElement table nil The element this scrollbar is attached to
---@field handleSize number Size of the scrollbar handle in characters
---@field step number Step size for scroll operations
---@field attachedProperty string nil The property being controlled
---@field dragMultiplier number How fast the scrollbar moves when dragging
---@field value number Current scroll value
---@field symbol string " Symbol used for the scrollbar handle
---@field backgroundSymbol string Symbol used for the scrollbar background
---@field min number Minimum scroll value
---@field max number Maximum scroll value
---@field symbolBackgroundColor color Background color of the scrollbar handle
---@field minValue number 0 Minimum value or function that returns it
---@field maxValue number 100 Maximum value or function that returns it
local Scrollbar = {}

---Attaches the scrollbar to an element's property
---@param element BaseElement The element to attach to
---@param config table Configuration {property = "propertyName", min = number|function, max = number|function}
---@return Scrollbar self The scrollbar instance
function Scrollbar:attach(element, config) end

---Gets the value of the Max property.
---@param self Scrollbar self
---@return number 100 Maximum scroll value
function Scrollbar:getMax(self) end

---Sets the value of the Value property.
---@param self Scrollbar self
---@param Value number Current scroll value
function Scrollbar:setValue(self, Value) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Scrollbar self The initialized instance
---@protected
function Scrollbar:init(props, basalt) end

---Gets the value of the Min property.
---@param self Scrollbar self
---@return number 0 Minimum scroll value
function Scrollbar:getMin(self) end

---Gets the value of the HandleSize property.
---@param self Scrollbar self
---@return number 2 Size of the scrollbar handle in characters
function Scrollbar:getHandleSize(self) end

---Gets the value of the Orientation property.
---@param self Scrollbar self
---@return string vertical Orientation of the scrollbar ("vertical" or "horizontal")
function Scrollbar:getOrientation(self) end

---Gets the value of the MinValue property.
---@param self Scrollbar self
---@return number |function 0 Minimum value or function that returns it
function Scrollbar:getMinValue(self) end

---Sets the value of the MaxValue property.
---@param self Scrollbar self
---@param MaxValue number 100 Maximum value or function that returns it
function Scrollbar:setMaxValue(self, MaxValue) end

---Gets the value of the BackgroundSymbol property.
---@param self Scrollbar self
---@return string "\127" Symbol used for the scrollbar background
function Scrollbar:getBackgroundSymbol(self) end

---Updates the attached element's property based on the scrollbar value
---@return Scrollbar self The scrollbar instance
function Scrollbar:updateAttachedElement() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean Whether the event was handled
---@protected
function Scrollbar:mouse_drag(button, x, y) end

---Sets the value of the HandleSize property.
---@param self Scrollbar self
---@param HandleSize number Size of the scrollbar handle in characters
function Scrollbar:setHandleSize(self, HandleSize) end

---Gets the value of the Symbol property.
---@param self Scrollbar self
---@return string " " Symbol used for the scrollbar handle
function Scrollbar:getSymbol(self) end

---Sets the value of the Orientation property.
---@param self Scrollbar self
---@param Orientation string Orientation of the scrollbar ("vertical" or "horizontal")
function Scrollbar:setOrientation(self, Orientation) end

---Gets the value of the DragMultiplier property.
---@param self Scrollbar self
---@return number 1 How fast the scrollbar moves when dragging
function Scrollbar:getDragMultiplier(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function Scrollbar:mouse_click(button, x, y) end

---Sets the value of the AttachedElement property.
---@param self Scrollbar self
---@param AttachedElement table nil The element this scrollbar is attached to
function Scrollbar:setAttachedElement(self, AttachedElement) end

---Gets the value of the AttachedProperty property.
---@param self Scrollbar self
---@return string ? nil The property being controlled
function Scrollbar:getAttachedProperty(self) end

---Sets the value of the BackgroundSymbol property.
---@param self Scrollbar self
---@param BackgroundSymbol string Symbol used for the scrollbar background
function Scrollbar:setBackgroundSymbol(self, BackgroundSymbol) end

---Gets the value of the Value property.
---@param self Scrollbar self
---@return number 0 Current scroll value
function Scrollbar:getValue(self) end

---Sets the value of the MinValue property.
---@param self Scrollbar self
---@param MinValue number 0 Minimum value or function that returns it
function Scrollbar:setMinValue(self, MinValue) end

---Sets the value of the DragMultiplier property.
---@param self Scrollbar self
---@param DragMultiplier number How fast the scrollbar moves when dragging
function Scrollbar:setDragMultiplier(self, DragMultiplier) end

---Sets the value of the AttachedProperty property.
---@param self Scrollbar self
---@param AttachedProperty string nil The property being controlled
function Scrollbar:setAttachedProperty(self, AttachedProperty) end

---Sets the value of the Step property.
---@param self Scrollbar self
---@param Step number Step size for scroll operations
function Scrollbar:setStep(self, Step) end

---Gets the value of the SymbolBackgroundColor property.
---@param self Scrollbar self
---@return color black Background color of the scrollbar handle
function Scrollbar:getSymbolBackgroundColor(self) end

---Sets the value of the Max property.
---@param self Scrollbar self
---@param Max number Maximum scroll value
function Scrollbar:setMax(self, Max) end

---Sets the value of the Symbol property.
---@param self Scrollbar self
---@param Symbol string " Symbol used for the scrollbar handle
function Scrollbar:setSymbol(self, Symbol) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean Whether the event was handled
---@protected
function Scrollbar:mouse_scroll(direction, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Scrollbar:render() end

---Gets the value of the MaxValue property.
---@param self Scrollbar self
---@return number |function 100 Maximum value or function that returns it
function Scrollbar:getMaxValue(self) end

---Sets the value of the Min property.
---@param self Scrollbar self
---@param Min number Minimum scroll value
function Scrollbar:setMin(self, Min) end

---Gets the value of the AttachedElement property.
---@param self Scrollbar self
---@return table ? nil The element this scrollbar is attached to
function Scrollbar:getAttachedElement(self) end

---Gets the value of the Step property.
---@param self Scrollbar self
---@return number 1 Step size for scroll operations
function Scrollbar:getStep(self) end

---Sets the value of the SymbolBackgroundColor property.
---@param self Scrollbar self
---@param SymbolBackgroundColor color Background color of the scrollbar handle
function Scrollbar:setSymbolBackgroundColor(self, SymbolBackgroundColor) end

---@class Menu : List
---@field separatorColor color The color used for separator items in the menu
local Menu = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Menu:render() end

---Sets the menu items
---@param items table [] List of items with {text, separator, callback, foreground, background} properties
---@return Menu self The Menu instance
function Menu:setItems(items) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function Menu:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Menu self The initialized instance
---@protected
function Menu:init(props, basalt) end

---Gets the value of the SeparatorColor property.
---@param self Menu self
---@return color gray The color used for separator items in the menu
function Menu:getSeparatorColor(self) end

---Sets the value of the SeparatorColor property.
---@param self Menu self
---@param SeparatorColor color The color used for separator items in the menu
function Menu:setSeparatorColor(self, SeparatorColor) end

---@class Input : VisualElement
---@field placeholder string Text to display when input is empty
---@field replaceChar string Character to replace the input with (for password fields)
---@field focusedForeground color Foreground color when input is focused
---@field cursorColor number Color of the cursor
---@field text string The current text content of the input
---@field pattern string nil Regular expression pattern for input validation
---@field maxLength number nil Maximum length of input text (optional)
---@field viewOffset number The horizontal scroll offset for viewing long text
---@field placeholderColor color Color of the placeholder text
---@field cursorPos number The current cursor position in the text
---@field focusedBackground color Background color when input is focused
local Input = {}

---Sets the value of the ReplaceChar property.
---@param self Input self
---@param ReplaceChar string Character to replace the input with (for password fields)
function Input:setReplaceChar(self, ReplaceChar) end

---Updates the input's viewport
---@return Input self The updated instance
function Input:updateViewport() end

---Sets the value of the Placeholder property.
---@param self Input self
---@param Placeholder string Text to display when input is empty
function Input:setPlaceholder(self, Placeholder) end

---Gets the value of the MaxLength property.
---@param self Input self
---@return number ? nil Maximum length of input text (optional)
function Input:getMaxLength(self) end

---Gets the value of the Text property.
---@param self Input self
---@return string - The current text content of the input
function Input:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:blur() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:focus() end

---Sets the value of the FocusedForeground property.
---@param self Input self
---@param FocusedForeground color Foreground color when input is focused
function Input:setFocusedForeground(self, FocusedForeground) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Input:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Input:key(key) end

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

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function Input:char(char) end

---Gets the value of the Pattern property.
---@param self Input self
---@return string ? nil Regular expression pattern for input validation
function Input:getPattern(self) end

---Sets the value of the MaxLength property.
---@param self Input self
---@param MaxLength number nil Maximum length of input text (optional)
function Input:setMaxLength(self, MaxLength) end

---Gets the value of the Placeholder property.
---@param self Input self
---@return string ... Text to display when input is empty
function Input:getPlaceholder(self) end

---Gets the value of the ReplaceChar property.
---@param self Input self
---@return string nil Character to replace the input with (for password fields)
function Input:getReplaceChar(self) end

---Sets the value of the CursorColor property.
---@param self Input self
---@param CursorColor number Color of the cursor
function Input:setCursorColor(self, CursorColor) end

---Gets the value of the CursorColor property.
---@param self Input self
---@return number nil Color of the cursor
function Input:getCursorColor(self) end

---Gets the value of the CursorPos property.
---@param self Input self
---@return number 1 The current cursor position in the text
function Input:getCursorPos(self) end

---Sets the value of the PlaceholderColor property.
---@param self Input self
---@param PlaceholderColor color Color of the placeholder text
function Input:setPlaceholderColor(self, PlaceholderColor) end

---Sets the value of the FocusedBackground property.
---@param self Input self
---@param FocusedBackground color Background color when input is focused
function Input:setFocusedBackground(self, FocusedBackground) end

---Sets the value of the CursorPos property.
---@param self Input self
---@param CursorPos number The current cursor position in the text
function Input:setCursorPos(self, CursorPos) end

---Sets the value of the ViewOffset property.
---@param self Input self
---@param ViewOffset number The horizontal scroll offset for viewing long text
function Input:setViewOffset(self, ViewOffset) end

---Gets the value of the FocusedForeground property.
---@param self Input self
---@return color white Foreground color when input is focused
function Input:getFocusedForeground(self) end

---Sets the cursor position and color
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
function Input:setCursor(x, y, blink, color) end

---Sets the value of the Pattern property.
---@param self Input self
---@param Pattern string nil Regular expression pattern for input validation
function Input:setPattern(self, Pattern) end

---Gets the value of the FocusedBackground property.
---@param self Input self
---@return color blue Background color when input is focused
function Input:getFocusedBackground(self) end

---Gets the value of the ViewOffset property.
---@param self Input self
---@return number 0 The horizontal scroll offset for viewing long text
function Input:getViewOffset(self) end

---Sets the value of the Text property.
---@param self Input self
---@param Text string The current text content of the input
function Input:setText(self, Text) end

---@class Flexbox : Container
---@field flexSpacing number The spacing between flex items
---@field flexUpdateLayout boolean Whether to update the layout of the flexbox
---@field flexDirection string The direction of the flexbox layout "row" or "column"
---@field flexWrap boolean Whether to wrap flex items onto multiple lines
---@field flexJustifyContent string The alignment of flex items along the main axis
local Flexbox = {}

---Sets the value of the FlexSpacing property.
---@param self Flexbox self
---@param FlexSpacing number The spacing between flex items
function Flexbox:setFlexSpacing(self, FlexSpacing) end

---Gets the value of the FlexWrap property.
---@param self Flexbox self
---@return boolean false Whether to wrap flex items onto multiple lines
function Flexbox:getFlexWrap(self) end

---Adds a child element to the flexbox
---@param element Element The child element to add
---@return Flexbox self The flexbox instance
function Flexbox:addChild(element) end

---Sets the value of the FlexWrap property.
---@param self Flexbox self
---@param FlexWrap boolean Whether to wrap flex items onto multiple lines
function Flexbox:setFlexWrap(self, FlexWrap) end

---Gets the value of the FlexDirection property.
---@param self Flexbox self
---@return string "row" The direction of the flexbox layout "row" or "column"
function Flexbox:getFlexDirection(self) end

---Gets the value of the FlexJustifyContent property.
---@param self Flexbox self
---@return string "flex-start" The alignment of flex items along the main axis
function Flexbox:getFlexJustifyContent(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Flexbox:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Flexbox self The initialized instance
---@protected
function Flexbox:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param element Element The child element to remove
---@return Flexbox self The flexbox instance
---@protected
function Flexbox:removeChild(element) end

---Sets the value of the FlexUpdateLayout property.
---@param self Flexbox self
---@param FlexUpdateLayout boolean Whether to update the layout of the flexbox
function Flexbox:setFlexUpdateLayout(self, FlexUpdateLayout) end

---Sets the value of the FlexDirection property.
---@param self Flexbox self
---@param FlexDirection string The direction of the flexbox layout "row" or "column"
function Flexbox:setFlexDirection(self, FlexDirection) end

---Gets the value of the FlexUpdateLayout property.
---@param self Flexbox self
---@return boolean false Whether to update the layout of the flexbox
function Flexbox:getFlexUpdateLayout(self) end

---Sets the value of the FlexJustifyContent property.
---@param self Flexbox self
---@param FlexJustifyContent string The alignment of flex items along the main axis
function Flexbox:setFlexJustifyContent(self, FlexJustifyContent) end

---Adds a new line break to the flexbox
---@param self Flexbox The element itself
---@return Flexbox 
function Flexbox:addLineBreak(self) end

---Gets the value of the FlexSpacing property.
---@param self Flexbox self
---@return number 1 The spacing between flex items
function Flexbox:getFlexSpacing(self) end

---@class BigFont : VisualElement
---@field fontSize number The font size of the BigFont
---@field text string BigFont text
local BigFont = {}

---Sets the value of the Text property.
---@param self BigFont self
---@param Text string BigFont text
function BigFont:setText(self, Text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BigFont:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function BigFont:init(props, basalt) end

---Sets the value of the FontSize property.
---@param self BigFont self
---@param FontSize number The font size of the BigFont
function BigFont:setFontSize(self, FontSize) end

---Gets the value of the Text property.
---@param self BigFont self
---@return string BigFont BigFont text
function BigFont:getText(self) end

---Gets the value of the FontSize property.
---@param self BigFont self
---@return number 1 The font size of the BigFont
function BigFont:getFontSize(self) end

---@class TextBox : VisualElement
---@field cursorColor number Color of the cursor
---@field syntaxPatterns table Syntax highlighting patterns
---@field scrollX number Horizontal scroll offset
---@field cursorY number Cursor Y position (line number)
---@field editable boolean Whether text can be edited
---@field cursorX number Cursor X position
---@field scrollY number Vertical scroll offset
---@field lines table Array of text lines
local TextBox = {}

---Gets the value of the Lines property.
---@param self TextBox self
---@return table {} Array of text lines
function TextBox:getLines(self) end

---Gets the value of the ScrollY property.
---@param self TextBox self
---@return number 0 Vertical scroll offset
function TextBox:getScrollY(self) end

---Sets the value of the Editable property.
---@param self TextBox self
---@param Editable boolean Whether text can be edited
function TextBox:setEditable(self, Editable) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:char(char) end

---Sets the value of the CursorColor property.
---@param self TextBox self
---@param CursorColor number Color of the cursor
function TextBox:setCursorColor(self, CursorColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TextBox:render() end

---Sets the value of the Lines property.
---@param self TextBox self
---@param Lines table Array of text lines
function TextBox:setLines(self, Lines) end

---Gets the text of the TextBox
---@return string text The text of the TextBox
function TextBox:getText() end

---Sets the value of the ScrollY property.
---@param self TextBox self
---@param ScrollY number Vertical scroll offset
function TextBox:setScrollY(self, ScrollY) end

---Sets the value of the SyntaxPatterns property.
---@param self TextBox self
---@param SyntaxPatterns table Syntax highlighting patterns
function TextBox:setSyntaxPatterns(self, SyntaxPatterns) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return TextBox self The initialized instance
---@protected
function TextBox:init(props, basalt) end

---Gets the value of the CursorY property.
---@param self TextBox self
---@return number 1 Cursor Y position (line number)
function TextBox:getCursorY(self) end

---Gets the value of the CursorX property.
---@param self TextBox self
---@return number 1 Cursor X position
function TextBox:getCursorX(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_scroll(direction, x, y) end

---Sets the value of the ScrollX property.
---@param self TextBox self
---@param ScrollX number Horizontal scroll offset
function TextBox:setScrollX(self, ScrollX) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:key(key) end

---Adds a new syntax highlighting pattern
---@param pattern string The regex pattern to match
---@param color colors The color to apply
---@return TextBox self The TextBox instance
function TextBox:addSyntaxPattern(pattern, color) end

---Gets the value of the CursorColor property.
---@param self TextBox self
---@return number nil Color of the cursor
function TextBox:getCursorColor(self) end

---Updates the viewport to keep the cursor in view
---@return TextBox self The TextBox instance
function TextBox:updateViewport() end

---Sets the value of the CursorX property.
---@param self TextBox self
---@param CursorX number Cursor X position
function TextBox:setCursorX(self, CursorX) end

---Gets the value of the Editable property.
---@param self TextBox self
---@return boolean true Whether text can be edited
function TextBox:getEditable(self) end

---Gets the value of the SyntaxPatterns property.
---@param self TextBox self
---@return table {} Syntax highlighting patterns
function TextBox:getSyntaxPatterns(self) end

---Gets the value of the ScrollX property.
---@param self TextBox self
---@return number 0 Horizontal scroll offset
function TextBox:getScrollX(self) end

---Sets the value of the CursorY property.
---@param self TextBox self
---@param CursorY number Cursor Y position (line number)
function TextBox:setCursorY(self, CursorY) end

---Sets the text of the TextBox
---@param text string The text to set
---@return TextBox self The TextBox instance
function TextBox:setText(text) end

---@class LineChart : Graph
local LineChart = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function LineChart:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return LineChart self The initialized instance
---@protected
function LineChart:init(props, basalt) end

---@class Reactive
local Reactive = {}

---@class Display : VisualElement
local Display = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Display:render() end

---Writes text to the display at the given position with the given foreground and background colors
---@param x number The x position to write to
---@param y number The y position to write to
---@param text string The text to write
---@return Display self The display instance
function Display:write(x, y, text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Display:init(props, basalt) end

---Returns the current window object
---@return table window The current window object
function Display:getWindow() end

---@class Checkbox : VisualElement
---@field checkedText string when checked
---@field text string Text to display
---@field autoSize boolean Whether to automatically size the checkbox
---@field checked boolean checkbox is checked
local Checkbox = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Checkbox:render() end

---Sets the value of the AutoSize property.
---@param self Checkbox self
---@param AutoSize boolean Whether to automatically size the checkbox
function Checkbox:setAutoSize(self, AutoSize) end

---Sets the value of the CheckedText property.
---@param self Checkbox self
---@param CheckedText string when checked
function Checkbox:setCheckedText(self, CheckedText) end

---Gets the value of the Text property.
---@param self Checkbox self
---@return string empty Text to display
function Checkbox:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Clicked Whether the event was handled
---@protected
function Checkbox:mouse_click(button, x, y) end

---Gets the value of the AutoSize property.
---@param self Checkbox self
---@return boolean true Whether to automatically size the checkbox
function Checkbox:getAutoSize(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Checkbox:init(props, basalt) end

---Gets the value of the Checked property.
---@param self Checkbox self
---@return boolean Whether checkbox is checked
function Checkbox:getChecked(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return Checkbox self The created instance
---@protected
function Checkbox.new() end

---Sets the value of the Checked property.
---@param self Checkbox self
---@param Checked boolean checkbox is checked
function Checkbox:setChecked(self, Checked) end

---Gets the value of the CheckedText property.
---@param self Checkbox self
---@return string Text when checked
function Checkbox:getCheckedText(self) end

---Sets the value of the Text property.
---@param self Checkbox self
---@param Text string Text to display
function Checkbox:setText(self, Text) end

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

---@class ErrorHandler
local ErrorHandler = {}

---Handles an error
---@param errMsg string The error message
function errorHandler.error(errMsg) end

---@class Dropdown : List
---@field dropSymbol string The symbol to show for dropdown indication
---@field dropdownHeight number Maximum height of the dropdown menu when open
---@field selectedText string The text to show when no item is selected
---@field isOpen boolean Whether the dropdown menu is currently open
local Dropdown = {}

---Sets the value of the IsOpen property.
---@param self Dropdown self
---@param IsOpen boolean Whether the dropdown menu is currently open
function Dropdown:setIsOpen(self, IsOpen) end

---Gets the value of the DropdownHeight property.
---@param self Dropdown self
---@return number 5 Maximum height of the dropdown menu when open
function Dropdown:getDropdownHeight(self) end

---Gets the value of the IsOpen property.
---@param self Dropdown self
---@return boolean false Whether the dropdown menu is currently open
function Dropdown:getIsOpen(self) end

---Sets the value of the DropSymbol property.
---@param self Dropdown self
---@param DropSymbol string The symbol to show for dropdown indication
function Dropdown:setDropSymbol(self, DropSymbol) end

---Gets the value of the SelectedText property.
---@param self Dropdown self
---@return string "" The text to show when no item is selected
function Dropdown:getSelectedText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Dropdown:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dropdown:render() end

---Sets the value of the SelectedText property.
---@param self Dropdown self
---@param SelectedText string The text to show when no item is selected
function Dropdown:setSelectedText(self, SelectedText) end

---Sets the value of the DropdownHeight property.
---@param self Dropdown self
---@param DropdownHeight number Maximum height of the dropdown menu when open
function Dropdown:setDropdownHeight(self, DropdownHeight) end

---Gets the value of the DropSymbol property.
---@param self Dropdown self
---@return string "\31" The symbol to show for dropdown indication
function Dropdown:getDropSymbol(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Dropdown self The initialized instance
---@protected
function Dropdown:init(props, basalt) end

---@class Graph : VisualElement
---@field series table The series of the graph
---@field minValue number The minimum value of the graph
---@field maxValue number The maximum value of the graph
local Graph = {}

---@param name string The name of the series
---@param visible boolean Whether the series should be visible
---@return Graph self The graph instance
function Graph:changeSeriesVisibility(name, visible) end

---Gets the value of the MinValue property.
---@param self Graph self
---@return number 0 The minimum value of the graph
function Graph:getMinValue(self) end

---Clears all points from a series
---@return Graph self The graph instance
function Graph:clear() end

---@param name string The name of the series
---@param symbol string The symbol of the series
---@param bgCol number The background color of the series
---@param fgCol number The foreground color of the series
---@param pointCount number The number of points in the series
---@return Graph self The graph instance
function Graph:addSeries(name, symbol, bgCol, fgCol, pointCount) end

---Sets the value of the MinValue property.
---@param self Graph self
---@param MinValue number The minimum value of the graph
function Graph:setMinValue(self, MinValue) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Graph:render() end

---@param name string The name of the series
---@return table ? series The series
function Graph:getSeries(name) end

---Gets the value of the MaxValue property.
---@param self Graph self
---@return number 100 The maximum value of the graph
function Graph:getMaxValue(self) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:removeSeries(name) end

---Sets the value of the MaxValue property.
---@param self Graph self
---@param MaxValue number The maximum value of the graph
function Graph:setMaxValue(self, MaxValue) end

---Sets the value of the Series property.
---@param self Graph self
---@param Series table The series of the graph
function Graph:setSeries(self, Series) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:focusSeries(name) end

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
---@param count number The number of points in the series
---@return Graph self The graph instance
function Graph:setSeriesPointCount(name, count) end

---@class basalt
local basalt = {}

---Returns a Plugin API
---@param name string The name of the plugin
---@return table Plugin The plugin API
function basalt.getAPI(name) end

---Returns the focused frame
---@return BaseFrame ? BaseFrame The focused frame
function basalt.getFocus() end

---Sets a frame as focused
---@param frame BaseFrame The frame to set as focused
function basalt.setFocus(frame) end

---Returns an element's class without creating a instance
---@param name string The name of the element
---@return table Element The element class
function basalt.getElementClass(name) end

---Returns the active frame
---@return BaseFrame ? BaseFrame The frame to set as active
function basalt.getActiveFrame() end

---Returns the error manager instance
---@return table ErrorManager The error manager
function basalt.getErrorManager() end

---Starts the Basalt runtime
function basalt.run() end

---Returns the element manager instance
---@return table ElementManager The element manager
function basalt.getElementManager() end

---Stops the Basalt runtime
function basalt.stop() end

---Gets or creates the main frame
---@return BaseFrame BaseFrame The main frame instance
function basalt.getMainFrame() end

---Runs basalt once, can be used to update the UI manually, but you have to feed it the events
function basalt.update() end

---Removes a scheduled update
---@param func thread The scheduled function to remove
---@return boolean success Whether the scheduled function was removed
function basalt.removeSchedule(func) end

---Creates and returns a new BaseFrame
---@return BaseFrame BaseFrame The created frame instance
function basalt.createFrame() end

---Schedules a function to run in a coroutine
---@param func function The function to schedule
---@return thread func The scheduled function
function basalt.schedule(func) end

---Sets the active frame
---@param frame BaseFrame The frame to set as active
function basalt.setActiveFrame(frame) end

---Creates and returns a new UI element of the specified type.
---@param type string The type of element to create (e.g. "Button", "Label", "BaseFrame")
---@return table element The created element instance
function basalt.create(type) end

---@class ElementManager
local ElementManager = {}

---Gets an Plugin API by name
---@param name string The name of the API to get
---@return table API The API
function ElementManager.getAPI(name) end

---Gets a list of all elements
---@return table ElementList A list of all elements
function ElementManager.getElementList() end

---Loads an element by name. This will load the element and apply any plugins to it.
---@param name string The name of the element to load
function ElementManager.loadElement(name) end

---Gets an element by name. If the element is not loaded, it will try to load it first.
---@param name string The name of the element to get
---@return table Element The element class
function ElementManager.getElement(name) end

---@class BaseElement : PropertySystem
---@field id string The unique identifier for the element
---@field type string The type identifier of the element
---@field eventCallbacks table The event callbacks for the element
---@field name string The name of the element
local BaseElement = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return table self The BaseElement instance
---@protected
function BaseElement:postInit() end

---Sets the value of the EventCallbacks property.
---@param self BaseElement self
---@param EventCallbacks table The event callbacks for the element
function BaseElement:setEventCallbacks(self, EventCallbacks) end

---Removes a state change observer
---@param self BaseElement The element to remove observer from
---@param stateName string The state to remove observer from
---@param callback function The callback function to remove
---@return BaseElement self The element instance
function BaseElement:removeStateChange(self, stateName, callback) end

---Observes a property and calls a callback when it changes
---@param property string The property to observe
---@param callback function The callback to call when the property changes
---@return table self The BaseElement instance
function BaseElement:onChange(property, callback) end

---Checks if the element is a specific type
---@param type string The type to check for
---@return boolean isType Whether the element is of the specified type
function BaseElement:isType(type) end

---Logs benchmark statistics for a method
---@param methodName string The name of the method to log
---@return BaseElement self The element instance
function BaseElement:logBenchmark(methodName) end

---Destroys the element and cleans up all references
function BaseElement:destroy() end

---Triggers an event and calls all registered callbacks
---@param event string The event to fire
---@return table self The BaseElement instance
function BaseElement:fireEvent(event) end

---Dumps debug information for this element
---@param self BaseElement The element to dump debug info for
function BaseElement.dumpDebug(self) end

---Gets the value of the EventCallbacks property.
---@param self BaseElement self
---@return table BaseElement The event callbacks for the element
function BaseElement:getEventCallbacks(self) end

---Sets the value of the Type property.
---@param self BaseElement self
---@param Type string The type identifier of the element
function BaseElement:setType(self, Type) end

---Registers a new event listener for the element (on class level)
---@param class table The class to register
---@param eventName string The name of the event to register
function BaseElement.defineEvent(class, eventName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseElement:init(props, basalt) end

---Sets the value of a state
---@param self BaseElement The element to set state for
---@param name string The name of the state
---@param value any The new value for the state
---@return BaseElement self The element instance
function BaseElement:setState(self, name, value) end

---Gets the value of the Id property.
---@param self BaseElement self
---@return string BaseElement The unique identifier for the element
function BaseElement:getId(self) end

---Stops benchmarking for a method
---@param methodName string The name of the method to stop benchmarking
---@return BaseElement self The element instance
function BaseElement:stopBenchmark(methodName) end

---Registers a callback for state changes
---@param self BaseElement The element to watch
---@param stateName string The state to watch
---@param callback function Called with (element, newValue, oldValue)
---@return BaseElement self The element instance
function BaseElement:onStateChange(self, stateName, callback) end

---Registers a new event callback for the element (on class level)
---@param class table The class to register
---@param callbackName string The name of the callback to register
function BaseElement.registerEventCallback(class, callbackName) end

---Gets the value of the Name property.
---@param self BaseElement self
---@return string BaseElement The name of the element
function BaseElement:getName(self) end

---Sets the value of the Id property.
---@param self BaseElement self
---@param Id string The unique identifier for the element
function BaseElement:setId(self, Id) end

---Gets benchmark statistics for a method
---@param methodName string The name of the method to get statistics for
---@return table ? stats The benchmark statistics or nil
function BaseElement:getBenchmarkStats(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:dispatchEvent(event) end

---Sets the value of the Name property.
---@param self BaseElement self
---@param Name string The name of the element
function BaseElement:setName(self, Name) end

---Enables debugging for this element
---@param self BaseElement The element to debug
---@param level number The debug level
function BaseElement.debug(self, level) end

---Gets the value of the Type property.
---@param self BaseElement self
---@return string BaseElement The type identifier of the element
function BaseElement:getType(self) end

---Requests a render update for this element
---@return table self The BaseElement instance
function BaseElement:updateRender() end

---Registers a callback function for an event
---@param event string The event to register the callback for
---@param callback function The callback function to register
---@return table self The BaseElement instance
function BaseElement:registerCallback(event, callback) end

---Ends profiling a method
---@param methodName string The name of the method to stop profiling
---@return BaseElement self The element instance
function BaseElement:endProfile(methodName) end

---Enables or disables event listening for a specific event
---@param eventName string The name of the event to listen for
---@return table self The BaseElement instance
function BaseElement:listenEvent(eventName) end

---Returns the base frame of the element
---@return BaseFrame BaseFrame The base frame of the element
function BaseElement:getBaseFrame() end

---Gets the value of a state
---@param self BaseElement The element to get state from
---@param name string The name of the state
---@return any value The current state value
function BaseElement:getState(self, name) end

---Starts profiling a method
---@param methodName string The name of the method to profile
---@return BaseElement self The element instance
function BaseElement:startProfile(methodName) end

---Gets the theme properties for this element
---@param self BaseElement The element to get theme for
---@return table styles The theme properties
function BaseElement:getTheme(self) end

---Binds a property to a state
---@param self BaseElement The element to bind
---@param propertyName string The property to bind
---@param stateName string The state to bind to (optional, uses propertyName if not provided)
---@return BaseElement self The element instance
function BaseElement:bind(self, propertyName, stateName) end

function BaseElement:computed() end

---Applies the current theme to this element
---@param self BaseElement The element to apply theme to
---@param applyToChildren boolean ? Whether to apply theme to child elements (default: true)
---@return BaseElement self The element instance
function BaseElement:applyTheme(self, applyToChildren) end

---Enables benchmarking for a method
---@param methodName string The name of the method to benchmark
---@return BaseElement self The element instance
function BaseElement:benchmark(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:handleEvent(event) end

---@class Program : VisualElement
---@field program table The program instance
---@field path string The path to the program
---@field running boolean Whether the program is running
local Program = {}

---Registers a callback for the program's error event, if the function returns false, the program won't stop
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onError(fn) end

---Gets the value of the Program property.
---@param self Program self
---@return table nil The program instance
function Program:getProgram(self) end

---Gets the value of the Running property.
---@param self Program self
---@return boolean false Whether the program is running
function Program:getRunning(self) end

---Gets the value of the Path property.
---@param self Program self
---@return string "" The path to the program
function Program:getPath(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:focus() end

---Sets the value of the Path property.
---@param self Program self
---@param Path string The path to the program
function Program:setPath(self, Path) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Program self The initialized instance
---@protected
function Program:init(props, basalt) end

---Sets the value of the Program property.
---@param self Program self
---@param Program table The program instance
function Program:setProgram(self, Program) end

---Sends an event to the program
---@param event string The event to send
---@return Program self The Program instance
function Program:sendEvent(event) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return any result The event result
---@protected
function Program:dispatchEvent(event) end

---Sets the value of the Running property.
---@param self Program self
---@param Running boolean Whether the program is running
function Program:setRunning(self, Running) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:render() end

---Executes a program
---@param path string The path to the program
---@return Program self The Program instance
function Program:execute(path) end

---@class VisualElement : BaseElement
---@field ignoreOffset boolean Whether to ignore the parent's offset
---@field width number The width of the element
---@field foreground color The text/foreground color
---@field background color The background color
---@field y number The vertical position relative to parent
---@field visible boolean Whether the element is visible
---@field hover boolean Whether the mouse is currently hover over the element (Craftos-PC only)
---@field clicked boolean Whether the element is currently clicked
---@field focused boolean Whether the element has input focus
---@field x number The horizontal position relative to parent
---@field backgroundEnabled boolean Whether to render the background
---@field height number The height of the element
---@field z number The z-index for layering elements
local VisualElement = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean clicked Whether the element was clicked
---@protected
function VisualElement:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:postRender() end

---Registers a function to handle the onRelease event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnRelease(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@protected
function VisualElement:mouse_release(button, x, y) end

---Gets the value of the Width property.
---@param self VisualElement self
---@return number 1 The width of the element
function VisualElement:getWidth(self) end

---Registers a function to handle the onDrag event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnDrag(self, func) end

function VisualElement:drawBg() end

function VisualElement:drawText() end

---Sets the value of the Hover property.
---@param self VisualElement self
---@param Hover boolean Whether the mouse is currently hover over the element (Craftos-PC only)
function VisualElement:setHover(self, Hover) end

---Sets the value of the X property.
---@param self VisualElement self
---@param X number The horizontal position relative to parent
function VisualElement:setX(self, X) end

---Sets the value of the Height property.
---@param self VisualElement self
---@param Height number The height of the element
function VisualElement:setHeight(self, Height) end

---Registers a function to handle the onScroll event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnScroll(self, func) end

---Sets the value of the Clicked property.
---@param self VisualElement self
---@param Clicked boolean Whether the element is currently clicked
function VisualElement:setClicked(self, Clicked) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@return boolean hover Whether the mouse has moved over the element
---@protected
function VisualElement:mouse_move(_, x, y) end

---Returns the absolute position of the element or the given coordinates.
---@return number x The absolute x position
---@return number y The absolute y position
function VisualElement:getAbsolutePosition() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean scroll Whether the element was scrolled
---@protected
function VisualElement:mouse_scroll(direction, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg string The foreground color
---@param bg string The background color
---@protected
function VisualElement:blit(x, y, text, fg, bg) end

---Gets the value of the Focused property.
---@param self VisualElement self
---@return boolean false Whether the element has input focus
function VisualElement:getFocused(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function VisualElement:init(props, basalt) end

---Gets the value of the Visible property.
---@param self VisualElement self
---@return boolean true Whether the element is visible
function VisualElement:getVisible(self) end

---Calculates the position of the element relative to its parent
---@return number x The x position
---@return number y The y position
function VisualElement:calculatePosition() end

---Gets the value of the Y property.
---@param self VisualElement self
---@return number 1 The vertical position relative to parent
function VisualElement:getY(self) end

---Gets the value of the IgnoreOffset property.
---@param self VisualElement self
---@return boolean false Whether to ignore the parent's offset
function VisualElement:getIgnoreOffset(self) end

---Registers a function to handle the onChar event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnChar(self, func) end

---Registers a function to handle the onMouseUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnMouseUp(self, func) end

---Returns the relative position of the element or the given coordinates.
---@return number x The relative x position
---@return number y The relative y position
function VisualElement:getRelativePosition() end

---Gets the value of the Z property.
---@param self VisualElement self
---@return number 1 The z-index for layering elements
function VisualElement:getZ(self) end

---Registers a function to handle the onBlur event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnBlur(self, func) end

---Gets the value of the Clicked property.
---@param self VisualElement self
---@return boolean false Whether the element is currently clicked
function VisualElement:getClicked(self) end

---Sets the value of the Z property.
---@param self VisualElement self
---@param Z number The z-index for layering elements
function VisualElement:setZ(self, Z) end

---Registers a function to handle the onFocus event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnFocus(self, func) end

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

---Sets the value of the Y property.
---@param self VisualElement self
---@param Y number The vertical position relative to parent
function VisualElement:setY(self, Y) end

---Sets the value of the Visible property.
---@param self VisualElement self
---@param Visible boolean Whether the element is visible
function VisualElement:setVisible(self, Visible) end

---Sets the value of the Focused property.
---@param self VisualElement self
---@param Focused boolean Whether the element has input focus
function VisualElement:setFocused(self, Focused) end

---Gets the value of the Height property.
---@param self VisualElement self
---@return number 1 The height of the element
function VisualElement:getHeight(self) end

---Sets the value of the Foreground property.
---@param self VisualElement self
---@param Foreground color The text/foreground color
function VisualElement:setForeground(self, Foreground) end

---Gets the value of the X property.
---@param self VisualElement self
---@return number 1 The horizontal position relative to parent
function VisualElement:getX(self) end

---Sets the value of the Background property.
---@param self VisualElement self
---@param Background color The background color
function VisualElement:setBackground(self, Background) end

---Sets the value of the IgnoreOffset property.
---@param self VisualElement self
---@param IgnoreOffset boolean Whether to ignore the parent's offset
function VisualElement:setIgnoreOffset(self, IgnoreOffset) end

function VisualElement:drawFg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:blur() end

---Registers a function to handle the onLeave event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnLeave(self, func) end

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

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked while dragging
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean drag Whether the element was dragged
---@protected
function VisualElement:mouse_drag(button, x, y) end

---Creates a new Animation Object
---@return Animation animation The new animation
function VisualElement:animate() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
---@return VisualElement self The VisualElement instance
---@protected
function VisualElement:setCursor(x, y, blink, color) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:render() end

---Registers a function to handle the onEnter event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnEnter(self, func) end

---Gets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@return boolean true Whether to render the background
function VisualElement:getBackgroundEnabled(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param bg color The background color
---@protected
function VisualElement:textBg(x, y, text, bg) end

---Gets the value of the Foreground property.
---@param self VisualElement self
---@return color white The text/foreground color
function VisualElement:getForeground(self) end

---Checks if the specified coordinates are within the bounds of the element
---@param x number The x position to check
---@param y number The y position to check
---@return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y) end

---Sets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@param BackgroundEnabled boolean Whether to render the background
function VisualElement:setBackgroundEnabled(self, BackgroundEnabled) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function VisualElement:char(char) end

---Sets the value of the Width property.
---@param self VisualElement self
---@param Width number The width of the element
function VisualElement:setWidth(self, Width) end

---Registers a function to handle the onClick event.
---@param button string
---@param x number
---@param y number
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnClick(self, func) end

---Registers a function to handle the onKeyUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKeyUp(self, func) end

---Registers a function to handle the onKey event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKey(self, func) end

---Gets the value of the Hover property.
---@param self VisualElement self
---@return boolean false Whether the mouse is currently hover over the element (Craftos-PC only)
function VisualElement:getHover(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:focus() end

---Gets the value of the Background property.
---@param self VisualElement self
---@return color black The background color
function VisualElement:getBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg color The foreground color
---@protected
function VisualElement:textFg(x, y, text, fg) end

---This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.
---@return VisualElement self The VisualElement instance
function VisualElement:prioritize() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function VisualElement:key(key) end

---@class AnimationInstance
local AnimationInstance = {}

---Creates a new AnimationInstance
---@param element VisualElement The element to animate
---@param animType string The type of animation
---@param args table The animation arguments
---@param duration number Duration in seconds
---@param easing string The easing function name
---@return AnimationInstance The new animation instance
function AnimationInstance.new(element, animType, args, duration, easing) end

---Updates the animation
---@param elapsed number The elapsed time in seconds
---@return boolean Whether the animation is finished
function AnimationInstance:update(elapsed) end

---Gets called when the animation is completed
function AnimationInstance:complete() end

---Starts the animation
---@return AnimationInstance self The animation instance
function AnimationInstance:start() end

---@class Animation
local Animation = {}

---Registers a callback for the update event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onUpdate(callback) end

---Creates a new Animation
---@param element VisualElement The element to animate
---@return Animation The new animation
function Animation.new(element) end

---The event handler for the animation (listens to timer events)
---@param event string The event type
---@param timerId number The timer ID
function Animation:event(event, timerId) end

---Adds a new animation to the sequence
---@param type string The type of animation
---@param args table The animation arguments
---@param duration number The duration in seconds
---@param easing string The easing function name
function Animation:addAnimation(type, args, duration, easing) end

---Registers a new easing function
---@param name string The name of the easing function
---@param func function The easing function (takes progress 0-1, returns modified progress)
function Animation.registerEasing(name, func) end

---Starts the animation
---@return Animation self The animation instance
function Animation:start() end

---Registers a callback for the start event
---@param callback function The callback function to register
function Animation:onStart(callback) end

---Creates a new sequence
---@return Animation self The animation instance
function Animation:sequence() end

---Registers a callback for the complete event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onComplete(callback) end

---Registers a new animation type
---@param name string The name of the animation
---@param handlers table Table containing start, update and complete handlers
function Animation.registerAnimation(name, handlers) end

---@class PropertySystem
local PropertySystem = {}

---Observers a property
---@param name string The name of the property
---@param callback function The callback function to call when the property changes
---@return table self The PropertySystem
function PropertySystem:observe(name, callback) end

---Defines a property for an element class
---@param class table The element class to define the property for
---@param name string The name of the property
---@param config table The configuration of the property
function PropertySystem.defineProperty(class, name, config) end

---Initializes the PropertySystem IS USED INTERNALLY
---@return table self The PropertySystem
function PropertySystem:__init() end

---Removes all observers from a property
---@param name string The name of the property
---@return table self The PropertySystem
function PropertySystem:removeAllObservers(name) end

---Gets a property configuration
---@param name string The name of the property
---@return table config The configuration of the property
function PropertySystem:getPropertyConfig(name) end

---Adds a setter hook to the PropertySystem. Setter hooks are functions that are called before a property is set.
---@param hook function The hook function to add
function PropertySystem.addSetterHook(hook) end

---Combines multiple properties into a single getter and setter
---@param class table The element class to combine the properties for
---@param name string The name of the combined property
function PropertySystem.combineProperties(class, name) end

---Removes a property from the PropertySystem on instance level
---@param name string The name of the property
---@return table self The PropertySystem
function PropertySystem:removeProperty(name) end

---Adds a property to the PropertySystem on instance level
---@param name string The name of the property
---@param config table The configuration of the property
---@return table self The PropertySystem
function PropertySystem:instanceProperty(name, config) end

---Removes an observer from a property
---@param name string The name of the property
---@param callback function The callback function to remove
---@return table self The PropertySystem
function PropertySystem:removeObserver(name, callback) end

---Update call for a property IS USED INTERNALLY
---@param name string The name of the property
---@param value any The value of the property
---@return table self The PropertySystem
function PropertySystem:_updateProperty(name, value) end

---Creates an element from a blueprint
---@param elementClass table The element class to create from the blueprint
---@param blueprint table The blueprint to create the element from
---@return table element The created element
function PropertySystem.createFromBlueprint(elementClass, blueprint) end

---Creates a blueprint of an element class with all its properties
---@param elementClass table The element class to create a blueprint from
---@return table blueprint A table containing all property definitions
function PropertySystem.blueprint(elementClass) end

---@class BaseFrame : Container
---@field term term term.current() The terminal or (monitor) peripheral object to render to
local BaseFrame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:term_resize() end

function BaseFrame:drawBg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function BaseFrame:key(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param name string The name of the monitor that was touched
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:monitor_touch(name, x, y) end

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

---Sets the cursor position
---@param x number The x position to set the cursor to
---@param y number The y position to set the cursor to
---@param blink boolean Whether the cursor should blink
function BaseFrame:setCursor(x, y, blink) end

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

function BaseFrame:dispatchEvent() end

function BaseFrame.setup() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param bg colors The background color
---@protected
function BaseFrame:drawText(x, y, text, bg) end

---Gets the value of the Term property.
---@param self BaseFrame self
---@return term |peripheral term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:getTerm(self) end

---Initializes a new state for this element
---@param self BaseFrame The element to initialize state for
---@param name string The name of the state
---@param default any The default value of the state
---@return BaseFrame self The element instance
function BaseFrame:initializeState(self, name, default) end

---Toggles the debug log frame
---@param self BaseFrame The frame to toggle debug log for
function BaseFrame.toggleConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg colors The foreground color
---@protected
function BaseFrame:textFg(x, y, text, fg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg string The foreground color
---@param bg string The background color
---@protected
function BaseFrame:blit(x, y, text, fg, bg) end

---Shows the debug log frame
---@param self BaseFrame The frame to show debug log in
function BaseFrame.openConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function BaseFrame:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function BaseFrame:key_up(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_up(button, x, y) end

---Hides the debug log frame
---@param self BaseFrame The frame to hide debug log for
function BaseFrame.closeConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseFrame:init(props, basalt) end

function BaseFrame:drawFg() end

---Sets the value of the Term property.
---@param self BaseFrame self
---@param Term term term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:setTerm(self, Term) end

---@class Frame : Container
---@field draggingMap table The map of dragging positions
---@field draggable boolean Whether the frame is draggable
local Frame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Frame self The initialized instance
---@protected
function Frame:init(props, basalt) end

---Sets the value of the DraggingMap property.
---@param self Frame self
---@param DraggingMap table The map of dragging positions
function Frame:setDraggingMap(self, DraggingMap) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the drag position
---@param y number The y position of the drag position
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_drag(button, x, y) end

---Gets the value of the Draggable property.
---@param self Frame self
---@return boolean false Whether the frame is draggable
function Frame:getDraggable(self) end

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
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_click(button, x, y) end

---Sets the value of the Draggable property.
---@param self Frame self
---@param Draggable boolean Whether the frame is draggable
function Frame:setDraggable(self, Draggable) end

---@class Tree : VisualElement
---@field selectedColor color Background color of selected node
---@field nodeColor color Color of unselected nodes
---@field selectedNode table nil Currently selected node
---@field nodes table The tree structure containing node objects with {text, children} properties
---@field scrollOffset number Current vertical scroll position
---@field expandedNodes table Table of nodes that are currently expanded
---@field horizontalOffset number Current horizontal scroll position
local Tree = {}

---Gets the size of the tree
---@return number width The width of the tree
---@return number height The height of the tree
function Tree:getNodeSize() end

---Gets the value of the SelectedNode property.
---@param self Tree self
---@return table ? nil Currently selected node
function Tree:getSelectedNode(self) end

---Gets the value of the ScrollOffset property.
---@param self Tree self
---@return number 0 Current vertical scroll position
function Tree:getScrollOffset(self) end

---Gets the value of the SelectedColor property.
---@param self Tree self
---@return color lightBlue Background color of selected node
function Tree:getSelectedColor(self) end

---Initializes the Tree instance
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Tree self The initialized instance
---@protected
function Tree:init(props, basalt) end

---Sets the value of the Nodes property.
---@param self Tree self
---@param Nodes table The tree structure containing node objects with {text, children} properties
function Tree:setNodes(self, Nodes) end

---Gets the value of the Nodes property.
---@param self Tree self
---@return table {} The tree structure containing node objects with {text, children} properties
function Tree:getNodes(self) end

---Sets the value of the ScrollOffset property.
---@param self Tree self
---@param ScrollOffset number Current vertical scroll position
function Tree:setScrollOffset(self, ScrollOffset) end

---Expands a node
---@param node table The node to expand
---@return Tree self The Tree instance
function Tree:expandNode(node) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Tree:render() end

---Sets the value of the ExpandedNodes property.
---@param self Tree self
---@param ExpandedNodes table Table of nodes that are currently expanded
function Tree:setExpandedNodes(self, ExpandedNodes) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_scroll(direction, x, y) end

---Registers a callback for when a node is selected
---@param callback function The callback function
---@return Tree self The Tree instance
function Tree:onSelect(callback) end

---Sets the value of the SelectedColor property.
---@param self Tree self
---@param SelectedColor color Background color of selected node
function Tree:setSelectedColor(self, SelectedColor) end

---Gets the value of the ExpandedNodes property.
---@param self Tree self
---@return table {} Table of nodes that are currently expanded
function Tree:getExpandedNodes(self) end

---Toggles a node's expanded state
---@param node table The node to toggle
---@return Tree self The Tree instance
function Tree:toggleNode(node) end

---Gets the value of the HorizontalOffset property.
---@param self Tree self
---@return number 0 Current horizontal scroll position
function Tree:getHorizontalOffset(self) end

---Handles mouse click events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_click(button, x, y) end

---Sets the value of the NodeColor property.
---@param self Tree self
---@param NodeColor color Color of unselected nodes
function Tree:setNodeColor(self, NodeColor) end

---Collapses a node
---@param node table The node to collapse
---@return Tree self The Tree instance
function Tree:collapseNode(node) end

---Sets the value of the SelectedNode property.
---@param self Tree self
---@param SelectedNode table nil Currently selected node
function Tree:setSelectedNode(self, SelectedNode) end

---Gets the value of the NodeColor property.
---@param self Tree self
---@return color white Color of unselected nodes
function Tree:getNodeColor(self) end

---Sets the value of the HorizontalOffset property.
---@param self Tree self
---@param HorizontalOffset number Current horizontal scroll position
function Tree:setHorizontalOffset(self, HorizontalOffset) end

---@class ProgressBar : VisualElement
---@field direction string The direction of the progress bar ("up", "down", "left", "right")
---@field showPercentage boolean Whether to show the percentage text in the center
---@field progress number Current progress value (0-100)
---@field progressColor color The color used for the filled portion of the progress bar
local ProgressBar = {}

---Sets the value of the ProgressColor property.
---@param self ProgressBar self
---@param ProgressColor color The color used for the filled portion of the progress bar
function ProgressBar:setProgressColor(self, ProgressColor) end

---Gets the value of the ShowPercentage property.
---@param self ProgressBar self
---@return boolean false Whether to show the percentage text in the center
function ProgressBar:getShowPercentage(self) end

---Gets the value of the Direction property.
---@param self ProgressBar self
---@return string right The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:getDirection(self) end

---Sets the value of the Progress property.
---@param self ProgressBar self
---@param Progress number Current progress value (0-100)
function ProgressBar:setProgress(self, Progress) end

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

---Sets the value of the Direction property.
---@param self ProgressBar self
---@param Direction string The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:setDirection(self, Direction) end

---Gets the value of the Progress property.
---@param self ProgressBar self
---@return number 0 Current progress value (0-100)
function ProgressBar:getProgress(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ProgressBar:render() end

---Gets the value of the ProgressColor property.
---@param self ProgressBar self
---@return color lime The color used for the filled portion of the progress bar
function ProgressBar:getProgressColor(self) end

---@class Table : VisualElement
---@field selectedRow number nil Currently selected row index
---@field gridColor color Color of grid lines
---@field sortColumn number nil Currently sorted column index
---@field columns table List of column definitions with {name, width} properties
---@field sortDirection string Sort direction ("asc" or "desc")
---@field data table The table data as array of row arrays
---@field headerColor color Color of the column headers
---@field scrollOffset number Current scroll position
---@field selectedColor color Background color of selected row
local Table = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Table:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Table self The initialized instance
---@protected
function Table:init(props, basalt) end

---Gets the value of the GridColor property.
---@param self Table self
---@return color gray Color of grid lines
function Table:getGridColor(self) end

---Sets the value of the GridColor property.
---@param self Table self
---@param GridColor color Color of grid lines
function Table:setGridColor(self, GridColor) end

---Sets the value of the Columns property.
---@param self Table self
---@param Columns table List of column definitions with {name, width} properties
function Table:setColumns(self, Columns) end

---Sets the value of the SelectedColor property.
---@param self Table self
---@param SelectedColor color Background color of selected row
function Table:setSelectedColor(self, SelectedColor) end

---Sets the value of the Data property.
---@param self Table self
---@param Data table The table data as array of row arrays
function Table:setData(self, Data) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (-1 up, 1 down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Table:mouse_scroll(direction, x, y) end

---Sets the value of the ScrollOffset property.
---@param self Table self
---@param ScrollOffset number Current scroll position
function Table:setScrollOffset(self, ScrollOffset) end

---Gets the value of the SortDirection property.
---@param self Table self
---@return string "asc" Sort direction ("asc" or "desc")
function Table:getSortDirection(self) end

---Sets the value of the SelectedRow property.
---@param self Table self
---@param SelectedRow number nil Currently selected row index
function Table:setSelectedRow(self, SelectedRow) end

---Gets the value of the SortColumn property.
---@param self Table self
---@return number ? nil Currently sorted column index
function Table:getSortColumn(self) end

---Sorts the table data by column
---@param columnIndex number The index of the column to sort by
---@param fn function ? Optional custom sorting function
---@return Table self The Table instance
function Table:sortData(columnIndex, fn) end

---Gets the value of the ScrollOffset property.
---@param self Table self
---@return number 0 Current scroll position
function Table:getScrollOffset(self) end

---Gets the value of the HeaderColor property.
---@param self Table self
---@return color blue Color of the column headers
function Table:getHeaderColor(self) end

---Gets the value of the Columns property.
---@param self Table self
---@return table {} List of column definitions with {name, width} properties
function Table:getColumns(self) end

---Sets the value of the SortColumn property.
---@param self Table self
---@param SortColumn number nil Currently sorted column index
function Table:setSortColumn(self, SortColumn) end

---Sets the value of the SortDirection property.
---@param self Table self
---@param SortDirection string Sort direction ("asc" or "desc")
function Table:setSortDirection(self, SortDirection) end

---Gets the value of the Data property.
---@param self Table self
---@return table {} The table data as array of row arrays
function Table:getData(self) end

---Sets the value of the HeaderColor property.
---@param self Table self
---@param HeaderColor color Color of the column headers
function Table:setHeaderColor(self, HeaderColor) end

---Gets the value of the SelectedColor property.
---@param self Table self
---@return color lightBlue Background color of selected row
function Table:getSelectedColor(self) end

---Gets the value of the SelectedRow property.
---@param self Table self
---@return number ? nil Currently selected row index
function Table:getSelectedRow(self) end

---@class Label : VisualElement
---@field autoSize boolean Whether the label should automatically resize its width based on the text content
---@field text string The text content to display. Can be a string or a function that returns a string
local Label = {}

---Gets the value of the Text property.
---@param self Label self
---@return string Label The text content to display. Can be a string or a function that returns a string
function Label:getText(self) end

---Sets the value of the Text property.
---@param self Label self
---@param Text string The text content to display. Can be a string or a function that returns a string
function Label:setText(self, Text) end

---Sets the value of the AutoSize property.
---@param self Label self
---@param AutoSize boolean Whether the label should automatically resize its width based on the text content
function Label:setAutoSize(self, AutoSize) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Label:render() end

---Gets the value of the AutoSize property.
---@param self Label self
---@return boolean true Whether the label should automatically resize its width based on the text content
function Label:getAutoSize(self) end

---Gets the wrapped lines of the Label
---@return table wrappedText The wrapped lines of the Label
function Label:getWrappedText() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Label self The initialized instance
---@protected
function Label:init(props, basalt) end

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

