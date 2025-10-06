---@meta

---@class FlexBox : Container
---@field flexJustifyContent string The alignment of flex items along the main axis
---@field flexDirection string The direction of the flexbox layout "row" or "column"
---@field flexSpacing number The spacing between flex items
---@field flexAlignItems string The alignment of flex items along the cross axis
---@field flexUpdateLayout boolean Whether to update the layout of the flexbox
---@field flexWrap boolean Whether to wrap flex items onto multiple lines
---@field flexCrossPadding number The padding on both sides of the cross axis
local FlexBox = {}

---Gets the value of the FlexAlignItems property.
---@param self FlexBox self
---@return string "flex-start" The alignment of flex items along the cross axis
function FlexBox:getFlexAlignItems(self) end

---Sets the value of the FlexUpdateLayout property.
---@param self FlexBox self
---@param FlexUpdateLayout boolean Whether to update the layout of the flexbox
function FlexBox:setFlexUpdateLayout(self, FlexUpdateLayout) end

---Sets the value of the FlexCrossPadding property.
---@param self FlexBox self
---@param FlexCrossPadding number The padding on both sides of the cross axis
function FlexBox:setFlexCrossPadding(self, FlexCrossPadding) end

---Sets the value of the FlexSpacing property.
---@param self FlexBox self
---@param FlexSpacing number The spacing between flex items
function FlexBox:setFlexSpacing(self, FlexSpacing) end

---Adds a child element to the flexbox
---@param element Element The child element to add
---@return FlexBox self The flexbox instance
function FlexBox:addChild(element) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function FlexBox:render() end

