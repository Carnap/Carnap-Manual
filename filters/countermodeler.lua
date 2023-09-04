local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isCounterModeler = false
            local counterModelerType

            for _, val in pairs(elem.classes) do
                if val == "CounterModeler" then isCounterModeler = true end
                if val == "Simple" or val == "Validity" or val == "Constraint"
                then counterModelerType = val:lower() end
            end

            if isCounterModeler
                then
                    local chunks = exercises.chunks(elem.text)
                    local problems = {}

                    for _,chunk in ipairs(chunks) do
                        local newOpts = {
                            ["data-carnap-type"] = "countermodeler",
                            ["data-carnap-countermodelertype"] = counterModelerType,
                            ["data-carnap-goal"] = chunk.problem,
                            ["data-carnap-submission"] = "saveAs:"..chunk.label
                        }

                        table.insert(problems, exercises.wrapper({}, chunk.label, pandoc.Div({},newOpts)))
                    end
                    return pandoc.Div(problems)
                else return elem
            end
        end,
    }
}
