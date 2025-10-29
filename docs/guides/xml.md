# XML in Basalt

Basalt provides an XML parser that lets you define your UI layout in a declarative way. This can make your code more readable and maintainable.

## Basic Usage

```lua
local main = basalt.getMainFrame()

-- Load from file
local xmlFile = fs.open("myUI.xml", "r")
main:loadXML(xmlFile.readAll())
xmlFile.close()

-- Or directly as string
main:loadXML([[
    <frame width="30" height="10">
        <button text="Click me!" x="2" y="2"/>
    </frame>
]])
```

## Working with Variables

The XML parser uses a scope system to access variables and functions. Any variables you want to use in your XML must be passed in the scope:

```lua
local scope = {
    title = "My App",
    buttonWidth = 10,
    handleClick = function(self)
        self:setText("Clicked!")
    end
}

main:loadXML([[
    <frame>
        <label text="${title}"/>
        <button width="${buttonWidth}" onClick="handleClick"/>
    </frame>
]], scope)
```

## State Management

Basalt's state system integrates seamlessly with XML, allowing you to bind element properties to reactive states.

### Inline State Binding

Use the `State:` suffix on any attribute to bind it to a state:

```lua
local scope = {}

main:loadXML([[
    <button 
        textState:clicked="Clicked me!"
        backgroundState:clicked="gray"
    />
]], scope)
```

This automatically calls `setTextState("clicked", "Click me!")` and `setBackgroundState("clicked", "gray")`.

### Nested State Configuration

For more complex state setups, use the `<state>` tag:

```lua
main:loadXML([[
    <button>
        <state name="hover">
            <background>lightGray</background>
            <foreground>black</foreground>
        </state>
        <state name="clicked">
            <background>blue</background>
            <foreground>white</foreground>
        </state>
    </button>
]], scope)
```
## Custom XML Tags

You can register custom tags to create reusable components or handle special logic.

### Registering a Custom Tag

```lua
local XMLParser = basalt.getXMLParser()

XMLParser.registerTagHandler("card", function(node, parent, scope)
    -- Create a frame container
    local card = parent:addFrame()
    card:setBackground(colors.gray)
    card:setSize(20, 10)
    
    -- Parse title attribute
    if node.attributes.title then
        local title = node.attributes.title:gsub("^\"", ""):gsub("\"$", "")
        local titleLabel = card:addLabel()
        titleLabel:setText(title)
        titleLabel:setPosition(2, 1)
    end
    
    -- Process children inside the card
    if node.children then
        for _, child in ipairs(node.children) do
            local childTag = child.tag:sub(1,1):upper() .. child.tag:sub(2)
            if card["add" .. childTag] then
                local element = card["add" .. childTag](card)
                element:fromXML(child, scope)
            end
        end
    end
    
    return card
end)
```

### Using Custom Tags

```lua
main:loadXML([[
    <card title="User Info">
        <label x="2" y="3" text="Name: John"/>
        <label x="2" y="4" text="Age: 25"/>
    </card>
]])
```

### Advanced Custom Tag Example

Create a reusable dialog component:

```lua
XMLParser.registerTagHandler("dialog", function(node, parent, scope)
    local dialog = parent:addFrame()
    dialog:setSize(30, 15)
    dialog:setBackground(colors.black)
    dialog:addBorder({left=true, right=true, top=true, bottom=true})
    dialog:center()
    
    -- Title bar
    if node.attributes.title then
        local title = node.attributes.title:gsub("^\"", ""):gsub("\"$", "")
        local titleBar = dialog:addLabel()
        titleBar:setText(title)
        titleBar:setPosition(2, 1)
        titleBar:setForeground(colors.white)
    end
    
    -- Close button
    local closeBtn = dialog:addButton()
    closeBtn:setText("X")
    closeBtn:setPosition(28, 1)
    closeBtn:setSize(2, 1)
    closeBtn:onClick(function()
        dialog:remove()
    end)
    
    -- Content area (process children)
    if node.children then
        for _, child in ipairs(node.children) do
            local childTag = child.tag:sub(1,1):upper() .. child.tag:sub(2)
            if dialog["add" .. childTag] then
                local element = dialog["add" .. childTag](dialog)
                element:fromXML(child, scope)
            end
        end
    end
    
    return dialog
end)

-- Usage
main:loadXML([[
    <dialog title="Settings">
        <label x="2" y="3" text="Volume:"/>
        <slider x="2" y="4" width="20"/>
        <button x="2" y="6" text="Save"/>
    </dialog>
]])
```

