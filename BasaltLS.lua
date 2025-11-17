---@meta

---@class TabControl : Container
---@field scrollableTab boolean Enables scroll mode for tabs if they exceed width
---@field activeTabBackground color Background color for the active tab
---@field activeTab number The currently active tab ID
---@field tabs table List of tab definitions
---@field tabHeight number Height of the tab header area
---@field activeTabTextColor color Foreground color for the active tab text
---@field tabScrollOffset number Current scroll offset for tabs in scrollable mode
---@field headerBackground color Background color for the tab header area
local TabControl = {}

function TabControl:drawBg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param child table The child element to check
---@return boolean Whether the child should be visible
---@protected
function TabControl:isChildVisible(child) end

---Gets the value of the HeaderBackground property.
---@param self TabControl self
---@return color gray Background color for the tab header area
function TabControl:getHeaderBackground(self) end

---Sets the value of the ActiveTabTextColor property.
---@param self TabControl self
---@param ActiveTabTextColor color Foreground color for the active tab text
function TabControl:setActiveTabTextColor(self, ActiveTabTextColor) end

function TabControl:mouse_move() end

function TabControl:blit() end

function TabControl:mouse_drag() end

function TabControl:getRelativePosition() end

---returns a proxy for adding elements to the tab
---@param title string The title of the tab
---@return table tabHandler The tab handler proxy for adding elements to the new tab
function TabControl:newTab(title) end

function TabControl:multiBlit() end

function TabControl:_getHeaderMetrics() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function TabControl:init(props, basalt) end

function TabControl:mouse_up() end

function TabControl:drawText() end

function TabControl:drawFg() end

---@param tabId number The ID of the tab to activate
function TabControl:setActiveTab(tabId) end

function TabControl:textFg() end

