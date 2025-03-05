local function findClassName(content)
    return content:match("%-%-%-@class%s+(%w+)")
end

local function findParentClass(content)
    return content:match("%-%-%-@class%s+%w+%s*:%s*(%w+)")
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

local function parseCombinedProperty(content)
    local combinedProperties = {}
    for line in content:gmatch("[^\r\n]+") do
        local name, props, desc = line:match("%-%-%-@combinedProperty%s+(%w+)%s+{(.-)%}%s+(.*)")
        if name and props then
            local propList = {}
            for prop, typ in props:gmatch("(%w+)%s*(%w*)")do
                table.insert(propList, {
                    name = prop,
                    type = typ ~= "" and typ or "any"
                })
            end

            combinedProperties[#combinedProperties + 1] = {
                name = name,
                properties = propList,
                description = desc
            }
        end
    end
    return combinedProperties
end

local function parseEvents(content)
    local events = {}
    for line in content:gmatch("[^\r\n]+") do
        local name, description = line:match("%-%-%-@event%s+([%w_]+)%s+(.+)")
        if name then
            -- Entferne das "on" Präfix falls vorhanden
            local baseName = name:match("^on(.+)") or name
            -- Konvertiere erste Buchstabe zu Großbuchstaben
            local functionName = "on" .. baseName:sub(1,1):upper() .. baseName:sub(2)

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
    for file in io.popen('ls "' .. folder .. '"'):lines() do
        if file:match("%.lua$") then
            local f = io.open(folder .. "/" .. file, "r")
            if f then
                local content = f:read("*a")
                f:close()

                local className = findClassName(content)
                if className and className ~= "BaseFrame" then
                    table.insert(classes, className)
                end
            end
        end
    end
    return classes
end

local function getParentProperties(parentClass, allClasses)
    -- Rekursiv alle Properties der Elternklasse(n) holen
    local properties = {}
    if parentClass then
        for _, classContent in pairs(allClasses) do
            if classContent.name == parentClass then
                -- Properties der Elternklasse kopieren
                for _, prop in ipairs(classContent.properties) do
                    table.insert(properties, prop)
                end
                -- Auch von der Elternklasse der Elternklasse holen
                if classContent.parent then
                    local parentProps = getParentProperties(classContent.parent, allClasses)
                    for _, prop in ipairs(parentProps) do
                        table.insert(properties, prop) 
                    end
                end
                break
            end
        end
    end
    return properties
end

local function generateClassContent(className, properties, combinedProperties, events, allClasses)
    -- Parent-Klasse finden
    local parentClass = findParentClass(content)
    -- Properties der Elternklasse(n) holen
    local inheritedProps = getParentProperties(parentClass, allClasses)
    -- Mit eigenen Properties kombinieren
    for _, prop in ipairs(inheritedProps) do
        table.insert(properties, prop)
    end

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

    for _, combinedProp in ipairs(combinedProperties) do
        table.insert(content, string.format("--- Gets the %s", combinedProp.description))
        table.insert(content, string.format("---@generic Element: %s", className))
        table.insert(content, "---@param self Element")
        for _, prop in ipairs(combinedProp.properties) do
            table.insert(content, string.format("---@return %s %s", prop.type, prop.name))
        end
        table.insert(content, string.format("function %s:get%s()",
            className,
            combinedProp.name:sub(1,1):upper() .. combinedProp.name:sub(2)
        ))
        local returnValues = {}
        for _, prop in ipairs(combinedProp.properties) do
            table.insert(returnValues, "self." .. prop.name)
        end
        table.insert(content, string.format("    return %s", table.concat(returnValues, ", ")))
        table.insert(content, "end")
        table.insert(content, "")

        table.insert(content, string.format("--- Sets the %s", combinedProp.description))
        table.insert(content, string.format("---@generic Element: %s", className))
        table.insert(content, "---@param self Element")
        for _, prop in ipairs(combinedProp.properties) do
            table.insert(content, string.format("---@param %s %s", prop.name, prop.type))
        end
        table.insert(content, "---@return Element")

        local params = {}
        for _, prop in ipairs(combinedProp.properties) do
            table.insert(params, prop.name)
        end
        table.insert(content, string.format("function %s:set%s(%s)",
            className,
            combinedProp.name:sub(1,1):upper() .. combinedProp.name:sub(2),
            table.concat(params, ", ")
        ))

        for _, prop in ipairs(combinedProp.properties) do
            table.insert(content, string.format("    self.%s = %s", prop.name, prop.name))
        end
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
end

--- Adds a new delayed %s to the container
---@generic Element: Container
---@param self Element
---@return %s
function Container:addDelayed%s()
    return self
end]], cls, cls, cls, cls, cls, cls))
            table.insert(content, "")
        end
    end

    return table.concat(content, "\n")
end

local function parseFolder(folder, destinationFile)
    local allClasses = collectAllClassNames(folder)
    local allContent = {}

    for file in io.popen('ls "' .. folder .. '"'):lines() do
        if file:match("%.lua$") then
            local f = io.open(folder .. "/" .. file, "r")
            if f then
                local content = f:read("*a")
                f:close()

                local className = findClassName(content)
                if className then
                    local properties = parseProperties(content)
                    local combinedProperties = parseCombinedProperty(content)
                    local events = parseEvents(content)
                    local classContent = generateClassContent(className, properties, combinedProperties, events, allClasses)
                    if classContent then
                        table.insert(allContent, classContent)
                    end
                end
            end
        end
    end

    local f = io.open(destinationFile, "w")
    if f then
        f:write(table.concat(allContent, "\n\n"))
        f:close()
    end
end

local args = {...}
if #args == 2 then
    parseFolder(args[1], args[2])
else
    print("Usage: annotationParser <sourceFolder> <destinationFile>")
end