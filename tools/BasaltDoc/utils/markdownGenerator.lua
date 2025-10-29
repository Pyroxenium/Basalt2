local markdownGenerator = {}

local function processDescription(description)
    if not description then return nil end
    local lines = {}
    for line in description:gmatch("([^\n]*)\n?") do
        if line ~= "" then
            line = line:gsub("https?://[^%s]+", function(url)
                return "[" .. url .. "](" .. url .. ")"
            end)
            table.insert(lines, "_" .. line .. "_")
        else
            table.insert(lines, "")
        end
    end
    return table.concat(lines, "\n")
end

local function generateFunctionMarkdown(class, functions)
    local md = {}

    for _, f in ipairs(functions) do
        local sig = "## "
        if class.name then
            sig = sig .. class.name .. (f.static and "." or ":")
        end
        sig = sig .. (f.name or "unknown") .. "("

        for i, p in ipairs(f.params) do
            sig = sig .. p.name
            if p.optional then sig = sig .. "?" end
            if i < #f.params then sig = sig .. ", " end
        end
        sig = sig .. ")"

        table.insert(md, sig)

        if f.description and f.description ~= "" then
            table.insert(md, "")
            table.insert(md, f.description)
            table.insert(md, "")
        end

        if #f.params > 0 then
            table.insert(md, "### Parameters")
            for _, p in ipairs(f.params) do
                local paramLine = "* `" .. p.name .. "`"
                if p.optional then paramLine = paramLine .. " *(optional)*" end
                paramLine = paramLine .. " `" .. p.type .. "`"
                if p.description and p.description ~= "" then
                    paramLine = paramLine .. " " .. p.description
                end
                table.insert(md, paramLine)
            end
            table.insert(md, "")
        end

        if #f.returns > 0 then
            table.insert(md, "### Returns")
            for _, r in ipairs(f.returns) do
                local returnLine = "* `" .. r.type .. "`"
                if r.name and r.name ~= "" then
                    returnLine = returnLine .. " `" .. r.name .. "`"
                end
                if r.description and r.description ~= "" then
                    returnLine = returnLine .. " " .. r.description
                end
                table.insert(md, returnLine)
            end
            table.insert(md, "")
        end

        if f.usage then
            table.insert(md, "### Usage")
            for _, usageBlock in ipairs(f.usage) do
                table.insert(md, "```lua")
                if type(usageBlock) == "string" then
                    if usageBlock:match("\n") then
                        table.insert(md, usageBlock)
                    else
                        table.insert(md, usageBlock)
                    end
                end
                table.insert(md, "```")
                table.insert(md, "")
            end
        end

        if f.run then
            table.insert(md, "### Usage (Executable)")
            table.insert(md, "```lua run")
            for _, run in ipairs(f.run) do
                if run == "" then
                    table.insert(md, "")
                else
                    table.insert(md, run)
                end
            end
            table.insert(md, "```")
            table.insert(md, "")
        end

        if f.examples then
            table.insert(md, "### Examples")
            for _, example in ipairs(f.examples) do
                table.insert(md, "```lua")
                table.insert(md, example)
                table.insert(md, "```")
            end
            table.insert(md, "")
        end

        if f.see then
            table.insert(md, "### See Also")
            for _, seeRef in ipairs(f.see) do
                table.insert(md, "* " .. seeRef)
            end
            table.insert(md, "")
        end

        if f.deprecated then
            table.insert(md, "> **⚠️ Deprecated** " .. (type(f.deprecated) == "string" and f.deprecated or "This function is deprecated"))
            table.insert(md, "")
        end

        if f.since then
            table.insert(md, "*Since: " .. f.since .. "*")
            table.insert(md, "")
        end
    end

    return md
end

