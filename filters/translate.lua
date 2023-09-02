local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isTranslate = false
            local transType

            for _, val in pairs(elem.classes) do
                if val == "Translate" then isTranslate = true end
                if val == "Prop" then transType = "prop"
                elseif val == "FOL" then transType = "first-order"
                elseif val == "Desc" then transType = "description"
                elseif val == "Exact" then transType = "exact"
                end
            end

            if isTranslate
                then
                    local chunks = exercises.chunks(elem.text)
                    local problems = {}

                    for _,chunk in ipairs(chunks) do
                        local source, target = string.match(chunk.problem, "(.-):(.*)")
                        local _,_,ciphered = exercises.simpleCipher(source)
                        local newOpts = {
                            ["data-carnap-type"] = "translate",
                            ["data-carnap-transtype"] = transType,
                            ["data-carnap-goal"] = ciphered,
                            ["data-carnap-problem"] = target,
                            ["data-carnap-submission"] = "saveAs:"..chunk.label
                        }
                        for k,v in pairs(elem.attributes) do
                            newOpts["data-carnap-" .. k] = v
                        end

                        table.insert(problems, exercises.wrapper({}, chunks[1].label, pandoc.Div({},newOpts)))
                    end
                    return pandoc.Div(problems)
                else return elem
            end
        end,
    }
}
