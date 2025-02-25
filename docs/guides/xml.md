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

## Example with Multiple Features

```lua
local scope = {
    appTitle = "My App",
    colors = colors,
    handleSubmit = function(self)
        -- handle submission
    end
}

local xmlFile = fs.open("example.xml", "r")
main:loadXML(xmlFile.readAll(), scope)
xmlFile.close()
```

```xml
<frame background="${colors.gray}">
    <label 
        x="2" y="2"
        text="${appTitle}"
    />
    <button 
        x="2" y="4"
        text="Submit"
        onClick="handleSubmit"
    />
    <button x="2" y="6">
        <onClick>
            <![CDATA[
                function(self)
                    self:getParent():remove()
                end
            ]]>
        </onClick>
    </button>
</frame>
```