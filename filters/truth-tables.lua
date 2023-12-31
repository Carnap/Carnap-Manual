local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isTruthTable = false
            local ttType

            for _, val in pairs(elem.classes) do
                if val == "TruthTable" then isTruthTable = true end
                if val == "Validity" or val == "Simple" or val == "Partial"
                then ttType = val:lower() end
            end

            if isTruthTable
                then
                    local chunks = exercises.chunks(elem.text)
                    local problems = {}

                    for _,chunk in ipairs(chunks) do
                        local newOpts = {
                            ["data-carnap-type"] = "truthtable",
                            ["data-carnap-tabletype"] = ttType,
                            ["data-carnap-goal"] = chunk.problem,
                            ["data-carnap-submission"] = "saveAs:"..chunk.label
                        }

                        exercises.transferAttributes(elem.attributes, newOpts)

                        local body = chunk.body and pandoc.Str(chunk.body) or {}

                        table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div(body,newOpts)))
                    end
                    return pandoc.Div(problems)
                else return elem
            end
        end,
    }
}
