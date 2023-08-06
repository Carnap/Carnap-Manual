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

                        for k,v in pairs(elem.attributes) do
                            newOpts["data-carnap-" .. k] = v
                        end
                        local body = {}
                        if chunk.body then 
                            print("body:" .. chunk.body)
                            body = pandoc.Str(chunk.body)
                        end
                        table.insert(problems, exercises.wrapper({}, chunks[1].label, pandoc.Div(body,newOpts)))
                    end
                    return pandoc.Div(problems)
                else return elem
            end
        end,
    }
}