### Unregistering Custom Tags

```lua
XMLParser.unregisterTagHandler("card")
```

### Checking for Custom Tags

```lua
local handler = XMLParser.getTagHandler("card")
if handler then
    -- Handler exists
end
```

## Event Handlers

There are two ways to define event handlers:

### 1. Reference a Function in Scope
```lua
local scope = {
    btnClick = function(self)
        self:setText("Clicked!")
    end
}

main:loadXML([[
    <button onClick="btnClick"/>
]], scope)
```

### 2. Using CDATA Sections
```xml
<button>
    <onClick>
        <![CDATA[
            function(self)
                self:setText("Clicked!")
            end
        ]]>
    </onClick>
</button>
```

## Property Types

The XML parser automatically converts values based on the property type:

```xml
<button
    x="5"                <!-- Converted to number -->
    visible="true"       <!-- Converted to boolean -->
    background="blue"    <!-- Converted to colors.blue -->
    text="${title}"      <!-- Evaluated from scope -->
/>
```

## Custom Attributes

Elements can store custom XML data that isn't a standard property:

```lua
main:loadXML([[
    <button customId="btn1" customData="test">
        <onClick>
            <![CDATA[
                function(self)
                    local custom = self:getCustomXML()
                    basalt.debug(custom.attributes.customId)
                end
            ]]>
        </onClick>
    </button>
]])
```

Custom attributes and children are stored in the `customXML` property and can be accessed via `getCustomXML()`.

## Important Notes

1. **Scope Variables**
   - All variables must be defined in the scope
   - Functions referenced in events must be in scope
   - Global variables are not automatically available

2. **Event Handlers**
   - Always use CDATA for inline functions
   - Function references must match exactly
   - Events are case-sensitive

3. **Expressions**
   - Use `${...}` for scope access
   - Expressions have access to scope variables
   - Complex logic should be in Lua code

4. **State Bindings**
   - State names are automatically extracted from attribute names
   - Use `propertyState:stateName` format for inline binding
   - Nested `<state>` tags provide better organization

5. **Custom Tags**
   - Custom handlers have full access to parent, node, and scope
   - Must manually process child nodes if needed
   - Can return elements for further manipulation

## Complete Example

```lua
local XMLParser = basalt.getAPI("xml")

-- Register custom card component
XMLParser.registerTagHandler("card", function(node, parent, scope)
    local card = parent:addFrame()
    card:setBackground(colors.gray)
    card:setSize(25, 8)
    
    if node.attributes.title then
        local title = node.attributes.title:gsub("^\"", ""):gsub("\"$", "")
        card:addLabel():setText(title):setPosition(2, 1)
    end
    
    if node.children then
        for _, child in ipairs(node.children) do
            local childTag = child.tag:sub(1,1):upper() .. child.tag:sub(2)
            if card["add" .. childTag] then
                local element = card["add" .. childTag](card)
                element:fromXML(child, scope)
            end
        end
    end
    
    return card
end)

-- Setup scope
local scope = {
    appTitle = "My App",
    colors = colors,
    hoverColor = colors.lightGray,
    handleSubmit = function(self)
        basalt.debug("Submitted!")
    end
}

-- Load XML
main:loadXML([[
    <frame background="${colors.gray}">
        <label 
            x="2" y="2"
            text="${appTitle}"
        />
        
        <card title="User Profile" x="2" y="4">
            <label x="2" y="2" text="Name:"/>
            <input x="8" y="2" width="15"/>
            
            <button 
                x="2" y="4" 
                text="Submit"
                onClick="handleSubmit"
                backgroundState:hover="${hoverColor}"
            />
        </card>
    </frame>
]], scope)
```