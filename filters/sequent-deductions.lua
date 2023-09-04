
local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isSequentDeduction = false
            local isPlayground = nil
            local system = nil
            local systems = {
                "propLK",
                "propLJ",
                "openLogicPropLK",
                "openLogicPropLJ",
                "foLK",
                "foLJ",
                "openLogicFOLK",
                "openLogicFOLJ",
            }

            for _, val in pairs(elem.classes) do
                if val == "Sequent" or val == "SequentPlayground" then isSequentDeduction = true end
                if val == "SequentPlayground" then isPlayground = true end
                for _, v in ipairs(systems) do
                    if v == val then system = val end
                end
            end

            if isSequentDeduction and isPlayground then
                local contents = exercises.formatChunk(elem.text) or ""
                local problems = {}

                local newOpts = {
                    ["data-carnap-type"] = "sequentchecker",
                    ["data-carnap-system"] = system
                }
                for k,v in pairs(elem.attributes) do
                    newOpts["data-carnap-" .. k] = v
                end
                local body = pandoc.Str(contents)
                table.insert(problems, exercises.wrapper({}, "Playground", pandoc.Div(body,newOpts)))
                return pandoc.Div(problems)
            elseif isSequentDeduction then
                local chunks = exercises.chunks(elem.text)
                local problems = {}

                for _,chunk in ipairs(chunks) do
                    local newOpts = {
                        ["data-carnap-type"] = "sequentchecker",
                        --shortcircut evaluation with `and`
                        ["data-carnap-goal"] = chunk.problem,
                        ["data-carnap-submission"] = "saveAs:"..chunk.label,
                        ["data-carnap-system"] = system
                    }

                    for k,v in pairs(elem.attributes) do
                        newOpts["data-carnap-" .. k] = v
                    end
                    local body = {}
                    if chunk.body then
                        body = pandoc.Str(chunk.body)
                    end
                    table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div(body,newOpts)))
                end
                return pandoc.Div(problems)
            else
                return elem
            end
        end,
    }
}
