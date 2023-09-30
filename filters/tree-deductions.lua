local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isTreeDeduction = false
            local isPlayground = nil
            local system = nil
            local systems = {
                "propNK",
                "propNJ",
                "huthAndRyanNK",
                "openLogicNK",
                "openLogicFOLNK",
                "openLogicSTNK",
                "openLogicExSTNK",
                "openLogicESTNK",
                "openLogicExESTNK",
                "openLogicSSTNK",
                "openLogicExSSTNK",
                "openLogicArithNK",
                "openLogicExArithNK",
                "openLogicExHOArithNK",
            }

            for _, val in pairs(elem.classes) do
                if val == "TreeDeduction" or val == "TreePlayground" then isTreeDeduction = true end
                if val == "TreePlayground" then isPlayground = true end
                for _, v in ipairs(systems) do
                    if v == val then system = val end
                end
            end

            if isTreeDeduction and isPlayground then
                local contents = exercises.formatChunk(elem.text) or ""
                local problems = {}

                local newOpts = {
                    ["data-carnap-type"] = "treedeductionchecker",
                    ["data-carnap-system"] = system
                }

                exercises.transferAttributes(elem.attributes, newOpts)

                local body = pandoc.Str(contents)

                table.insert(problems, exercises.wrapper({}, "Playground", pandoc.Div(body,newOpts)))
                return pandoc.Div(problems)
            elseif isTreeDeduction then
                local chunks = exercises.chunks(elem.text)
                local problems = {}

                for _,chunk in ipairs(chunks) do
                    local newOpts = {
                        ["data-carnap-type"] = "treedeductionchecker",
                        ["data-carnap-goal"] = chunk.problem,
                        ["data-carnap-submission"] = "saveAs:"..chunk.label,
                        ["data-carnap-system"] = system
                    }

                    exercises.transferAttributes(elem.attributes, newOpts)

                    local body = chunk.body and pandoc.Str(chunk.body) or {}

                    table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div(body,newOpts)))
                end
                return pandoc.Div(problems)
            else
                return elem
            end
        end,
    }
}
