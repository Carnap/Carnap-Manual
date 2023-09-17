local exercises = require("exercises")

local function withHash (s)
    local sclean = s:match("%s(.*)")
    if sclean:len() > 0 then
        if sclean:sub(1,1) == "*"
        or sclean:sub(1,1) == "+"
        or sclean:sub(1,1) == "-"
        then
            local result = "(" .. exercises.simpleHash(sclean) .. ", \"" .. sclean:sub(2,-1) .. "\")"
            return result
        end
    end

    local result = "(" .. exercises.simpleHash(sclean) .. ", \"" .. sclean .. "\")"
    return result
end


return {
    {
        CodeBlock = function (elem)
            local isQualitative = false
            local qualType

            for _, val in pairs(elem.classes) do

                if val == "QualitativeProblem" then isQualitative = true end

                if val == "MultipleChoice"
                or val == "MultipleSelection"
                or val == "ShortAnswer"
                or val == "Numerical"
                then qualType = val:lower() end

            end

            if isQualitative then
                local chunks = exercises.chunks(elem.text)
                local problems = {}

                if qualType == "multiplechoice"
                or qualType == "multipleselection"
                then

                    for _,chunk in ipairs(chunks) do
                        local newOpts = {
                            ["data-carnap-type"] = "qualitative",
                            ["data-carnap-qualitativetype"] = qualType,
                            ["data-carnap-goal"] = exercises.sanitizeHTML(chunk.problem),
                            ["data-carnap-submission"] = "saveAs:"..chunk.label
                        }
                        for k,v in pairs(elem.attributes) do
                            newOpts["data-carnap-" .. k] = v
                        end

                        local optstring = ""
                        for k, v in pairs(newOpts) do
                            optstring = optstring .. k .. "=\"" .. v .. "\" "
                        end

                        local contents = ""
                        for line in exercises.lines(chunk.body) do
                            contents = contents .. withHash(line) .. "\n"
                        end

                        local body = pandoc.RawBlock("html",
                                "<div " .. optstring .. ">" ..
                                contents ..
                                "</div>"
                            )

                        table.insert(problems, exercises.wrapper({}, chunk.label, body))
                    end
                    return pandoc.Div(problems)

                elseif qualType == "shortanswer" then
                    for _,chunk in ipairs(chunks) do
                        local newOpts = {
                            ["data-carnap-type"] = "qualitative",
                            ["data-carnap-qualitativetype"] = qualType,
                            ["data-carnap-goal"] = exercises.sanitizeHTML(chunk.problem),
                            ["data-carnap-submission"] = "saveAs:"..chunk.label
                        }

                        for k,v in pairs(elem.attributes) do
                            newOpts["data-carnap-" .. k] = v
                        end
                        local optstring = ""
                        for k, v in pairs(newOpts) do
                            optstring = optstring .. k .. "=\"" .. v .. "\" "
                        end

                        local body = pandoc.RawBlock("html",
                                "<div " .. optstring .. ">" ..
                                (chunk.body or "") ..
                                "</div>"
                            )
                        table.insert(problems, exercises.wrapper({}, chunk.label, body))
                    end
                    return pandoc.Div(problems)

                elseif qualType == "numerical" then
                    for _,chunk in ipairs(chunks) do
                        local value, spec = string.match(chunk.problem, "(.-):(.*)")
                        local _, _, ciphered = exercises.simpleCipher(value)
                        local newOpts = {
                            ["data-carnap-type"] = "qualitative",
                            ["data-carnap-qualitativetype"] = qualType,
                            ["data-carnap-goal"] = ciphered,
                            ["data-carnap-problem"] = exercises.sanitizeHTML(spec),
                            ["data-carnap-submission"] = "saveAs:"..chunk.label,
                        }

                        for k,v in pairs(elem.attributes) do
                            newOpts["data-carnap-" .. k] = v
                        end
                        table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div(chunk.body,newOpts)))
                    end
                    return pandoc.Div(problems)
                end
            else return elem
            end
        end,
    }
}
