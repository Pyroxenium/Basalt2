local helper = {}

function helper.applyAnnotations(annotations, target, handlers)
    local i = 1
    while i <= #annotations do
        local ann = annotations[i]

        local tag, args = ann:match("^%-%-%-?%s*(@%S+)%s*(.*)")
        if tag then
            if args and args:match("^%s*%[%[") then
                local blockContent = args:gsub("^%s*%[%[%s*", "")

                if blockContent:match("%]%]%s*$") then
                    args = blockContent:gsub("%]%]%s*$", "")
                else
                    local multiArgs = {}
                    if blockContent ~= "" then
                        table.insert(multiArgs, blockContent)
                    end
                    i = i + 1

                    while i <= #annotations do
                        local nextAnn = annotations[i]
                        local content = nextAnn:match("^%-%-%-?%s*(.*)") or nextAnn

                        if content:match("%]%]%s*$") then
                            local finalContent = content:gsub("%]%]%s*$", "")
                            if finalContent ~= "" then
                                table.insert(multiArgs, finalContent)
                            end
                            break
                        else
                            table.insert(multiArgs, content)
                        end
                        i = i + 1
                    end
                    args = table.concat(multiArgs, "\n")
                end
            elseif args == ">" then
                local multiArgs = ""
                i = i + 1

                while i <= #annotations do
                    local nextAnn = annotations[i]
                    local nextTag = nextAnn:match("^%-%-%-?%s*(@%S+)")
                    if nextTag then
                        i = i - 1
                        break
                    else
                        local content = nextAnn:match("^%-%-%-?%s*(.*)") or nextAnn
                        if multiArgs ~= "" then
                            multiArgs = multiArgs .. "\n" .. content
                        else
                            multiArgs = content
                        end
                    end
                    i = i + 1
                end
                args = multiArgs
            end

            if handlers and handlers[tag] then
                handlers[tag](target, args)
            end
        else
            local comment = ann:match("^%-%-%-?%s*(.*)") or ann
            if comment and not comment:match("^@%S+") then
                if target.description then
                    target.description = target.description .. "\n" .. comment
                else
                    target.description = comment
                end
            end
        end
        i = i + 1
    end
end

function helper.findAnnotationLine(annotations, tag)
    for _, l in ipairs(annotations) do
        if l:match("@" .. tag) then
            return l
        end
    end
    return nil
end

return helper