function markdownGenerator.generate(ast)
    local md = {}

    if ast.global then
        if ast.global.description then
            table.insert(md, ast.global.description)
        end
    end

    local seen = {}
    for _, class in ipairs(ast.classes) do
        if not class.skip and not seen[class.name] then
            seen[class.name] = true
            local title = class.title or class.name
            table.insert(md, "# " .. title)
            if class.description then
                local processedDesc = processDescription(class.description)
                if processedDesc then
                    table.insert(md, processedDesc)
                end
            end
            if class.extends then
                table.insert(md, "")
                table.insert(md, "Extends: `" .. class.extends .. "`")
            end
            table.insert(md, "")

            if class.usage then
                table.insert(md, "## Usage")
                for _, usageBlock in ipairs(class.usage) do
                    table.insert(md, "```lua")
                    if type(usageBlock) == "string" then
                        table.insert(md, usageBlock)
                    end
                    table.insert(md, "```")
                    table.insert(md, "")
                end
            end

            if class.run then
                table.insert(md, "## Examples (Executable)")
                for _, runBlock in ipairs(class.run) do
                    table.insert(md, "```lua run")
                    if type(runBlock) == "string" then
                        table.insert(md, runBlock)
                    end
                    table.insert(md, "```")
                    table.insert(md, "")
                end
            end

            if class.notes then
                for _, note in ipairs(class.notes) do
                    table.insert(md, "> **Note:** " .. note)
                    table.insert(md, "")
                end
            end

            if #class.tableTypes > 0 then
                table.insert(md, "## Table Types")
                table.insert(md, "")
                for _, tableType in ipairs(class.tableTypes) do
                    table.insert(md, "### " .. tableType.name)
                    table.insert(md, "")
                    if #tableType.fields > 0 then
                        table.insert(md, "|Property|Type|Description|")
                        table.insert(md, "|---|---|---|")
                        for _, field in ipairs(tableType.fields) do
                            table.insert(md, string.format("|%s|%s|%s|",
                                field.name or "",
                                field.type or "any",
                                field.description or ""))
                        end
                        table.insert(md, "")
                    end
                end
            end

            if not class.skipPropertyList and #class.properties > 0 then
                table.insert(md, "## Properties")
                table.insert(md, "")
                table.insert(md, "|Property|Type|Default|Description|")
                table.insert(md, "|---|---|---|---|")
                for _, p in ipairs(class.properties) do
                    table.insert(md, string.format("|%s|%s|%s|%s|",
                        p.name or "",
                        p.propType or "any",
                        p.default or "nil",
                        p.description or ""))
                end
                table.insert(md, "")
            end

            if #class.events > 0 then
                table.insert(md, "## Events")
                table.insert(md, "")
                table.insert(md, "|Event|Parameters|Description|")
                table.insert(md, "|---|---|---|")
                for _, e in ipairs(class.events) do
                    local params = e.params or ""
                    if params:match("^{.*}$") then
                        params = params:sub(2, -2)
                    end
                    if params == "" then params = "-" else params = "`" .. params .. "`" end

                    table.insert(md, string.format("|%s|%s|%s|",
                        e.name or "", params, e.description or ""))
                end
                table.insert(md, "")
            end

            if not class.skipFunctionList and #class.functions > 0 then
                local publicFunctions = {}
                for _, f in ipairs(class.functions) do
                    if f.visibility ~= "private" and f.visibility ~= "protected" then
                        table.insert(publicFunctions, f)
                    end
                end

                if #publicFunctions > 0 then
                    table.insert(md, "## Functions")
                    table.insert(md, "")
                    table.insert(md, "|Method|Returns|Description|")
                    table.insert(md, "|---|---|---|")

                    for _, f in ipairs(publicFunctions) do
                        local methodName = (class.name or "") .. (f.static and "." or ":") .. (f.name or "")

                    local anchor = methodName:lower()
                    if #f.params > 0 then
                        for _, p in ipairs(f.params) do
                            anchor = anchor .. "-" .. p.name:lower()
                        end
                    end
                    anchor = anchor:gsub("[^%w%-]", "-")

                    local returnType = "-"
                    if #f.returns > 0 then
                        local types = {}
                        for _, r in ipairs(f.returns) do
                            table.insert(types, r.type)
                        end
                        returnType = table.concat(types, ", ")
                    end

                    local shortDesc = f.shortDescription or f.description or ""
                    table.insert(md, string.format("|[%s](#%s)|%s|%s|",
                        methodName,
                        anchor,
                        returnType,
                        shortDesc))
                    end
                    table.insert(md, "")

                    if not class.skipDetailedFunctionList then
                        local functionMd = generateFunctionMarkdown(class, publicFunctions)
                        for _, line in ipairs(functionMd) do
                            table.insert(md, line)
                        end
                    end
                end
            end
        end
    end

    return md
end

return markdownGenerator