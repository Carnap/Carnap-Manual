local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isSyntaxChecker = false
            local matchType

            for _, val in pairs(elem.classes) do
                if val == "SynChecker" then isSyntaxChecker = true end
                if val == "Match" or val == "MatchClean"
                then matchType = val:lower() end
            end

            if isSyntaxChecker
                then
                    local chunks = exercises.chunks(elem.text)
                    local problems = {}

                    for _,chunk in ipairs(chunks) do
                        local newOpts = {
                            ["data-carnap-type"] = "synchecker",
                            ["data-carnap-matchType"] = matchType,
                            ["data-carnap-goal"] = chunk.problem,
                            ["data-carnap-submission"] = "saveAs:"..chunk.label
                        }
                        exercises.transferAttributes(elem.attributes, newOpts)

                        table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div({},newOpts)))
                    end
                    return pandoc.Div(problems)
                else return elem
            end
        end,
    }
}
