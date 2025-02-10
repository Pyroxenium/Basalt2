local function parseProperty(line)
    -- Matches: ---@property name type default description
    local name, type, default, description = line:match("%-%-%-@property%s+(%w+)%s+(%w+)%s+(.-)%s+(.*)")
    
    if name and type then
        -- Generate field annotation
        local fieldDef = string.format("---@field %s %s\n", name, type)
        
        -- Generate getter annotation and function
        local getterDoc = string.format([[
--- Gets the %s
---@generic T: %s
---@param self T
---@return %s
]], description, "VisualElement", type)

        local getterFunc = string.format([[
function VisualElement:get%s()
    return self.%s
end
]], name:sub(1,1):upper() .. name:sub(2), name)

        -- Generate setter annotation and function
        local setterDoc = string.format([[
--- Sets the %s
---@generic T: %s
---@param self T
---@param %s %s
---@return T
]], description, "VisualElement", name, type)

        local setterFunc = string.format([[
function VisualElement:set%s(%s)
    self.%s = %s
    return self
end
]], name:sub(1,1):upper() .. name:sub(2), name, name, name)

        return fieldDef .. getterDoc .. getterFunc .. setterDoc .. setterFunc
    end
end

local input = [[
---@property x number 1 The x position of the element
---@property y number 1 The y position of the element
]]

for line in input:gmatch("[^\r\n]+") do
    parseProperty(line)
end

local function findClassName(content)
    return content:match("%-%-%-@class%s+(%w+)")
end

local function parseProperties(content)
    local properties = {}
    for line in content:gmatch("[^\r\n]+") do
        local name, type, default, desc = line:match("%-%-%-@property%s+(%w+)%s+(%w+)%s+(.-)%s+(.*)")
        if name and type then
            properties[#properties + 1] = {
                name = name,
                type = type,
                default = default,
                description = desc
            }
        end
    end
    return properties
end

local function parseEvents(content)
    local events = {}
    for line in content:gmatch("[^\r\n]+") do

        local name, description = line:match("%-%-%-@event%s+([%w_]+)%s+(.+)")
        if name then
            local functionName = name:gsub("_(%w)", function(c) return c:upper() end)
            functionName = "on" .. functionName:sub(1,1):upper() .. functionName:sub(2)

            events[#events + 1] = {
                name = name,
                functionName = functionName,
                description = description
            }
        end
    end
    return events
end

local function collectAllClassNames(folder)
    local classes = {}
    local files = fs.list(folder)

    for _, filename in ipairs(files) do
        if filename:match("%.lua$") then
            local path = fs.combine(folder, filename)
            local f = fs.open(path, "r")
            if f then
                local content = f.readAll()
                f.close()

                local className = findClassName(content)
                if className and className ~= "BaseFrame" then
                    table.insert(classes, className)
                end
            end
        end
    end
    return classes
end

local function generateClassContent(className, properties, events, allClasses)
    if #properties == 0 and #events == 0 and className ~= "Container" then
        return nil
    end

    local content = {}
    table.insert(content, string.format("---@class %s", className))

    for _, prop in ipairs(properties) do
        table.insert(content, string.format("---@field %s %s", prop.name, prop.type))
    end

    table.insert(content, string.format("local %s = {}", className))
    table.insert(content, "")

    for _, prop in ipairs(properties) do
        table.insert(content, string.format("--- Gets the %s", prop.description))
        table.insert(content, string.format("---@generic Element: %s", className))
        table.insert(content, "---@param self Element")
        table.insert(content, string.format("---@return %s", prop.type))
        table.insert(content, string.format("function %s:get%s()", 
            className,
            prop.name:sub(1,1):upper() .. prop.name:sub(2)
        ))
        table.insert(content, string.format("    return self.%s", prop.name))
        table.insert(content, "end")
        table.insert(content, "")

        table.insert(content, string.format("--- Sets the %s", prop.description))
        table.insert(content, string.format("---@generic Element: %s", className))
        table.insert(content, "---@param self Element")
        table.insert(content, string.format("---@param %s %s", prop.name, prop.type))
        table.insert(content, "---@return Element")
        table.insert(content, string.format("function %s:set%s(%s)", 
            className,
            prop.name:sub(1,1):upper() .. prop.name:sub(2),
            prop.name
        ))
        table.insert(content, string.format("    self.%s = %s", prop.name, prop.name))
        table.insert(content, "    return self")
        table.insert(content, "end")
        table.insert(content, "")
    end

    for _, event in ipairs(events) do
        table.insert(content, string.format([[
--- %s
---@generic Element: %s
---@param self Element
---@param callback function
---@return Element
function %s:%s(callback)
    return self
end]], event.description, className, className, event.functionName))
        table.insert(content, "")
    end

    if className == "Container" then
        for _, cls in ipairs(allClasses) do
            table.insert(content, string.format([[
--- Adds a new %s to the container
---@generic Element: Container
---@param self Element
---@return %s
function Container:add%s()
    return self
end]], cls, cls, cls))
            table.insert(content, "")
        end
    end

    return table.concat(content, "\n")
end

local function parseFolder(folder, destinationFile)
    local allClasses = collectAllClassNames(folder)
    local allContent = {}

    local files = fs.list(folder)

    for _, filename in ipairs(files) do
        if filename:match("%.lua$") then
            local path = fs.combine(folder, filename)
            local f = fs.open(path, "r")
            if f then
                local content = f.readAll()
                f.close()

                local className = findClassName(content)
                if className then
                    local properties = parseProperties(content)
                    local events = parseEvents(content)
                    local classContent = generateClassContent(className, properties, events, allClasses)
                    if classContent then  -- Only add if content was generated
                        table.insert(allContent, classContent)
                    end
                end
            end
        end
    end

    local f = fs.open(destinationFile, "w")
    if f then
        f.write(table.concat(allContent, "\n\n"))
        f.close()
    end
end

local args = {...}
if #args == 2 then
    parseFolder(args[1], args[2])
else
    print("Usage: annotationParser <sourceFolder> <destinationFile>")
end