---Adds a new line break to the flexbox
---@param self FlexBox The element itself
---@return FlexBox 
function FlexBox:addLineBreak(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param element Element The child element to remove
---@return FlexBox self The flexbox instance
---@protected
function FlexBox:removeChild(element) end

---Sets the value of the FlexAlignItems property.
---@param self FlexBox self
---@param FlexAlignItems string The alignment of flex items along the cross axis
function FlexBox:setFlexAlignItems(self, FlexAlignItems) end

---Sets the value of the FlexWrap property.
---@param self FlexBox self
---@param FlexWrap boolean Whether to wrap flex items onto multiple lines
function FlexBox:setFlexWrap(self, FlexWrap) end

---Gets the value of the FlexDirection property.
---@param self FlexBox self
---@return string "row" The direction of the flexbox layout "row" or "column"
function FlexBox:getFlexDirection(self) end

---Sets the value of the FlexDirection property.
---@param self FlexBox self
---@param FlexDirection string The direction of the flexbox layout "row" or "column"
function FlexBox:setFlexDirection(self, FlexDirection) end

---Sets the value of the FlexJustifyContent property.
---@param self FlexBox self
---@param FlexJustifyContent string The alignment of flex items along the main axis
function FlexBox:setFlexJustifyContent(self, FlexJustifyContent) end

---Gets the value of the FlexJustifyContent property.
---@param self FlexBox self
---@return string "flex-start" The alignment of flex items along the main axis
function FlexBox:getFlexJustifyContent(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return FlexBox self The initialized instance
---@protected
function FlexBox:init(props, basalt) end

---Gets the value of the FlexCrossPadding property.
---@param self FlexBox self
---@return number 0 The padding on both sides of the cross axis
function FlexBox:getFlexCrossPadding(self) end

---Gets the value of the FlexWrap property.
---@param self FlexBox self
---@return boolean false Whether to wrap flex items onto multiple lines
function FlexBox:getFlexWrap(self) end

---Gets the value of the FlexSpacing property.
---@param self FlexBox self
---@return number 1 The spacing between flex items
function FlexBox:getFlexSpacing(self) end

---Gets the value of the FlexUpdateLayout property.
---@param self FlexBox self
---@return boolean false Whether to update the layout of the flexbox
function FlexBox:getFlexUpdateLayout(self) end

---@class Tree : VisualElement
---@field scrollOffset number Current vertical scroll position
---@field nodeColor color Color of unselected nodes
---@field horizontalOffset number Current horizontal scroll position
---@field selectedColor color Background color of selected node
---@field selectedNode table nil Currently selected node
---@field expandedNodes table Table of nodes that are currently expanded
---@field nodes table The tree structure containing node objects with {text, children} properties
local Tree = {}

---Gets the size of the tree
---@return number width The width of the tree
---@return number height The height of the tree
function Tree:getNodeSize() end

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

---Sets the value of the ExpandedNodes property.
---@param self Tree self
---@param ExpandedNodes table Table of nodes that are currently expanded
function Tree:setExpandedNodes(self, ExpandedNodes) end

---Expands a node
---@param node table The node to expand
---@return Tree self The Tree instance
function Tree:expandNode(node) end

---Sets the value of the NodeColor property.
---@param self Tree self
---@param NodeColor color Color of unselected nodes
function Tree:setNodeColor(self, NodeColor) end

---Gets the value of the ScrollOffset property.
---@param self Tree self
---@return number 0 Current vertical scroll position
function Tree:getScrollOffset(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_scroll(direction, x, y) end

---Gets the value of the NodeColor property.
---@param self Tree self
---@return color white Color of unselected nodes
function Tree:getNodeColor(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Tree:render() end

---Gets the value of the SelectedNode property.
---@param self Tree self
---@return table ? nil Currently selected node
function Tree:getSelectedNode(self) end

---Registers a callback for when a node is selected
---@param callback function The callback function
---@return Tree self The Tree instance
function Tree:onSelect(callback) end

---Collapses a node
---@param node table The node to collapse
---@return Tree self The Tree instance
function Tree:collapseNode(node) end

---Gets the value of the HorizontalOffset property.
---@param self Tree self
---@return number 0 Current horizontal scroll position
function Tree:getHorizontalOffset(self) end

---Sets the value of the SelectedColor property.
---@param self Tree self
---@param SelectedColor color Background color of selected node
function Tree:setSelectedColor(self, SelectedColor) end

---Sets the value of the SelectedNode property.
---@param self Tree self
---@param SelectedNode table nil Currently selected node
function Tree:setSelectedNode(self, SelectedNode) end

---Gets the value of the ExpandedNodes property.
---@param self Tree self
---@return table {} Table of nodes that are currently expanded
function Tree:getExpandedNodes(self) end

---Handles mouse click events
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Tree:mouse_click(button, x, y) end

---Sets the value of the HorizontalOffset property.
---@param self Tree self
---@param HorizontalOffset number Current horizontal scroll position
function Tree:setHorizontalOffset(self, HorizontalOffset) end

---Gets the value of the SelectedColor property.
---@param self Tree self
---@return color lightBlue Background color of selected node
function Tree:getSelectedColor(self) end

---Sets the value of the ScrollOffset property.
---@param self Tree self
---@param ScrollOffset number Current vertical scroll position
function Tree:setScrollOffset(self, ScrollOffset) end

---Gets the value of the Nodes property.
---@param self Tree self
---@return table {} The tree structure containing node objects with {text, children} properties
function Tree:getNodes(self) end

---Sets the value of the Nodes property.
---@param self Tree self
---@param Nodes table The tree structure containing node objects with {text, children} properties
function Tree:setNodes(self, Nodes) end

---@class Reactive
local Reactive = {}

---@class Program : VisualElement
---@field program table The program instance
---@field doneCallback function The done callback function
---@field path string The path to the program
---@field errorCallback function The error callback function
---@field running boolean Whether the program is running
local Program = {}

---Registers a callback for the program's error event, if the function returns false, the program won't stop
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onError(fn) end

---Sets the value of the ErrorCallback property.
---@param self Program self
---@param ErrorCallback function The error callback function
function Program:setErrorCallback(self, ErrorCallback) end

---Sets the value of the DoneCallback property.
---@param self Program self
---@param DoneCallback function The done callback function
function Program:setDoneCallback(self, DoneCallback) end

---Sets the value of the Path property.
---@param self Program self
---@param Path string The path to the program
function Program:setPath(self, Path) end

---Gets the value of the ErrorCallback property.
---@param self Program self
---@return function nil The error callback function
function Program:getErrorCallback(self) end

---Executes a program
---@param path string The path to the program
---@return Program self The Program instance
function Program:execute(path) end

---Gets the value of the DoneCallback property.
---@param self Program self
---@return function nil The done callback function
function Program:getDoneCallback(self) end

---Registers a callback for the program's done event
---@param fn function The callback function to register
---@return Program self The Program instance
function Program:onDone(fn) end

function BasaltProgram:setArgs() end

---Gets the value of the Program property.
---@param self Program self
---@return table nil The program instance
function Program:getProgram(self) end

---Gets the value of the Running property.
---@param self Program self
---@return boolean false Whether the program is running
function Program:getRunning(self) end

---Stops the program
---@return Program self The Program instance
function Program:stop() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:focus() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return any result The event result
---@protected
function Program:dispatchEvent(event) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Program:render() end

---Gets the value of the Path property.
---@param self Program self
---@return string "" The path to the program
function Program:getPath(self) end

---Sends an event to the program
---@param event string The event to send
---@return Program self The Program instance
function Program:sendEvent(event) end

---Sets the value of the Program property.
---@param self Program self
---@param Program table The program instance
function Program:setProgram(self, Program) end

---Sets the value of the Running property.
---@param self Program self
---@param Running boolean Whether the program is running
function Program:setRunning(self, Running) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Program self The initialized instance
---@protected
function Program:init(props, basalt) end

---@class TabControl : Container
---@field headerBackground color color for the tab header area
---@field tabs table of tab definitions
---@field activeTab number currently active tab ID
---@field activeTabTextColor color color for the active tab text
---@field activeTabBackground color color for the active tab
---@field tabHeight number of the tab header area
local TabControl = {}

function TabControl:mouse_up() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param child table The child element to add
---@return Container self For method chaining
---@protected
function TabControl:addChild(child) end

---Gets the value of the ActiveTabTextColor property.
---@param self TabControl self
---@return color Foreground color for the active tab text
function TabControl:getActiveTabTextColor(self) end

---returns a proxy for adding elements to the tab
---@param title string The title of the tab
---@return table tabHandler The tab handler proxy for adding elements to the new tab
function TabControl:newTab(title) end

function TabControl:_getHeaderMetrics() end

---Gets the value of the ActiveTab property.
---@param self TabControl self
---@return number The currently active tab ID
function TabControl:getActiveTab(self) end

---@param element table The element to assign to a tab
---@param tabId number The ID of the tab to assign the element to
---@return TabControl self For method chaining
function TabControl:setTab(element, tabId) end

---Gets the value of the ActiveTabBackground property.
---@param self TabControl self
---@return color Background color for the active tab
function TabControl:getActiveTabBackground(self) end

function TabControl:setCursor() end

---Sets the value of the ActiveTabTextColor property.
---@param self TabControl self
---@param ActiveTabTextColor color color for the active tab text
function TabControl:setActiveTabTextColor(self, ActiveTabTextColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TabControl:sortChildrenEvents() end

---Sets the value of the TabHeight property.
---@param self TabControl self
---@param TabHeight number of the tab header area
function TabControl:setTabHeight(self, TabHeight) end

---Sets the value of the Tabs property.
---@param self TabControl self
---@param Tabs table of tab definitions
function TabControl:setTabs(self, Tabs) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TabControl:render() end

function TabControl:drawFg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function TabControl:init(props, basalt) end

function TabControl:mouse_move() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param child table The child element to check
---@return boolean Whether the child should be visible
---@protected
function TabControl:isChildVisible(child) end

---Gets the value of the HeaderBackground property.
---@param self TabControl self
---@return color Background color for the tab header area
function TabControl:getHeaderBackground(self) end

function TabControl:blit() end

---Sets the value of the ActiveTabBackground property.
---@param self TabControl self
---@param ActiveTabBackground color color for the active tab
function TabControl:setActiveTabBackground(self, ActiveTabBackground) end

function TabControl:mouse_scroll() end

function TabControl:mouse_drag() end

---@param elementType string The type of element to add
---@param tabId number Optional tab ID, defaults to active tab
---@return table element The created element
function TabControl:addElement(elementType, tabId) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click (global)
---@param y number The y position of the click (global)
---@return boolean Whether the event was handled
---@protected
function TabControl:mouse_click(button, x, y) end

function TabControl:multiBlit() end

---Sets the value of the HeaderBackground property.
---@param self TabControl self
---@param HeaderBackground color color for the tab header area
function TabControl:setHeaderBackground(self, HeaderBackground) end

function TabControl:textBg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return number yOffset The Y offset for content
---@protected
function TabControl:getContentYOffset() end

---@param tabId number The ID of the tab to activate
function TabControl:setActiveTab(tabId) end

function TabControl:textFg() end

function TabControl:drawText() end

function TabControl:mouse_release() end

function TabControl:getRelativePosition() end

---Gets the value of the Tabs property.
---@param self TabControl self
---@return table List of tab definitions
function TabControl:getTabs(self) end

---Gets the value of the TabHeight property.
---@param self TabControl self
---@return number Height of the tab header area
function TabControl:getTabHeight(self) end

function TabControl:drawBg() end

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

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Label:render() end

---Sets the value of the AutoSize property.
---@param self Label self
---@param AutoSize boolean Whether the label should automatically resize its width based on the text content
function Label:setAutoSize(self, AutoSize) end

---Gets the value of the AutoSize property.
---@param self Label self
---@return boolean true Whether the label should automatically resize its width based on the text content
function Label:getAutoSize(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Label self The initialized instance
---@protected
function Label:init(props, basalt) end

---Gets the wrapped lines of the Label
---@return table wrappedText The wrapped lines of the Label
function Label:getWrappedText() end

---@class basalt
local basalt = {}

---Sets the active frame
---@param frame BaseFrame The frame to set as active
function basalt.setActiveFrame(frame) end

---Triggers a custom event and calls all registered callbacks
---@param eventName string The name of the event to trigger
function basalt.triggerEvent(eventName) end

---Removes a callback function for a specific event
---@param eventName string The name of the event
---@param callback function The callback function to remove
---@return boolean success Whether the callback was found and removed
function basalt.removeEvent(eventName, callback) end

---Runs basalt once, can be used to update the UI manually, but you have to feed it the events
function basalt.update() end

---Returns a Plugin API
---@param name string The name of the plugin
---@return table Plugin The plugin API
function basalt.getAPI(name) end

---Returns the error manager instance
---@return table ErrorManager The error manager
function basalt.getErrorManager() end

---Schedules a function to run in a coroutine
---@param func function The function to schedule
---@return thread func The scheduled function
function basalt.schedule(func) end

---Starts the Basalt runtime
function basalt.run() end

---Registers a callback function for a specific event
---@param eventName string The name of the event to listen for (e.g. "mouse_click", "key", "timer")
---@param callback function The callback function to execute when the event occurs
function basalt.onEvent(eventName, callback) end

---Stops the Basalt runtime
function basalt.stop() end

---Gets or creates the main frame
---@return BaseFrame BaseFrame The main frame instance
function basalt.getMainFrame() end

---Returns an element's class without creating a instance
---@param name string The name of the element
---@return table Element The element class
function basalt.getElementClass(name) end

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

---Returns the active frame
---@return BaseFrame ? BaseFrame The frame to set as active
function basalt.getActiveFrame() end

---Removes a scheduled update
---@param func thread The scheduled function to remove
---@return boolean success Whether the scheduled function was removed
function basalt.removeSchedule(func) end

---Returns the focused frame
---@return BaseFrame ? BaseFrame The focused frame
function basalt.getFocus() end

---Returns the element manager instance
---@return table ElementManager The element manager
function basalt.getElementManager() end

---@class PropertySystem
local PropertySystem = {}

---Creates a blueprint of an element class with all its properties
---@param elementClass table The element class to create a blueprint from
---@return table blueprint A table containing all property definitions
function PropertySystem.blueprint(elementClass) end

---Creates an element from a blueprint
---@param elementClass table The element class to create from the blueprint
---@param blueprint table The blueprint to create the element from
---@return table element The created element
function PropertySystem.createFromBlueprint(elementClass, blueprint) end

---Gets a property configuration
---@param name string The name of the property
---@return table config The configuration of the property
function PropertySystem:getPropertyConfig(name) end

---Removes all observers from a property
---@return table self The PropertySystem
function PropertySystem:removeAllObservers() end

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

---Observers a property
---@param name string The name of the property
---@param callback function The callback function to call when the property changes
---@return table self The PropertySystem
function PropertySystem:observe(name, callback) end

---Removes a property from the PropertySystem on instance level
---@param name string The name of the property
---@return table self The PropertySystem
function PropertySystem:removeProperty(name) end

---Combines multiple properties into a single getter and setter
---@param class table The element class to combine the properties for
---@param name string The name of the combined property
function PropertySystem.combineProperties(class, name) end

---Removes an observer from a property
---@param name string The name of the property
---@param callback function The callback function to remove
---@return table self The PropertySystem
function PropertySystem:removeObserver(name, callback) end

---Initializes the PropertySystem IS USED INTERNALLY
---@return table self The PropertySystem
function PropertySystem:__init() end

---Adds a property to the PropertySystem on instance level
---@param name string The name of the property
---@param config table The configuration of the property
---@return table self The PropertySystem
function PropertySystem:instanceProperty(name, config) end

---@class Button : VisualElement
---@field text string Label text displayed centered within the button
local Button = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Button:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Button:init(props, basalt) end

---Gets the value of the Text property.
---@param self Button self
---@return string Button Label text displayed centered within the button
function Button:getText(self) end

---Sets the value of the Text property.
---@param self Button self
---@param Text string Label text displayed centered within the button
function Button:setText(self, Text) end

---@class ElementManager
local ElementManager = {}

---Gets an element by name. If the element is not loaded, it will try to load it first.
---@param name string The name of the element to get
---@return table Element The element class
function ElementManager.getElement(name) end

---Gets an Plugin API by name
---@param name string The name of the API to get
---@return table API The API
function ElementManager.getAPI(name) end

---Loads an element by name. This will load the element and apply any plugins to it.
---@param name string The name of the element to load
function ElementManager.loadElement(name) end

---Gets a list of all elements
---@return table ElementList A list of all elements
function ElementManager.getElementList() end

---@class ErrorHandler
local ErrorHandler = {}

---Handles an error
---@param errMsg string The error message
function errorHandler.error(errMsg) end

---@class BaseElement : PropertySystem
---@field type string A hierarchical identifier of the element's type chain
---@field eventCallbacks table Collection of registered event handler functions
---@field enabled boolean Controls event processing for this element
---@field id string Auto-generated unique identifier for element lookup
---@field name string User-defined name for the element
local BaseElement = {}

---Gets the value of a state
---@param self BaseElement The element to get state from
---@param name string The name of the state
---@return any value The current state value
function BaseElement:getState(self, name) end

---Defines a class-level event callback method with automatic event registration
---@param class table The class to register
---@param callbackName string The name of the callback to register
function BaseElement.registerEventCallback(class, callbackName) end

---Gets the value of the Enabled property.
---@param self BaseElement self
---@return boolean BaseElement Controls event processing for this element
function BaseElement:getEnabled(self) end

---Applies the current theme to this element
---@param self BaseElement The element to apply theme to
---@param applyToChildren boolean ? Whether to apply theme to child elements (default: true)
---@return BaseElement self The element instance
function BaseElement:applyTheme(self, applyToChildren) end

---Propagates render request up the element tree
---@return table self The BaseElement instance
function BaseElement:updateRender() end

---Removes the element from UI tree and cleans up resources
function BaseElement:destroy() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:handleEvent(event) end

---Enables benchmarking for a method
---@param methodName string The name of the method to benchmark
---@return BaseElement self The element instance
function BaseElement:benchmark(methodName) end

---Registers a callback for state changes
---@param self BaseElement The element to watch
---@param stateName string The state to watch
---@param callback function Called with (element, newValue, oldValue)
---@return BaseElement self The element instance
function BaseElement:onStateChange(self, stateName, callback) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseElement:init(props, basalt) end

---Enables debugging for this element
---@param self BaseElement The element to debug
---@param level number The debug level
function BaseElement.debug(self, level) end

---Traverses parent chain to locate the root frame element
---@return BaseFrame BaseFrame The base frame of the element
function BaseElement:getBaseFrame() end

---Stops benchmarking for a method
---@param methodName string The name of the method to stop benchmarking
---@return BaseElement self The element instance
function BaseElement:stopBenchmark(methodName) end

---Checks if the element matches or inherits from the specified type
---@param type string The type to check for
---@return boolean isType Whether the element is of the specified type
function BaseElement:isType(type) end

---Ends profiling a method
---@param methodName string The name of the method to stop profiling
---@return BaseElement self The element instance
function BaseElement:endProfile(methodName) end

function BaseElement:computed() end

---Dumps debug information for this element
---@param self BaseElement The element to dump debug info for
function BaseElement.dumpDebug(self) end

---Sets the value of the Enabled property.
---@param self BaseElement self
---@param Enabled boolean Controls event processing for this element
function BaseElement:setEnabled(self, Enabled) end

---Sets the value of the Id property.
---@param self BaseElement self
---@param Id string Auto-generated unique identifier for element lookup
function BaseElement:setId(self, Id) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean ? handled Whether the event was handled
---@protected
function BaseElement:dispatchEvent(event) end

---Sets the value of the Name property.
---@param self BaseElement self
---@param Name string User-defined name for the element
function BaseElement:setName(self, Name) end

---Sets the value of the Type property.
---@param self BaseElement self
---@param Type string A hierarchical identifier of the element's type chain
function BaseElement:setType(self, Type) end

---Sets the value of the EventCallbacks property.
---@param self BaseElement self
---@param EventCallbacks table Collection of registered event handler functions
function BaseElement:setEventCallbacks(self, EventCallbacks) end

---Gets the theme properties for this element
---@param self BaseElement The element to get theme for
---@return table styles The theme properties
function BaseElement:getTheme(self) end

---Removes a state change observer
---@param self BaseElement The element to remove observer from
---@param stateName string The state to remove observer from
---@param callback function The callback function to remove
---@return BaseElement self The element instance
function BaseElement:removeStateChange(self, stateName, callback) end

---Binds a property to a state
---@param self BaseElement The element to bind
---@param propertyName string The property to bind
---@param stateName string The state to bind to (optional, uses propertyName if not provided)
---@return BaseElement self The element instance
function BaseElement:bind(self, propertyName, stateName) end

---Gets the value of the EventCallbacks property.
---@param self BaseElement self
---@return table BaseElement Collection of registered event handler functions
function BaseElement:getEventCallbacks(self) end

---Registers a class-level event listener with optional dependency
---@param class table The class to register
---@param eventName string The name of the event to register
function BaseElement.defineEvent(class, eventName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return table self The BaseElement instance
---@protected
function BaseElement:postInit() end

---Sets the value of a state
---@param self BaseElement The element to set state for
---@param name string The name of the state
---@param value any The new value for the state
---@return BaseElement self The element instance
function BaseElement:setState(self, name, value) end

---Configures event listening behavior with automatic parent notification
---@param eventName string The name of the event to listen for
---@return table self The BaseElement instance
function BaseElement:listenEvent(eventName) end

---Adds an event handler function with automatic event registration
---@param event string The event to register the callback for
---@param callback function The callback function to register
---@return table self The BaseElement instance
function BaseElement:registerCallback(event, callback) end

---Gets the value of the Type property.
---@param self BaseElement self
---@return string BaseElement A hierarchical identifier of the element's type chain
function BaseElement:getType(self) end

---Gets benchmark statistics for a method
---@param methodName string The name of the method to get statistics for
---@return table ? stats The benchmark statistics or nil
function BaseElement:getBenchmarkStats(methodName) end

---Logs benchmark statistics for a method
---@param methodName string The name of the method to log
---@return BaseElement self The element instance
function BaseElement:logBenchmark(methodName) end

---Gets the value of the Id property.
---@param self BaseElement self
---@return string BaseElement Auto-generated unique identifier for element lookup
function BaseElement:getId(self) end

---Starts profiling a method
---@param methodName string The name of the method to profile
---@return BaseElement self The element instance
function BaseElement:startProfile(methodName) end

---Sets up a property change observer with immediate callback registration
---@param property string The property to observe
---@param callback function The callback to call when the property changes
---@return table self The BaseElement instance
function BaseElement:onChange(property, callback) end

---Gets the value of the Name property.
---@param self BaseElement self
---@return string BaseElement User-defined name for the element
function BaseElement:getName(self) end

---Executes all registered callbacks for the specified event
---@param event string The event to fire
---@return table self The BaseElement instance
function BaseElement:fireEvent(event) end

---@class AnimationInstance
local AnimationInstance = {}

---Gets called when the animation is completed
function AnimationInstance:complete() end

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

---Updates the animation
---@param elapsed number The elapsed time in seconds
---@return boolean Whether the animation is finished
function AnimationInstance:update(elapsed) end

---@class Container : VisualElement
---@field offsetY number Vertical scroll/content offset
---@field childrenEvents table Registered event handlers for all children
---@field visibleChildrenEvents table Event handlers for currently visible children
---@field childrenSorted boolean Indicates if children are sorted by z-index
---@field childrenEventsSorted boolean Indicates if event handlers are properly sorted
---@field focusedChild table Currently focused child element (receives keyboard events)
---@field children table Collection of all child elements
---@field eventListenerCount table Number of listeners per event type
---@field visibleChildren table Currently visible child elements (calculated based on viewport)
---@field offsetX number Horizontal scroll/content offset
local Container = {}

---Creates a new CheckBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return CheckBox element A new CheckBox element.
function Container:addCheckBox(self, props) end

---Gets the value of the FocusedChild property.
---@param self Container self
---@return table nil Currently focused child element (receives keyboard events)
function Container:getFocusedChild(self) end

---Creates a new Label element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Label element A new Label element.
function Container:addLabel(self, props) end

---Gets the value of the VisibleChildrenEvents property.
---@param self Container self
---@return table {} Event handlers for currently visible children
function Container:getVisibleChildrenEvents(self) end

---Creates a new Tree element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Tree element A new Tree element.
function Container:addTree(self, props) end

---Creates a new List element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return List element A new List element.
function Container:addList(self, props) end

---Gets the value of the ChildrenEvents property.
---@param self Container self
---@return table {} Registered event handlers for all children
function Container:getChildrenEvents(self) end

---Sets the value of the ChildrenEvents property.
---@param self Container self
---@param ChildrenEvents table Registered event handlers for all children
function Container:setChildrenEvents(self, ChildrenEvents) end

---Creates a new TabControl element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return TabControl element A new TabControl element.
function Container:addTabControl(self, props) end

---Creates a new DropDown element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return DropDown element A new DropDown element.
function Container:addDropDown(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@return boolean handled Whether the event was handled
---@protected
function Container:key_up(key) end

---Creates a new Menu element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Menu element A new Menu element.
function Container:addMenu(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Container:init(props, basalt) end

---Sets the value of the ChildrenEventsSorted property.
---@param self Container self
---@param ChildrenEventsSorted boolean Indicates if event handlers are properly sorted
function Container:setChildrenEventsSorted(self, ChildrenEventsSorted) end

---Re-sorts children by their z-index and updates visibility
---@return Container self For method chaining
function Container:sortChildren() end

---Creates a new BaseFrame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseFrame element A new BaseFrame element.
function Container:addBaseFrame(self, props) end

function Container:drawFg() end

---Creates a new ScrollBar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ScrollBar element A new ScrollBar element.
function Container:addScrollBar(self, props) end

---Creates a new Input element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Input element A new Input element.
function Container:addInput(self, props) end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@param eventName string The event name to unregister
---@return Container self The container instance
function Container:unregisterChildEvent(child, eventName) end

---Gets the value of the OffsetY property.
---@param self Container self
---@return number 0 Vertical scroll/content offset
function Container:getOffsetY(self) end

---Sets the value of the FocusedChild property.
---@param self Container self
---@param FocusedChild table Currently focused child element (receives keyboard events)
function Container:setFocusedChild(self, FocusedChild) end

---Gets the value of the OffsetX property.
---@param self Container self
---@return number 0 Horizontal scroll/content offset
function Container:getOffsetX(self) end

---Creates a new VisualElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return VisualElement element A new VisualElement element.
function Container:addVisualElement(self, props) end

function Container:drawText() end

function Container:drawBg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_scroll(direction, x, y) end

---Gets the value of the ChildrenEventsSorted property.
---@param self Container self
---@return boolean true Indicates if event handlers are properly sorted
function Container:getChildrenEventsSorted(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param bg color The background color of the text
---@return Container self The container instance
---@protected
function Container:textBg(x, y, text, bg) end

---Gets the value of the Children property.
---@param self Container self
---@return table {} Collection of all child elements
function Container:getChildren(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg color The foreground color of the text
---@return Container self The container instance
---@protected
function Container:textFg(x, y, text, fg) end

---Gets the value of the EventListenerCount property.
---@param self Container self
---@return table {} Number of listeners per event type
function Container:getEventListenerCount(self) end

---Locates a child element using a path-like syntax (e.g. "panel/button1")
---@param path string Path to the child (e.g. "panel/button1", "header/title")
---@return Element ? child The found element or nil if not found
function Container:getChild(path) end

---Unregisters the children events of the container
---@param child table The child to unregister events for
---@return Container self The container instance
function Container:removeChildrenEvents(child) end

---Gets the value of the VisibleChildren property.
---@param self Container self
---@return table {} Currently visible child elements (calculated based on viewport)
function Container:getVisibleChildren(self) end

---Creates a new Button element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Button element A new Button element.
function Container:addButton(self, props) end

---Enables debugging for this container and all its children
---@param self Container The container to debug
---@param level number The debug level
function Container.debugChildren(self, level) end

---Creates a new Container element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Container element A new Container element.
function Container:addContainer(self, props) end

---Stops benchmarking for a container and all its children
---@param methodName string The method to stop benchmarking
---@return Container self The container instance
function Container:stopContainerBenchmark(methodName) end

---Adds a new element to this container's hierarchy
---@param child table The element to add as a child
---@return Container self For method chaining
function Container:addChild(child) end

---Creates a new Display element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Display element A new Display element.
function Container:addDisplay(self, props) end

---Creates a new Graph element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Graph element A new Graph element.
function Container:addGraph(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_up(button, x, y) end

---Registers an event handler for a specific child element
---@param child table The child element to register events for
---@param eventName string The name of the event to register
---@return Container self For method chaining
function Container:registerChildEvent(child, eventName) end

---Creates a new ComboBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ComboBox element A new ComboBox element.
function Container:addComboBox(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@protected
function Container:mouse_release(button, x, y) end

---Creates a new Table element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Table element A new Table element.
function Container:addTable(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:key(key) end

---Gets the value of the ChildrenSorted property.
---@param self Container self
---@return boolean true Indicates if children are sorted by z-index
function Container:getChildrenSorted(self) end

---Sets the value of the VisibleChildrenEvents property.
---@param self Container self
---@param VisibleChildrenEvents table Event handlers for currently visible children
function Container:setVisibleChildrenEvents(self, VisibleChildrenEvents) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Container:render() end

---Sets the value of the EventListenerCount property.
---@param self Container self
---@param EventListenerCount table Number of listeners per event type
function Container:setEventListenerCount(self, EventListenerCount) end

---Creates a new BaseElement element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BaseElement element A new BaseElement element.
function Container:addBaseElement(self, props) end

---Registers the children events of the container
---@param child table The child to register events for
---@return Container self The container instance
function Container:registerChildrenEvents(child) end

---Calls a event on all children
---@param visibleOnly boolean Whether to only call the event on visible children
---@param event string The event to call
---@return boolean handled Whether the event was handled
---@return table ? child The child that handled the event
function Container:callChildrenEvent(visibleOnly, event) end

---Creates a new ProgressBar element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return ProgressBar element A new ProgressBar element.
function Container:addProgressBar(self, props) end

---Creates a new TextBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return TextBox element A new TextBox element.
function Container:addTextBox(self, props) end

---Logs benchmark statistics for a container and all its children
---@param methodName string The method to log
---@return Container self The container instance
function Container:logContainerBenchmarks(methodName) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_move(_, x, y) end

---Creates a new BarChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BarChart element A new BarChart element.
function Container:addBarChart(self, props) end

---Sets the value of the OffsetY property.
---@param self Container self
---@param OffsetY number Vertical scroll/content offset
function Container:setOffsetY(self, OffsetY) end

---Sets the value of the ChildrenSorted property.
---@param self Container self
---@param ChildrenSorted boolean Indicates if children are sorted by z-index
function Container:setChildrenSorted(self, ChildrenSorted) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_click(button, x, y) end

---Creates a new Switch element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Switch element A new Switch element.
function Container:addSwitch(self, props) end

---Creates a new Program element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Program element A new Program element.
function Container:addProgram(self, props) end

---Creates a new LineChart element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return LineChart element A new LineChart element.
function Container:addLineChart(self, props) end

---Enables benchmarking for a container and all its children
---@param methodName string The method to benchmark
---@return Container self The container instance
function Container:benchmarkContainer(methodName) end

---Creates a new Frame element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Frame element A new Frame element.
function Container:addFrame(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw the text
---@param y number The y position to draw the text
---@param text string The text to draw
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Container self The container instance
---@protected
function Container:blit(x, y, text, fg, bg) end

---Removes an element from this container's hierarchy and cleans up its events
---@param child table The element to remove
---@return Container self For method chaining
function Container:removeChild(child) end

---Sets the value of the Children property.
---@param self Container self
---@param Children table Collection of all child elements
function Container:setChildren(self, Children) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param event string The event to handle
---@return boolean handled Whether the event was handled
---@protected
function Container:handleEvent(event) end

---Creates a new FlexBox element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return FlexBox element A new FlexBox element.
function Container:addFlexBox(self, props) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Container:mouse_drag(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Container:char(char) end

---Tests whether a child element is currently visible within the container's viewport
---@param child table The child element to check
---@return boolean isVisible Whether the child is within view bounds
function Container:isChildVisible(child) end

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

---Creates a new Image element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Image element A new Image element.
function Container:addImage(self, props) end

---Creates a new Timer element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Timer element A new Timer element.
function Container:addTimer(self, props) end

---Removes all child elements and resets the container's state
---@return Container self For method chaining
function Container:clear() end

---Sorts the children events of the container
---@param eventName string The event name to sort
---@return Container self The container instance
function Container:sortChildrenEvents(eventName) end

---Sets the value of the OffsetX property.
---@param self Container self
---@param OffsetX number Horizontal scroll/content offset
function Container:setOffsetX(self, OffsetX) end

---Creates a new Slider element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return Slider element A new Slider element.
function Container:addSlider(self, props) end

---Sets the value of the VisibleChildren property.
---@param self Container self
---@param VisibleChildren table Currently visible child elements (calculated based on viewport)
function Container:setVisibleChildren(self, VisibleChildren) end

---Creates a new BigFont element.
---@param self Container self
---@param props? table Optional: properties for the element.
---@return BigFont element A new BigFont element.
function Container:addBigFont(self, props) end

---@class DropDown : List
---@field dropSymbol string Indicator for dropdown state
---@field dropdownHeight number Maximum visible items when expanded
---@field isOpen boolean Controls the expanded/collapsed state
---@field selectedText string Text shown when no selection made
local DropDown = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function DropDown:render() end

---Gets the value of the DropdownHeight property.
---@param self DropDown self
---@return number 5 Maximum visible items when expanded
function DropDown:getDropdownHeight(self) end

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

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function DropDown:mouse_click(button, x, y) end

---Gets the value of the DropSymbol property.
---@param self DropDown self
---@return string "\31" Indicator for dropdown state
function DropDown:getDropSymbol(self) end

---Gets the value of the IsOpen property.
---@param self DropDown self
---@return boolean false Controls the expanded/collapsed state
function DropDown:getIsOpen(self) end

---Sets the value of the SelectedText property.
---@param self DropDown self
---@param SelectedText string Text shown when no selection made
function DropDown:setSelectedText(self, SelectedText) end

---Sets the value of the DropSymbol property.
---@param self DropDown self
---@param DropSymbol string Indicator for dropdown state
function DropDown:setDropSymbol(self, DropSymbol) end

---Sets the value of the IsOpen property.
---@param self DropDown self
---@param IsOpen boolean Controls the expanded/collapsed state
function DropDown:setIsOpen(self, IsOpen) end

---Gets the value of the SelectedText property.
---@param self DropDown self
---@return string "" Text shown when no selection made
function DropDown:getSelectedText(self) end

---@class Menu : List
---@field separatorColor color The color used for separator items in the menu
local Menu = {}

---Gets the value of the SeparatorColor property.
---@param self Menu self
---@return color gray The color used for separator items in the menu
function Menu:getSeparatorColor(self) end

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

---Sets the menu items
---@param items table [] List of items with {text, separator, callback, foreground, background} properties
---@return Menu self The Menu instance
function Menu:setItems(items) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Menu self The initialized instance
---@protected
function Menu:init(props, basalt) end

---@class CheckBox : VisualElement
---@field autoSize boolean Automatically adjusts width based on text length
---@field text string Text shown when the checkbox is unchecked
---@field checkedText string Text shown when the checkbox is checked
---@field checked boolean The current state of the checkbox (true=checked, false=unchecked)
local CheckBox = {}

---Handles mouse interactions to toggle the checkbox state
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Clicked Whether the event was handled
---@protected
function CheckBox:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function CheckBox:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function CheckBox:render() end

---Gets the value of the CheckedText property.
---@param self CheckBox self
---@return string x Text shown when the checkbox is checked
function CheckBox:getCheckedText(self) end

---Sets the value of the Checked property.
---@param self CheckBox self
---@param Checked boolean The current state of the checkbox (true=checked, false=unchecked)
function CheckBox:setChecked(self, Checked) end

---Sets the value of the CheckedText property.
---@param self CheckBox self
---@param CheckedText string Text shown when the checkbox is checked
function CheckBox:setCheckedText(self, CheckedText) end

---Sets the value of the Text property.
---@param self CheckBox self
---@param Text string Text shown when the checkbox is unchecked
function CheckBox:setText(self, Text) end

---Sets the value of the AutoSize property.
---@param self CheckBox self
---@param AutoSize boolean Automatically adjusts width based on text length
function CheckBox:setAutoSize(self, AutoSize) end

---Gets the value of the Text property.
---@param self CheckBox self
---@return string empty Text shown when the checkbox is unchecked
function CheckBox:getText(self) end

---Gets the value of the Checked property.
---@param self CheckBox self
---@return boolean false The current state of the checkbox (true=checked, false=unchecked)
function CheckBox:getChecked(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@return CheckBox self The created instance
---@protected
function CheckBox.new() end

---Gets the value of the AutoSize property.
---@param self CheckBox self
---@return boolean true Automatically adjusts width based on text length
function CheckBox:getAutoSize(self) end

---@class Table : VisualElement
---@field customSortFunction table Custom sort functions for columns
---@field headerColor color Color of the column headers
---@field data table The table data as array of row arrays
---@field gridColor color Color of grid lines
---@field selectedRow number nil Currently selected row index
---@field scrollOffset number Current scroll position
---@field sortDirection string Sort direction ("asc" or "desc")
---@field columns table List of column definitions with {name, width} properties
---@field sortColumn number nil Currently sorted column index
---@field selectedColor color Background color of selected row
local Table = {}

---Sets the value of the SortDirection property.
---@param self Table self
---@param SortDirection string Sort direction ("asc" or "desc")
function Table:setSortDirection(self, SortDirection) end

---Gets the value of the HeaderColor property.
---@param self Table self
---@return color blue Color of the column headers
function Table:getHeaderColor(self) end

---Gets the value of the Data property.
---@param self Table self
---@return table {} The table data as array of row arrays
function Table:getData(self) end

---Gets the value of the SortColumn property.
---@param self Table self
---@return number ? nil Currently sorted column index
function Table:getSortColumn(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Table:render() end

---Set data with automatic formatting
---@param rawData table The raw data array
---@param formatters table Optional formatter functions for columns {[2] = function(value) return value end}
---@return Table self The Table instance
function Table:setData(rawData, formatters) end

---Sets the value of the GridColor property.
---@param self Table self
---@param GridColor color Color of grid lines
function Table:setGridColor(self, GridColor) end

---Gets the value of the Columns property.
---@param self Table self
---@return table {} List of column definitions with {name, width} properties
function Table:getColumns(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (-1 up, 1 down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Table:mouse_scroll(direction, x, y) end

---Sorts the table data by column
---@param columnIndex number The index of the column to sort by
---@param fn function ? Optional custom sorting function
---@return Table self The Table instance
function Table:sortData(columnIndex, fn) end

---Gets the value of the ScrollOffset property.
---@param self Table self
---@return number 0 Current scroll position
function Table:getScrollOffset(self) end

---Gets the value of the SortDirection property.
---@param self Table self
---@return string "asc" Sort direction ("asc" or "desc")
function Table:getSortDirection(self) end

---Sets the value of the HeaderColor property.
---@param self Table self
---@param HeaderColor color Color of the column headers
function Table:setHeaderColor(self, HeaderColor) end

---Sets the value of the SelectedColor property.
---@param self Table self
---@param SelectedColor color Background color of selected row
function Table:setSelectedColor(self, SelectedColor) end

---Gets the value of the SelectedRow property.
---@param self Table self
---@return number ? nil Currently selected row index
function Table:getSelectedRow(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Table:mouse_click(button, x, y) end

---Sets the value of the SelectedRow property.
---@param self Table self
---@param SelectedRow number nil Currently selected row index
function Table:setSelectedRow(self, SelectedRow) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Table self The initialized instance
---@protected
function Table:init(props, basalt) end

---Sets the value of the SortColumn property.
---@param self Table self
---@param SortColumn number nil Currently sorted column index
function Table:setSortColumn(self, SortColumn) end

---Sets the value of the Columns property.
---@param self Table self
---@param Columns table List of column definitions with {name, width} properties
function Table:setColumns(self, Columns) end

---Sets a custom sort function for a specific column
---@param columnIndex number The index of the column
---@param sortFn function Function that takes (rowA, rowB) and returns comparison result
---@return Table self The Table instance
function Table:setColumnSortFunction(columnIndex, sortFn) end

---Adds a new row of data to the table
---@return Table self The Table instance
function Table:addData() end

---Adds a new column to the table
---@param name string The name of the column
---@param width number The width of the column
---@return Table self The Table instance
function Table:addColumn(name, width) end

---Adds data with both display and sort values
---@param displayData table The formatted data for display
---@param sortData table The raw data for sorting (optional)
---@return Table self The Table instance
function Table:setFormattedData(displayData, sortData) end

---Gets the value of the CustomSortFunction property.
---@param self Table self
---@return table {} Custom sort functions for columns
function Table:getCustomSortFunction(self) end

---Gets the value of the SelectedColor property.
---@param self Table self
---@return color lightBlue Background color of selected row
function Table:getSelectedColor(self) end

---Sets the value of the CustomSortFunction property.
---@param self Table self
---@param CustomSortFunction table Custom sort functions for columns
function Table:setCustomSortFunction(self, CustomSortFunction) end

---Gets the value of the GridColor property.
---@param self Table self
---@return color gray Color of grid lines
function Table:getGridColor(self) end

---Sets the value of the ScrollOffset property.
---@param self Table self
---@param ScrollOffset number Current scroll position
function Table:setScrollOffset(self, ScrollOffset) end

---@class BarChart : Graph
local BarChart = {}

---Renders the bar chart by calculating bar positions and heights based on data values
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BarChart:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return BarChart self The initialized instance
---@protected
function BarChart:init(props, basalt) end

---@class ThemeAPI
local ThemeAPI = {}

---Gets the current theme configuration
---@return table theme The current theme configuration
function ThemeAPI.getTheme() end

---Sets the current theme
---@param newTheme table The theme configuration to set
function ThemeAPI.setTheme(newTheme) end

---Loads a theme from a JSON file
---@param path string Path to the theme JSON file
function ThemeAPI.loadTheme(path) end

---@class Animation
local Animation = {}

---Starts the animation
---@return Animation self The animation instance
function Animation:start() end

---Registers a callback for the complete event
---@param callback function The callback function to register
---@return Animation self The animation instance
function Animation:onComplete(callback) end

---Registers a new animation type
---@param name string The name of the animation
---@param handlers table Table containing start, update and complete handlers
function Animation.registerAnimation(name, handlers) end

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

---Stops the animation immediately: cancels timers, completes running anim instances and clears the element property
function Animation:stop() end

---Creates a new sequence
---@return Animation self The animation instance
function Animation:sequence() end

---Registers a new easing function
---@param name string The name of the easing function
---@param func function The easing function (takes progress 0-1, returns modified progress)
function Animation.registerEasing(name, func) end

---Creates a new Animation
---@param element VisualElement The element to animate
---@return Animation The new animation
function Animation.new(element) end

---The event handler for the animation (listens to timer events)
---@param event string The event type
---@param timerId number The timer ID
function Animation:event(event, timerId) end

---Registers a callback for the start event
---@param callback function The callback function to register
function Animation:onStart(callback) end

---@class Switch : VisualElement
---@field autoSize boolean to automatically size the element to fit switch and text
---@field onBackground number color when ON
---@field checked boolean switch is checked
---@field offBackground number color when OFF
---@field text string to display next to switch
local Switch = {}

---Sets the value of the OnBackground property.
---@param self Switch self
---@param OnBackground number color when ON
function Switch:setOnBackground(self, OnBackground) end

---Gets the value of the AutoSize property.
---@param self Switch self
---@return boolean Whether to automatically size the element to fit switch and text
function Switch:getAutoSize(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function Switch:mouse_click(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Switch:init(props, basalt) end

---Gets the value of the OnBackground property.
---@param self Switch self
---@return number Background color when ON
function Switch:getOnBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Switch:render() end

---Sets the value of the OffBackground property.
---@param self Switch self
---@param OffBackground number color when OFF
function Switch:setOffBackground(self, OffBackground) end

---Sets the value of the Text property.
---@param self Switch self
---@param Text string to display next to switch
function Switch:setText(self, Text) end

---Gets the value of the Text property.
---@param self Switch self
---@return string Text to display next to switch
function Switch:getText(self) end

---Gets the value of the OffBackground property.
---@param self Switch self
---@return number Background color when OFF
function Switch:getOffBackground(self) end

---Sets the value of the AutoSize property.
---@param self Switch self
---@param AutoSize boolean to automatically size the element to fit switch and text
function Switch:setAutoSize(self, AutoSize) end

---Sets the value of the Checked property.
---@param self Switch self
---@param Checked boolean switch is checked
function Switch:setChecked(self, Checked) end

---Gets the value of the Checked property.
---@param self Switch self
---@return boolean Whether switch is checked
function Switch:getChecked(self) end

---@class BaseFrame : Container
---@field term term term.current() The terminal or (monitor) peripheral object to render to
local BaseFrame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:render() end

function BaseFrame:dispatchEvent() end

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
---@param width number The width of the text
---@param height number The height of the text
---@param text string The text to render
---@param fg string The foreground color
---@param bg string The background color
---@protected
function BaseFrame:multiBlit(x, y, width, height, text, fg, bg) end

---Shows the debug log frame
---@param self BaseFrame The frame to show debug log in
function BaseFrame.openConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function BaseFrame:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param fg colors The foreground color
---@protected
function BaseFrame:drawFg(x, y, fg) end

---Sets the value of the Term property.
---@param self BaseFrame self
---@param Term term term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:setTerm(self, Term) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@protected
function BaseFrame:drawText(x, y, text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BaseFrame:term_resize() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function BaseFrame:key_up(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return table self The initialized instance
---@protected
function BaseFrame:init(props, basalt) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param bg colors The background color
---@protected
function BaseFrame:drawBg(x, y, bg) end

function BaseFrame.setup() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_click(button, x, y) end

---Initializes a new state for this element
---@param self BaseFrame The element to initialize state for
---@param name string The name of the state
---@param default any The default value of the state
---@return BaseFrame self The element instance
function BaseFrame:initializeState(self, name, default) end

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

---Toggles the debug log frame
---@param self BaseFrame The frame to toggle debug log for
function BaseFrame.toggleConsole(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param bg colors The background color
---@protected
function BaseFrame:textBg(x, y, text, bg) end

---Gets the value of the Term property.
---@param self BaseFrame self
---@return term |peripheral term.current() The terminal or (monitor) peripheral object to render to
function BaseFrame:getTerm(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to render to
---@param y number The y position to render to
---@param text string The text to render
---@param fg string The foreground color
---@param bg string The background color
---@protected
function BaseFrame:blit(x, y, text, fg, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@protected
function BaseFrame:mouse_up(button, x, y) end

---Sets the cursor position
---@param x number The x position to set the cursor to
---@param y number The y position to set the cursor to
---@param blink boolean Whether the cursor should blink
function BaseFrame:setCursor(x, y, blink) end

---Hides the debug log frame
---@param self BaseFrame The frame to hide debug log for
function BaseFrame.closeConsole(self) end

---@class Render
local Render = {}

---Creates a new Render object
---@param terminal table The terminal object to render to
---@return Render 
function Render.new(terminal) end

---Gets the size of the render
---@return number , number
function Render:getSize() end

---Sets the size of the render
---@param width number The width of the render
---@param height number The height of the render
---@return Render 
function Render:setSize(width, height) end

---Merges two rectangles
---@param target table The target rectangle
---@param source table The source rectangle
---@return Render 
function Render:mergeRects(target, source) end

---Blits text to the screen with a background color
---@param x number The x position to blit to
---@param y number The y position to blit to
---@param text string The text to blit
---@param bg colors The background color of the text
---@return Render 
function Render:textBg(x, y, text, bg) end

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

---Blits a background color to the screen
---@param x number The x position
---@param y number The y position
---@param bg string The background color to blit
---@return Render 
function Render:bg(x, y, bg) end

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

---Adds a dirty rectangle to the buffer
---@param x number The x position of the rectangle
---@param y number The y position of the rectangle
---@param width number The width of the rectangle
---@param height number The height of the rectangle
---@return Render 
function Render:addDirtyRect(x, y, width, height) end

---Sets the cursor position
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@return Render 
function Render:setCursor(x, y, blink) end

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
---@param fg string The foreground color of the text
---@param bg string The background color of the text
---@return Render 
function Render:blit(x, y, text, fg, bg) end

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

---Checks if two rectangles overlap
---@param r1 table The first rectangle
---@param r2 table The second rectangle
---@return boolean 
function Render:rectOverlaps(r1, r2) end

---Clears an area of the screen
---@param x number The x position of the area
---@param y number The y position of the area
---@param width number The width of the area
---@param height number The height of the area
---@param bg colors The background color to clear the area with
---@return Render 
function Render:clearArea(x, y, width, height, bg) end

---@class VisualElement : BaseElement
---@field y number The vertical position relative to parent
---@field x number The horizontal position relative to parent
---@field hover boolean Whether the mouse is currently hover over the element (Craftos-PC only)
---@field clicked boolean Whether the element is currently clicked
---@field z number The z-index for layering elements
---@field visible boolean Whether the element is visible
---@field borderBottom boolean Draw bottom border
---@field borderTop boolean Draw top border
---@field borderLeft boolean Draw left border
---@field focused boolean Whether the element has input focus
---@field borderColor color Border color
---@field ignoreOffset boolean Whether to ignore the parent's offset
---@field borderRight boolean Draw right border
---@field background color The background color
---@field height number The height of the element
---@field width number The width of the element
---@field foreground color The text/foreground color
---@field backgroundEnabled boolean Whether to render the background
local VisualElement = {}

---Sets the value of the Y property.
---@param self VisualElement self
---@param Y number The vertical position relative to parent
function VisualElement:setY(self, Y) end

---Gets the value of the Height property.
---@param self VisualElement self
---@return number 1 The height of the element
function VisualElement:getHeight(self) end

---Gets the value of the BorderTop property.
---@param self VisualElement self
---@return boolean false Draw top border
function VisualElement:getBorderTop(self) end

---Registers a function to handle the onChar event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnChar(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function VisualElement:init(props, basalt) end

---Gets the value of the Hover property.
---@param self VisualElement self
---@return boolean false Whether the mouse is currently hover over the element (Craftos-PC only)
function VisualElement:getHover(self) end

---Gets the value of the X property.
---@param self VisualElement self
---@return number 1 The horizontal position relative to parent
function VisualElement:getX(self) end

---Registers a function to handle the onClick event.
---@param button string
---@param x number
---@param y number
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnClick(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:postRender() end

---Registers a function to handle the onKeyUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKeyUp(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param _ number unknown
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@return boolean hover Whether the mouse has moved over the element
---@protected
function VisualElement:mouse_move(_, x, y) end

---Removes the previously added border (if any)
---@return VisualElement self
function VisualElement:removeBorder() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was released
---@protected
function VisualElement:key_up(key) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@protected
function VisualElement:key(key) end

---Sets the value of the IgnoreOffset property.
---@param self VisualElement self
---@param IgnoreOffset boolean Whether to ignore the parent's offset
function VisualElement:setIgnoreOffset(self, IgnoreOffset) end

function VisualElement:drawText() end

---Registers a function to handle the onLeave event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnLeave(self, func) end

---Gets the value of the Z property.
---@param self VisualElement self
---@return number 1 The z-index for layering elements
function VisualElement:getZ(self) end

---Creates a new Animation Object
---@return Animation animation The new animation
function VisualElement:animate() end

---Gets the value of the BorderBottom property.
---@param self VisualElement self
---@return boolean false Draw bottom border
function VisualElement:getBorderBottom(self) end

---Sets the value of the BorderLeft property.
---@param self VisualElement self
---@param BorderLeft boolean Draw left border
function VisualElement:setBorderLeft(self, BorderLeft) end

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
---@protected
function VisualElement:render() end

---Returns the relative position of the element or the given coordinates.
---@return number x The relative x position
---@return number y The relative y position
function VisualElement:getRelativePosition() end

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

---Registers a function to handle the onScroll event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnScroll(self, func) end

---Returns the absolute position of the element or the given coordinates.
---@return number x The absolute x position
---@return number y The absolute y position
function VisualElement:getAbsolutePosition() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was pressed
---@protected
function VisualElement:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked while dragging
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean drag Whether the element was dragged
---@protected
function VisualElement:mouse_drag(button, x, y) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:blur() end

---Registers a function to handle the onDrag event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnDrag(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function VisualElement:focus() end

---Adds or updates a drawable character border around the element using the canvas plugin.
The border will automatically adapt to size/background changes because the command
reads current properties each render.
---@param colorOrOptions any Border color or options table
---@return VisualElement self
function VisualElement:addBorder(colorOrOptions) end

---Sets the value of the BorderColor property.
---@param self VisualElement self
---@param BorderColor color Border color
function VisualElement:setBorderColor(self, BorderColor) end

---Sets the value of the Focused property.
---@param self VisualElement self
---@param Focused boolean Whether the element has input focus
function VisualElement:setFocused(self, Focused) end

---Sets the value of the Width property.
---@param self VisualElement self
---@param Width number The width of the element
function VisualElement:setWidth(self, Width) end

---Gets the value of the BorderColor property.
---@param self VisualElement self
---@return color white Border color
function VisualElement:getBorderColor(self) end

---Gets the value of the Clicked property.
---@param self VisualElement self
---@return boolean false Whether the element is currently clicked
function VisualElement:getClicked(self) end

---Gets the value of the Visible property.
---@param self VisualElement self
---@return boolean true Whether the element is visible
function VisualElement:getVisible(self) end

---Gets the value of the Foreground property.
---@param self VisualElement self
---@return color white The text/foreground color
function VisualElement:getForeground(self) end

function VisualElement:drawFg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean scroll Whether the element was scrolled
---@protected
function VisualElement:mouse_scroll(direction, x, y) end

---Sets the value of the BorderRight property.
---@param self VisualElement self
---@param BorderRight boolean Draw right border
function VisualElement:setBorderRight(self, BorderRight) end

---Registers a function to handle the onEnter event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnEnter(self, func) end

---Gets the value of the IgnoreOffset property.
---@param self VisualElement self
---@return boolean false Whether to ignore the parent's offset
function VisualElement:getIgnoreOffset(self) end

function VisualElement:destroy() end

---Gets the value of the Focused property.
---@param self VisualElement self
---@return boolean false Whether the element has input focus
function VisualElement:getFocused(self) end

---Sets the value of the X property.
---@param self VisualElement self
---@param X number The horizontal position relative to parent
function VisualElement:setX(self, X) end

---Gets the value of the Width property.
---@param self VisualElement self
---@return number 1 The width of the element
function VisualElement:getWidth(self) end

---Gets the value of the Background property.
---@param self VisualElement self
---@return color black The background color
function VisualElement:getBackground(self) end

---Sets the value of the Clicked property.
---@param self VisualElement self
---@param Clicked boolean Whether the element is currently clicked
function VisualElement:setClicked(self, Clicked) end

---Convenience to stop animations from the element
function VisualElement.stopAnimation() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param fg string The foreground color
---@param bg string The background color
---@protected
function VisualElement:blit(x, y, text, fg, bg) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
---@return VisualElement self The VisualElement instance
---@protected
function VisualElement:setCursor(x, y, blink, color) end

---Sets the value of the BorderBottom property.
---@param self VisualElement self
---@param BorderBottom boolean Draw bottom border
function VisualElement:setBorderBottom(self, BorderBottom) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean release Whether the element was released on the element
---@protected
function VisualElement:mouse_up(button, x, y) end

---Registers a function to handle the onFocus event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnFocus(self, func) end

---Calculates the position of the element relative to its parent
---@return number x The x position
---@return number y The y position
function VisualElement:calculatePosition() end

---Gets the value of the BorderRight property.
---@param self VisualElement self
---@return boolean false Draw right border
function VisualElement:getBorderRight(self) end

---Sets the value of the Z property.
---@param self VisualElement self
---@param Z number The z-index for layering elements
function VisualElement:setZ(self, Z) end

---Registers a function to handle the onRelease event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnRelease(self, func) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param x number The x position to draw
---@param y number The y position to draw
---@param text string The text char to draw
---@param bg color The background color
---@protected
function VisualElement:textBg(x, y, text, bg) end

---Gets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@return boolean true Whether to render the background
function VisualElement:getBackgroundEnabled(self) end

function VisualElement:drawBg() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@protected
function VisualElement:mouse_release(button, x, y) end

---Sets the value of the Height property.
---@param self VisualElement self
---@param Height number The height of the element
function VisualElement:setHeight(self, Height) end

---Sets the value of the Visible property.
---@param self VisualElement self
---@param Visible boolean Whether the element is visible
function VisualElement:setVisible(self, Visible) end

---Sets the value of the BorderTop property.
---@param self VisualElement self
---@param BorderTop boolean Draw top border
function VisualElement:setBorderTop(self, BorderTop) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean clicked Whether the element was clicked
---@protected
function VisualElement:mouse_click(button, x, y) end

---Registers a function to handle the onBlur event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnBlur(self, func) end

---Sets the value of the BackgroundEnabled property.
---@param self VisualElement self
---@param BackgroundEnabled boolean Whether to render the background
function VisualElement:setBackgroundEnabled(self, BackgroundEnabled) end

---Sets the value of the Hover property.
---@param self VisualElement self
---@param Hover boolean Whether the mouse is currently hover over the element (Craftos-PC only)
function VisualElement:setHover(self, Hover) end

---Gets the value of the Y property.
---@param self VisualElement self
---@return number 1 The vertical position relative to parent
function VisualElement:getY(self) end

---Sets the value of the Foreground property.
---@param self VisualElement self
---@param Foreground color The text/foreground color
function VisualElement:setForeground(self, Foreground) end

---Registers a function to handle the onMouseUp event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnMouseUp(self, func) end

---Registers a function to handle the onKey event.
---@param self VisualElement self
---@param func function The function to be called when the event fires
function VisualElement:onOnKey(self, func) end

---Checks if the specified coordinates are within the bounds of the element
---@param x number The x position to check
---@param y number The y position to check
---@return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y) end

---Gets the value of the BorderLeft property.
---@param self VisualElement self
---@return boolean false Draw left border
function VisualElement:getBorderLeft(self) end

---Sets the value of the Background property.
---@param self VisualElement self
---@param Background color The background color
function VisualElement:setBackground(self, Background) end

---@class ComboBox : DropDown
---@field placeholderColor color Color used for placeholder text
---@field text string The current text value of the input field
---@field cursorPos number Current cursor position in the text input
---@field editable boolean Enables direct text input in the field
---@field focusedBackground color Background color when input is focused
---@field autoComplete boolean Enables filtering dropdown items while typing
---@field viewOffset number Horizontal scroll position for viewing long text
---@field placeholder string Text shown when the input is empty
---@field manuallyOpened boolean Indicates if dropdown was opened by user action
---@field focusedForeground color Text color when input is focused
local ComboBox = {}

---Called when the ComboBox loses focus
function ComboBox:blur() end

---Sets the value of the PlaceholderColor property.
---@param self ComboBox self
---@param PlaceholderColor color Color used for placeholder text
function ComboBox:setPlaceholderColor(self, PlaceholderColor) end

---Called when the ComboBox gains focus
function ComboBox:focus() end

---Creates a new ComboBox instance
---@return ComboBox self The newly created ComboBox instance
function ComboBox.new() end

---Renders the ComboBox
function ComboBox:render() end

---Sets the value of the ManuallyOpened property.
---@param self ComboBox self
---@param ManuallyOpened boolean Indicates if dropdown was opened by user action
function ComboBox:setManuallyOpened(self, ManuallyOpened) end

---Handles mouse clicks
---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button (1 = left, 2 = right, 3 = middle)
---@param x number The x coordinate of the click
---@param y number The y coordinate of the click
---@return boolean handled Whether the event was handled
---@protected
function ComboBox:mouse_click(button, x, y) end

---Gets the value of the Placeholder property.
---@param self ComboBox self
---@return string "..." Text shown when the input is empty
function ComboBox:getPlaceholder(self) end

---Sets the value of the FocusedForeground property.
---@param self ComboBox self
---@param FocusedForeground color Text color when input is focused
function ComboBox:setFocusedForeground(self, FocusedForeground) end

---Handles key input when editable
---@param key number The key code that was pressed
---@param held boolean Whether the key is being held
function ComboBox:key(key, held) end

---Handles character input when editable
---@param char string The character that was typed
function ComboBox:char(char) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ComboBox self The initialized instance
---@protected
function ComboBox:init(props, basalt) end

---Sets the value of the CursorPos property.
---@param self ComboBox self
---@param CursorPos number Current cursor position in the text input
function ComboBox:setCursorPos(self, CursorPos) end

---Sets the value of the AutoComplete property.
---@param self ComboBox self
---@param AutoComplete boolean Enables filtering dropdown items while typing
function ComboBox:setAutoComplete(self, AutoComplete) end

---Gets the current text content
---@return string text The current text
function ComboBox:getText() end

---Gets the value of the AutoComplete property.
---@param self ComboBox self
---@return boolean false Enables filtering dropdown items while typing
function ComboBox:getAutoComplete(self) end

---Gets the value of the FocusedBackground property.
---@param self ComboBox self
---@return color blue Background color when input is focused
function ComboBox:getFocusedBackground(self) end

---Sets the value of the ViewOffset property.
---@param self ComboBox self
---@param ViewOffset number Horizontal scroll position for viewing long text
function ComboBox:setViewOffset(self, ViewOffset) end

---Gets the value of the ViewOffset property.
---@param self ComboBox self
---@return number 0 Horizontal scroll position for viewing long text
function ComboBox:getViewOffset(self) end

---Gets the value of the PlaceholderColor property.
---@param self ComboBox self
---@return color gray Color used for placeholder text
function ComboBox:getPlaceholderColor(self) end

---Sets the value of the Placeholder property.
---@param self ComboBox self
---@param Placeholder string Text shown when the input is empty
function ComboBox:setPlaceholder(self, Placeholder) end

---Gets the value of the Editable property.
---@param self ComboBox self
---@return boolean true Enables direct text input in the field
function ComboBox:getEditable(self) end

---Gets the value of the CursorPos property.
---@param self ComboBox self
---@return number 1 Current cursor position in the text input
function ComboBox:getCursorPos(self) end

---Gets the value of the FocusedForeground property.
---@param self ComboBox self
---@return color white Text color when input is focused
function ComboBox:getFocusedForeground(self) end

---Sets the value of the FocusedBackground property.
---@param self ComboBox self
---@param FocusedBackground color Background color when input is focused
function ComboBox:setFocusedBackground(self, FocusedBackground) end

---Sets whether the ComboBox is editable
---@param editable boolean Whether the ComboBox should be editable
---@return ComboBox self
function ComboBox:setEditable(editable) end

---Gets the value of the ManuallyOpened property.
---@param self ComboBox self
---@return boolean false Indicates if dropdown was opened by user action
function ComboBox:getManuallyOpened(self) end

---Sets the text content of the ComboBox
---@param text string The text to set
---@return ComboBox self
function ComboBox:setText(text) end

---@class TextBox : VisualElement
---@field autoCompleteProvider function Optional suggestion provider returning a list for the current prefix
---@field cursorColor number Color of the cursor
---@field editable boolean Whether text can be edited
---@field autoCompleteAcceptOnEnter boolean Whether pressing Enter accepts the current suggestion
---@field autoPairOverType boolean When pressing a closing char that matches the next char, move over it instead of inserting
---@field autoPairEnabled boolean Whether automatic bracket/quote pairing is enabled
---@field autoCompleteSelectedBackground color Background color for the selected suggestion
---@field autoCompleteItems table List of suggestions used when no provider is supplied
---@field autoCompleteSelectedForeground color Foreground color for the selected suggestion
---@field autoCompleteForeground color Foreground color of the suggestion popup
---@field autoCompleteTokenPattern string Pattern used to extract the current token for suggestions
---@field autoCompleteEnabled boolean Whether autocomplete suggestions are enabled
---@field autoCompleteMaxItems number Maximum number of visible suggestions
---@field autoPairSkipClosing boolean Skip inserting a closing char if the same one is already at cursor
---@field scrollX number Horizontal scroll offset
---@field syntaxPatterns table Syntax highlighting patterns
---@field autoCompleteMinChars number Minimum characters required before showing suggestions
---@field scrollY number Vertical scroll offset
---@field autoCompleteBorderColor color Color of the popup border when enabled
---@field autoCompleteAcceptOnClick boolean Whether clicking a suggestion accepts it immediately
---@field autoCompleteBackground color Background color of the suggestion popup
---@field lines table Array of text lines
---@field autoCompleteCaseInsensitive boolean Whether suggestions should match case-insensitively
---@field autoCompleteZOffset number Z-index offset applied to the popup frame
---@field autoCompleteCloseOnEscape boolean Whether pressing Escape closes the popup
---@field autoCompleteMaxWidth number Maximum width of the autocomplete popup (0 uses the textbox width)
---@field autoPairNewlineIndent boolean On Enter between matching braces, create blank line and keep closing aligned
---@field cursorX number Cursor X position
---@field cursorY number Cursor Y position (line number)
---@field autoPairCharacters table ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
---@field autoCompleteOffsetX number Horizontal offset applied to the popup frame relative to the TextBox
---@field autoCompleteShowBorder boolean Whether to render a character border around the popup
---@field autoCompleteOffsetY number Vertical offset applied to the popup frame relative to the TextBox bottom edge
local TextBox = {}

---Gets the value of the AutoCompleteShowBorder property.
---@param self TextBox self
---@return boolean true Whether to render a character border around the popup
function TextBox:getAutoCompleteShowBorder(self) end

---Gets the value of the AutoCompleteZOffset property.
---@param self TextBox self
---@return number 1 Z-index offset applied to the popup frame
function TextBox:getAutoCompleteZOffset(self) end

---Sets the value of the AutoPairOverType property.
---@param self TextBox self
---@param AutoPairOverType boolean When pressing a closing char that matches the next char, move over it instead of inserting
function TextBox:setAutoPairOverType(self, AutoPairOverType) end

---Sets the value of the AutoCompleteForeground property.
---@param self TextBox self
---@param AutoCompleteForeground color Foreground color of the suggestion popup
function TextBox:setAutoCompleteForeground(self, AutoCompleteForeground) end

---Gets the value of the AutoCompleteProvider property.
---@param self TextBox self
---@return function nil Optional suggestion provider returning a list for the current prefix
function TextBox:getAutoCompleteProvider(self) end

---Sets the value of the Lines property.
---@param self TextBox self
---@param Lines table Array of text lines
function TextBox:setLines(self, Lines) end

---Gets the value of the Editable property.
---@param self TextBox self
---@return boolean true Whether text can be edited
function TextBox:getEditable(self) end

---Sets the value of the AutoPairNewlineIndent property.
---@param self TextBox self
---@param AutoPairNewlineIndent boolean On Enter between matching braces, create blank line and keep closing aligned
function TextBox:setAutoPairNewlineIndent(self, AutoPairNewlineIndent) end

---Sets the value of the AutoCompleteAcceptOnClick property.
---@param self TextBox self
---@param AutoCompleteAcceptOnClick boolean Whether clicking a suggestion accepts it immediately
function TextBox:setAutoCompleteAcceptOnClick(self, AutoCompleteAcceptOnClick) end

---Gets the value of the ScrollX property.
---@param self TextBox self
---@return number 0 Horizontal scroll offset
function TextBox:getScrollX(self) end

---Sets the value of the ScrollY property.
---@param self TextBox self
---@param ScrollY number Vertical scroll offset
function TextBox:setScrollY(self, ScrollY) end

---Sets the value of the AutoPairEnabled property.
---@param self TextBox self
---@param AutoPairEnabled boolean Whether automatic bracket/quote pairing is enabled
function TextBox:setAutoPairEnabled(self, AutoPairEnabled) end

---Sets the value of the AutoPairSkipClosing property.
---@param self TextBox self
---@param AutoPairSkipClosing boolean Skip inserting a closing char if the same one is already at cursor
function TextBox:setAutoPairSkipClosing(self, AutoPairSkipClosing) end

---Sets the value of the CursorX property.
---@param self TextBox self
---@param CursorX number Cursor X position
function TextBox:setCursorX(self, CursorX) end

---Sets the value of the AutoCompleteMaxWidth property.
---@param self TextBox self
---@param AutoCompleteMaxWidth number Maximum width of the autocomplete popup (0 uses the textbox width)
function TextBox:setAutoCompleteMaxWidth(self, AutoCompleteMaxWidth) end

---Sets the value of the ScrollX property.
---@param self TextBox self
---@param ScrollX number Horizontal scroll offset
function TextBox:setScrollX(self, ScrollX) end

---Sets the value of the Editable property.
---@param self TextBox self
---@param Editable boolean Whether text can be edited
function TextBox:setEditable(self, Editable) end

---Gets the value of the AutoCompleteOffsetY property.
---@param self TextBox self
---@return number 1 Vertical offset applied to the popup frame relative to the TextBox bottom edge
function TextBox:getAutoCompleteOffsetY(self) end

---Gets the value of the CursorX property.
---@param self TextBox self
---@return number 1 Cursor X position
function TextBox:getCursorX(self) end

---Updates the viewport to keep the cursor in view
---@return TextBox self The TextBox instance
function TextBox:updateViewport() end

---Gets the value of the AutoCompleteMaxItems property.
---@param self TextBox self
---@return number 6 Maximum number of visible suggestions
function TextBox:getAutoCompleteMaxItems(self) end

---Gets the value of the AutoCompleteAcceptOnEnter property.
---@param self TextBox self
---@return boolean true Whether pressing Enter accepts the current suggestion
function TextBox:getAutoCompleteAcceptOnEnter(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function TextBox:render() end

---Sets the value of the AutoCompleteCloseOnEscape property.
---@param self TextBox self
---@param AutoCompleteCloseOnEscape boolean Whether pressing Escape closes the popup
function TextBox:setAutoCompleteCloseOnEscape(self, AutoCompleteCloseOnEscape) end

---Sets the value of the AutoPairCharacters property.
---@param self TextBox self
---@param AutoPairCharacters table ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
function TextBox:setAutoPairCharacters(self, AutoPairCharacters) end

---Gets the value of the AutoPairEnabled property.
---@param self TextBox self
---@return boolean true Whether automatic bracket/quote pairing is enabled
function TextBox:getAutoPairEnabled(self) end

---Gets the value of the AutoCompleteMaxWidth property.
---@param self TextBox self
---@return number 0 Maximum width of the autocomplete popup (0 uses the textbox width)
function TextBox:getAutoCompleteMaxWidth(self) end

---Sets the value of the CursorColor property.
---@param self TextBox self
---@param CursorColor number Color of the cursor
function TextBox:setCursorColor(self, CursorColor) end

---Sets the value of the AutoCompleteEnabled property.
---@param self TextBox self
---@param AutoCompleteEnabled boolean Whether autocomplete suggestions are enabled
function TextBox:setAutoCompleteEnabled(self, AutoCompleteEnabled) end

---Sets the value of the AutoCompleteBackground property.
---@param self TextBox self
---@param AutoCompleteBackground color Background color of the suggestion popup
function TextBox:setAutoCompleteBackground(self, AutoCompleteBackground) end

---Gets the value of the AutoCompleteMinChars property.
---@param self TextBox self
---@return number 1 Minimum characters required before showing suggestions
function TextBox:getAutoCompleteMinChars(self) end

---Gets the value of the AutoPairNewlineIndent property.
---@param self TextBox self
---@return boolean true On Enter between matching braces, create blank line and keep closing aligned
function TextBox:getAutoPairNewlineIndent(self) end

---Sets the value of the AutoCompleteSelectedBackground property.
---@param self TextBox self
---@param AutoCompleteSelectedBackground color Background color for the selected suggestion
function TextBox:setAutoCompleteSelectedBackground(self, AutoCompleteSelectedBackground) end

---Gets the value of the AutoCompleteAcceptOnClick property.
---@param self TextBox self
---@return boolean true Whether clicking a suggestion accepts it immediately
function TextBox:getAutoCompleteAcceptOnClick(self) end

---Gets the value of the Lines property.
---@param self TextBox self
---@return table {} Array of text lines
function TextBox:getLines(self) end

---Gets the value of the AutoCompleteForeground property.
---@param self TextBox self
---@return color black Foreground color of the suggestion popup
function TextBox:getAutoCompleteForeground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_scroll(direction, x, y) end

function TextBox:destroy() end

---Gets the value of the AutoCompleteBorderColor property.
---@param self TextBox self
---@return color black Color of the popup border when enabled
function TextBox:getAutoCompleteBorderColor(self) end

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

---Removes a syntax pattern by index (1-based)
---@param index number The index of the pattern to remove
---@return TextBox self
function TextBox:removeSyntaxPattern(index) end

---Sets the value of the AutoCompleteMaxItems property.
---@param self TextBox self
---@param AutoCompleteMaxItems number Maximum number of visible suggestions
function TextBox:setAutoCompleteMaxItems(self, AutoCompleteMaxItems) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:key(key) end

---Sets the value of the AutoCompleteOffsetX property.
---@param self TextBox self
---@param AutoCompleteOffsetX number Horizontal offset applied to the popup frame relative to the TextBox
function TextBox:setAutoCompleteOffsetX(self, AutoCompleteOffsetX) end

---Gets the value of the AutoCompleteTokenPattern property.
---@param self TextBox self
---@return string "[%w_]+" Pattern used to extract the current token for suggestions
function TextBox:getAutoCompleteTokenPattern(self) end

---Sets the value of the AutoCompleteBorderColor property.
---@param self TextBox self
---@param AutoCompleteBorderColor color Color of the popup border when enabled
function TextBox:setAutoCompleteBorderColor(self, AutoCompleteBorderColor) end

---Gets the value of the SyntaxPatterns property.
---@param self TextBox self
---@return table {} Syntax highlighting patterns
function TextBox:getSyntaxPatterns(self) end

---Sets the value of the AutoCompleteItems property.
---@param self TextBox self
---@param AutoCompleteItems table List of suggestions used when no provider is supplied
function TextBox:setAutoCompleteItems(self, AutoCompleteItems) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function TextBox:mouse_click(button, x, y) end

---Adds a new syntax highlighting pattern
---@param pattern string The regex pattern to match
---@param color number The color to apply
---@return TextBox self The TextBox instance
function TextBox:addSyntaxPattern(pattern, color) end

---Sets the value of the AutoCompleteMinChars property.
---@param self TextBox self
---@param AutoCompleteMinChars number Minimum characters required before showing suggestions
function TextBox:setAutoCompleteMinChars(self, AutoCompleteMinChars) end

---Sets the value of the CursorY property.
---@param self TextBox self
---@param CursorY number Cursor Y position (line number)
function TextBox:setCursorY(self, CursorY) end

---Gets the value of the AutoCompleteCloseOnEscape property.
---@param self TextBox self
---@return boolean true Whether pressing Escape closes the popup
function TextBox:getAutoCompleteCloseOnEscape(self) end

---Sets the value of the AutoCompleteProvider property.
---@param self TextBox self
---@param AutoCompleteProvider function Optional suggestion provider returning a list for the current prefix
function TextBox:setAutoCompleteProvider(self, AutoCompleteProvider) end

---Gets the value of the AutoCompleteItems property.
---@param self TextBox self
---@return table {} List of suggestions used when no provider is supplied
function TextBox:getAutoCompleteItems(self) end

---Sets the value of the AutoCompleteCaseInsensitive property.
---@param self TextBox self
---@param AutoCompleteCaseInsensitive boolean Whether suggestions should match case-insensitively
function TextBox:setAutoCompleteCaseInsensitive(self, AutoCompleteCaseInsensitive) end

---Sets the value of the AutoCompleteSelectedForeground property.
---@param self TextBox self
---@param AutoCompleteSelectedForeground color Foreground color for the selected suggestion
function TextBox:setAutoCompleteSelectedForeground(self, AutoCompleteSelectedForeground) end

---Sets the value of the AutoCompleteShowBorder property.
---@param self TextBox self
---@param AutoCompleteShowBorder boolean Whether to render a character border around the popup
function TextBox:setAutoCompleteShowBorder(self, AutoCompleteShowBorder) end

---Gets the value of the AutoCompleteSelectedForeground property.
---@param self TextBox self
---@return color white Foreground color for the selected suggestion
function TextBox:getAutoCompleteSelectedForeground(self) end

---Gets the value of the AutoPairOverType property.
---@param self TextBox self
---@return boolean true When pressing a closing char that matches the next char, move over it instead of inserting
function TextBox:getAutoPairOverType(self) end

---Sets the value of the AutoCompleteZOffset property.
---@param self TextBox self
---@param AutoCompleteZOffset number Z-index offset applied to the popup frame
function TextBox:setAutoCompleteZOffset(self, AutoCompleteZOffset) end

---Gets the value of the AutoCompleteCaseInsensitive property.
---@param self TextBox self
---@return boolean true Whether suggestions should match case-insensitively
function TextBox:getAutoCompleteCaseInsensitive(self) end

---Gets the value of the CursorY property.
---@param self TextBox self
---@return number 1 Cursor Y position (line number)
function TextBox:getCursorY(self) end

---Gets the value of the ScrollY property.
---@param self TextBox self
---@return number 0 Vertical scroll offset
function TextBox:getScrollY(self) end

---Gets the value of the AutoCompleteSelectedBackground property.
---@param self TextBox self
---@return color gray Background color for the selected suggestion
function TextBox:getAutoCompleteSelectedBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return TextBox self The initialized instance
---@protected
function TextBox:init(props, basalt) end

---Clears all syntax highlighting patterns
---@return TextBox self
function TextBox:clearSyntaxPatterns() end

---Gets the value of the CursorColor property.
---@param self TextBox self
---@return number nil Color of the cursor
function TextBox:getCursorColor(self) end

---Sets the value of the AutoCompleteAcceptOnEnter property.
---@param self TextBox self
---@param AutoCompleteAcceptOnEnter boolean Whether pressing Enter accepts the current suggestion
function TextBox:setAutoCompleteAcceptOnEnter(self, AutoCompleteAcceptOnEnter) end

---Sets the value of the SyntaxPatterns property.
---@param self TextBox self
---@param SyntaxPatterns table Syntax highlighting patterns
function TextBox:setSyntaxPatterns(self, SyntaxPatterns) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function TextBox:char(char) end

---Sets the value of the AutoCompleteTokenPattern property.
---@param self TextBox self
---@param AutoCompleteTokenPattern string Pattern used to extract the current token for suggestions
function TextBox:setAutoCompleteTokenPattern(self, AutoCompleteTokenPattern) end

---Gets the value of the AutoPairCharacters property.
---@param self TextBox self
---@return table { ["("]=")", ["["]="]", ["{"]="}", ['"']='"', ['\'']='\'', ['`']='`'} Mapping of opening to closing characters for auto pairing
function TextBox:getAutoPairCharacters(self) end

---Sets the value of the AutoCompleteOffsetY property.
---@param self TextBox self
---@param AutoCompleteOffsetY number Vertical offset applied to the popup frame relative to the TextBox bottom edge
function TextBox:setAutoCompleteOffsetY(self, AutoCompleteOffsetY) end

---Gets the value of the AutoCompleteEnabled property.
---@param self TextBox self
---@return boolean false Whether autocomplete suggestions are enabled
function TextBox:getAutoCompleteEnabled(self) end

---Gets the value of the AutoCompleteBackground property.
---@param self TextBox self
---@return color lightGray Background color of the suggestion popup
function TextBox:getAutoCompleteBackground(self) end

---Gets the value of the AutoCompleteOffsetX property.
---@param self TextBox self
---@return number 0 Horizontal offset applied to the popup frame relative to the TextBox
function TextBox:getAutoCompleteOffsetX(self) end

---Gets the value of the AutoPairSkipClosing property.
---@param self TextBox self
---@return boolean true Skip inserting a closing char if the same one is already at cursor
function TextBox:getAutoPairSkipClosing(self) end

---@class Frame : Container
---@field draggingMap table The map of dragging positions
---@field scrollable boolean Whether the frame is scrollable
---@field draggable boolean Whether the frame is draggable
local Frame = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_scroll(direction, x, y) end

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

---Gets the value of the Scrollable property.
---@param self Frame self
---@return boolean false Whether the frame is scrollable
function Frame:getScrollable(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Frame:mouse_click(button, x, y) end

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
---@return number height The total height needed for all children
---@protected
function Frame:getChildrenHeight() end

---Sets the value of the Draggable property.
---@param self Frame self
---@param Draggable boolean Whether the frame is draggable
function Frame:setDraggable(self, Draggable) end

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

---@class Image : VisualElement
---@field autoResize boolean Whether to automatically resize the image when content exceeds bounds
---@field offsetY number Vertical offset for viewing larger images
---@field bimg table The bimg image data
---@field currentFrame number Current animation frame
---@field offsetX number Horizontal offset for viewing larger images
local Image = {}

---Gets the value of the Bimg property.
---@param self Image self
---@return table {} The bimg image data
function Image:getBimg(self) end

---Gets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the foreground color pattern to get
---@return string fg The foreground color pattern
function Image:getFg(x, y, length) end

---Gets the value of the OffsetX property.
---@param self Image self
---@return number 0 Horizontal offset for viewing larger images
function Image:getOffsetX(self) end

---Sets the foreground color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The foreground color pattern
---@return Image self The Image instance
function Image:setFg(x, y, pattern) end

---Gets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the text to get
---@return string text The text at the specified position
function Image:getText(x, y, length) end

---Gets the metadata of the image
---@return table metadata The metadata of the image
function Image:getMetadata() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Image:render() end

---Gets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param length number The length of the background color pattern to get
---@return string bg The background color pattern
function Image:getBg(x, y, length) end

---Sets the value of the OffsetY property.
---@param self Image self
---@param OffsetY number Vertical offset for viewing larger images
function Image:setOffsetY(self, OffsetY) end

---Gets the value of the AutoResize property.
---@param self Image self
---@return boolean false Whether to automatically resize the image when content exceeds bounds
function Image:getAutoResize(self) end

---Sets the value of the Bimg property.
---@param self Image self
---@param Bimg table The bimg image data
function Image:setBimg(self, Bimg) end

---Updates the specified frame with the provided data
---@param frameIndex number The index of the frame to update
---@param frame table The new frame data
---@return Image self The Image instance
function Image:updateFrame(frameIndex, frame) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Image self The initialized instance
---@protected
function Image:init(props, basalt) end

---Adds a new frame to the image
---@return Image self The Image instance
function Image:addFrame() end

---Gets the value of the CurrentFrame property.
---@param self Image self
---@return number 1 Current animation frame
function Image:getCurrentFrame(self) end

---Sets the value of the AutoResize property.
---@param self Image self
---@param AutoResize boolean Whether to automatically resize the image when content exceeds bounds
function Image:setAutoResize(self, AutoResize) end

---Sets the background color at the specified position
---@param x number The x position
---@param y number The y position
---@param pattern string The background color pattern
---@return Image self The Image instance
function Image:setBg(x, y, pattern) end

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

---Sets the value of the CurrentFrame property.
---@param self Image self
---@param CurrentFrame number Current animation frame
function Image:setCurrentFrame(self, CurrentFrame) end

---Sets the value of the OffsetX property.
---@param self Image self
---@param OffsetX number Horizontal offset for viewing larger images
function Image:setOffsetX(self, OffsetX) end

---Gets the value of the OffsetY property.
---@param self Image self
---@return number 0 Vertical offset for viewing larger images
function Image:getOffsetY(self) end

---Gets pixel information at position
---@param x number X position
---@param y number Y position
---@return number ? fg Foreground color
---@return number ? bg Background color
---@return string ? char Character at position
function Image:getPixelData(x, y) end

---Sets the text at the specified position
---@param x number The x position
---@param y number The y position
---@param text string The text to set
---@return Image self The Image instance
function Image:setText(x, y, text) end

---Sets the metadata of the image
---@param key string The key of the metadata to set
---@param value string The value of the metadata to set
---@return Image self The Image instance
function Image:setMetadata(key, value) end

---Gets the size of the image
---@return number width The width of the image
---@return number height The height of the image
function Image:getImageSize() end

---Gets the specified frame
---@param frameIndex number The index of the frame to get
---@return table frame The frame data
function Image:getFrame(frameIndex) end

---Resizes the image to the specified width and height
---@param width number The new width of the image
---@param height number The new height of the image
---@return Image self The Image instance
function Image:resizeImage(width, height) end

---@class ProgressBar : VisualElement
---@field progress number Current progress value (0-100)
---@field progressColor color The color used for the filled portion of the progress bar
---@field showPercentage boolean Whether to show the percentage text in the center
---@field direction string The direction of the progress bar ("up", "down", "left", "right")
local ProgressBar = {}

---Sets the value of the Direction property.
---@param self ProgressBar self
---@param Direction string The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:setDirection(self, Direction) end

---Gets the value of the Direction property.
---@param self ProgressBar self
---@return string right The direction of the progress bar ("up", "down", "left", "right")
function ProgressBar:getDirection(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ProgressBar:render() end

---Sets the value of the ShowPercentage property.
---@param self ProgressBar self
---@param ShowPercentage boolean Whether to show the percentage text in the center
function ProgressBar:setShowPercentage(self, ShowPercentage) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ProgressBar self The initialized instance
---@protected
function ProgressBar:init(props, basalt) end

---Gets the value of the ShowPercentage property.
---@param self ProgressBar self
---@return boolean false Whether to show the percentage text in the center
function ProgressBar:getShowPercentage(self) end

---Gets the value of the ProgressColor property.
---@param self ProgressBar self
---@return color lime The color used for the filled portion of the progress bar
function ProgressBar:getProgressColor(self) end

---Sets the value of the ProgressColor property.
---@param self ProgressBar self
---@param ProgressColor color The color used for the filled portion of the progress bar
function ProgressBar:setProgressColor(self, ProgressColor) end

---Gets the value of the Progress property.
---@param self ProgressBar self
---@return number 0 Current progress value (0-100)
function ProgressBar:getProgress(self) end

---Sets the value of the Progress property.
---@param self ProgressBar self
---@param Progress number Current progress value (0-100)
function ProgressBar:setProgress(self, Progress) end

---@class BigFontText
local BigFontText = {}

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

---@class List : VisualElement
---@field selectedForeground color Text color for selected items
---@field multiSelection boolean Whether multiple items can be selected at once
---@field offset number Current scroll offset for viewing long lists
---@field selectedBackground color Background color for selected items
---@field items table List of items to display. Items can be tables with properties including selected state
---@field selectable boolean Whether items in the list can be selected
local List = {}

---Gets the value of the SelectedBackground property.
---@param self List self
---@return color blue Background color for selected items
function List:getSelectedBackground(self) end

---Gets the currently selected items
---@return table selected List of selected items
function List:getSelectedItems() end

---Removes an item from the list
---@param index number The index of the item to remove
---@return List self The List instance
function List:removeItem(index) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function List:render() end

---Gets the value of the Offset property.
---@param self List self
---@return number 0 Current scroll offset for viewing long lists
function List:getOffset(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return List self The initialized instance
---@protected
function List:init(props, basalt) end

---Registers a function to handle the onSelect event.
---@param index number
---@param item table
---@param self List self
---@param func function The function to be called when the event fires
function List:onOnSelect(self, func) end

---Scrolls the list to the top
---@return List self The List instance
function List:scrollToTop() end

---Adds an item to the list
---@param text string |table The item to add (string or item table)
---@return List self The List instance
function List:addItem(text) end

---Sets the value of the Selectable property.
---@param self List self
---@param Selectable boolean Whether items in the list can be selected
function List:setSelectable(self, Selectable) end

---Gets the value of the Selectable property.
---@param self List self
---@return boolean true Whether items in the list can be selected
function List:getSelectable(self) end

---Clears all items from the list
---@return List self The List instance
function List:clear() end

---Sets the value of the SelectedBackground property.
---@param self List self
---@param SelectedBackground color Background color for selected items
function List:setSelectedBackground(self, SelectedBackground) end

---Gets the value of the Items property.
---@param self List self
---@return table {} List of items to display. Items can be tables with properties including selected state
function List:getItems(self) end

---Registers a callback for the select event
---@param callback function The callback function to register
---@return List self The List instance
function List:onSelect(callback) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The direction of the scroll (1 for down, -1 for up)
---@param x number The x-coordinate of the scroll
---@param y number The y-coordinate of the scroll
---@return boolean Whether the event was handled
---@protected
function List:mouse_scroll(direction, x, y) end

---Scrolls the list to the bottom
---@return List self The List instance
function List:scrollToBottom() end

---Gets the value of the SelectedForeground property.
---@param self List self
---@return color white Text color for selected items
function List:getSelectedForeground(self) end

---Gets first selected item
---@return table ? selected The first item
function List:getSelectedItem() end

---Sets the value of the Items property.
---@param self List self
---@param Items table List of items to display. Items can be tables with properties including selected state
function List:setItems(self, Items) end

---Gets the value of the MultiSelection property.
---@param self List self
---@return boolean false Whether multiple items can be selected at once
function List:getMultiSelection(self) end

---Sets the value of the Offset property.
---@param self List self
---@param Offset number Current scroll offset for viewing long lists
function List:setOffset(self, Offset) end

---Sets the value of the MultiSelection property.
---@param self List self
---@param MultiSelection boolean Whether multiple items can be selected at once
function List:setMultiSelection(self, MultiSelection) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was clicked
---@param x number The x-coordinate of the click
---@param y number The y-coordinate of the click
---@return boolean Whether the event was handled
---@protected
function List:mouse_click(button, x, y) end

---Sets the value of the SelectedForeground property.
---@param self List self
---@param SelectedForeground color Text color for selected items
function List:setSelectedForeground(self, SelectedForeground) end

---@class Log
local Log = {}

---Sends a warning message to the logger.
function Log.warn() end

---Sends a debug message to the logger.
function Log.debug() end

---Sends an error message to the logger.
function Log.error() end

---Sets if the logger should log
function Log.setEnabled() end

---Sets if the logger should log to a file.
function Log.setLogToFile() end

---Sends an info message to the logger.
function Log.info() end

---@class Benchmark
local Benchmark = {}

---Gets statistics for a benchmark
---@param name string The name of the benchmark
---@return table ? stats The benchmark statistics or nil
function API.getStats(name) end

---Starts a custom benchmark
---@param name string The name of the benchmark
function API.start(name) end

---Clears a specific benchmark
---@param name string The name of the benchmark to clear
function API.clear(name) end

---Stops a custom benchmark
---@param name string The name of the benchmark to stop
function API.stop(name) end

---Clears all custom benchmarks
function API.clearAll() end

---@class Input : VisualElement
---@field placeholderColor color Color of the placeholder text
---@field replaceChar string Character to replace the input with (for password fields)
---@field placeholder string Text to display when input is empty
---@field pattern string nil Regular expression pattern for input validation
---@field cursorColor number Color of the cursor
---@field focusedBackground color Background color when input is focused
---@field viewOffset number The horizontal scroll offset for viewing long text
---@field cursorPos number The current cursor position in the text
---@field maxLength number nil Maximum length of input text (optional)
---@field text string The current text content of the input
---@field focusedForeground color Foreground color when input is focused
local Input = {}

---Sets the value of the Text property.
---@param self Input self
---@param Text string The current text content of the input
function Input:setText(self, Text) end

---Gets the value of the Pattern property.
---@param self Input self
---@return string ? nil Regular expression pattern for input validation
function Input:getPattern(self) end

---Sets the value of the CursorPos property.
---@param self Input self
---@param CursorPos number The current cursor position in the text
function Input:setCursorPos(self, CursorPos) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:focus() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:paste() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:blur() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param char string The character that was typed
---@return boolean handled Whether the event was handled
---@protected
function Input:char(char) end

---Updates the input's viewport
---@return Input self The updated instance
function Input:updateViewport() end

---Gets the value of the PlaceholderColor property.
---@param self Input self
---@return color gray Color of the placeholder text
function Input:getPlaceholderColor(self) end

---Gets the value of the FocusedBackground property.
---@param self Input self
---@return color blue Background color when input is focused
function Input:getFocusedBackground(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The button that was clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean handled Whether the event was handled
---@protected
function Input:mouse_click(button, x, y) end

---Gets the value of the Placeholder property.
---@param self Input self
---@return string ... Text to display when input is empty
function Input:getPlaceholder(self) end

---Gets the value of the CursorColor property.
---@param self Input self
---@return number nil Color of the cursor
function Input:getCursorColor(self) end

---Sets the value of the ViewOffset property.
---@param self Input self
---@param ViewOffset number The horizontal scroll offset for viewing long text
function Input:setViewOffset(self, ViewOffset) end

---Gets the value of the Text property.
---@param self Input self
---@return string - The current text content of the input
function Input:getText(self) end

---Sets the cursor position and color
---@param x number The x position of the cursor
---@param y number The y position of the cursor
---@param blink boolean Whether the cursor should blink
---@param color number The color of the cursor
function Input:setCursor(x, y, blink, color) end

---Gets the value of the MaxLength property.
---@param self Input self
---@return number ? nil Maximum length of input text (optional)
function Input:getMaxLength(self) end

---Sets the value of the MaxLength property.
---@param self Input self
---@param MaxLength number nil Maximum length of input text (optional)
function Input:setMaxLength(self, MaxLength) end

---Gets the value of the ReplaceChar property.
---@param self Input self
---@return string nil Character to replace the input with (for password fields)
function Input:getReplaceChar(self) end

---Sets the value of the FocusedForeground property.
---@param self Input self
---@param FocusedForeground color Foreground color when input is focused
function Input:setFocusedForeground(self, FocusedForeground) end

---Gets the value of the FocusedForeground property.
---@param self Input self
---@return color white Foreground color when input is focused
function Input:getFocusedForeground(self) end

---Gets the value of the CursorPos property.
---@param self Input self
---@return number 1 The current cursor position in the text
function Input:getCursorPos(self) end

---Sets the value of the CursorColor property.
---@param self Input self
---@param CursorColor number Color of the cursor
function Input:setCursorColor(self, CursorColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param key number The key that was pressed
---@return boolean handled Whether the event was handled
---@protected
function Input:key(key) end

---Sets the value of the Placeholder property.
---@param self Input self
---@param Placeholder string Text to display when input is empty
function Input:setPlaceholder(self, Placeholder) end

---Sets the value of the PlaceholderColor property.
---@param self Input self
---@param PlaceholderColor color Color of the placeholder text
function Input:setPlaceholderColor(self, PlaceholderColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Input:render() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Input self The initialized instance
---@protected
function Input:init(props, basalt) end

---Gets the value of the ViewOffset property.
---@param self Input self
---@return number 0 The horizontal scroll offset for viewing long text
function Input:getViewOffset(self) end

---Sets the value of the Pattern property.
---@param self Input self
---@param Pattern string nil Regular expression pattern for input validation
function Input:setPattern(self, Pattern) end

---Sets the value of the FocusedBackground property.
---@param self Input self
---@param FocusedBackground color Background color when input is focused
function Input:setFocusedBackground(self, FocusedBackground) end

---Sets the value of the ReplaceChar property.
---@param self Input self
---@param ReplaceChar string Character to replace the input with (for password fields)
function Input:setReplaceChar(self, ReplaceChar) end

---@class Slider : VisualElement
---@field barColor color Color of the slider track
---@field sliderColor color Color of the slider handle
---@field max number Maximum value for value conversion (maps slider position to this range)
---@field step number Current position of the slider handle (1 to width/height)
---@field horizontal boolean Whether the slider is horizontal (false for vertical)
local Slider = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button that was released
---@param x number The x position of the release
---@param y number The y position of the release
---@return boolean handled Whether the event was handled
---@protected
function Slider:mouse_scroll(button, x, y) end

---Registers a function to handle the onChange event.
---@param value number
---@param self Slider self
---@param func function The function to be called when the event fires
function Slider:onOnChange(self, func) end

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

---Gets the current value of the slider
---@return number value The current value (0 to max)
function Slider:getValue() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Slider self The initialized instance
---@protected
function Slider:init(props, basalt) end

---Gets the value of the SliderColor property.
---@param self Slider self
---@return color blue Color of the slider handle
function Slider:getSliderColor(self) end

---Sets the value of the SliderColor property.
---@param self Slider self
---@param SliderColor color Color of the slider handle
function Slider:setSliderColor(self, SliderColor) end

---Gets the value of the Horizontal property.
---@param self Slider self
---@return boolean true Whether the slider is horizontal (false for vertical)
function Slider:getHorizontal(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Slider:render() end

---Sets the value of the Horizontal property.
---@param self Slider self
---@param Horizontal boolean Whether the slider is horizontal (false for vertical)
function Slider:setHorizontal(self, Horizontal) end

---Gets the value of the Max property.
---@param self Slider self
---@return number 100 Maximum value for value conversion (maps slider position to this range)
function Slider:getMax(self) end

---Gets the value of the Step property.
---@param self Slider self
---@return number 1 Current position of the slider handle (1 to width/height)
function Slider:getStep(self) end

---Sets the value of the BarColor property.
---@param self Slider self
---@param BarColor color Color of the slider track
function Slider:setBarColor(self, BarColor) end

---Sets the value of the Step property.
---@param self Slider self
---@param Step number Current position of the slider handle (1 to width/height)
function Slider:setStep(self, Step) end

---Sets the value of the Max property.
---@param self Slider self
---@param Max number Maximum value for value conversion (maps slider position to this range)
function Slider:setMax(self, Max) end

---@class Timer : BaseElement
---@field running boolean Indicates whether the timer is currently running or not.
---@field amount number The amount of time the timer should run.
---@field interval number The interval in seconds at which the timer will trigger its action.
---@field action function The action to be performed when the timer triggers.
local Timer = {}

---Gets the value of the Action property.
---@param self Timer self
---@return function function The action to be performed when the timer triggers.
function Timer:getAction(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Timer:dispatchEvent() end

---Sets the value of the Amount property.
---@param self Timer self
---@param Amount number The amount of time the timer should run.
function Timer:setAmount(self, Amount) end

---Stops the timer if it is currently running.
---@param self Timer The Timer instance to stop
---@return Timer self The Timer instance
function Timer:stop(self) end

---Starts the timer with the specified interval.
---@param self Timer The Timer instance to start
---@return Timer self The Timer instance
function Timer:start(self) end

---Sets the value of the Action property.
---@param self Timer self
---@param Action function The action to be performed when the timer triggers.
function Timer:setAction(self, Action) end

---Gets the value of the Amount property.
---@param self Timer self
---@return number -1 The amount of time the timer should run.
function Timer:getAmount(self) end

---Sets the value of the Interval property.
---@param self Timer self
---@param Interval number The interval in seconds at which the timer will trigger its action.
function Timer:setInterval(self, Interval) end

---Sets the value of the Running property.
---@param self Timer self
---@param Running boolean Indicates whether the timer is currently running or not.
function Timer:setRunning(self, Running) end

---Gets the value of the Running property.
---@param self Timer self
---@return boolean false Indicates whether the timer is currently running or not.
function Timer:getRunning(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Timer:init(props, basalt) end

---Gets the value of the Interval property.
---@param self Timer self
---@return number 1 The interval in seconds at which the timer will trigger its action.
function Timer:getInterval(self) end

---@class Display : VisualElement
local Display = {}

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Display:render() end

---Retrieves the underlying ComputerCraft window object
---@return table window A CC window object with all standard terminal methods
function Display:getWindow() end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function Display:init(props, basalt) end

---Writes text directly to the display with optional colors
---@param x number X position (1-based)
---@param y number Y position (1-based)
---@param text string Text to write
---@return Display self For method chaining
function Display:write(x, y, text) end

---@class BigFont : VisualElement
---@field fontSize number Scale factor for text size (1-3, where 1 is 3x3 pixels per character)
---@field text string The text string to display in enlarged format
local BigFont = {}

---Gets the value of the Text property.
---@param self BigFont self
---@return string BigFont The text string to display in enlarged format
function BigFont:getText(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@protected
function BigFont:init(props, basalt) end

---Gets the value of the FontSize property.
---@param self BigFont self
---@return number 1 Scale factor for text size (1-3, where 1 is 3x3 pixels per character)
function BigFont:getFontSize(self) end

---Sets the value of the Text property.
---@param self BigFont self
---@param Text string The text string to display in enlarged format
function BigFont:setText(self, Text) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function BigFont:render() end

---Sets the value of the FontSize property.
---@param self BigFont self
---@param FontSize number Scale factor for text size (1-3, where 1 is 3x3 pixels per character)
function BigFont:setFontSize(self, FontSize) end

---@class ScrollBar : VisualElement
---@field attachedElement table nil The element this ScrollBar is attached to
---@field min number Minimum scroll value
---@field attachedProperty string nil The property being controlled
---@field symbol string " Symbol used for the ScrollBar handle
---@field dragMultiplier number How fast the ScrollBar moves when dragging
---@field minValue number 0 Minimum value or function that returns it
---@field backgroundSymbol string Symbol used for the ScrollBar background
---@field handleSize number Size of the ScrollBar handle in characters
---@field orientation string Orientation of the ScrollBar ("vertical" or "horizontal")
---@field maxValue number 100 Maximum value or function that returns it
---@field value number Current scroll value
---@field max number Maximum scroll value
---@field step number Step size for scroll operations
---@field symbolBackgroundColor color Background color of the ScrollBar handle
local ScrollBar = {}

---Sets the value of the AttachedElement property.
---@param self ScrollBar self
---@param AttachedElement table nil The element this ScrollBar is attached to
function ScrollBar:setAttachedElement(self, AttachedElement) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param direction number The scroll direction (1 for up, -1 for down)
---@param x number The x position of the scroll
---@param y number The y position of the scroll
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_scroll(direction, x, y) end

---Sets the value of the Orientation property.
---@param self ScrollBar self
---@param Orientation string Orientation of the ScrollBar ("vertical" or "horizontal")
function ScrollBar:setOrientation(self, Orientation) end

---Sets the value of the MinValue property.
---@param self ScrollBar self
---@param MinValue number 0 Minimum value or function that returns it
function ScrollBar:setMinValue(self, MinValue) end

---Gets the value of the SymbolBackgroundColor property.
---@param self ScrollBar self
---@return color black Background color of the ScrollBar handle
function ScrollBar:getSymbolBackgroundColor(self) end

---Gets the value of the Max property.
---@param self ScrollBar self
---@return number 100 Maximum scroll value
function ScrollBar:getMax(self) end

---Attaches the ScrollBar to an element's property
---@param element BaseElement The element to attach to
---@param config table Configuration {property = "propertyName", min = number|function, max = number|function}
---@return ScrollBar self The ScrollBar instance
function ScrollBar:attach(element, config) end

---Gets the value of the Step property.
---@param self ScrollBar self
---@return number 1 Step size for scroll operations
function ScrollBar:getStep(self) end

---Sets the value of the AttachedProperty property.
---@param self ScrollBar self
---@param AttachedProperty string nil The property being controlled
function ScrollBar:setAttachedProperty(self, AttachedProperty) end

---Gets the value of the Value property.
---@param self ScrollBar self
---@return number 0 Current scroll value
function ScrollBar:getValue(self) end

---Gets the value of the HandleSize property.
---@param self ScrollBar self
---@return number 2 Size of the ScrollBar handle in characters
function ScrollBar:getHandleSize(self) end

---Gets the value of the BackgroundSymbol property.
---@param self ScrollBar self
---@return string "\127" Symbol used for the ScrollBar background
function ScrollBar:getBackgroundSymbol(self) end

---Sets the value of the Step property.
---@param self ScrollBar self
---@param Step number Step size for scroll operations
function ScrollBar:setStep(self, Step) end

---Sets the value of the SymbolBackgroundColor property.
---@param self ScrollBar self
---@param SymbolBackgroundColor color Background color of the ScrollBar handle
function ScrollBar:setSymbolBackgroundColor(self, SymbolBackgroundColor) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button clicked
---@param x number The x position of the click
---@param y number The y position of the click
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_click(button, x, y) end

---Updates the attached element's property based on the ScrollBar value
---@return ScrollBar self The ScrollBar instance
function ScrollBar:updateAttachedElement() end

---Sets the value of the Symbol property.
---@param self ScrollBar self
---@param Symbol string " Symbol used for the ScrollBar handle
function ScrollBar:setSymbol(self, Symbol) end

---Gets the value of the DragMultiplier property.
---@param self ScrollBar self
---@return number 1 How fast the ScrollBar moves when dragging
function ScrollBar:getDragMultiplier(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param button number The mouse button being dragged
---@param x number The x position of the drag
---@param y number The y position of the drag
---@return boolean Whether the event was handled
---@protected
function ScrollBar:mouse_drag(button, x, y) end

---Sets the value of the Min property.
---@param self ScrollBar self
---@param Min number Minimum scroll value
function ScrollBar:setMin(self, Min) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function ScrollBar:render() end

---Sets the value of the MaxValue property.
---@param self ScrollBar self
---@param MaxValue number 100 Maximum value or function that returns it
function ScrollBar:setMaxValue(self, MaxValue) end

---Gets the value of the Symbol property.
---@param self ScrollBar self
---@return string " " Symbol used for the ScrollBar handle
function ScrollBar:getSymbol(self) end

---Sets the value of the Max property.
---@param self ScrollBar self
---@param Max number Maximum scroll value
function ScrollBar:setMax(self, Max) end

---Gets the value of the MaxValue property.
---@param self ScrollBar self
---@return number |function 100 Maximum value or function that returns it
function ScrollBar:getMaxValue(self) end

---Sets the value of the Value property.
---@param self ScrollBar self
---@param Value number Current scroll value
function ScrollBar:setValue(self, Value) end

---Sets the value of the DragMultiplier property.
---@param self ScrollBar self
---@param DragMultiplier number How fast the ScrollBar moves when dragging
function ScrollBar:setDragMultiplier(self, DragMultiplier) end

---Gets the value of the MinValue property.
---@param self ScrollBar self
---@return number |function 0 Minimum value or function that returns it
function ScrollBar:getMinValue(self) end

---Gets the value of the AttachedElement property.
---@param self ScrollBar self
---@return table ? nil The element this ScrollBar is attached to
function ScrollBar:getAttachedElement(self) end

---Gets the value of the AttachedProperty property.
---@param self ScrollBar self
---@return string ? nil The property being controlled
function ScrollBar:getAttachedProperty(self) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return ScrollBar self The initialized instance
---@protected
function ScrollBar:init(props, basalt) end

---Sets the value of the HandleSize property.
---@param self ScrollBar self
---@param HandleSize number Size of the ScrollBar handle in characters
function ScrollBar:setHandleSize(self, HandleSize) end

---Sets the value of the BackgroundSymbol property.
---@param self ScrollBar self
---@param BackgroundSymbol string Symbol used for the ScrollBar background
function ScrollBar:setBackgroundSymbol(self, BackgroundSymbol) end

---Gets the value of the Min property.
---@param self ScrollBar self
---@return number 0 Minimum scroll value
function ScrollBar:getMin(self) end

---Gets the value of the Orientation property.
---@param self ScrollBar self
---@return string vertical Orientation of the ScrollBar ("vertical" or "horizontal")
function ScrollBar:getOrientation(self) end

---@class Graph : VisualElement
---@field series table The series of the graph
---@field minValue number The minimum value of the graph
---@field maxValue number The maximum value of the graph
local Graph = {}

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:focusSeries(name) end

---Sets the value of the Series property.
---@param self Graph self
---@param Series table The series of the graph
function Graph:setSeries(self, Series) end

---@param name string The name of the series
---@return Graph self The graph instance
function Graph:removeSeries(name) end

---Sets the value of the MinValue property.
---@param self Graph self
---@param MinValue number The minimum value of the graph
function Graph:setMinValue(self, MinValue) end

---@param name string The name of the series
---@param visible boolean Whether the series should be visible
---@return Graph self The graph instance
function Graph:changeSeriesVisibility(name, visible) end

---@param name string The name of the series
---@param count number The number of points in the series
---@return Graph self The graph instance
function Graph:setSeriesPointCount(name, count) end

---Sets the value of the MaxValue property.
---@param self Graph self
---@param MaxValue number The maximum value of the graph
function Graph:setMaxValue(self, MaxValue) end

---@param name string The name of the series
---@param value number The value of the point
---@return Graph self The graph instance
function Graph:addPoint(name, value) end

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@param props table The properties to initialize the element with
---@param basalt table The basalt instance
---@return Graph self The initialized instance
---@protected
function Graph:init(props, basalt) end

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

---This function is protected and should not be called outside of basalt, however you can overwrite it if you know what you're doing.
---@protected
function Graph:render() end

---Gets the value of the MinValue property.
---@param self Graph self
---@return number 0 The minimum value of the graph
function Graph:getMinValue(self) end

---@param name string The name of the series
---@return table ? series The series
function Graph:getSeries(name) end

---Gets the value of the MaxValue property.
---@param self Graph self
---@return number 100 The maximum value of the graph
function Graph:getMaxValue(self) end

