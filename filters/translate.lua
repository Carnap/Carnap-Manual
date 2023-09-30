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
                        exercises.transferAttributes(elem.attributes, newOpts)

                        local body = chunk.body and pandoc.Str(chunk.body) or {}

                        table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div(body ,newOpts)))
                    end
                    return pandoc.Div(problems)
                else return elem
            end
        end,
    }
}