---Gets the value of the ScrollableTab property.
---@param self TabControl self
---@return boolean false Enables scroll mode for tabs if they exceed width
function TabControl:getScrollableTab(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TabControl:render() end

---Sets the value of the Tabs property.
---@param self TabControl self
---@param Tabs table List of tab definitions
function TabControl:setTabs(self, Tabs) end

---Sets the value of the TabHeight property.
---@param self TabControl self
---@param TabHeight number Height of the tab header area
function TabControl:setTabHeight(self, TabHeight) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TabControl:sortChildrenEvents() end

---Gets the value of the ActiveTabBackground property.
---@param self TabControl self
---@return color white Background color for the active tab
function TabControl:getActiveTabBackground(self) end

function TabControl:textBg() end

function TabControl:setCursor() end

function TabControl:mouse_scroll() end

---Sets the value of the HeaderBackground property.
---@param self TabControl self
---@param HeaderBackground color Background color for the tab header area
function TabControl:setHeaderBackground(self, HeaderBackground) end

function TabControl:mouse_release() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click (global)
---@param y number The y position of the click (global)
---@return boolean Whether the event was handled
---@protected
function TabControl:mouse_click(button, x, y) end

---Gets the value of the ActiveTab property.
---@param self TabControl self
---@return number nil The currently active tab ID
function TabControl:getActiveTab(self) end

---Gets the value of the TabScrollOffset property.
---@param self TabControl self
---@return number 0 Current scroll offset for tabs in scrollable mode
function TabControl:getTabScrollOffset(self) end

---Gets the value of the Tabs property.
---@param self TabControl self
---@return table {} List of tab definitions
function TabControl:getTabs(self) end

---Scrolls the tab header left or right if scrollableTab is enabled
---@param direction number -1 to scroll left, 1 to scroll right
---@return TabControl self For method chaining
function TabControl:scrollTabs(direction) end

---Sets the value of the ScrollableTab property.
---@param self TabControl self
---@param ScrollableTab boolean Enables scroll mode for tabs if they exceed width
function TabControl:setScrollableTab(self, ScrollableTab) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param child table The child element to add
---@return Container self For method chaining
---@protected
function TabControl:addChild(child) end

---Gets the value of the ActiveTabTextColor property.
---@param self TabControl self
---@return color black Foreground color for the active tab text
function TabControl:getActiveTabTextColor(self) end

---Sets the value of the TabScrollOffset property.
---@param self TabControl self
---@param TabScrollOffset number Current scroll offset for tabs in scrollable mode
function TabControl:setTabScrollOffset(self, TabScrollOffset) end

---@param elementType string The type of element to add
---@param tabId number Optional tab ID, defaults to active tab
---@return table element The created element
function TabControl:addElement(elementType, tabId) end

---@param element table The element to assign to a tab
---@param tabId number The ID of the tab to assign the element to
---@return TabControl self For method chaining
function TabControl:setTab(element, tabId) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return number yOffset The Y offset for content
---@protected
function TabControl:getContentYOffset() end

---Gets the value of the TabHeight property.
---@param self TabControl self
---@return number 1 Height of the tab header area
function TabControl:getTabHeight(self) end

---Sets the value of the ActiveTabBackground property.
---@param self TabControl self
---@param ActiveTabBackground color Background color for the active tab
function TabControl:setActiveTabBackground(self, ActiveTabBackground) end

---@class Frame : Container
---@field draggingMap table The map of dragging positions
---@field scrollable boolean Whether the frame is scrollable
---@field draggable boolean Whether the frame is draggable
local Frame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Frame self The initialized instance
---@protected
function Frame:init(props, basalt) end

---Gets the value of the Draggable property.
---@param self Frame self
---@return boolean false Whether the frame is draggable
function Frame:getDraggable(self) end

---Sets the value of the Scrollable property.
---@param self Frame self
---@param Scrollable boolean Whether the frame is scrollable
function Frame:setScrollable(self, Scrollable) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return number height The total height needed for all children
---@protected
function Frame:getChildrenHeight() end

---Sets the value of the Draggable property.
---@param self Frame self
---@param Draggable boolean Whether the frame is draggable
function Frame:setDraggable(self, Draggable) end

---Gets the value of the Scrollable property.
---@param self Frame self
---@return boolean false Whether the frame is scrollable
function Frame:getScrollable(self) end

---Gets the value of the DraggingMap property.
---@param self Frame self
---@return table {} The map of dragging positions
function Frame:getDraggingMap(self) end

---Sets the value of the DraggingMap property.
---@param self Frame self
---@param DraggingMap table The map of dragging positions
function Frame:setDraggingMap(self, DraggingMap) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the drag position
---@param y number The y position of the drag position
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_drag(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_up(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_scroll(direction, x, y) end

---@class ErrorHandler
local ErrorHandler = {}

---Handles an error
---@param errMsg string The error message
function errorHandler.error(errMsg) end

---@class Table : Collection
---@field customSortFunction table Custom sort functions for columns
---@field gridColor color Color of grid lines
---@field columns table List of column definitions with {name, width} properties
---@field showScrollBar boolean Whether to show the scrollbar when items exceed height
---@field scrollBarBackgroundColor color Background color of the scrollbar
---@field scrollBarColor color Color of the scrollbar handle
---@field scrollBarBackground string Symbol used for the scrollbar background
---@field scrollBarSymbol string " Symbol used for the scrollbar handle
---@field sortDirection string Sort direction ("asc" or "desc")
---@field headerColor color Color of the column headers
---@field sortColumn number nil Currently sorted column index
---@field offset number Scroll offset for vertical scrolling
local Table = {}

---Gets the value of the ScrollBarBackgroundColor property.
---@param self Table self
---@return color gray Background color of the scrollbar
function Table:getScrollBarBackgroundColor(self) end

---Sets the value of the ShowScrollBar property.
---@param self Table self
---@param ShowScrollBar boolean Whether to show the scrollbar when items exceed height
function Table:setShowScrollBar(self, ShowScrollBar) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Table self The initialized instance
---@protected
function Table:init(props, basalt) end

---Updates a specific cell value
---@param rowIndex number The row index
---@param colIndex number The column index
---@param value any The new value
---@return Table self The Table instance
function Table:updateCell(rowIndex, colIndex, value) end

---Sets the value of the ScrollBarSymbol property.
---@param self Table self
---@param ScrollBarSymbol string " Symbol used for the scrollbar handle
function Table:setScrollBarSymbol(self, ScrollBarSymbol) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:mouse_click() end

---Sorts the table data by column
---@param columnIndex number The index of the column to sort by
---@param fn function ? Optional custom sorting function
---@return Table self The Table instance
function Table:sortByColumn(columnIndex, fn) end

---Gets the value of the ScrollBarSymbol property.
---@param self Table self
---@return string " " Symbol used for the scrollbar handle
function Table:getScrollBarSymbol(self) end

---Sets the value of the Columns property.
---@param self Table self
---@param Columns table List of column definitions with {name, width} properties
function Table:setColumns(self, Columns) end

---Gets the value of the CustomSortFunction property.
---@param self Table self
---@return table {} Custom sort functions for columns
function Table:getCustomSortFunction(self) end

---Gets a row by index
---@param rowIndex number The index of the row
---@return table ? row The row data or nil
function Table:getRow(rowIndex) end

---Sets a custom sort function for a specific column
---@param columnIndex number The index of the column
---@param sortFn function Function that takes (rowA, rowB) and returns comparison result
---@return Table self The Table instance
function Table:setColumnSortFunction(columnIndex, sortFn) end

---Sets the value of the ScrollBarBackground property.
---@param self Table self
---@param ScrollBarBackground string Symbol used for the scrollbar background
function Table:setScrollBarBackground(self, ScrollBarBackground) end

---Gets the value of the ShowScrollBar property.
---@param self Table self
---@return boolean true Whether to show the scrollbar when items exceed height
function Table:getShowScrollBar(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:mouse_drag() end

---Sets the value of the ScrollBarBackgroundColor property.
---@param self Table self
---@param ScrollBarBackgroundColor color Background color of the scrollbar
function Table:setScrollBarBackgroundColor(self, ScrollBarBackgroundColor) end

---Registers a function to handle the onRowSelect event.
---@param rowIndex number
---@param row table
---@param self Table self
---@param func function The function to be called when the event fires
function Table:onOnRowSelect(self, func) end

---Adds a new column to the table
---@param name string The name of the column
---@param width number |string The width of the column (number, "auto", or "30%")
---@return Table self The Table instance
function Table:addColumn(name, width) end

---Sets the value of the Offset property.
---@param self Table self
---@param Offset number Scroll offset for vertical scrolling
function Table:setOffset(self, Offset) end

---Adds a new row to the table
---@return Table self The Table instance
function Table:addRow() end

---Gets the currently selected row
---@return table ? row The selected row or nil
function Table:getSelectedRow() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:mouse_scroll() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:mouse_up() end

---Registers callback for row selection
---@param callback function The callback function(rowIndex, row)
---@return Table self The Table instance
function Table:onRowSelect(callback) end

---Gets the value of the GridColor property.
---@param self Table self
---@return color gray Color of grid lines
function Table:getGridColor(self) end

---Gets the value of the SortDirection property.
---@param self Table self
---@return string "asc" Sort direction ("asc" or "desc")
function Table:getSortDirection(self) end

---Removes a row by index
---@param rowIndex number The index of the row to remove
---@return Table self The Table instance
function Table:removeRow(rowIndex) end

---Sets the value of the SortColumn property.
---@param self Table self
---@param SortColumn number nil Currently sorted column index
function Table:setSortColumn(self, SortColumn) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:render() end

---Gets the value of the SortColumn property.
---@param self Table self
---@return number ? nil Currently sorted column index
function Table:getSortColumn(self) end

---Sets the value of the SortDirection property.
---@param self Table self
---@param SortDirection string Sort direction ("asc" or "desc")
function Table:setSortDirection(self, SortDirection) end

---Gets the value of the ScrollBarColor property.
---@param self Table self
---@return color lightGray Color of the scrollbar handle
function Table:getScrollBarColor(self) end

---Gets the value of the Offset property.
---@param self Table self
---@return number 0 Scroll offset for vertical scrolling
function Table:getOffset(self) end

---Gets all table data
---@return table data Array of row cell arrays
function Table:getData() end

---Sets the value of the GridColor property.
---@param self Table self
---@param GridColor color Color of grid lines
function Table:setGridColor(self, GridColor) end

---Gets the value of the ScrollBarBackground property.
---@param self Table self
---@return string "\127" Symbol used for the scrollbar background
function Table:getScrollBarBackground(self) end

---Sets the value of the HeaderColor property.
---@param self Table self
---@param HeaderColor color Color of the column headers
function Table:setHeaderColor(self, HeaderColor) end

---Sets the value of the CustomSortFunction property.
---@param self Table self
---@param CustomSortFunction table Custom sort functions for columns
function Table:setCustomSortFunction(self, CustomSortFunction) end

---Sets the value of the ScrollBarColor property.
---@param self Table self
---@param ScrollBarColor color Color of the scrollbar handle
function Table:setScrollBarColor(self, ScrollBarColor) end

---Clears all table data
---@return Table self The Table instance
function Table:clearData() end

---Gets the value of the Columns property.
---@param self Table self
---@return table {} List of column definitions with {name, width} properties
function Table:getColumns(self) end

---Gets the value of the HeaderColor property.
---@param self Table self
---@return color blue Color of the column headers
function Table:getHeaderColor(self) end

---Set data with automatic formatting
---@param rawData table The raw data array (array of row arrays)
---@param formatters table ? Optional formatter functions for columns {[2] = function(value) return value end}
---@return Table self The Table instance
function Table:setData(rawData, formatters) end

---@class Slider : VisualElement
---@field step number Current position of the slider handle (1 to width/height)
---@field sliderColor color Color of the slider handle
---@field horizontal boolean Whether the slider is horizontal (false for vertical)
---@field barColor color Color of the slider track
---@field max number Maximum value for value conversion (maps slider position to this range)
local Slider = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Slider:render() end

---Sets the value of the SliderColor property.
---@param self Slider self
---@param SliderColor color Color of the slider handle
function Slider:setSliderColor(self, SliderColor) end

---Sets the value of the Horizontal property.
---@param self Slider self
---@param Horizontal boolean Whether the slider is horizontal (false for vertical)
function Slider:setHorizontal(self, Horizontal) end

---Gets the current value of the slider
---@return number value The current value (0 to max)
function Slider:getValue() end

---Registers a function to handle the onChange event.
---@param value number
---@param self Slider self
---@param func function The function to be called when the event fires
function Slider:onOnChange(self, func) end

---Gets the value of the Horizontal property.
---@param self Slider self
---@return boolean true Whether the slider is horizontal (false for vertical)
function Slider:getHorizontal(self) end

---Sets the value of the Max property.
---@param self Slider self
---@param Max number Maximum value for value conversion (maps slider position to this range)
function Slider:setMax(self, Max) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_click(button, x, y) end

---Sets the value of the Step property.
---@param self Slider self
---@param Step number Current position of the slider handle (1 to width/height)
function Slider:setStep(self, Step) end

---Gets the value of the Step property.
---@param self Slider self
---@return number 1 Current position of the slider handle (1 to width/height)
function Slider:getStep(self) end

---Gets the value of the SliderColor property.
---@param self Slider self
---@return color blue Color of the slider handle
function Slider:getSliderColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Slider self The initialized instance
---@protected
function Slider:init(props, basalt) end

---Gets the value of the Max property.
---@param self Slider self
---@return number 100 Maximum value for value conversion (maps slider position to this range)
function Slider:getMax(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_scroll(button, x, y) end

---Gets the value of the BarColor property.
---@param self Slider self
---@return color gray Color of the slider track
function Slider:getBarColor(self) end

---Sets the value of the BarColor property.
---@param self Slider self
---@param BarColor color Color of the slider track
function Slider:setBarColor(self, BarColor) end

---@class Container : VisualElement
---@field offsetY number Vertical scroll/content offset
---@field visibleChildrenEvents table Event handlers for currently visible children
---@field children table Collection of all child elements
---@field childrenSorted boolean Indicates if children are sorted by z-index
---@field childrenEvents table Registered event handlers for all children
---@field focusedChild table Currently focused child element (receives keyboard events)
---@field offsetX number Horizontal scroll/content offset
---@field eventListenerCount table Number of listeners per event type
---@field visibleChildren table Currently visible child elements (calculated based on viewport)
---@field childrenEventsSorted boolean Indicates if event handlers are properly sorted
local Container = {}

---Sets the value of the OffsetX property.
---@param self Container self
---@param OffsetX number Horizontal scroll/content offset
function Container:setOffsetX(self, OffsetX) end

---Creates a new Table element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Table element A new Table element.
function Container:addTable(self, props) end

---Creates a new Breadcrumb element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Breadcrumb element A new Breadcrumb element.
function Container:addBreadcrumb(self, props) end

---Creates a new TabControl element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return TabControl element A new TabControl element.
function Container:addTabControl(self, props) end

---Creates a new Tree element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Tree element A new Tree element.
function Container:addTree(self, props) end

---Gets the value of the FocusedChild property.
---@param self Container self
---@return table nil Currently focused child element (receives keyboard events)
function Container:getFocusedChild(self) end

---Creates a new Toast element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Toast element A new Toast element.
function Container:addToast(self, props) end

---Creates a new Container element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Container element A new Container element.
function Container:addContainer(self, props) end

---Gets the value of the ChildrenEventsSorted property.
---@param self Container self
---@return boolean true Indicates if event handlers are properly sorted
function Container:getChildrenEventsSorted(self) end

---Sets the value of the Children property.
---@param self Container self
---@param Children table Collection of all child elements
function Container:setChildren(self, Children) end

---Applies a layout from a file to this container
---@param layoutPath string Path to the layout file (e.g. "layouts/grid")
---@return Container self For method chaining
function Container:applyLayout(layoutPath) end

---Creates a new ScrollFrame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ScrollFrame element A new ScrollFrame element.
function Container:addScrollFrame(self, props) end

---Tests whether a child element is currently visible within the container's viewport
---@param child table The child element to check
---@return boolean isVisible Whether the child is within view bounds
function Container:isChildVisible(child) end

---Sets the value of the ChildrenEvents property.
---@param self Container self
---@param ChildrenEvents table Registered event handlers for all children
function Container:setChildrenEvents(self, ChildrenEvents) end

---Creates a new SideNav element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return SideNav element A new SideNav element.
function Container:addSideNav(self, props) end

---Creates a new Frame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Frame element A new Frame element.
function Container:addFrame(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@protected
function Container:mouse_release(button, x, y) end

---Enables benchmarking for a container and all its children
---@param methodName string The method to benchmark
---@return Container self The container instance
function Container:benchmarkContainer(methodName) end

---Gets the value of the OffsetX property.
---@param self Container self
---@return number 0 Horizontal scroll/content offset
function Container:getOffsetX(self) end

---Creates a new ScrollBar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ScrollBar element A new ScrollBar element.
function Container:addScrollBar(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param bg color The background color of the text
---@return Container self The container instance
---@protected
function Container:textBg(x, y, text, bg) end

---Removes all child elements and resets the container's state
---@return Container self For method chaining
function Container:clear() end

---Creates a new BigFont element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BigFont element A new BigFont element.
function Container:addBigFont(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:char(char) end

---Sets the value of the VisibleChildren property.
---@param self Container self
---@param VisibleChildren table Currently visible child elements (calculated based on viewport)
function Container:setVisibleChildren(self, VisibleChildren) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@return boolean handled Whether the event was handled
---@protected
function Container:key_up(key) end

---Gets the value of the VisibleChildrenEvents property.
---@param self Container self
---@return table {} Event handlers for currently visible children
function Container:getVisibleChildrenEvents(self) end

---Creates a new Slider element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Slider element A new Slider element.
function Container:addSlider(self, props) end

---Creates a new Program element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Program element A new Program element.
function Container:addProgram(self, props) end

---Creates a new CheckBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return CheckBox element A new CheckBox element.
function Container:addCheckBox(self, props) end

---Creates a new LineChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return LineChart element A new LineChart element.
function Container:addLineChart(self, props) end

---Logs benchmark statistics for a container and all its children
---@param methodName string The method to log
---@return Container self The container instance
function Container:logContainerBenchmarks(methodName) end

---Stops benchmarking for a container and all its children
---@param methodName string The method to stop benchmarking
---@return Container self The container instance
function Container:stopContainerBenchmark(methodName) end

---Creates a new ProgressBar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ProgressBar element A new ProgressBar element.
function Container:addProgressBar(self, props) end

---Locates a child element using a path-like syntax (e.g. "panel/button1")
---@param path string Path to the child (e.g. "panel/button1", "header/title")
---@return Element ? child The found element or nil if not found
function Container:getChild(path) end

---Creates a new BaseElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseElement element A new BaseElement element.
function Container:addBaseElement(self, props) end

---Gets the value of the ChildrenSorted property.
---@param self Container self
---@return boolean true Indicates if children are sorted by z-index
function Container:getChildrenSorted(self) end

---Calls a event on all children
---@param visibleOnly boolean Whether to only call the event on visible children
---@param event string The event to call
---@return boolean handled Whether the event was handled
---@return table ? child The child that handled the event
function Container:callChildrenEvent(visibleOnly, event) end

---Removes the current layout
---@return Container self For method chaining
function Container:clearLayout() end

---Adds a new element to this container's hierarchy
---@param child table The element to add as a child
---@return Container self For method chaining
function Container:addChild(child) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_move(_, x, y) end

---Sets the value of the FocusedChild property.
---@param self Container self
---@param FocusedChild table Currently focused child element (receives keyboard events)
function Container:setFocusedChild(self, FocusedChild) end

---Sets the value of the VisibleChildrenEvents property.
---@param self Container self
---@param VisibleChildrenEvents table Event handlers for currently visible children
function Container:setVisibleChildrenEvents(self, VisibleChildrenEvents) end

---Creates a new Display element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Display element A new Display element.
function Container:addDisplay(self, props) end

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

---Creates a new VisualElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return VisualElement element A new VisualElement element.
function Container:addVisualElement(self, props) end

---Sets the value of the OffsetY property.
---@param self Container self
---@param OffsetY number Vertical scroll/content offset
function Container:setOffsetY(self, OffsetY) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_scroll(direction, x, y) end

---Creates a new Button element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Button element A new Button element.
function Container:addButton(self, props) end

function Container:drawFg() end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@return Container self The container instance
function Container:removeChildrenEvents(child) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_up(button, x, y) end

function Container:drawText() end

---Gets the value of the Children property.
---@param self Container self
---@return table {} Collection of all child elements
function Container:getChildren(self) end

---Gets the value of the OffsetY property.
---@param self Container self
---@return number 0 Vertical scroll/content offset
function Container:getOffsetY(self) end

---Gets the value of the VisibleChildren property.
---@param self Container self
---@return table {} Currently visible child elements (calculated based on viewport)
function Container:getVisibleChildren(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:key(key) end

---Creates a new Input element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Input element A new Input element.
function Container:addInput(self, props) end

---Updates the current layout (recalculates positions)
---@return Container self For method chaining
function Container:updateLayout() end

---Re-sorts children by their z-index and updates visibility
---@return Container self For method chaining
function Container:sortChildren() end

---Removes an element from this container's hierarchy and cleans up its events
---@param child table The element to remove
---@return Container self For method chaining
function Container:removeChild(child) end

---Creates a new Image element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Image element A new Image element.
function Container:addImage(self, props) end

---Creates a new Collection element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Collection element A new Collection element.
function Container:addCollection(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Container:render() end

---Sets the value of the ChildrenSorted property.
---@param self Container self
---@param ChildrenSorted boolean Indicates if children are sorted by z-index
function Container:setChildrenSorted(self, ChildrenSorted) end

---Registers the children events of the container
---@param child table The child to register events for
---@return Container self The container instance
function Container:registerChildrenEvents(child) end

---Creates a new BaseFrame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseFrame element A new BaseFrame element.
function Container:addBaseFrame(self, props) end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@param eventName string The event name to unregister
---@return Container self The container instance
function Container:unregisterChildEvent(child, eventName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Container:init(props, basalt) end

---Creates a new ComboBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ComboBox element A new ComboBox element.
function Container:addComboBox(self, props) end

---Creates a new Timer element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Timer element A new Timer element.
function Container:addTimer(self, props) end

---Creates a new List element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return List element A new List element.
function Container:addList(self, props) end

---Creates a new DropDown element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return DropDown element A new DropDown element.
function Container:addDropDown(self, props) end

---Creates a new TextBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return TextBox element A new TextBox element.
function Container:addTextBox(self, props) end

---Creates a new Accordion element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Accordion element A new Accordion element.
function Container:addAccordion(self, props) end

function Container:drawBg() end

---Gets the value of the ChildrenEvents property.
---@param self Container self
---@return table {} Registered event handlers for all children
function Container:getChildrenEvents(self) end

---Sorts the children events of the container
---@param eventName string The event name to sort
---@return Container self The container instance
function Container:sortChildrenEvents(eventName) end

---Enables debugging for this container and all its children
---@param self Container The container to debug
---@param level number The debug level
function Container.debugChildren(self, level) end

---Creates a new Dialog element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Dialog element A new Dialog element.
function Container:addDialog(self, props) end

---Creates a new Graph element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Graph element A new Graph element.
function Container:addGraph(self, props) end

---Gets the value of the EventListenerCount property.
---@param self Container self
---@return table {} Number of listeners per event type
function Container:getEventListenerCount(self) end

---Creates a new Switch element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Switch element A new Switch element.
function Container:addSwitch(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_click(button, x, y) end

---Registers an event handler for a specific child element
---@param child table The child element to register events for
---@param eventName string The name of the event to register
---@return Container self For method chaining
function Container:registerChildEvent(child, eventName) end

---Sets the value of the EventListenerCount property.
---@param self Container self
---@param EventListenerCount table Number of listeners per event type
function Container:setEventListenerCount(self, EventListenerCount) end

---Creates a new Label element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Label element A new Label element.
function Container:addLabel(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean handled Whether the event was handled
---@protected
function Container:handleEvent(event) end

---Sets the value of the ChildrenEventsSorted property.
---@param self Container self
---@param ChildrenEventsSorted boolean Indicates if event handlers are properly sorted
function Container:setChildrenEventsSorted(self, ChildrenEventsSorted) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg color The foreground color of the text
---@return Container self The container instance
---@protected
function Container:textFg(x, y, text, fg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_drag(button, x, y) end

---Creates a new Menu element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Menu element A new Menu element.
function Container:addMenu(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Container self The container instance
---@protected
function Container:blit(x, y, text, fg, bg) end

---Creates a new BarChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BarChart element A new BarChart element.
function Container:addBarChart(self, props) end

---Creates a new ContextMenu element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ContextMenu element A new ContextMenu element.
function Container:addContextMenu(self, props) end

---@class Dialog : Frame
---@field primaryColor color Primary button color (OK, confirm actions)
---@field secondaryColor color Secondary button color (Cancel, dismiss actions)
---@field modal boolean If true, blocks all events outside the dialog
---@field buttonForeground color Foreground color for buttons
---@field title string The dialog title
local Dialog = {}

---Sets the value of the PrimaryColor property.
---@param self Dialog self
---@param PrimaryColor color Primary button color (OK, confirm actions)
function Dialog:setPrimaryColor(self, PrimaryColor) end

---Sets the value of the ButtonForeground property.
---@param self Dialog self
---@param ButtonForeground color Foreground color for buttons
function Dialog:setButtonForeground(self, ButtonForeground) end

---Creates a simple alert dialog
---@param title string The alert title
---@param message string The alert message
---@return Dialog self The Dialog instance
function Dialog:alert(title, message) end

---Creates a prompt dialog with input
---@param title string The dialog title
---@param message string The prompt message
---@return Dialog self The Dialog instance
function Dialog:prompt(title, message) end

---Renders the dialog
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dialog:render() end

---Sets the value of the Modal property.
---@param self Dialog self
---@param Modal boolean If true, blocks all events outside the dialog
function Dialog:setModal(self, Modal) end

---Gets the value of the PrimaryColor property.
---@param self Dialog self
---@return color lime Primary button color (OK, confirm actions)
function Dialog:getPrimaryColor(self) end

---Gets the value of the SecondaryColor property.
---@param self Dialog self
---@return color lightGray Secondary button color (Cancel, dismiss actions)
function Dialog:getSecondaryColor(self) end

---Handles mouse scroll events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dialog:mouse_scroll() end

---Gets the value of the Modal property.
---@param self Dialog self
---@return boolean true If true, blocks all events outside the dialog
function Dialog:getModal(self) end

---Sets the value of the Title property.
---@param self Dialog self
---@param Title string The dialog title
function Dialog:setTitle(self, Title) end

---Sets the value of the SecondaryColor property.
---@param self Dialog self
---@param SecondaryColor color Secondary button color (Cancel, dismiss actions)
function Dialog:setSecondaryColor(self, SecondaryColor) end

---Handles mouse up events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dialog:mouse_up() end

---Handles mouse drag events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dialog:mouse_drag() end

---Handles mouse click events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Dialog:mouse_click() end

---Gets the value of the ButtonForeground property.
---@param self Dialog self
---@return color black Foreground color for buttons
function Dialog:getButtonForeground(self) end

---Gets the value of the Title property.
---@param self Dialog self
---@return string "" The dialog title
function Dialog:getTitle(self) end

---Creates a confirm dialog
---@param title string The dialog title
---@param message string The confirmation message
---@param callback function Callback (receives boolean result)
---@return Dialog self The Dialog instance
function Dialog:confirm(title, message, callback) end

---Closes the dialog
---@return Dialog self The Dialog instance
function Dialog:close() end

---Shows the dialog
---@return Dialog self The Dialog instance
function Dialog:show() end

---@class ScrollFrame : Container
---@field contentWidth number The total width of the content (calculated from children)
---@field contentHeight number The total height of the content (calculated from children)
---@field scrollBarBackgroundColor2 secondary black Background color of the scrollbar
---@field scrollBarBackgroundColor color Background color of the scrollbar
---@field scrollBarColor color Color of the scrollbar handle
---@field scrollBarSymbol string The symbol used for the scrollbar handle
---@field showScrollBar boolean Whether to show scrollbars
---@field scrollBarBackgroundSymbol string The symbol used for the scrollbar background
local ScrollFrame = {}

---Sets the value of the ScrollBarBackgroundColor property.
---@param self ScrollFrame self
---@param ScrollBarBackgroundColor color Background color of the scrollbar
function ScrollFrame:setScrollBarBackgroundColor(self, ScrollBarBackgroundColor) end

---Sets the value of the ScrollBarColor property.
---@param self ScrollFrame self
---@param ScrollBarColor color Color of the scrollbar handle
function ScrollFrame:setScrollBarColor(self, ScrollBarColor) end

---Handles mouse up events to stop scrollbar dragging
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x-coordinate of the release
---@param y number The y-coordinate of the release
---@return boolean Whether the event was handled
---@protected
function ScrollFrame:mouse_up(button, x, y) end

---Gets the value of the ScrollBarBackgroundSymbol property.
---@param self ScrollFrame self
---@return string "\127" The symbol used for the scrollbar background
function ScrollFrame:getScrollBarBackgroundSymbol(self) end

---Gets the value of the ScrollBarBackgroundColor2 property.
---@param self ScrollFrame self
---@return secondary color black Background color of the scrollbar
function ScrollFrame:getScrollBarBackgroundColor2(self) end

---Gets the value of the ContentHeight property.
---@param self ScrollFrame self
---@return number 0 The total height of the content (calculated from children)
function ScrollFrame:getContentHeight(self) end

---Sets the value of the ContentWidth property.
---@param self ScrollFrame self
---@param ContentWidth number The total width of the content (calculated from children)
function ScrollFrame:setContentWidth(self, ContentWidth) end

---Gets the value of the ScrollBarSymbol property.
---@param self ScrollFrame self
---@return string "_" The symbol used for the scrollbar handle
function ScrollFrame:getScrollBarSymbol(self) end

---Gets the value of the ScrollBarBackgroundColor property.
---@param self ScrollFrame self
---@return color gray Background color of the scrollbar
function ScrollFrame:getScrollBarBackgroundColor(self) end

---Renders the ScrollFrame and its scrollbars
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ScrollFrame:render() end

---Handles mouse scroll events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number 1 for up, -1 for down
---@param x number Mouse x position relative to element
---@param y number Mouse y position relative to element
---@return boolean Whether the event was handled
---@protected
function ScrollFrame:mouse_scroll(direction, x, y) end

---Handles mouse drag events for scrollbar
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x-coordinate of the drag
---@param y number The y-coordinate of the drag
---@return boolean Whether the event was handled
---@protected
function ScrollFrame:mouse_drag(button, x, y) end

---Handles mouse click events for scrollbars and content
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button (1=left, 2=right, 3=middle)
---@param x number The x-coordinate of the click
---@param y number The y-coordinate of the click
---@return boolean Whether the event was handled
---@protected
function ScrollFrame:mouse_click(button, x, y) end

---Gets the value of the ContentWidth property.
---@param self ScrollFrame self
---@return number 0 The total width of the content (calculated from children)
function ScrollFrame:getContentWidth(self) end

---Sets the value of the ScrollBarSymbol property.
---@param self ScrollFrame self
---@param ScrollBarSymbol string The symbol used for the scrollbar handle
function ScrollFrame:setScrollBarSymbol(self, ScrollBarSymbol) end

---Sets the value of the ContentHeight property.
---@param self ScrollFrame self
---@param ContentHeight number The total height of the content (calculated from children)
function ScrollFrame:setContentHeight(self, ContentHeight) end

---Sets the value of the ScrollBarBackgroundColor2 property.
---@param self ScrollFrame self
---@param ScrollBarBackgroundColor2 secondary black Background color of the scrollbar
function ScrollFrame:setScrollBarBackgroundColor2(self, ScrollBarBackgroundColor2) end

---Sets the value of the ShowScrollBar property.
---@param self ScrollFrame self
---@param ShowScrollBar boolean Whether to show scrollbars
function ScrollFrame:setShowScrollBar(self, ShowScrollBar) end

---Gets the value of the ShowScrollBar property.
---@param self ScrollFrame self
---@return boolean true Whether to show scrollbars
function ScrollFrame:getShowScrollBar(self) end

---Sets the value of the ScrollBarBackgroundSymbol property.
---@param self ScrollFrame self
---@param ScrollBarBackgroundSymbol string The symbol used for the scrollbar background
function ScrollFrame:setScrollBarBackgroundSymbol(self, ScrollBarBackgroundSymbol) end

---Gets the value of the ScrollBarColor property.
---@param self ScrollFrame self
---@return color lightGray Color of the scrollbar handle
function ScrollFrame:getScrollBarColor(self) end

---@class Label : VisualElement
---@field autoSize boolean Whether the label should automatically resize its width based on the text content
---@field text string The text content to display. Can be a string or a function that returns a string
local Label = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Label:render() end

---Sets the value of the AutoSize property.
---@param self Label self
---@param AutoSize boolean Whether the label should automatically resize its width based on the text content
function Label:setAutoSize(self, AutoSize) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Label self The initialized instance
---@protected
function Label:init(props, basalt) end

---Sets the value of the Text property.
---@param self Label self
---@param Text string The text content to display. Can be a string or a function that returns a string
function Label:setText(self, Text) end

---Gets the value of the Text property.
---@param self Label self
---@return string Label The text content to display. Can be a string or a function that returns a string
function Label:getText(self) end

---Gets the value of the AutoSize property.
---@param self Label self
---@return boolean true Whether the label should automatically resize its width based on the text content
function Label:getAutoSize(self) end

---Gets the wrapped lines of the Label
---@return table wrappedText The wrapped lines of the Label
function Label:getWrappedText() end

---@class Button : VisualElement
---@field text string Label text displayed centered within the button
local Button = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Button:render() end

---Sets the value of the Text property.
---@param self Button self
---@param Text string Label text displayed centered within the button
function Button:setText(self, Text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Button:init(props, basalt) end

---Gets the value of the Text property.
---@param self Button self
---@return string Button Label text displayed centered within the button
function Button:getText(self) end

---@class Timer : BaseElement
---@field action function The action to be performed when the timer triggers.
---@field amount number The amount of time the timer should run.
---@field interval number The interval in seconds at which the timer will trigger its action.
---@field running boolean Indicates whether the timer is currently running or not.
local Timer = {}

---Starts the timer with the specified interval.
---@param self Timer The Timer instance to start
---@return Timer self The Timer instance
function Timer:start(self) end

---Sets the value of the Action property.
---@param self Timer self
---@param Action function The action to be performed when the timer triggers.
function Timer:setAction(self, Action) end

---Gets the value of the Interval property.
---@param self Timer self
---@return number 1 The interval in seconds at which the timer will trigger its action.
function Timer:getInterval(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Timer:dispatchEvent() end

---Sets the value of the Interval property.
---@param self Timer self
---@param Interval number The interval in seconds at which the timer will trigger its action.
function Timer:setInterval(self, Interval) end

---Sets the value of the Amount property.
---@param self Timer self
---@param Amount number The amount of time the timer should run.
function Timer:setAmount(self, Amount) end

---Gets the value of the Amount property.
---@param self Timer self
---@return number -1 The amount of time the timer should run.
function Timer:getAmount(self) end

---Stops the timer if it is currently running.
---@param self Timer The Timer instance to stop
---@return Timer self The Timer instance
function Timer:stop(self) end

---Gets the value of the Running property.
---@param self Timer self
---@return boolean false Indicates whether the timer is currently running or not.
function Timer:getRunning(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Timer:init(props, basalt) end

---Sets the value of the Running property.
---@param self Timer self
---@param Running boolean Indicates whether the timer is currently running or not.
function Timer:setRunning(self, Running) end

---Gets the value of the Action property.
---@param self Timer self
---@return function function The action to be performed when the timer triggers.
function Timer:getAction(self) end

---@class BigFontText
local BigFontText = {}

---@class ThemeAPI
local ThemeAPI = {}

---Sets the current theme
---@param newTheme table The theme configuration to set
function ThemeAPI.setTheme(newTheme) end

---Loads a theme from a JSON file
---@param path string Path to the theme JSON file
function ThemeAPI.loadTheme(path) end

---Gets the current theme configuration
---@return table theme The current theme configuration
function ThemeAPI.getTheme() end

---@class Image : VisualElement
---@field currentFrame number Current animation frame
---@field offsetY number Vertical offset for viewing larger images
---@field offsetX number Horizontal offset for viewing larger images
---@field autoResize boolean Whether to automatically resize the image when content exceeds bounds
---@field bimg table The bimg image data
local Image = {}

---Sets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param text string The text to set
---@return Image self The Image instance
function Image:setText(x, y, text) end

---Sets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The background color pattern
---@return Image self The Image instance
function Image:setBg(x, y, pattern) end

---Gets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the text to get
---@return string text The text at the specified position
function Image:getText(x, y, length) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Image:render() end

---Gets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the foreground color pattern to get
---@return string fg The foreground color pattern
function Image:getFg(x, y, length) end

---Gets the metadata of the image
---@return table metadata The metadata of the image
function Image:getMetadata() end

---Gets the size of the image
---@return number width The width of the image
---@return number height The height of the image
function Image:getImageSize() end

---Gets pixel information at position
---@param x number X position
---@param y number Y position
---@return number ? fg Foreground color
---@return number ? bg Background color
---@return string ? char Character at position
function Image:getPixelData(x, y) end

---Gets the value of the OffsetY property.
---@param self Image self
---@return number 0 Vertical offset for viewing larger images
function Image:getOffsetY(self) end

---Gets the specified frame
---@param frameIndex number The index of the frame to get
---@return table frame The frame data
function Image:getFrame(frameIndex) end

---Sets the value of the OffsetY property.
---@param self Image self
---@param OffsetY number Vertical offset for viewing larger images
function Image:setOffsetY(self, OffsetY) end

---Updates the specified frame with the provided data
---@param frameIndex number The index of the frame to update
---@param frame table The new frame data
---@return Image self The Image instance
function Image:updateFrame(frameIndex, frame) end

---Adds a new frame to the image
---@return Image self The Image instance
function Image:addFrame() end

---Sets the pixel at the specified position
---@param x number The x position
---@param y number The y position
---@param char string The character to set
---@param fg string The foreground color pattern
---@param bg string The background color pattern
---@return Image self The Image instance
function Image:setPixel(x, y, char, fg, bg) end

---Advances to the next frame in the animation
---@return Image self The Image instance
function Image:nextFrame() end

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

---Gets the value of the AutoResize property.
---@param self Image self
---@return boolean false Whether to automatically resize the image when content exceeds bounds
function Image:getAutoResize(self) end

---Sets the value of the AutoResize property.
---@param self Image self
---@param AutoResize boolean Whether to automatically resize the image when content exceeds bounds
function Image:setAutoResize(self, AutoResize) end

---Resizes the image to the specified width and height
---@param width number The new width of the image
---@param height number The new height of the image
---@return Image self The Image instance
function Image:resizeImage(width, height) end

---Gets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the background color pattern to get
---@return string bg The background color pattern
function Image:getBg(x, y, length) end

---Sets the metadata of the image
---@param key string The key of the metadata to set
---@param value string The value of the metadata to set
---@return Image self The Image instance
function Image:setMetadata(key, value) end

---Gets the value of the OffsetX property.
---@param self Image self
---@return number 0 Horizontal offset for viewing larger images
function Image:getOffsetX(self) end

---Gets the value of the CurrentFrame property.
---@param self Image self
---@return number 1 Current animation frame
function Image:getCurrentFrame(self) end

---Sets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The foreground color pattern
---@return Image self The Image instance
function Image:setFg(x, y, pattern) end

---Sets the value of the Bimg property.
---@param self Image self
---@param Bimg table The bimg image data
function Image:setBimg(self, Bimg) end

---Sets the value of the OffsetX property.
---@param self Image self
---@param OffsetX number Horizontal offset for viewing larger images
function Image:setOffsetX(self, OffsetX) end

---Gets the value of the Bimg property.
---@param self Image self
---@return table {} The bimg image data
function Image:getBimg(self) end

---@class Accordion : Container
---@field panels table List of panel definitions
---@field panelHeaderHeight number Height of each panel header
---@field allowMultiple boolean Allow multiple panels to be open at once
---@field headerBackground color Background color for panel headers
---@field expandedHeaderTextColor color Text color for expanded panel headers
---@field headerTextColor color Text color for panel headers
---@field expandedHeaderBackground color Background color for expanded panel headers
local Accordion = {}

---Gets the value of the HeaderBackground property.
---@param self Accordion self
---@return color gray Background color for panel headers
function Accordion:getHeaderBackground(self) end

---Gets the value of the Panels property.
---@param self Accordion self
---@return table {} List of panel definitions
function Accordion:getPanels(self) end

---Sets the value of the HeaderBackground property.
---@param self Accordion self
---@param HeaderBackground color Background color for panel headers
function Accordion:setHeaderBackground(self, HeaderBackground) end

---Sets the value of the PanelHeaderHeight property.
---@param self Accordion self
---@param PanelHeaderHeight number Height of each panel header
function Accordion:setPanelHeaderHeight(self, PanelHeaderHeight) end

---Creates a new panel and returns the panel's container
---@param title string The title of the panel
---@param expanded boolean Whether the panel starts expanded (default: false)
---@return table panelContainer The container for this panel
function Accordion:newPanel(title, expanded) end

---Sets the value of the ExpandedHeaderBackground property.
---@param self Accordion self
---@param ExpandedHeaderBackground color Background color for expanded panel headers
function Accordion:setExpandedHeaderBackground(self, ExpandedHeaderBackground) end

---@param panelId number The ID of the panel to collapse
---@return Accordion self For method chaining
function Accordion:collapsePanel(panelId) end

---@param panelId number The ID of the panel to toggle
---@return Accordion self For method chaining
function Accordion:togglePanel(panelId) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Accordion:render() end

---Gets the value of the AllowMultiple property.
---@param self Accordion self
---@return boolean false Allow multiple panels to be open at once
function Accordion:getAllowMultiple(self) end

function Accordion:mouse_scroll() end

---Sets the value of the Panels property.
---@param self Accordion self
---@param Panels table List of panel definitions
function Accordion:setPanels(self, Panels) end

---Gets the value of the ExpandedHeaderTextColor property.
---@param self Accordion self
---@return color black Text color for expanded panel headers
function Accordion:getExpandedHeaderTextColor(self) end

---@param panelId number The ID of the panel to expand
---@return Accordion self For method chaining
function Accordion:expandPanel(panelId) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click (global)
---@param y number The y position of the click (global)
---@return boolean Whether the event was handled
---@protected
function Accordion:mouse_click(button, x, y) end

---Gets the value of the ExpandedHeaderBackground property.
---@param self Accordion self
---@return color lightGray Background color for expanded panel headers
function Accordion:getExpandedHeaderBackground(self) end

---@param panelId number The ID of the panel
---@return table ? container The panel's container or nil
function Accordion:getPanel(panelId) end

---Sets the value of the HeaderTextColor property.
---@param self Accordion self
---@param HeaderTextColor color Text color for panel headers
function Accordion:setHeaderTextColor(self, HeaderTextColor) end

---Sets the value of the AllowMultiple property.
---@param self Accordion self
---@param AllowMultiple boolean Allow multiple panels to be open at once
function Accordion:setAllowMultiple(self, AllowMultiple) end

---Gets the value of the HeaderTextColor property.
---@param self Accordion self
---@return color white Text color for panel headers
function Accordion:getHeaderTextColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Accordion:init(props, basalt) end

---Gets the value of the PanelHeaderHeight property.
---@param self Accordion self
---@return number 1 Height of each panel header
function Accordion:getPanelHeaderHeight(self) end

---Sets the value of the ExpandedHeaderTextColor property.
---@param self Accordion self
---@param ExpandedHeaderTextColor color Text color for expanded panel headers
function Accordion:setExpandedHeaderTextColor(self, ExpandedHeaderTextColor) end

---@class VisualElement : BaseElement
---@field foreground color The text/foreground color
---@field height number The height of the element
---@field width number The width of the element
---@field background color The background color
---@field layoutConfig table Configuration for layout systems (grow, shrink, alignSelf, etc.)
---@field borderTop boolean Draw top border
---@field x number The horizontal position relative to parent
---@field y number The vertical position relative to parent
---@field z number The z-index for layering elements
---@field borderRight boolean Draw right border
---@field borderBottom boolean Draw bottom border
---@field ignoreOffset boolean Whether to ignore the parent's offset
---@field borderLeft boolean Draw left border
---@field backgroundEnabled boolean Whether to render the background
---@field visible boolean Whether the element is visible
---@field borderColor color Border color
local VisualElement = {}

---Positions the element to the right of the target with optional gap
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:rightOf(target) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked while dragging
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean drag Whether the element was dragged
---@protected
function VisualElement:mouse_drag(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg color The foreground color
---@protected
function VisualElement:textFg(x, y, text, fg) end

---Aligns the element's top edge to the target's top edge with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:alignTop(target) end

---Sets the value of the Height property.
---@param self VisualElement self
---@param Height number The height of the element
function VisualElement:setHeight(self, Height) end

---Sets the value of the Y property.
---@param self VisualElement self
---@param Y number The vertical position relative to parent
function VisualElement:setY(self, Y) end

---Centers the element both horizontally and vertically relative to the target
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:centerIn(target) end

---Aligns the element's bottom edge to the target's bottom edge with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:alignBottom(target) end

function VisualElement:drawText() end

---Matches the element's height to the target's height with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:matchHeight(target) end

---Centers the element horizontally relative to the target with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:centerHorizontal(target) end

---Sets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@param BackgroundEnabled boolean Whether to render the background
function VisualElement:setBackgroundEnabled(self, BackgroundEnabled) end

---Stretches the element to match the target's width and height with optional margin
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:stretch(target) end

---Registers a function to handle the onLeave event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnLeave(self, func) end

---Sets the value of the BorderRight property.
---@param self VisualElement self
---@param BorderRight boolean Draw right border
function VisualElement:setBorderRight(self, BorderRight) end

---Aligns the element's right edge to the target's right edge with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:alignRight(target) end

function VisualElement:destroy() end

---Gets the value of the BorderTop property.
---@param self VisualElement self
---@return boolean false Draw top border
function VisualElement:getBorderTop(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean release Whether the element was released on the element
---@protected
function VisualElement:mouse_up(button, x, y) end

---Gets the value of the LayoutConfig property.
---@param self VisualElement self
---@return table {} Configuration for layout systems (grow, shrink, alignSelf, etc.)
function VisualElement:getLayoutConfig(self) end

---Convenience to stop animations from the element
function VisualElement.stopAnimation() end

---Sets the value of the IgnoreOffset property.
---@param self VisualElement self
---@param IgnoreOffset boolean Whether to ignore the parent's offset
function VisualElement:setIgnoreOffset(self, IgnoreOffset) end

---Sets the value of the BorderBottom property.
---@param self VisualElement self
---@param BorderBottom boolean Draw bottom border
function VisualElement:setBorderBottom(self, BorderBottom) end

---Registers a function to handle the onKeyUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKeyUp(self, func) end

---Gets the value of the BorderLeft property.
---@param self VisualElement self
---@return boolean false Draw left border
function VisualElement:getBorderLeft(self) end

---Aligns the element's bottom edge to its parent's bottom edge with optional gap
---@return VisualElement self
function VisualElement:toBottom() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg string The foreground color
---@param bg string The background color
---@protected
function VisualElement:blit(x, y, text, fg, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function VisualElement:init(props, basalt) end

---Sets a constraint on a property relative to another element's property
---@param property string The property to constrain (x, y, width, height, left, right, top, bottom, centerX, centerY)
---@param targetElement BaseElement |string The target element or "parent"
---@param targetProperty string The target property to constrain to (left, right, top, bottom, centerX, centerY, width, height)
---@param offset number The offset to apply (negative = inside, positive = outside, fractional = percentage)
---@return VisualElement self The element instance
function VisualElement:setConstraint(property, targetElement, targetProperty, offset) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean clicked Whether the element was clicked
---@protected
function VisualElement:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function VisualElement:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param bg color The background color
---@protected
function VisualElement:textBg(x, y, text, bg) end

---Sets the value of the Foreground property.
---@param self VisualElement self
---@param Foreground color The text/foreground color
function VisualElement:setForeground(self, Foreground) end

---Registers a function to handle the onEnter event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnEnter(self, func) end

---Registers a function to handle the onKey event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKey(self, func) end

---Positions the element above the target with optional gap
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:above(target) end

---Registers a function to handle the onScroll event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnScroll(self, func) end

---Calculates the position of the element relative to its parent
---@return number x The x position
---@return number y The y position
function VisualElement:calculatePosition() end

---Registers a function to handle the onBlur event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnBlur(self, func) end

---Stretches the element to match the target's height with optional margin
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:stretchHeight(target) end

---Registers a function to handle the onDrag event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnDrag(self, func) end

---Gets the value of the Foreground property.
---@param self VisualElement self
---@return color white The text/foreground color
function VisualElement:getForeground(self) end

---Gets the value of the Width property.
---@param self VisualElement self
---@return number 1 The width of the element
function VisualElement:getWidth(self) end

---Aligns the element's top edge to its parent's top edge with optional gap
---@return VisualElement self
function VisualElement:toTop() end

function VisualElement:drawBg() end

---Gets the value of the IgnoreOffset property.
---@param self VisualElement self
---@return boolean false Whether to ignore the parent's offset
function VisualElement:getIgnoreOffset(self) end

---Returns the absolute position of the element or the given coordinates.
---@return number x The absolute x position
---@return number y The absolute y position
function VisualElement:getAbsolutePosition() end

---Gets the value of the X property.
---@param self VisualElement self
---@return number 1 The horizontal position relative to parent
function VisualElement:getX(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function VisualElement:key(key) end

---Returns the relative position of the element or the given coordinates.
---@return number x The relative x position
---@return number y The relative y position
function VisualElement:getRelativePosition() end

---Sets the value of the X property.
---@param self VisualElement self
---@param X number The horizontal position relative to parent
function VisualElement:setX(self, X) end

---Sets the value of the BorderLeft property.
---@param self VisualElement self
---@param BorderLeft boolean Draw left border
function VisualElement:setBorderLeft(self, BorderLeft) end

---Resolves all constraints for the element
---@return VisualElement self The element instance
function VisualElement:resolveAllConstraints() end

---This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.
---@return VisualElement self The VisualElement instance
function VisualElement:prioritize() end

---Gets the value of the BorderBottom property.
---@param self VisualElement self
---@return boolean false Draw bottom border
function VisualElement:getBorderBottom(self) end

---Updates all constraints, recalculating positions and sizes
---@return VisualElement self The element instance
function VisualElement:updateConstraints() end

---Removes the previously added border (if any)
---@return VisualElement self
function VisualElement:removeBorder() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:focus() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
---@return VisualElement self The VisualElement instance
---@protected
function VisualElement:setCursor(x, y, blink, color) end

---Gets a single property from the layoutConfig table
---@param key string The layout config property to get
---@return any value The value of the property, or nil if not set
function VisualElement:getLayoutConfigProperty(key) end

---Centers the element vertically relative to the target with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:centerVertical(target) end

---Sets the value of the Background property.
---@param self VisualElement self
---@param Background color The background color
function VisualElement:setBackground(self, Background) end

---Positions the element to the left of the target with optional gap
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:leftOf(target) end

---Gets whether this element is focused
---@return boolean isFocused
function VisualElement:isFocused() end

---Centers the element within its parent both horizontally and vertically
---@return VisualElement self
function VisualElement:center() end

---Sets the element's width as a percentage of the target's width
---@param target BaseElement |string The target element or "parent"
---@param percent number Percentage of target's width (0-100)
---@return VisualElement self
function VisualElement:widthPercent(target, percent) end

---Creates a new Animation Object
---@return Animation animation The new animation
function VisualElement:animate() end

function VisualElement:drawFg() end

---Registers a function to handle the onFocus event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnFocus(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean scroll Whether the element was scrolled
---@protected
function VisualElement:mouse_scroll(direction, x, y) end

---Gets the value of the Height property.
---@param self VisualElement self
---@return number 1 The height of the element
function VisualElement:getHeight(self) end

---Registers a function to handle the onChar event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnChar(self, func) end

---Sets the value of the LayoutConfig property.
---@param self VisualElement self
---@param LayoutConfig table Configuration for layout systems (grow, shrink, alignSelf, etc.)
function VisualElement:setLayoutConfig(self, LayoutConfig) end

---Stretches the element to fill its parent's height with optional margin
---@return VisualElement self
function VisualElement:fillHeight() end

---Aligns the element's left edge to its parent's left edge with optional gap
---@return VisualElement self
function VisualElement:toLeft() end

---Stretches the element to match the target's width with optional margin
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:stretchWidth(target) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:blur() end

---Positions the element below the target with optional gap
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:below(target) end

---Gets the value of the Y property.
---@param self VisualElement self
---@return number 1 The vertical position relative to parent
function VisualElement:getY(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@return boolean hover Whether the mouse has moved over the element
---@protected
function VisualElement:mouse_move(_, x, y) end

---Registers a function to handle the onClickUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnClickUp(self, func) end

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

---Sets the element's height as a percentage of the target's height
---@param target BaseElement |string The target element or "parent"
---@param percent number Percentage of target's height (0-100)
---@return VisualElement self
function VisualElement:heightPercent(target, percent) end

---Sets the value of the Width property.
---@param self VisualElement self
---@param Width number The width of the element
function VisualElement:setWidth(self, Width) end

---Gets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@return boolean true Whether to render the background
function VisualElement:getBackgroundEnabled(self) end

---Gets the value of the Background property.
---@param self VisualElement self
---@return color black The background color
function VisualElement:getBackground(self) end

---Updates a single property in the layoutConfig table
---@param key string The layout config property to update (grow, shrink, basis, alignSelf, order, etc.)
---@param value any The value to set for the property
---@return VisualElement self The element instance
function VisualElement:setLayoutConfigProperty(key, value) end

---Checks if the specified coordinates are within the bounds of the element
---@param x number The x position to check
---@param y number The y position to check
---@return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y) end

---Gets the value of the Z property.
---@param self VisualElement self
---@return number 1 The z-index for layering elements
function VisualElement:getZ(self) end

---Aligns the element's left edge to the target's left edge with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:alignLeft(target) end

---Sets the value of the Visible property.
---@param self VisualElement self
---@param Visible boolean Whether the element is visible
function VisualElement:setVisible(self, Visible) end

---Sets or removes focus from this element
---@param focused boolean Whether to focus or blur
---@return VisualElement self
function VisualElement:setFocused(focused) end

---Matches the element's width to the target's width with optional offset
---@param target BaseElement |string The target element or "parent"
---@return VisualElement self
function VisualElement:matchWidth(target) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:render() end

---Gets the value of the Visible property.
---@param self VisualElement self
---@return boolean true Whether the element is visible
function VisualElement:getVisible(self) end

---Aligns the element's right edge to its parent's right edge with optional gap
---@return VisualElement self
function VisualElement:toRight() end

---Gets the value of the BorderRight property.
---@param self VisualElement self
---@return boolean false Draw right border
function VisualElement:getBorderRight(self) end

---Registers a function to handle the onClick event.
---@param button string
---@param x number
---@param y number
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnClick(self, func) end

---Removes a constraint from the element
---@param property string The property of the constraint to remove
---@return VisualElement self The element instance
function VisualElement:removeConstraint(property) end

---Sets the value of the Z property.
---@param self VisualElement self
---@param Z number The z-index for layering elements
function VisualElement:setZ(self, Z) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:postRender() end

---Stretches the element to fill its parent's width and height with optional margin
---@return VisualElement self
function VisualElement:fillParent() end

---Adds or updates a drawable character border around the element. The border will automatically adapt to size/background changes because the command reads current properties each render.
---@param colorOrOptions any Border color or options table
---@return VisualElement self
function VisualElement:addBorder(colorOrOptions) end

---Stretches the element to fill its parent's width with optional margin
---@return VisualElement self
function VisualElement:fillWidth() end

---Sets the value of the BorderColor property.
---@param self VisualElement self
---@param BorderColor color Border color
function VisualElement:setBorderColor(self, BorderColor) end

---Gets the value of the BorderColor property.
---@param self VisualElement self
---@return color white Border color
function VisualElement:getBorderColor(self) end

---Sets the value of the BorderTop property.
---@param self VisualElement self
---@param BorderTop boolean Draw top border
function VisualElement:setBorderTop(self, BorderTop) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function VisualElement:key_up(key) end

---@class ScrollBar : VisualElement
---@field min number Minimum scroll value
---@field symbolBackgroundColor color Background color of the ScrollBar handle
---@field value number Current scroll value
---@field attachedProperty string nil The property being controlled
---@field dragMultiplier number How fast the ScrollBar moves when dragging
---@field handleSize number Size of the ScrollBar handle in characters
---@field orientation string Orientation of the ScrollBar ("vertical" or "horizontal")
---@field maxValue number 100 Maximum value or function that returns it
---@field symbol string " Symbol used for the ScrollBar handle
---@field attachedElement table nil The element this ScrollBar is attached to
---@field minValue number 0 Minimum value or function that returns it
---@field step number Step size for scroll operations
---@field backgroundSymbol string Symbol used for the ScrollBar background
---@field max number Maximum scroll value
local ScrollBar = {}

---Sets the value of the AttachedProperty property.
---@param self ScrollBar self
---@param AttachedProperty string nil The property being controlled
function ScrollBar:setAttachedProperty(self, AttachedProperty) end

---Sets the value of the Step property.
---@param self ScrollBar self
---@param Step number Step size for scroll operations
function ScrollBar:setStep(self, Step) end

---Gets the value of the Orientation property.
---@param self ScrollBar self
---@return string vertical Orientation of the ScrollBar ("vertical" or "horizontal")
function ScrollBar:getOrientation(self) end

---Gets the value of the AttachedProperty property.
---@param self ScrollBar self
---@return string ? nil The property being controlled
function ScrollBar:getAttachedProperty(self) end

---Sets the value of the SymbolBackgroundColor property.
---@param self ScrollBar self
---@param SymbolBackgroundColor color Background color of the ScrollBar handle
function ScrollBar:setSymbolBackgroundColor(self, SymbolBackgroundColor) end

---Gets the value of the DragMultiplier property.
---@param self ScrollBar self
---@return number 1 How fast the ScrollBar moves when dragging
function ScrollBar:getDragMultiplier(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_click(button, x, y) end

---Gets the value of the Symbol property.
---@param self ScrollBar self
---@return string " " Symbol used for the ScrollBar handle
function ScrollBar:getSymbol(self) end

---Updates the attached element's property based on the ScrollBar value
---@return ScrollBar self The ScrollBar instance
function ScrollBar:updateAttachedElement() end

---Sets the value of the Max property.
---@param self ScrollBar self
---@param Max number Maximum scroll value
function ScrollBar:setMax(self, Max) end

---Gets the value of the Max property.
---@param self ScrollBar self
---@return number 100 Maximum scroll value
function ScrollBar:getMax(self) end

---Gets the value of the MaxValue property.
---@param self ScrollBar self
---@return number |function 100 Maximum value or function that returns it
function ScrollBar:getMaxValue(self) end

---Sets the value of the HandleSize property.
---@param self ScrollBar self
---@param HandleSize number Size of the ScrollBar handle in characters
function ScrollBar:setHandleSize(self, HandleSize) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_scroll(direction, x, y) end

---Gets the value of the Step property.
---@param self ScrollBar self
---@return number 1 Step size for scroll operations
function ScrollBar:getStep(self) end

---Sets the value of the Orientation property.
---@param self ScrollBar self
---@param Orientation string Orientation of the ScrollBar ("vertical" or "horizontal")
function ScrollBar:setOrientation(self, Orientation) end

---Sets the value of the Value property.
---@param self ScrollBar self
---@param Value number Current scroll value
function ScrollBar:setValue(self, Value) end

---Gets the value of the SymbolBackgroundColor property.
---@param self ScrollBar self
---@return color black Background color of the ScrollBar handle
function ScrollBar:getSymbolBackgroundColor(self) end

---Gets the value of the Min property.
---@param self ScrollBar self
---@return number 0 Minimum scroll value
function ScrollBar:getMin(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_drag(button, x, y) end

---Gets the value of the AttachedElement property.
---@param self ScrollBar self
---@return table ? nil The element this ScrollBar is attached to
function ScrollBar:getAttachedElement(self) end

---Sets the value of the MinValue property.
---@param self ScrollBar self
---@param MinValue number 0 Minimum value or function that returns it
function ScrollBar:setMinValue(self, MinValue) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ScrollBar:render() end

---Gets the value of the BackgroundSymbol property.
---@param self ScrollBar self
---@return string "\127" Symbol used for the ScrollBar background
function ScrollBar:getBackgroundSymbol(self) end

---Sets the value of the Symbol property.
---@param self ScrollBar self
---@param Symbol string " Symbol used for the ScrollBar handle
function ScrollBar:setSymbol(self, Symbol) end

---Sets the value of the BackgroundSymbol property.
---@param self ScrollBar self
---@param BackgroundSymbol string Symbol used for the ScrollBar background
function ScrollBar:setBackgroundSymbol(self, BackgroundSymbol) end

---Sets the value of the DragMultiplier property.
---@param self ScrollBar self
---@param DragMultiplier number How fast the ScrollBar moves when dragging
function ScrollBar:setDragMultiplier(self, DragMultiplier) end

---Sets the value of the MaxValue property.
---@param self ScrollBar self
---@param MaxValue number 100 Maximum value or function that returns it
function ScrollBar:setMaxValue(self, MaxValue) end

---Sets the value of the Min property.
---@param self ScrollBar self
---@param Min number Minimum scroll value
function ScrollBar:setMin(self, Min) end

---Sets the value of the AttachedElement property.
---@param self ScrollBar self
---@param AttachedElement table nil The element this ScrollBar is attached to
function ScrollBar:setAttachedElement(self, AttachedElement) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ScrollBar self The initialized instance
---@protected
function ScrollBar:init(props, basalt) end

---Gets the value of the MinValue property.
---@param self ScrollBar self
---@return number |function 0 Minimum value or function that returns it
function ScrollBar:getMinValue(self) end

---Gets the value of the Value property.
---@param self ScrollBar self
---@return number 0 Current scroll value
function ScrollBar:getValue(self) end

---Attaches the ScrollBar to an element's property
---@param element BaseElement The element to attach to
---@param config table Configuration {property = "propertyName", min = number|function, max = number|function}
---@return ScrollBar self The ScrollBar instance
function ScrollBar:attach(element, config) end

---Gets the value of the HandleSize property.
---@param self ScrollBar self
---@return number 2 Size of the ScrollBar handle in characters
function ScrollBar:getHandleSize(self) end

---@class Render
local Render = {}

---Blits a background color to the screen
---@param x number The x position
---@param y number The y position
---@param bg string The background color to blit
---@return Render 
function Render:bg(x, y, bg) end

---Checks if two rectangles overlap
---@param r1 table The first rectangle
---@param r2 table The second rectangle
---@return boolean 
function Render:rectOverlaps(r1, r2) end

---Gets the size of the render
---@return number , number
function Render:getSize() end

---Merges two rectangles
---@param target table The target rectangle
---@param source table The source rectangle
---@return Render 
function Render:mergeRects(target, source) end

---Renders the buffer to the screen
---@return Render 
function Render:render() end

---Blits text to the screen with a foreground color
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param fg colors The foreground color of the text
---@return Render 
function Render:textFg(x, y, text, fg) end

---Creates a new Render object
---@param terminal table The terminal object to render to
---@return Render 
function Render.new(terminal) end

---Blits a foreground color to the screen
---@param x number The x position
---@param y number The y position
---@param fg string The foreground color to blit
---@return Render 
function Render:fg(x, y, fg) end

---Adds a dirty rectangle to the buffer
---@param x number The x position of the rectangle
---@param y number The y position of the rectangle
---@param width number The width of the rectangle
---@param height number The height of the rectangle
---@return Render 
function Render:addDirtyRect(x, y, width, height) end

---Blits text to the screen
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Render 
function Render:blit(x, y, text, fg, bg) end

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

---Sets the size of the render
---@param width number The width of the render
---@param height number The height of the render
---@return Render 
function Render:setSize(width, height) end

---Sets the cursor position
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@return Render 
function Render:setCursor(x, y, blink) end

---Blits text to the screen with a background color
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param bg colors The background color of the text
---@return Render 
function Render:textBg(x, y, text, bg) end

---Clears an area of the screen
---@param x number The x position of the area
---@param y number The y position of the area
---@param width number The width of the area
---@param height number The height of the area
---@param bg colors The background color to clear the area with
---@return Render 
function Render:clearArea(x, y, width, height, bg) end

---@class DropDown : List
---@field dropdownHeight number Maximum visible items when expanded
---@field selectedText string Text shown when no selection made
---@field dropSymbol string Indicator for dropdown state
---@field undropSymbol string Indicator for dropdown state
local DropDown = {}

---Called when the DropDown loses focus
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function DropDown:blur() end

---Gets the value of the DropSymbol property.
---@param self DropDown self
---@return string "\31" Indicator for dropdown state
function DropDown:getDropSymbol(self) end

---Gets the value of the SelectedText property.
---@param self DropDown self
---@return string "" Text shown when no selection made
function DropDown:getSelectedText(self) end

---Sets the value of the DropSymbol property.
---@param self DropDown self
---@param DropSymbol string Indicator for dropdown state
function DropDown:setDropSymbol(self, DropSymbol) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x-coordinate of the release
---@param y number The y-coordinate of the release
---@return boolean Whether the event was handled
---@protected
function DropDown:mouse_up(button, x, y) end

---Gets the value of the UndropSymbol property.
---@param self DropDown self
---@return string "\31" Indicator for dropdown state
function DropDown:getUndropSymbol(self) end

---Sets the value of the UndropSymbol property.
---@param self DropDown self
---@param UndropSymbol string Indicator for dropdown state
function DropDown:setUndropSymbol(self, UndropSymbol) end

---Gets the value of the DropdownHeight property.
---@param self DropDown self
---@return number 5 Maximum visible items when expanded
function DropDown:getDropdownHeight(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function DropDown:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x-coordinate of the drag
---@param y number The y-coordinate of the drag
---@return boolean Whether the event was handled
---@protected
function DropDown:mouse_drag(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function DropDown:render() end

---Sets the value of the DropdownHeight property.
---@param self DropDown self
---@param DropdownHeight number Maximum visible items when expanded
function DropDown:setDropdownHeight(self, DropdownHeight) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return DropDown self The initialized instance
---@protected
function DropDown:init(props, basalt) end

---Called when the DropDown gains focus
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function DropDown:focus() end

---Sets the value of the SelectedText property.
---@param self DropDown self
---@param SelectedText string Text shown when no selection made
function DropDown:setSelectedText(self, SelectedText) end

---@class ComboBox : DropDown
---@field editable boolean Enables direct text input in the field
---@field text string The current text value of the input field
---@field cursorPos number Current cursor position in the text input
---@field autoComplete boolean Enables filtering dropdown items while typing
---@field viewOffset number Horizontal scroll position for viewing long text
---@field manuallyOpened boolean Indicates if dropdown was opened by user action
local ComboBox = {}

---Sets the value of the CursorPos property.
---@param self ComboBox self
---@param CursorPos number Current cursor position in the text input
function ComboBox:setCursorPos(self, CursorPos) end

---Handles mouse up events for item selection
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x-coordinate of the release
---@param y number The y-coordinate of the release
---@return boolean handled Whether the event was handled
---@protected
function ComboBox:mouse_up(button, x, y) end

---Sets the value of the AutoComplete property.
---@param self ComboBox self
---@param AutoComplete boolean Enables filtering dropdown items while typing
function ComboBox:setAutoComplete(self, AutoComplete) end

---Sets the value of the ManuallyOpened property.
---@param self ComboBox self
---@param ManuallyOpened boolean Indicates if dropdown was opened by user action
function ComboBox:setManuallyOpened(self, ManuallyOpened) end

---Gets the value of the ViewOffset property.
---@param self ComboBox self
---@return number 0 Horizontal scroll position for viewing long text
function ComboBox:getViewOffset(self) end

---Sets the value of the Editable property.
---@param self ComboBox self
---@param Editable boolean Enables direct text input in the field
function ComboBox:setEditable(self, Editable) end

---Sets the value of the ViewOffset property.
---@param self ComboBox self
---@param ViewOffset number Horizontal scroll position for viewing long text
function ComboBox:setViewOffset(self, ViewOffset) end

---Handles mouse clicks
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button (1 = left, 2 = right, 3 = middle)
---@param x number The x coordinate of the click
---@param y number The y coordinate of the click
---@return boolean handled Whether the event was handled
---@protected
function ComboBox:mouse_click(button, x, y) end

---Gets the value of the ManuallyOpened property.
---@param self ComboBox self
---@return boolean false Indicates if dropdown was opened by user action
function ComboBox:getManuallyOpened(self) end

---Gets the value of the Text property.
---@param self ComboBox self
---@return string "" The current text value of the input field
function ComboBox:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ComboBox self The initialized instance
---@protected
function ComboBox:init(props, basalt) end

---Gets the value of the Editable property.
---@param self ComboBox self
---@return boolean true Enables direct text input in the field
function ComboBox:getEditable(self) end

---Handles key input when editable
---@param key number The key code that was pressed
---@param held boolean Whether the key is being held
function ComboBox:key(key, held) end

---Creates a new ComboBox instance
---@return ComboBox self The newly created ComboBox instance
function ComboBox.new() end

---Handles character input when editable
---@param char string The character that was typed
function ComboBox:char(char) end

---Renders the ComboBox
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ComboBox:render() end

---Gets the value of the CursorPos property.
---@param self ComboBox self
---@return number 1 Current cursor position in the text input
function ComboBox:getCursorPos(self) end

---Sets the value of the Text property.
---@param self ComboBox self
---@param Text string The current text value of the input field
function ComboBox:setText(self, Text) end

---Gets the value of the AutoComplete property.
---@param self ComboBox self
---@return boolean false Enables filtering dropdown items while typing
function ComboBox:getAutoComplete(self) end

function ComboBox:selectItem() end

---@class Graph : VisualElement
---@field series table The series of the graph
---@field minValue number The minimum value of the graph
---@field maxValue number The maximum value of the graph
local Graph = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Graph:render() end

---Gets the value of the MaxValue property.
---@param self Graph self
---@return number 100 The maximum value of the graph
function Graph:getMaxValue(self) end

---@param name string The name of the series
---@param value number The value of the point
---@return Graph self The graph instance
function Graph:addPoint(name, value) end

---Gets the value of the MinValue property.
---@param self Graph self
---@return number 0 The minimum value of the graph
function Graph:getMinValue(self) end

---@param name string The name of the series
---@param count number The number of points in the series
---@return Graph self The graph instance
function Graph:setSeriesPointCount(name, count) end

---Sets the value of the MinValue property.
---@param self Graph self
---@param MinValue number The minimum value of the graph
function Graph:setMinValue(self, MinValue) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:focusSeries(name) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:removeSeries(name) end

---@param name string The name of the series
---@param symbol string The symbol of the series
---@param bgCol number The background color of the series
---@param fgCol number The foreground color of the series
---@param pointCount number The number of points in the series
---@return Graph self The graph instance
function Graph:addSeries(name, symbol, bgCol, fgCol, pointCount) end

---@param name string The name of the series
---@param visible boolean Whether the series should be visible
---@return Graph self The graph instance
function Graph:changeSeriesVisibility(name, visible) end

---Sets the value of the MaxValue property.
---@param self Graph self
---@param MaxValue number The maximum value of the graph
function Graph:setMaxValue(self, MaxValue) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Graph self The initialized instance
---@protected
function Graph:init(props, basalt) end

---Sets the value of the Series property.
---@param self Graph self
---@param Series table The series of the graph
function Graph:setSeries(self, Series) end

---Clears all points from a series
---@return Graph self The graph instance
function Graph:clear() end

---@param name string The name of the series
---@return table ? series The series
function Graph:getSeries(name) end

---@class BaseElement : PropertySystem
---@field type string A hierarchical identifier of the element's type chain
---@field name string User-defined name for the element
---@field id string Auto-generated unique identifier for element lookup
---@field enabled boolean Controls event processing for this element
---@field eventCallbacks table Collection of registered event handler functions
---@field states table Table of currently active states with their priorities
local BaseElement = {}

---Dumps debug information for this element
---@param self BaseElement The element to dump debug info for
function BaseElement.dumpDebug(self) end

---Removes the element from UI tree and cleans up resources
function BaseElement:destroy() end

---Checks if a state is currently active
---@param stateName string The state to check
---@return boolean isActive
function BaseElement:hasState(stateName) end

---Configures event listening behavior with automatic parent notification
---@param eventName string The name of the event to listen for
---@return table self The BaseElement instance
function BaseElement:listenEvent(eventName) end

---Gets the highest priority active state
---@return string |nil currentState The state with highest priority
function BaseElement:getCurrentState() end

---Gets the value of the Name property.
---@param self BaseElement self
---@return string BaseElement User-defined name for the element
function BaseElement:getName(self) end

---Checks if the element matches or inherits from the specified type
---@param type string The type to check for
---@return boolean isType Whether the element is of the specified type
function BaseElement:isType(type) end

---Gets all currently active states sorted by priority
---@return table states Array of {name, priority} sorted by priority
function BaseElement:getActiveStates() end

---Registers a class-level event listener with optional dependency
---@param class table The class to register
---@param eventName string The name of the event to register
function BaseElement.defineEvent(class, eventName) end

---Executes all registered callbacks for the specified event
---@param event string The event to fire
---@return table self The BaseElement instance
function BaseElement:fireEvent(event) end

---Sets the value of the Type property.
---@param self BaseElement self
---@param Type string A hierarchical identifier of the element's type chain
function BaseElement:setType(self, Type) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return table self The BaseElement instance
---@protected
function BaseElement:postInit() end

---Enables debugging for this element
---@param self BaseElement The element to debug
---@param level number The debug level
function BaseElement.debug(self, level) end

---Creates a responsive builder for defining responsive states
---@param self BaseElement The element to create the builder for
---@return ResponsiveBuilder builder The responsive builder instance
function BaseElement:responsive(self) end

---Gets the value of the Enabled property.
---@param self BaseElement self
---@return boolean BaseElement Controls event processing for this element
function BaseElement:getEnabled(self) end

---Gets the value of the Id property.
---@param self BaseElement self
---@return string BaseElement Auto-generated unique identifier for element lookup
function BaseElement:getId(self) end

---Gets the value of the Type property.
---@param self BaseElement self
---@return string BaseElement A hierarchical identifier of the element's type chain
function BaseElement:getType(self) end

---Registers a new state with optional auto-condition
---@param stateName string The name of the state
---@return BaseElement self The BaseElement instance
function BaseElement:registerState(stateName) end

---Registers a responsive state that reacts to parent size changes
---@param stateName string The name of the state
---@param condition string |function Condition as string expression or function: function(element) return boolean end
---@return BaseElement self
function BaseElement:registerResponsiveState(stateName, condition) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:handleEvent(event) end

---Manually activates a state
---@param stateName string The state to activate
---@return BaseElement self
function BaseElement:setState(stateName) end

---Sets up a property change observer with immediate callback registration
---@param property string The property to observe
---@param callback function The callback to call when the property changes
---@return table self The BaseElement instance
function BaseElement:onChange(property, callback) end

---Stops benchmarking for a method
---@param methodName string The name of the method to stop benchmarking
---@return BaseElement self The element instance
function BaseElement:stopBenchmark(methodName) end

---Gets benchmark statistics for a method
---@param methodName string The name of the method to get statistics for
---@return table ? stats The benchmark statistics or nil
function BaseElement:getBenchmarkStats(methodName) end

---Adds an event handler function with automatic event registration
---@param event string The event to register the callback for
---@param callback function The callback function to register
---@return table self The BaseElement instance
function BaseElement:registerCallback(event, callback) end

---Ends profiling a method
---@param methodName string The name of the method to stop profiling
---@return BaseElement self The element instance
function BaseElement:endProfile(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:dispatchEvent(event) end

---Gets the value of the States property.
---@param self BaseElement self
---@return table {} Table of currently active states with their priorities
function BaseElement:getStates(self) end

---Gets the value of the EventCallbacks property.
---@param self BaseElement self
---@return table BaseElement Collection of registered event handler functions
function BaseElement:getEventCallbacks(self) end

---Sets the value of the Id property.
---@param self BaseElement self
---@param Id string Auto-generated unique identifier for element lookup
function BaseElement:setId(self, Id) end

---Logs benchmark statistics for a method
---@param methodName string The name of the method to log
---@return BaseElement self The element instance
function BaseElement:logBenchmark(methodName) end

---Starts profiling a method
---@param methodName string The name of the method to profile
---@return BaseElement self The element instance
function BaseElement:startProfile(methodName) end

---Defines a class-level event callback method with automatic event registration
---@param class table The class to register
---@param callbackName string The name of the callback to register
function BaseElement.registerEventCallback(class, callbackName) end

---Sets the value of the Enabled property.
---@param self BaseElement self
---@param Enabled boolean Controls event processing for this element
function BaseElement:setEnabled(self, Enabled) end

---Sets the value of the States property.
---@param self BaseElement self
---@param States table Table of currently active states with their priorities
function BaseElement:setStates(self, States) end

---Gets the theme properties for this element
---@param self BaseElement The element to get theme for
---@return table styles The theme properties
function BaseElement:getTheme(self) end

---Sets the value of the Name property.
---@param self BaseElement self
---@param Name string User-defined name for the element
function BaseElement:setName(self, Name) end

---Propagates render request up the element tree
---@return table self The BaseElement instance
function BaseElement:updateRender() end

---Removes a state from the registry
---@param stateName string The state to remove
---@return BaseElement self
function BaseElement:unregisterState(stateName) end

---Applies the current theme to this element
---@param self BaseElement The element to apply theme to
---@param applyToChildren boolean ? Whether to apply theme to child elements (default: true)
---@return BaseElement self The element instance
function BaseElement:applyTheme(self, applyToChildren) end

---Updates all states that have auto-conditions
---@return BaseElement self
function BaseElement:updateConditionalStates() end

---Sets the value of the EventCallbacks property.
---@param self BaseElement self
---@param EventCallbacks table Collection of registered event handler functions
function BaseElement:setEventCallbacks(self, EventCallbacks) end

---Enables benchmarking for a method
---@param methodName string The name of the method to benchmark
---@return BaseElement self The element instance
function BaseElement:benchmark(methodName) end

---Manually deactivates a state
---@param stateName string The state to deactivate
---@return BaseElement self
function BaseElement:unsetState(stateName) end

---Traverses parent chain to locate the root frame element
---@return BaseFrame BaseFrame The base frame of the element
function BaseElement:getBaseFrame() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseElement:init(props, basalt) end

---@class TextBox : VisualElement
---@field autoCompleteMinChars number Minimum characters required before showing suggestions
---@field cursorY number Cursor Y position (line number)
---@field autoCompleteAcceptOnEnter boolean Whether pressing Enter accepts the current suggestion
---@field autoCompleteZOffset number Z-index offset applied to the popup frame
---@field scrollY number Vertical scroll offset
---@field autoCompleteTokenPattern string Pattern used to extract the current token for suggestions
---@field autoCompleteProvider function Optional suggestion provider returning a list for the current prefix
---@field cursorX number Cursor X position
---@field lines table Array of text lines
---@field autoCompleteSelectedBackground color Background color for the selected suggestion
---@field autoPairSkipClosing boolean Skip inserting a closing char if the same one is already at cursor
---@field autoPairEnabled boolean Whether automatic bracket/quote pairing is enabled
---@field autoCompleteCaseInsensitive boolean Whether suggestions should match case-insensitively
---@field autoCompleteBorderColor color Color of the popup border when enabled
---@field autoPairNewlineIndent boolean On Enter between matching braces, create blank line and keep closing aligned
---@field autoPairOverType boolean When pressing a closing char that matches the next char, move over it instead of inserting
---@field autoCompleteForeground color Foreground color of the suggestion popup
---@field editable boolean Whether text can be edited
---@field autoCompleteSelectedForeground color Foreground color for the selected suggestion
---@field autoCompleteMaxWidth number Maximum width of the autocomplete popup (0 uses the textbox width)
---@field autoCompleteOffsetY number Vertical offset applied to the popup frame relative to the TextBox bottom edge
---@field autoCompleteShowBorder boolean Whether to render a character border around the popup
---@field cursorColor number Color of the cursor
---@field autoCompleteItems table List of suggestions used when no provider is supplied
---@field autoCompleteCloseOnEscape boolean Whether pressing Escape closes the popup
---@field scrollX number Horizontal scroll offset
---@field autoCompleteAcceptOnClick boolean Whether clicking a suggestion accepts it immediately
---@field autoCompleteMaxItems number Maximum number of visible suggestions
---@field syntaxPatterns table Syntax highlighting patterns
---@field autoCompleteEnabled boolean Whether autocomplete suggestions are enabled
---@field autoCompleteOffsetX number Horizontal offset applied to the popup frame relative to the TextBox
---@field autoCompleteBackground color Background color of the suggestion popup
---@field autoPairCharacters table ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
local TextBox = {}

---Gets the value of the AutoCompleteSelectedBackground property.
---@param self TextBox self
---@return color gray Background color for the selected suggestion
function TextBox:getAutoCompleteSelectedBackground(self) end

---Gets the value of the AutoCompleteMinChars property.
---@param self TextBox self
---@return number 1 Minimum characters required before showing suggestions
function TextBox:getAutoCompleteMinChars(self) end

---Gets the value of the ScrollX property.
---@param self TextBox self
---@return number 0 Horizontal scroll offset
function TextBox:getScrollX(self) end

---Gets the value of the AutoCompleteEnabled property.
---@param self TextBox self
---@return boolean false Whether autocomplete suggestions are enabled
function TextBox:getAutoCompleteEnabled(self) end

---Gets the value of the Lines property.
---@param self TextBox self
---@return table {} Array of text lines
function TextBox:getLines(self) end

---Gets the value of the Editable property.
---@param self TextBox self
---@return boolean true Whether text can be edited
function TextBox:getEditable(self) end

---Sets the value of the AutoCompleteMinChars property.
---@param self TextBox self
---@param AutoCompleteMinChars number Minimum characters required before showing suggestions
function TextBox:setAutoCompleteMinChars(self, AutoCompleteMinChars) end

---Sets the value of the AutoCompleteForeground property.
---@param self TextBox self
---@param AutoCompleteForeground color Foreground color of the suggestion popup
function TextBox:setAutoCompleteForeground(self, AutoCompleteForeground) end

---Gets the value of the AutoCompleteForeground property.
---@param self TextBox self
---@return color black Foreground color of the suggestion popup
function TextBox:getAutoCompleteForeground(self) end

---Gets the value of the SyntaxPatterns property.
---@param self TextBox self
---@return table {} Syntax highlighting patterns
function TextBox:getSyntaxPatterns(self) end

---Gets the value of the AutoCompleteAcceptOnClick property.
---@param self TextBox self
---@return boolean true Whether clicking a suggestion accepts it immediately
function TextBox:getAutoCompleteAcceptOnClick(self) end

---Gets the value of the AutoPairOverType property.
---@param self TextBox self
---@return boolean true When pressing a closing char that matches the next char, move over it instead of inserting
function TextBox:getAutoPairOverType(self) end

---Gets the value of the AutoCompleteBorderColor property.
---@param self TextBox self
---@return color black Color of the popup border when enabled
function TextBox:getAutoCompleteBorderColor(self) end

---Gets the value of the ScrollY property.
---@param self TextBox self
---@return number 0 Vertical scroll offset
function TextBox:getScrollY(self) end

---Sets the value of the AutoPairNewlineIndent property.
---@param self TextBox self
---@param AutoPairNewlineIndent boolean On Enter between matching braces, create blank line and keep closing aligned
function TextBox:setAutoPairNewlineIndent(self, AutoPairNewlineIndent) end

---Gets the value of the AutoPairNewlineIndent property.
---@param self TextBox self
---@return boolean true On Enter between matching braces, create blank line and keep closing aligned
function TextBox:getAutoPairNewlineIndent(self) end

---Sets the value of the ScrollX property.
---@param self TextBox self
---@param ScrollX number Horizontal scroll offset
function TextBox:setScrollX(self, ScrollX) end

---Gets the value of the AutoCompleteMaxWidth property.
---@param self TextBox self
---@return number 0 Maximum width of the autocomplete popup (0 uses the textbox width)
function TextBox:getAutoCompleteMaxWidth(self) end

---Sets the value of the CursorColor property.
---@param self TextBox self
---@param CursorColor number Color of the cursor
function TextBox:setCursorColor(self, CursorColor) end

---Gets the value of the AutoPairSkipClosing property.
---@param self TextBox self
---@return boolean true Skip inserting a closing char if the same one is already at cursor
function TextBox:getAutoPairSkipClosing(self) end

---Sets the value of the AutoCompleteMaxItems property.
---@param self TextBox self
---@param AutoCompleteMaxItems number Maximum number of visible suggestions
function TextBox:setAutoCompleteMaxItems(self, AutoCompleteMaxItems) end

---Sets the value of the AutoCompleteAcceptOnEnter property.
---@param self TextBox self
---@param AutoCompleteAcceptOnEnter boolean Whether pressing Enter accepts the current suggestion
function TextBox:setAutoCompleteAcceptOnEnter(self, AutoCompleteAcceptOnEnter) end

---Sets the value of the AutoCompleteMaxWidth property.
---@param self TextBox self
---@param AutoCompleteMaxWidth number Maximum width of the autocomplete popup (0 uses the textbox width)
function TextBox:setAutoCompleteMaxWidth(self, AutoCompleteMaxWidth) end

---Sets the value of the AutoCompleteProvider property.
---@param self TextBox self
---@param AutoCompleteProvider function Optional suggestion provider returning a list for the current prefix
function TextBox:setAutoCompleteProvider(self, AutoCompleteProvider) end

---Sets the value of the AutoCompleteOffsetX property.
---@param self TextBox self
---@param AutoCompleteOffsetX number Horizontal offset applied to the popup frame relative to the TextBox
function TextBox:setAutoCompleteOffsetX(self, AutoCompleteOffsetX) end

---Sets the value of the AutoPairOverType property.
---@param self TextBox self
---@param AutoPairOverType boolean When pressing a closing char that matches the next char, move over it instead of inserting
function TextBox:setAutoPairOverType(self, AutoPairOverType) end

---Gets the value of the AutoCompleteOffsetY property.
---@param self TextBox self
---@return number 1 Vertical offset applied to the popup frame relative to the TextBox bottom edge
function TextBox:getAutoCompleteOffsetY(self) end

---Sets the value of the AutoCompleteCaseInsensitive property.
---@param self TextBox self
---@param AutoCompleteCaseInsensitive boolean Whether suggestions should match case-insensitively
function TextBox:setAutoCompleteCaseInsensitive(self, AutoCompleteCaseInsensitive) end

---Sets the value of the AutoPairEnabled property.
---@param self TextBox self
---@param AutoPairEnabled boolean Whether automatic bracket/quote pairing is enabled
function TextBox:setAutoPairEnabled(self, AutoPairEnabled) end

---Gets the value of the CursorColor property.
---@param self TextBox self
---@return number nil Color of the cursor
function TextBox:getCursorColor(self) end

---Sets the value of the AutoCompleteAcceptOnClick property.
---@param self TextBox self
---@param AutoCompleteAcceptOnClick boolean Whether clicking a suggestion accepts it immediately
function TextBox:setAutoCompleteAcceptOnClick(self, AutoCompleteAcceptOnClick) end

---Gets the value of the AutoCompleteZOffset property.
---@param self TextBox self
---@return number 1 Z-index offset applied to the popup frame
function TextBox:getAutoCompleteZOffset(self) end

---Sets the value of the AutoCompleteShowBorder property.
---@param self TextBox self
---@param AutoCompleteShowBorder boolean Whether to render a character border around the popup
function TextBox:setAutoCompleteShowBorder(self, AutoCompleteShowBorder) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TextBox:render() end

---Gets the value of the AutoPairEnabled property.
---@param self TextBox self
---@return boolean true Whether automatic bracket/quote pairing is enabled
function TextBox:getAutoPairEnabled(self) end

---Sets the value of the AutoPairSkipClosing property.
---@param self TextBox self
---@param AutoPairSkipClosing boolean Skip inserting a closing char if the same one is already at cursor
function TextBox:setAutoPairSkipClosing(self, AutoPairSkipClosing) end

---Sets the value of the CursorX property.
---@param self TextBox self
---@param CursorX number Cursor X position
function TextBox:setCursorX(self, CursorX) end

---Sets the value of the AutoPairCharacters property.
---@param self TextBox self
---@param AutoPairCharacters table ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
function TextBox:setAutoPairCharacters(self, AutoPairCharacters) end

---Sets the value of the AutoCompleteBackground property.
---@param self TextBox self
---@param AutoCompleteBackground color Background color of the suggestion popup
function TextBox:setAutoCompleteBackground(self, AutoCompleteBackground) end

---Sets the value of the CursorY property.
---@param self TextBox self
---@param CursorY number Cursor Y position (line number)
function TextBox:setCursorY(self, CursorY) end

---Gets the value of the AutoCompleteItems property.
---@param self TextBox self
---@return table {} List of suggestions used when no provider is supplied
function TextBox:getAutoCompleteItems(self) end

---Sets the value of the Editable property.
---@param self TextBox self
---@param Editable boolean Whether text can be edited
function TextBox:setEditable(self, Editable) end

function TextBox:destroy() end

---Gets the text of the TextBox
---@return string text The text of the TextBox
function TextBox:getText() end

---Sets the text of the TextBox
---@param text string The text to set
---@return TextBox self The TextBox instance
function TextBox:setText(text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TextBox:paste() end

---Gets the value of the AutoCompleteProvider property.
---@param self TextBox self
---@return function nil Optional suggestion provider returning a list for the current prefix
function TextBox:getAutoCompleteProvider(self) end

---Gets the value of the AutoCompleteOffsetX property.
---@param self TextBox self
---@return number 0 Horizontal offset applied to the popup frame relative to the TextBox
function TextBox:getAutoCompleteOffsetX(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_click(button, x, y) end

---Sets the value of the SyntaxPatterns property.
---@param self TextBox self
---@param SyntaxPatterns table Syntax highlighting patterns
function TextBox:setSyntaxPatterns(self, SyntaxPatterns) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_scroll(direction, x, y) end

---Gets the value of the AutoCompleteMaxItems property.
---@param self TextBox self
---@return number 6 Maximum number of visible suggestions
function TextBox:getAutoCompleteMaxItems(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:key(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:char(char) end

---Updates the viewport to keep the cursor in view
---@return TextBox self The TextBox instance
function TextBox:updateViewport() end

---Gets the value of the AutoCompleteCaseInsensitive property.
---@param self TextBox self
---@return boolean true Whether suggestions should match case-insensitively
function TextBox:getAutoCompleteCaseInsensitive(self) end

---Gets the value of the AutoCompleteSelectedForeground property.
---@param self TextBox self
---@return color white Foreground color for the selected suggestion
function TextBox:getAutoCompleteSelectedForeground(self) end

---Clears all syntax highlighting patterns
---@return TextBox self
function TextBox:clearSyntaxPatterns() end

---Removes a syntax pattern by index (1-based)
---@param index number The index of the pattern to remove
---@return TextBox self
function TextBox:removeSyntaxPattern(index) end

---Adds a new syntax highlighting pattern
---@param pattern string The regex pattern to match
---@param color number The color to apply
---@return TextBox self The TextBox instance
function TextBox:addSyntaxPattern(pattern, color) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return TextBox self The initialized instance
---@protected
function TextBox:init(props, basalt) end

---Sets the value of the AutoCompleteBorderColor property.
---@param self TextBox self
---@param AutoCompleteBorderColor color Color of the popup border when enabled
function TextBox:setAutoCompleteBorderColor(self, AutoCompleteBorderColor) end

---Gets the value of the CursorY property.
---@param self TextBox self
---@return number 1 Cursor Y position (line number)
function TextBox:getCursorY(self) end

---Gets the value of the AutoCompleteAcceptOnEnter property.
---@param self TextBox self
---@return boolean true Whether pressing Enter accepts the current suggestion
function TextBox:getAutoCompleteAcceptOnEnter(self) end

---Sets the value of the AutoCompleteEnabled property.
---@param self TextBox self
---@param AutoCompleteEnabled boolean Whether autocomplete suggestions are enabled
function TextBox:setAutoCompleteEnabled(self, AutoCompleteEnabled) end

---Sets the value of the Lines property.
---@param self TextBox self
---@param Lines table Array of text lines
function TextBox:setLines(self, Lines) end

---Gets the value of the AutoCompleteBackground property.
---@param self TextBox self
---@return color lightGray Background color of the suggestion popup
function TextBox:getAutoCompleteBackground(self) end

---Sets the value of the AutoCompleteTokenPattern property.
---@param self TextBox self
---@param AutoCompleteTokenPattern string Pattern used to extract the current token for suggestions
function TextBox:setAutoCompleteTokenPattern(self, AutoCompleteTokenPattern) end

---Sets the value of the ScrollY property.
---@param self TextBox self
---@param ScrollY number Vertical scroll offset
function TextBox:setScrollY(self, ScrollY) end

---Sets the value of the AutoCompleteZOffset property.
---@param self TextBox self
---@param AutoCompleteZOffset number Z-index offset applied to the popup frame
function TextBox:setAutoCompleteZOffset(self, AutoCompleteZOffset) end

---Gets the value of the AutoPairCharacters property.
---@param self TextBox self
---@return table { ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
function TextBox:getAutoPairCharacters(self) end

---Gets the value of the CursorX property.
---@param self TextBox self
---@return number 1 Cursor X position
function TextBox:getCursorX(self) end

---Sets the value of the AutoCompleteOffsetY property.
---@param self TextBox self
---@param AutoCompleteOffsetY number Vertical offset applied to the popup frame relative to the TextBox bottom edge
function TextBox:setAutoCompleteOffsetY(self, AutoCompleteOffsetY) end

---Sets the value of the AutoCompleteItems property.
---@param self TextBox self
---@param AutoCompleteItems table List of suggestions used when no provider is supplied
function TextBox:setAutoCompleteItems(self, AutoCompleteItems) end

---Gets the value of the AutoCompleteShowBorder property.
---@param self TextBox self
---@return boolean true Whether to render a character border around the popup
function TextBox:getAutoCompleteShowBorder(self) end

---Sets the value of the AutoCompleteCloseOnEscape property.
---@param self TextBox self
---@param AutoCompleteCloseOnEscape boolean Whether pressing Escape closes the popup
function TextBox:setAutoCompleteCloseOnEscape(self, AutoCompleteCloseOnEscape) end

---Gets the value of the AutoCompleteCloseOnEscape property.
---@param self TextBox self
---@return boolean true Whether pressing Escape closes the popup
function TextBox:getAutoCompleteCloseOnEscape(self) end

---Sets the value of the AutoCompleteSelectedForeground property.
---@param self TextBox self
---@param AutoCompleteSelectedForeground color Foreground color for the selected suggestion
function TextBox:setAutoCompleteSelectedForeground(self, AutoCompleteSelectedForeground) end

---Sets the value of the AutoCompleteSelectedBackground property.
---@param self TextBox self
---@param AutoCompleteSelectedBackground color Background color for the selected suggestion
function TextBox:setAutoCompleteSelectedBackground(self, AutoCompleteSelectedBackground) end

---Gets the value of the AutoCompleteTokenPattern property.
---@param self TextBox self
---@return string "[%w_]+" Pattern used to extract the current token for suggestions
function TextBox:getAutoCompleteTokenPattern(self) end

---@class List : Collection
---@field emptyText string items" Text to display when the list is empty
---@field scrollBarBackgroundColor color Background color of the scrollbar
---@field scrollBarBackground string Symbol used for the scrollbar background
---@field scrollBarColor color Color of the scrollbar handle
---@field offset number Current scroll offset for viewing long lists
---@field showScrollBar boolean Whether to show the scrollbar when items exceed height
---@field scrollBarSymbol string " Symbol used for the scrollbar handle
local List = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function List:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll (1 for down, -1 for up)
---@param x number The x-coordinate of the scroll
---@param y number The y-coordinate of the scroll
---@return boolean Whether the event was handled
---@protected
function List:mouse_scroll(direction, x, y) end

---Gets the value of the ScrollBarBackground property.
---@param self List self
---@return string "\127" Symbol used for the scrollbar background
function List:getScrollBarBackground(self) end

---Gets the value of the ScrollBarColor property.
---@param self List self
---@return color lightGray Color of the scrollbar handle
function List:getScrollBarColor(self) end

---Handles key events for keyboard navigation
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param keyCode number The key code
---@return boolean Whether the event was handled
---@protected
function List:key(keyCode) end

---Sets the value of the EmptyText property.
---@param self List self
---@param EmptyText string items" Text to display when the list is empty
function List:setEmptyText(self, EmptyText) end

---Scrolls to make a specific item visible
---@param index number The index of the item to scroll to
---@return List self The List instance
function List:scrollToItem(index) end

---Scrolls the list to the top
---@return List self The List instance
function List:scrollToTop() end

---Scrolls the list to the bottom
---@return List self The List instance
function List:scrollToBottom() end

---Sets the value of the ScrollBarSymbol property.
---@param self List self
---@param ScrollBarSymbol string " Symbol used for the scrollbar handle
function List:setScrollBarSymbol(self, ScrollBarSymbol) end

---Sets the value of the ShowScrollBar property.
---@param self List self
---@param ShowScrollBar boolean Whether to show the scrollbar when items exceed height
function List:setShowScrollBar(self, ShowScrollBar) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x-coordinate of the drag
---@param y number The y-coordinate of the drag
---@return boolean Whether the event was handled
---@protected
function List:mouse_drag(button, x, y) end

---Gets the value of the ScrollBarSymbol property.
---@param self List self
---@return string " " Symbol used for the scrollbar handle
function List:getScrollBarSymbol(self) end

---Sets the value of the ScrollBarBackground property.
---@param self List self
---@param ScrollBarBackground string Symbol used for the scrollbar background
function List:setScrollBarBackground(self, ScrollBarBackground) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x-coordinate of the release
---@param y number The y-coordinate of the release
---@return boolean Whether the event was handled
---@protected
function List:mouse_up(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x-coordinate of the click
---@param y number The y-coordinate of the click
---@return boolean Whether the event was handled
---@protected
function List:mouse_click(button, x, y) end

---Gets the value of the ScrollBarBackgroundColor property.
---@param self List self
---@return color gray Background color of the scrollbar
function List:getScrollBarBackgroundColor(self) end

---Registers a function to handle the onSelect event.
---@param List self
---@param index number
---@param item table
---@param self List self
---@param func function The function to be called when the event fires
function List:onOnSelect(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return List self The initialized instance
---@protected
function List:init(props, basalt) end

---Sets the value of the Offset property.
---@param self List self
---@param Offset number Current scroll offset for viewing long lists
function List:setOffset(self, Offset) end

---Gets the value of the EmptyText property.
---@param self List self
---@return string "No items" Text to display when the list is empty
function List:getEmptyText(self) end

---Sets the value of the ScrollBarColor property.
---@param self List self
---@param ScrollBarColor color Color of the scrollbar handle
function List:setScrollBarColor(self, ScrollBarColor) end

---Sets the value of the ScrollBarBackgroundColor property.
---@param self List self
---@param ScrollBarBackgroundColor color Background color of the scrollbar
function List:setScrollBarBackgroundColor(self, ScrollBarBackgroundColor) end

---Gets the value of the ShowScrollBar property.
---@param self List self
---@return boolean true Whether to show the scrollbar when items exceed height
function List:getShowScrollBar(self) end

---Registers a callback for the select event
---@param callback function The callback function to register
---@return List self The List instance
function List:onSelect(callback) end

---Gets the value of the Offset property.
---@param self List self
---@return number 0 Current scroll offset for viewing long lists
function List:getOffset(self) end

---@class BigFont : VisualElement
---@field fontSize number Scale factor for text size (1-3, where 1 is 3x3 pixels per character)
---@field text string The text string to display in enlarged format
local BigFont = {}

---Gets the value of the Text property.
---@param self BigFont self
---@return string BigFont The text string to display in enlarged format
function BigFont:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BigFont:render() end

---Gets the value of the FontSize property.
---@param self BigFont self
---@return number 1 Scale factor for text size (1-3, where 1 is 3x3 pixels per character)
function BigFont:getFontSize(self) end

---Sets the value of the Text property.
---@param self BigFont self
---@param Text string The text string to display in enlarged format
function BigFont:setText(self, Text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function BigFont:init(props, basalt) end

---Sets the value of the FontSize property.
---@param self BigFont self
---@param FontSize number Scale factor for text size (1-3, where 1 is 3x3 pixels per character)
function BigFont:setFontSize(self, FontSize) end

---@class BarChart : Graph
local BarChart = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return BarChart self The initialized instance
---@protected
function BarChart:init(props, basalt) end

---Renders the bar chart by calculating bar positions and heights based on data values
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BarChart:render() end

---@class ElementManager
local ElementManager = {}

---Preloads elements into the global cache
---@param elementNames table List of element names to preload
function ElementManager.preloadElements(elementNames) end

---Gets an Plugin API by name
---@param name string The name of the API to get
---@return table API The API
function ElementManager.getAPI(name) end

---Checks if an element exists (is registered)
---@param name string The element name
---@return boolean exists Whether the element exists
function ElementManager.hasElement(name) end

---Registers a disk mount point for loading elements
---@param mountPath string The path to the disk mount
function ElementManager.registerDiskMount(mountPath) end

---Gets cache statistics
---@return table stats Cache statistics with size and element names
function ElementManager.getCacheStats() end

---Gets a list of all elements
---@return table ElementList A list of all elements
function ElementManager.getElementList() end

---Checks if an element is loaded
---@param name string The element name
---@return boolean loaded Whether the element is loaded
function ElementManager.isElementLoaded(name) end

---Clears the global cache (_G)
function ElementManager.clearGlobalCache() end

---Gets an element by name. If the element is not loaded, it will try to load it first.
---@param name string The name of the element to get
---@return table Element The element class
function ElementManager.getElement(name) end

---Registers a remote source for an element
---@param elementName string The name of the element
---@param url string The URL to load the element from
function ElementManager.registerRemoteSource(elementName, url) end

---Tries to load an element from any available source
---@param name string The element name
---@return boolean success Whether the element was loaded
function ElementManager.tryAutoLoad(name) end

---Loads an element by name. This will load the element and apply any plugins to it.
---@param name string The name of the element to load
function ElementManager.loadElement(name) end

---Configures the ElementManager
---@param config table Configuration options
function ElementManager.configure(config) end

---@class Switch : VisualElement
---@field text string to display next to switch
---@field autoSize boolean to automatically size the element to fit switch and text
---@field offBackground number color when OFF
---@field onBackground number color when ON
---@field checked boolean switch is checked
local Switch = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function Switch:mouse_click(button, x, y) end

---Sets the value of the AutoSize property.
---@param self Switch self
---@param AutoSize boolean to automatically size the element to fit switch and text
function Switch:setAutoSize(self, AutoSize) end

---Sets the value of the OnBackground property.
---@param self Switch self
---@param OnBackground number color when ON
function Switch:setOnBackground(self, OnBackground) end

---Gets the value of the Text property.
---@param self Switch self
---@return string Text to display next to switch
function Switch:getText(self) end

---Gets the value of the AutoSize property.
---@param self Switch self
---@return boolean Whether to automatically size the element to fit switch and text
function Switch:getAutoSize(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Switch:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Switch:init(props, basalt) end

---Sets the value of the Checked property.
---@param self Switch self
---@param Checked boolean switch is checked
function Switch:setChecked(self, Checked) end

---Gets the value of the OnBackground property.
---@param self Switch self
---@return number Background color when ON
function Switch:getOnBackground(self) end

---Sets the value of the OffBackground property.
---@param self Switch self
---@param OffBackground number color when OFF
function Switch:setOffBackground(self, OffBackground) end

---Gets the value of the OffBackground property.
---@param self Switch self
---@return number Background color when OFF
function Switch:getOffBackground(self) end

---Gets the value of the Checked property.
---@param self Switch self
---@return boolean Whether switch is checked
function Switch:getChecked(self) end

---Sets the value of the Text property.
---@param self Switch self
---@param Text string to display next to switch
function Switch:setText(self, Text) end

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

---@class AnimationInstance
local AnimationInstance = {}

---Updates the animation
---@param elapsed number The elapsed time in seconds
---@return boolean Whether the animation is finished
function AnimationInstance:update(elapsed) end

---Gets called when the animation is completed
function AnimationInstance:complete() end

---Creates a new AnimationInstance
---@param element VisualElement The element to animate
---@param animType string The type of animation
---@param args table The animation arguments
---@param duration number Duration in seconds
---@param easing string The easing function name
---@return AnimationInstance The new animation instance
function AnimationInstance.new(element, animType, args, duration, easing) end

---Starts the animation
---@return AnimationInstance self The animation instance
function AnimationInstance:start() end

---@class BaseFrame : Container
---@field term term term.current() The terminal or (monitor) peripheral object to render to
local BaseFrame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function BaseFrame:char(char) end

---Toggles the debug log frame
---@param self BaseFrame The frame to toggle debug log for
function BaseFrame.toggleConsole(self) end

---Sets the value of the Term property.
---@param self BaseFrame self
---@param Term term term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:setTerm(self, Term) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseFrame:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function BaseFrame:key(key) end

---Sets the cursor position
---@param x number The x position to set the cursor to
---@param y number The y position to set the cursor to
---@param blink boolean Whether the cursor should blink
function BaseFrame:setCursor(x, y, blink) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:term_resize() end

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

---Hides the debug log frame
---@param self BaseFrame The frame to hide debug log for
function BaseFrame.closeConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param bg colors The background color
---@protected
function BaseFrame:textBg(x, y, text, bg) end

---Shows the debug log frame
---@param self BaseFrame The frame to show debug log in
function BaseFrame.openConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg string The foreground color
---@param bg string The background color
---@protected
function BaseFrame:blit(x, y, text, fg, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param bg colors The background color
---@protected
function BaseFrame:drawBg(x, y, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@protected
function BaseFrame:drawText(x, y, text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_up(button, x, y) end

---Gets the value of the Term property.
---@param self BaseFrame self
---@return term |peripheral term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:getTerm(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param fg colors The foreground color
---@protected
function BaseFrame:drawFg(x, y, fg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param name string The name of the monitor that was touched
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:monitor_touch(name, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg colors The foreground color
---@protected
function BaseFrame:textFg(x, y, text, fg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:render() end

function BaseFrame:dispatchEvent() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function BaseFrame:key_up(key) end

---@class ProgressBar : VisualElement
---@field progress number Current progress value (0-100)
---@field direction string The direction of the progress bar ("up", "down", "left", "right")
---@field progressColor color The color used for the filled portion of the progress bar
---@field showPercentage boolean Whether to show the percentage text in the center
local ProgressBar = {}

---Sets the value of the ShowPercentage property.
---@param self ProgressBar self
---@param ShowPercentage boolean Whether to show the percentage text in the center
function ProgressBar:setShowPercentage(self, ShowPercentage) end

---Gets the value of the Progress property.
---@param self ProgressBar self
---@return number 0 Current progress value (0-100)
function ProgressBar:getProgress(self) end

---Sets the value of the ProgressColor property.
---@param self ProgressBar self
---@param ProgressColor color The color used for the filled portion of the progress bar
function ProgressBar:setProgressColor(self, ProgressColor) end

---Gets the value of the Direction property.
---@param self ProgressBar self
---@return string right The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:getDirection(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ProgressBar:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ProgressBar self The initialized instance
---@protected
function ProgressBar:init(props, basalt) end

---Sets the value of the Direction property.
---@param self ProgressBar self
---@param Direction string The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:setDirection(self, Direction) end

---Gets the value of the ProgressColor property.
---@param self ProgressBar self
---@return color lime The color used for the filled portion of the progress bar
function ProgressBar:getProgressColor(self) end

---Sets the value of the Progress property.
---@param self ProgressBar self
---@param Progress number Current progress value (0-100)
function ProgressBar:setProgress(self, Progress) end

---Gets the value of the ShowPercentage property.
---@param self ProgressBar self
---@return boolean false Whether to show the percentage text in the center
function ProgressBar:getShowPercentage(self) end

---@class Display : VisualElement
local Display = {}

---Writes text directly to the display with optional colors
---@param x number X position (1-based)
---@param y number Y position (1-based)
---@param text string Text to write
---@return Display self For method chaining
function Display:write(x, y, text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Display:init(props, basalt) end

---Retrieves the underlying ComputerCraft window object
---@return table window A CC window object with all standard terminal methods
function Display:getWindow() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Display:render() end

---@class Reactive
local Reactive = {}

---@class Benchmark
local Benchmark = {}

---Stops a custom benchmark
---@param name string The name of the benchmark to stop
function API.stop(name) end

---Clears all custom benchmarks
function API.clearAll() end

---Clears a specific benchmark
---@param name string The name of the benchmark to clear
function API.clear(name) end

---Starts a custom benchmark
---@param name string The name of the benchmark
function API.start(name) end

---Gets statistics for a benchmark
---@param name string The name of the benchmark
---@return table ? stats The benchmark statistics or nil
function API.getStats(name) end

---@class Menu : List
---@field spacing number The number of spaces between menu items
---@field dropdownBackground color Background color for dropdown menus
---@field dropdownForeground color Foreground color for dropdown menus
---@field openDropdown table Currently open dropdown data {index, items, x, y, width, height}
---@field separatorColor color The color used for separator items in the menu
---@field maxWidth number Maximum width before scrolling is enabled (nil = auto-size to items)
---@field horizontalOffset number Current horizontal scroll offset
local Menu = {}

---Sets the value of the SeparatorColor property.
---@param self Menu self
---@param SeparatorColor color The color used for separator items in the menu
function Menu:setSeparatorColor(self, SeparatorColor) end

---Gets the value of the HorizontalOffset property.
---@param self Menu self
---@return number 0 Current horizontal scroll offset
function Menu:getHorizontalOffset(self) end

---Sets the value of the DropdownForeground property.
---@param self Menu self
---@param DropdownForeground color Foreground color for dropdown menus
function Menu:setDropdownForeground(self, DropdownForeground) end

---Calculates the total width of all menu items with spacing
---@return number totalWidth The total width of all items
function Menu:getTotalWidth() end

---Gets the value of the OpenDropdown property.
---@param self Menu self
---@return table nil Currently open dropdown data {index, items, x, y, width, height}
function Menu:getOpenDropdown(self) end

---Handles click inside dropdown
---@param relX number Relative X position
---@param relY number Relative Y position
---@param dropdown table Dropdown data
---@return boolean handled Whether click was handled
function Menu:handleDropdownClick(relX, relY, dropdown) end

---Gets the value of the Spacing property.
---@param self Menu self
---@return number 0 The number of spaces between menu items
function Menu:getSpacing(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Menu:mouse_click() end

---Checks if a position is inside the dropdown
---@param relX number Relative X position
---@param relY number Relative Y position
---@param dropdown table Dropdown data
---@return boolean inside Whether position is inside dropdown
function Menu:isInsideDropdown(relX, relY, dropdown) end

---Shows a dropdown menu for a specific item
---@param index number The item index
---@param item table The menu item
---@param itemX number The X position of the item
function Menu:showDropdown(index, item, itemX) end

---Gets the value of the DropdownForeground property.
---@param self Menu self
---@return color white Foreground color for dropdown menus
function Menu:getDropdownForeground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Menu:render() end

---Gets the value of the SeparatorColor property.
---@param self Menu self
---@return color gray The color used for separator items in the menu
function Menu:getSeparatorColor(self) end

---Sets the value of the Spacing property.
---@param self Menu self
---@param Spacing number The number of spaces between menu items
function Menu:setSpacing(self, Spacing) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Menu self The initialized instance
---@protected
function Menu:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Menu:mouse_scroll() end

---Sets the value of the OpenDropdown property.
---@param self Menu self
---@param OpenDropdown table Currently open dropdown data {index, items, x, y, width, height}
function Menu:setOpenDropdown(self, OpenDropdown) end

---Gets the value of the DropdownBackground property.
---@param self Menu self
---@return color black Background color for dropdown menus
function Menu:getDropdownBackground(self) end

---Sets the value of the MaxWidth property.
---@param self Menu self
---@param MaxWidth number Maximum width before scrolling is enabled (nil = auto-size to items)
function Menu:setMaxWidth(self, MaxWidth) end

---Sets the value of the DropdownBackground property.
---@param self Menu self
---@param DropdownBackground color Background color for dropdown menus
function Menu:setDropdownBackground(self, DropdownBackground) end

---Gets the value of the MaxWidth property.
---@param self Menu self
---@return number nil Maximum width before scrolling is enabled (nil = auto-size to items)
function Menu:getMaxWidth(self) end

---Renders the dropdown menu
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param dropdown table Dropdown data
---@protected
function Menu:renderDropdown(dropdown) end

---Sets the value of the HorizontalOffset property.
---@param self Menu self
---@param HorizontalOffset number Current horizontal scroll offset
function Menu:setHorizontalOffset(self, HorizontalOffset) end

---Closes the currently open dropdown
function Menu:hideDropdown() end

---@class Breadcrumb : VisualElement
---@field autoSize false Whether to resize the element width automatically based on text
---@field path table Array of strings representing the breadcrumb segments
---@field clickable true Whether the segments are clickable
local Breadcrumb = {}

---@param button number 
---@param x number 
---@param y number 
---@return boolean handled
function Breadcrumb:mouse_click(button, x, y) end

---Gets the value of the AutoSize property.
---@param self Breadcrumb self
---@return false boolean Whether to resize the element width automatically based on text
function Breadcrumb:getAutoSize(self) end

---@param props table 
---@param basalt table 
function Breadcrumb:init(props, basalt) end

---Registers a callback for the select event
---@param callback function The callback function to register
---@return Breadcrumb self The Breadcrumb instance
function Breadcrumb:onSelect(callback) end

---@return table self
function Breadcrumb.new() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Breadcrumb:render() end

---Gets the value of the Path property.
---@param self Breadcrumb self
---@return table {} Array of strings representing the breadcrumb segments
function Breadcrumb:getPath(self) end

---Sets the value of the Clickable property.
---@param self Breadcrumb self
---@param Clickable true Whether the segments are clickable
function Breadcrumb:setClickable(self, Clickable) end

---Gets the value of the Clickable property.
---@param self Breadcrumb self
---@return true boolean Whether the segments are clickable
function Breadcrumb:getClickable(self) end

---Sets the value of the AutoSize property.
---@param self Breadcrumb self
---@param AutoSize false Whether to resize the element width automatically based on text
function Breadcrumb:setAutoSize(self, AutoSize) end

---Sets the value of the Path property.
---@param self Breadcrumb self
---@param Path table Array of strings representing the breadcrumb segments
function Breadcrumb:setPath(self, Path) end

---@class Toast : VisualElement
---@field message string The message text of the toast
---@field title string The title text of the toast
---@field duration number Duration in seconds before the toast auto-hides
---@field active boolean Whether the toast is currently showing a message
---@field toastType string Type of toast: default, success, error, warning, info
---@field colorMap table of toast types to their colors
---@field autoHide boolean Whether the toast should automatically hide after duration
local Toast = {}

---Sets the value of the AutoHide property.
---@param self Toast self
---@param AutoHide boolean Whether the toast should automatically hide after duration
function Toast:setAutoHide(self, AutoHide) end

---Sets the value of the Title property.
---@param self Toast self
---@param Title string The title text of the toast
function Toast:setTitle(self, Title) end

---Sets the value of the Message property.
---@param self Toast self
---@param Message string The message text of the toast
function Toast:setMessage(self, Message) end

---Shows an error toast
---@param titleOrMessage string The title or message
---@return Toast self The Toast instance
function Toast:error(titleOrMessage) end

---Shows a toast message
---@param titleOrMessage string The title (if message provided) or the message (if no message)
---@return Toast self The Toast instance
function Toast:show(titleOrMessage) end

---Renders the toast
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Toast:render() end

---Hides the toast
---@return Toast self The Toast instance
function Toast:hide() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Toast:dispatchEvent() end

---Sets the value of the ToastType property.
---@param self Toast self
---@param ToastType string Type of toast: default, success, error, warning, info
function Toast:setToastType(self, ToastType) end

---Shows an info toast
---@param titleOrMessage string The title or message
---@return Toast self The Toast instance
function Toast:info(titleOrMessage) end

---Shows a warning toast
---@param titleOrMessage string The title or message
---@return Toast self The Toast instance
function Toast:warning(titleOrMessage) end

---Sets the value of the Duration property.
---@param self Toast self
---@param Duration number Duration in seconds before the toast auto-hides
function Toast:setDuration(self, Duration) end

---Gets the value of the AutoHide property.
---@param self Toast self
---@return boolean true Whether the toast should automatically hide after duration
function Toast:getAutoHide(self) end

---Gets the value of the Duration property.
---@param self Toast self
---@return number 3 Duration in seconds before the toast auto-hides
function Toast:getDuration(self) end

---Sets the value of the Active property.
---@param self Toast self
---@param Active boolean Whether the toast is currently showing a message
function Toast:setActive(self, Active) end

---Gets the value of the ColorMap property.
---@param self Toast self
---@return table Map of toast types to their colors
function Toast:getColorMap(self) end

---Sets the value of the ColorMap property.
---@param self Toast self
---@param ColorMap table of toast types to their colors
function Toast:setColorMap(self, ColorMap) end

---Gets the value of the Title property.
---@param self Toast self
---@return string "" The title text of the toast
function Toast:getTitle(self) end

---Shows a success toast
---@param titleOrMessage string The title or message
---@return Toast self The Toast instance
function Toast:success(titleOrMessage) end

---Gets the value of the Active property.
---@param self Toast self
---@return boolean false Whether the toast is currently showing a message
function Toast:getActive(self) end

---Gets the value of the ToastType property.
---@param self Toast self
---@return string "default" Type of toast: default, success, error, warning, info
function Toast:getToastType(self) end

---Gets the value of the Message property.
---@param self Toast self
---@return string "" The message text of the toast
function Toast:getMessage(self) end

---@class Log
local Log = {}

---Sends an error message to the logger.
function Log.error() end

---Sends an info message to the logger.
function Log.info() end

---Sets if the logger should log
function Log.setEnabled() end

---Sets if the logger should log to a file.
function Log.setLogToFile() end

---Sends a warning message to the logger.
function Log.warn() end

---Sends a debug message to the logger.
function Log.debug() end

---@class Program : VisualElement
---@field doneCallback function The done callback function
---@field running boolean Whether the program is running
---@field errorCallback function The error callback function
---@field program table The program instance
---@field path string The path to the program
local Program = {}

---Registers a callback for the program's error event, if the function returns false, the program won't stop
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onError(fn) end

---Registers a callback for the program's done event
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onDone(fn) end

---Stops the program
---@return Program self The Program instance
function Program:stop() end

---Gets the value of the DoneCallback property.
---@param self Program self
---@return function nil The done callback function
function Program:getDoneCallback(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Program self The initialized instance
---@protected
function Program:init(props, basalt) end

---Sets the value of the DoneCallback property.
---@param self Program self
---@param DoneCallback function The done callback function
function Program:setDoneCallback(self, DoneCallback) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:render() end

---Sets the value of the Path property.
---@param self Program self
---@param Path string The path to the program
function Program:setPath(self, Path) end

---Sets the value of the ErrorCallback property.
---@param self Program self
---@param ErrorCallback function The error callback function
function Program:setErrorCallback(self, ErrorCallback) end

---Sets the value of the Program property.
---@param self Program self
---@param Program table The program instance
function Program:setProgram(self, Program) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:focus() end

---Gets the value of the ErrorCallback property.
---@param self Program self
---@return function nil The error callback function
function Program:getErrorCallback(self) end

---Gets the value of the Path property.
---@param self Program self
---@return string "" The path to the program
function Program:getPath(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return any result The event result
---@protected
function Program:dispatchEvent(event) end

---Sends an event to the program
---@param event string The event to send
---@return Program self The Program instance
function Program:sendEvent(event) end

---Sets the value of the Running property.
---@param self Program self
---@param Running boolean Whether the program is running
function Program:setRunning(self, Running) end

---Gets the value of the Program property.
---@param self Program self
---@return table nil The program instance
function Program:getProgram(self) end

---Executes a program
---@param path string The path to the program
---@return Program self The Program instance
function Program:execute(path) end

function BasaltProgram:setArgs() end

---Gets the value of the Running property.
---@param self Program self
---@return boolean false Whether the program is running
function Program:getRunning(self) end

---@class CheckBox : VisualElement
---@field autoSize boolean Automatically adjusts width based on text length
---@field text string Text shown when the checkbox is unchecked
---@field checkedText string Text shown when the checkbox is checked
---@field checked boolean The current state of the checkbox (true=checked, false=unchecked)
local CheckBox = {}

---Gets the value of the AutoSize property.
---@param self CheckBox self
---@return boolean true Automatically adjusts width based on text length
function CheckBox:getAutoSize(self) end

---Handles mouse interactions to toggle the checkbox state
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Clicked Whether the event was handled
---@protected
function CheckBox:mouse_click(button, x, y) end

---Gets the value of the Text property.
---@param self CheckBox self
---@return string empty Text shown when the checkbox is unchecked
function CheckBox:getText(self) end

---Sets the value of the Checked property.
---@param self CheckBox self
---@param Checked boolean The current state of the checkbox (true=checked, false=unchecked)
function CheckBox:setChecked(self, Checked) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function CheckBox:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function CheckBox:init(props, basalt) end

---Sets the value of the Text property.
---@param self CheckBox self
---@param Text string Text shown when the checkbox is unchecked
function CheckBox:setText(self, Text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return CheckBox self The created instance
---@protected
function CheckBox.new() end

---Sets the value of the CheckedText property.
---@param self CheckBox self
---@param CheckedText string Text shown when the checkbox is checked
function CheckBox:setCheckedText(self, CheckedText) end

---Sets the value of the AutoSize property.
---@param self CheckBox self
---@param AutoSize boolean Automatically adjusts width based on text length
function CheckBox:setAutoSize(self, AutoSize) end

---Gets the value of the CheckedText property.
---@param self CheckBox self
---@return string x Text shown when the checkbox is checked
function CheckBox:getCheckedText(self) end

---Gets the value of the Checked property.
---@param self CheckBox self
---@return boolean false The current state of the checkbox (true=checked, false=unchecked)
function CheckBox:getChecked(self) end

---@class Tree : VisualElement
---@field selectedNode table nil Currently selected node
---@field scrollBarColor color Color of the scrollbar handle
---@field expandedNodes table Table of nodes that are currently expanded
---@field showScrollBar boolean Whether to show the scrollbar when nodes exceed height
---@field selectedForegroundColor color foreground color of selected node
---@field horizontalOffset number Current horizontal scroll position
---@field scrollBarBackground string Symbol used for the scrollbar background
---@field scrollBarSymbol string " Symbol used for the scrollbar handle
---@field offset number Current vertical scroll position
---@field selectedBackgroundColor color background color of selected node
---@field scrollBarBackgroundColor color Background color of the scrollbar
---@field nodes table The tree structure containing node objects with {text, children} properties
local Tree = {}

---Sets the value of the SelectedForegroundColor property.
---@param self Tree self
---@param SelectedForegroundColor color foreground color of selected node
function Tree:setSelectedForegroundColor(self, SelectedForegroundColor) end

---Sets the value of the Offset property.
---@param self Tree self
---@param Offset number Current vertical scroll position
function Tree:setOffset(self, Offset) end

---Initializes the Tree instance
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Tree self The initialized instance
---@protected
function Tree:init(props, basalt) end

---Sets the value of the HorizontalOffset property.
---@param self Tree self
---@param HorizontalOffset number Current horizontal scroll position
function Tree:setHorizontalOffset(self, HorizontalOffset) end

---Sets the value of the ShowScrollBar property.
---@param self Tree self
---@param ShowScrollBar boolean Whether to show the scrollbar when nodes exceed height
function Tree:setShowScrollBar(self, ShowScrollBar) end

---Gets the value of the HorizontalOffset property.
---@param self Tree self
---@return number 0 Current horizontal scroll position
function Tree:getHorizontalOffset(self) end

---Gets the value of the ExpandedNodes property.
---@param self Tree self
---@return table {} Table of nodes that are currently expanded
function Tree:getExpandedNodes(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x-coordinate of the drag
---@param y number The y-coordinate of the drag
---@return boolean Whether the event was handled
---@protected
function Tree:mouse_drag(button, x, y) end

---Expands a node
---@param node table The node to expand
---@return Tree self The Tree instance
function Tree:expandNode(node) end

---Gets the value of the ShowScrollBar property.
---@param self Tree self
---@return boolean true Whether to show the scrollbar when nodes exceed height
function Tree:getShowScrollBar(self) end

---Sets the value of the ScrollBarSymbol property.
---@param self Tree self
---@param ScrollBarSymbol string " Symbol used for the scrollbar handle
function Tree:setScrollBarSymbol(self, ScrollBarSymbol) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x-coordinate of the release
---@param y number The y-coordinate of the release
---@return boolean Whether the event was handled
---@protected
function Tree:mouse_up(button, x, y) end

---Gets the value of the Nodes property.
---@param self Tree self
---@return table {} The tree structure containing node objects with {text, children} properties
function Tree:getNodes(self) end

---Toggles a node's expanded state
---@param node table The node to toggle
---@return Tree self The Tree instance
function Tree:toggleNode(node) end

---Gets the size of the tree
---@return number width The width of the tree
---@return number height The height of the tree
function Tree:getNodeSize() end

---Sets the value of the Nodes property.
---@param self Tree self
---@param Nodes table The tree structure containing node objects with {text, children} properties
function Tree:setNodes(self, Nodes) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_scroll(direction, x, y) end

---Gets the value of the Offset property.
---@param self Tree self
---@return number 0 Current vertical scroll position
function Tree:getOffset(self) end

---Sets the value of the SelectedBackgroundColor property.
---@param self Tree self
---@param SelectedBackgroundColor color background color of selected node
function Tree:setSelectedBackgroundColor(self, SelectedBackgroundColor) end

---Gets the value of the SelectedBackgroundColor property.
---@param self Tree self
---@return color lightBlue background color of selected node
function Tree:getSelectedBackgroundColor(self) end

---Handles mouse click events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_click(button, x, y) end

---Gets the value of the SelectedNode property.
---@param self Tree self
---@return table ? nil Currently selected node
function Tree:getSelectedNode(self) end

---Sets the value of the ScrollBarColor property.
---@param self Tree self
---@param ScrollBarColor color Color of the scrollbar handle
function Tree:setScrollBarColor(self, ScrollBarColor) end

---Sets the value of the SelectedNode property.
---@param self Tree self
---@param SelectedNode table nil Currently selected node
function Tree:setSelectedNode(self, SelectedNode) end

---Gets the value of the ScrollBarBackground property.
---@param self Tree self
---@return string "\127" Symbol used for the scrollbar background
function Tree:getScrollBarBackground(self) end

---Gets the value of the ScrollBarBackgroundColor property.
---@param self Tree self
---@return color gray Background color of the scrollbar
function Tree:getScrollBarBackgroundColor(self) end

---Gets the value of the ScrollBarColor property.
---@param self Tree self
---@return color lightGray Color of the scrollbar handle
function Tree:getScrollBarColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Tree:render() end

---Sets the value of the ExpandedNodes property.
---@param self Tree self
---@param ExpandedNodes table Table of nodes that are currently expanded
function Tree:setExpandedNodes(self, ExpandedNodes) end

---Collapses a node
---@param node table The node to collapse
---@return Tree self The Tree instance
function Tree:collapseNode(node) end

---Sets the value of the ScrollBarBackgroundColor property.
---@param self Tree self
---@param ScrollBarBackgroundColor color Background color of the scrollbar
function Tree:setScrollBarBackgroundColor(self, ScrollBarBackgroundColor) end

---Gets the value of the SelectedForegroundColor property.
---@param self Tree self
---@return color white foreground color of selected node
function Tree:getSelectedForegroundColor(self) end

---Gets the value of the ScrollBarSymbol property.
---@param self Tree self
---@return string " " Symbol used for the scrollbar handle
function Tree:getScrollBarSymbol(self) end

---Registers a callback for when a node is selected
---@param callback function The callback function
---@return Tree self The Tree instance
function Tree:onSelect(callback) end

---Sets the value of the ScrollBarBackground property.
---@param self Tree self
---@param ScrollBarBackground string Symbol used for the scrollbar background
function Tree:setScrollBarBackground(self, ScrollBarBackground) end

---@class Animation
local Animation = {}

---Adds a new animation to the sequence
---@param type string The type of animation
---@param args table The animation arguments
---@param duration number The duration in seconds
---@param easing string The easing function name
function Animation:addAnimation(type, args, duration, easing) end

---Registers a callback for the update event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onUpdate(callback) end

---Registers a callback for the start event
---@param callback function The callback function to register
function Animation:onStart(callback) end

---Registers a new animation type
---@param name string The name of the animation
---@param handlers table Table containing start, update and complete handlers
function Animation.registerAnimation(name, handlers) end

---Starts the animation
---@return Animation self The animation instance
function Animation:start() end

---Registers a callback for the complete event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onComplete(callback) end

---Registers a new easing function
---@param name string The name of the easing function
---@param func function The easing function (takes progress 0-1, returns modified progress)
function Animation.registerEasing(name, func) end

---Creates a new Animation
---@param element VisualElement The element to animate
---@return Animation The new animation
function Animation.new(element) end

---Creates a new sequence
---@return Animation self The animation instance
function Animation:sequence() end

---Stops the animation immediately: cancels timers, completes running anim instances and clears the element property
function Animation:stop() end

---The event handler for the animation (listens to timer events)
---@param event string The event type
---@param timerId number The timer ID
function Animation:event(event, timerId) end

---@class ContextMenu : Container
---@field itemHeight number Height of each menu item
---@field openSubmenu table Currently open submenu data
---@field isOpen boolean Whether the menu is currently open
---@field items table List of menu items
local ContextMenu = {}

---Sets the value of the OpenSubmenu property.
---@param self ContextMenu self
---@param OpenSubmenu table Currently open submenu data
function ContextMenu:setOpenSubmenu(self, OpenSubmenu) end

---Gets the value of the OpenSubmenu property.
---@param self ContextMenu self
---@return table nil Currently open submenu data
function ContextMenu:getOpenSubmenu(self) end

---Sets the menu items
---@param items table Array of item definitions
---@return ContextMenu self For method chaining
function ContextMenu:setItems(items) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ContextMenu:render() end

---Gets the value of the Items property.
---@param self ContextMenu self
---@return table {} List of menu items
function ContextMenu:getItems(self) end

---Sets the value of the ItemHeight property.
---@param self ContextMenu self
---@param ItemHeight number Height of each menu item
function ContextMenu:setItemHeight(self, ItemHeight) end

---Opens the menu
---@return ContextMenu self For method chaining
function ContextMenu:open() end

---Sets the value of the IsOpen property.
---@param self ContextMenu self
---@param IsOpen boolean Whether the menu is currently open
function ContextMenu:setIsOpen(self, IsOpen) end

---Closes the entire menu chain (parent and all submenus)
---@return ContextMenu self For method chaining
function ContextMenu:closeAll() end

---Gets the value of the ItemHeight property.
---@param self ContextMenu self
---@return number 1 Height of each menu item
function ContextMenu:getItemHeight(self) end

---Closes the menu and any submenus
---@return ContextMenu self For method chaining
function ContextMenu:close() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ContextMenu:mouse_click() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function ContextMenu:init(props, basalt) end

---Gets the value of the IsOpen property.
---@param self ContextMenu self
---@return boolean false Whether the menu is currently open
function ContextMenu:getIsOpen(self) end

---@class SideNav : Container
---@field sidebarScrollOffset number Current scroll offset for navigation items in scrollable mode
---@field sidebarPosition string Position of the sidebar ("left" or "right")
---@field activeTab number The currently active navigation item ID
---@field tabs table List of navigation item definitions
---@field sidebarBackground color Background color for the sidebar area
---@field sidebarWidth number Width of the sidebar navigation area
---@field activeTabTextColor color Foreground color for the active navigation item text
---@field activeTabBackground color Background color for the active navigation item
local SideNav = {}

---Gets the value of the ActiveTab property.
---@param self SideNav self
---@return number nil The currently active navigation item ID
function SideNav:getActiveTab(self) end

---Scrolls the sidebar up or down
---@param direction number -1 to scroll up, 1 to scroll down
---@return SideNav self For method chaining
function SideNav:scrollSidebar(direction) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function SideNav:init(props, basalt) end

---returns a proxy for adding elements to the navigation item
---@param title string The title of the navigation item
---@return table tabHandler The navigation item handler proxy for adding elements
function SideNav:newTab(title) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click (global)
---@param y number The y position of the click (global)
---@return boolean Whether the event was handled
---@protected
function SideNav:mouse_click(button, x, y) end

function SideNav:getRelativePosition() end

---Gets the value of the ActiveTabBackground property.
---@param self SideNav self
---@return color white Background color for the active navigation item
function SideNav:getActiveTabBackground(self) end

---Gets the value of the Tabs property.
---@param self SideNav self
---@return table {} List of navigation item definitions
function SideNav:getTabs(self) end

---Sets the value of the SidebarWidth property.
---@param self SideNav self
---@param SidebarWidth number Width of the sidebar navigation area
function SideNav:setSidebarWidth(self, SidebarWidth) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param child table The child element to check
---@return boolean Whether the child should be visible
---@protected
function SideNav:isChildVisible(child) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return number xOffset The X offset for content
---@protected
function SideNav:getContentXOffset() end

function SideNav:mouse_drag() end

function SideNav:drawBg() end

---Gets the value of the SidebarWidth property.
---@param self SideNav self
---@return number 12 Width of the sidebar navigation area
function SideNav:getSidebarWidth(self) end

---Gets the value of the SidebarPosition property.
---@param self SideNav self
---@return string left Position of the sidebar ("left" or "right")
function SideNav:getSidebarPosition(self) end

function SideNav:textFg() end

---Sets the value of the SidebarBackground property.
---@param self SideNav self
---@param SidebarBackground color Background color for the sidebar area
function SideNav:setSidebarBackground(self, SidebarBackground) end

---Sets the value of the ActiveTabBackground property.
---@param self SideNav self
---@param ActiveTabBackground color Background color for the active navigation item
function SideNav:setActiveTabBackground(self, ActiveTabBackground) end

function SideNav:mouse_scroll() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function SideNav:sortChildrenEvents() end

function SideNav:drawFg() end

---Sets the value of the ActiveTabTextColor property.
---@param self SideNav self
---@param ActiveTabTextColor color Foreground color for the active navigation item text
function SideNav:setActiveTabTextColor(self, ActiveTabTextColor) end

function SideNav:textBg() end

---Sets the value of the Tabs property.
---@param self SideNav self
---@param Tabs table List of navigation item definitions
function SideNav:setTabs(self, Tabs) end

function SideNav:setCursor() end

---Sets the value of the SidebarScrollOffset property.
---@param self SideNav self
---@param SidebarScrollOffset number Current scroll offset for navigation items in scrollable mode
function SideNav:setSidebarScrollOffset(self, SidebarScrollOffset) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param child table The child element to add
---@return Container self For method chaining
---@protected
function SideNav:addChild(child) end

function SideNav:_getSidebarMetrics() end

---@param tabId number The ID of the navigation item to activate
function SideNav:setActiveTab(tabId) end

function SideNav:mouse_up() end

function SideNav:drawText() end

---@param element table The element to assign to a navigation item
---@param tabId number The ID of the navigation item to assign the element to
---@return SideNav self For method chaining
function SideNav:setTab(element, tabId) end

---Gets the value of the SidebarScrollOffset property.
---@param self SideNav self
---@return number 0 Current scroll offset for navigation items in scrollable mode
function SideNav:getSidebarScrollOffset(self) end

function SideNav:mouse_release() end

---Gets the value of the SidebarBackground property.
---@param self SideNav self
---@return color gray Background color for the sidebar area
function SideNav:getSidebarBackground(self) end

---Gets the value of the ActiveTabTextColor property.
---@param self SideNav self
---@return color black Foreground color for the active navigation item text
function SideNav:getActiveTabTextColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function SideNav:render() end

function SideNav:blit() end

---Sets the value of the SidebarPosition property.
---@param self SideNav self
---@param SidebarPosition string Position of the sidebar ("left" or "right")
function SideNav:setSidebarPosition(self, SidebarPosition) end

function SideNav:multiBlit() end

---@param elementType string The type of element to add
---@param tabId number Optional navigation item ID, defaults to active item
---@return table element The created element
function SideNav:addElement(elementType, tabId) end

function SideNav:mouse_move() end

---@class Collection : VisualElement
---@field selectable boolean Whether items can be selected
---@field multiSelection boolean Whether multiple items can be selected at once
---@field selectedForeground color Text color for selected items
---@field selectedBackground color Background color for selected items
local Collection = {}

function Collection:clearItemSelection() end

---Registers a callback for the select event
---@param callback function The callback function to register
---@return Collection self The Collection instance
function Collection:onSelect(callback) end

---Sets the value of the SelectedBackground property.
---@param self Collection self
---@param SelectedBackground color Background color for selected items
function Collection:setSelectedBackground(self, SelectedBackground) end

function Collection:unselectItem() end

---Sets the value of the SelectedForeground property.
---@param self Collection self
---@param SelectedForeground color Text color for selected items
function Collection:setSelectedForeground(self, SelectedForeground) end

---Selects the previous item in the collection
---@return Collection self The Collection instance
function Collection:selectPrevious() end

---Gets the value of the Selectable property.
---@param self Collection self
---@return boolean true Whether items can be selected
function Collection:getSelectable(self) end

---Gets the currently selected items
---@return table selected Collection of selected items
function Collection:getSelectedItems() end

---Clears all items from the Collection
---@return Collection self The Collection instance
function Collection:clear() end

---Gets the index of the first selected item
---@return number ? index The index of the first selected item, or nil if none selected
function Collection:getSelectedIndex() end

---Sets the value of the MultiSelection property.
---@param self Collection self
---@param MultiSelection boolean Whether multiple items can be selected at once
function Collection:setMultiSelection(self, MultiSelection) end

---Removes an item from the Collection
---@param index number The index of the item to remove
---@return Collection self The Collection instance
function Collection:removeItem(index) end

---Sets the value of the Selectable property.
---@param self Collection self
---@param Selectable boolean Whether items can be selected
function Collection:setSelectable(self, Selectable) end

function Collection:selectItem() end

---Gets the value of the SelectedBackground property.
---@param self Collection self
---@return color blue Background color for selected items
function Collection:getSelectedBackground(self) end

---Adds an item to the Collection
---@param text string |table The item to add (string or item table)
---@return Collection self The Collection instance
function Collection:addItem(text) end

---Selects the next item in the collection
---@return Collection self The Collection instance
function Collection:selectNext() end

---Registers a function to handle the onSelect event.
---@param index number
---@param item table
---@param self Collection self
---@param func function The function to be called when the event fires
function Collection:onOnSelect(self, func) end

---Gets the value of the SelectedForeground property.
---@param self Collection self
---@return color white Text color for selected items
function Collection:getSelectedForeground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Collection self The initialized instance
---@protected
function Collection:init(props, basalt) end

---Gets first selected item
---@return table ? selected The first item
function Collection:getSelectedItem() end

---Gets the value of the MultiSelection property.
---@param self Collection self
---@return boolean false Whether multiple items can be selected at once
function Collection:getMultiSelection(self) end

---@class basalt
local basalt = {}

---Removes a scheduled update
---@param func thread The scheduled function to remove
---@return boolean success Whether the scheduled function was removed
function basalt.removeSchedule(func) end

---Removes a callback function for a specific event
---@param eventName string The name of the event
---@param callback function The callback function to remove
---@return boolean success Whether the callback was found and removed
function basalt.removeEvent(eventName, callback) end

---Returns the error manager instance
---@return table ErrorManager The error manager
function basalt.getErrorManager() end

---Returns the active frame
---@return BaseFrame ? BaseFrame The frame to set as active
function basalt.getActiveFrame() end

---Returns a Plugin API
---@param name string The name of the plugin
---@return table Plugin The plugin API
function basalt.getAPI(name) end

---Returns an element's class without creating a instance
---@param name string The name of the element
---@return table Element The element class
function basalt.getElementClass(name) end

---Stops the Basalt runtime
function basalt.stop() end

---Requires specific elements and validates they are available
---@param elements table |string List of element names or single element name
function basalt.requireElements(elements) end

---Sets a frame as focused
---@param frame BaseFrame The frame to set as focused
function basalt.setFocus(frame) end

---Installs an element interactively or from a specified source
---@param elementName string The name of the element to install
function basalt.install(elementName) end

---Starts the Basalt runtime
function basalt.run() end

---Creates and returns a new BaseFrame
---@return BaseFrame BaseFrame The created frame instance
function basalt.createFrame() end

---Loads a manifest file that describes element requirements and configuration
---@param path string The path to the manifest file
---@return table manifest The loaded manifest data
function basalt.loadManifest(path) end

---Sets the active frame
---@param frame BaseFrame The frame to set as active
function basalt.setActiveFrame(frame) end

---Creates and returns a new UI element of the specified type.
---@param type string The type of element to create (e.g. "Button", "Label", "BaseFrame")
---@return table element The created element instance
function basalt.create(type) end

---Returns the focused frame
---@return BaseFrame ? BaseFrame The focused frame
function basalt.getFocus() end

---Runs basalt once, can be used to update the UI manually, but you have to feed it the events
function basalt.update() end

---Gets or creates the main frame
---@return BaseFrame BaseFrame The main frame instance
function basalt.getMainFrame() end

---Schedules a function to run in a coroutine
---@param func function The function to schedule
---@return thread func The scheduled function
function basalt.schedule(func) end

---Returns the element manager instance
---@return table ElementManager The element manager
function basalt.getElementManager() end

---Registers a callback function for a specific event
---@param eventName string The name of the event to listen for (e.g. "mouse_click", "key", "timer")
---@param callback function The callback function to execute when the event occurs
function basalt.onEvent(eventName, callback) end

---Triggers a custom event and calls all registered callbacks
---@param eventName string The name of the event to trigger
function basalt.triggerEvent(eventName) end

---Configures the ElementManager (shortcut to elementManager.configure)
---@param config table Configuration options
function basalt.configure(config) end

---@class Input : VisualElement
---@field cursorColor number Color of the cursor
---@field cursorPos number The current cursor position in the text
---@field pattern string nil Regular expression pattern for input validation
---@field placeholderColor color Color of the placeholder text
---@field maxLength number nil Maximum length of input text (optional)
---@field replaceChar string Character to replace the input with (for password fields)
---@field viewOffset number The horizontal scroll offset for viewing long text
---@field text string The current text content of the input
---@field placeholder string Text to display when input is empty
local Input = {}

---Gets the value of the PlaceholderColor property.
---@param self Input self
---@return color gray Color of the placeholder text
function Input:getPlaceholderColor(self) end

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

---Gets the value of the Text property.
---@param self Input self
---@return string - The current text content of the input
function Input:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Input self The initialized instance
---@protected
function Input:init(props, basalt) end

---Sets the value of the ViewOffset property.
---@param self Input self
---@param ViewOffset number The horizontal scroll offset for viewing long text
function Input:setViewOffset(self, ViewOffset) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:paste() end

---Gets the value of the MaxLength property.
---@param self Input self
---@return number ? nil Maximum length of input text (optional)
function Input:getMaxLength(self) end

---Gets the value of the CursorColor property.
---@param self Input self
---@return number nil Color of the cursor
function Input:getCursorColor(self) end

---Updates the input's viewport
---@return Input self The updated instance
function Input:updateViewport() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:focus() end

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

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function Input:char(char) end

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

---Sets the value of the ReplaceChar property.
---@param self Input self
---@param ReplaceChar string Character to replace the input with (for password fields)
function Input:setReplaceChar(self, ReplaceChar) end

---Gets the value of the CursorPos property.
---@param self Input self
---@return number 1 The current cursor position in the text
function Input:getCursorPos(self) end

---Sets the value of the CursorColor property.
---@param self Input self
---@param CursorColor number Color of the cursor
function Input:setCursorColor(self, CursorColor) end

---Gets the value of the Pattern property.
---@param self Input self
---@return string ? nil Regular expression pattern for input validation
function Input:getPattern(self) end

---Sets the value of the Text property.
---@param self Input self
---@param Text string The current text content of the input
function Input:setText(self, Text) end

---Sets the value of the Placeholder property.
---@param self Input self
---@param Placeholder string Text to display when input is empty
function Input:setPlaceholder(self, Placeholder) end

---Sets the value of the PlaceholderColor property.
---@param self Input self
---@param PlaceholderColor color Color of the placeholder text
function Input:setPlaceholderColor(self, PlaceholderColor) end

---Gets the value of the ViewOffset property.
---@param self Input self
---@return number 0 The horizontal scroll offset for viewing long text
function Input:getViewOffset(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:blur() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Input:key(key) end

---@class PropertySystem
local PropertySystem = {}

---Combines multiple properties into a single getter and setter
---@param class table The element class to combine the properties for
---@param name string The name of the combined property
function PropertySystem.combineProperties(class, name) end

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

---Adds a setter hook to the PropertySystem. Setter hooks are functions that are called before a property is set.
---@param hook function The hook function to add
function PropertySystem.addSetterHook(hook) end

---Gets a property configuration
---@param name string The name of the property
---@return table config The configuration of the property
function PropertySystem:getPropertyConfig(name) end

---Initializes the PropertySystem IS USED INTERNALLY
---@return table self The PropertySystem
function PropertySystem:__init() end

---Removes a property from the PropertySystem on instance level
---@param name string The name of the property
---@return table self The PropertySystem
function PropertySystem:removeProperty(name) end

---Creates an element from a blueprint
---@param elementClass table The element class to create from the blueprint
---@param blueprint table The blueprint to create the element from
---@return table element The created element
function PropertySystem.createFromBlueprint(elementClass, blueprint) end

---Update call for a property IS USED INTERNALLY
---@param name string The name of the property
---@param value any The value of the property
---@return table self The PropertySystem
function PropertySystem:_updateProperty(name, value) end

---Removes all observers from a property
---@return table self The PropertySystem
function PropertySystem:removeAllObservers() end

---Creates a blueprint of an element class with all its properties
---@param elementClass table The element class to create a blueprint from
---@return table blueprint A table containing all property definitions
function PropertySystem.blueprint(elementClass) end

---Defines a property for an element class
---@param class table The element class to define the property for
---@param name string The name of the property
---@param config table The configuration of the property
function PropertySystem.defineProperty(class, name, config) end

---Observers a property
---@param name string The name of the property
---@param callback function The callback function to call when the property changes
---@return table self The PropertySystem
function PropertySystem:observe(name, callback) end

