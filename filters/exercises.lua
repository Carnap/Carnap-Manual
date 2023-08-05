local function wrapper(opts, label, content)
    local spans = pandoc.Plain({
        pandoc.Span(label,{})
    })
    if opts.points then
    local spans = pandoc.Plain({
        pandoc.Span(label,{}),
        pandoc.Span(opts.points .. " pts")
    })
    end
    return pandoc.Div(spans,{
        id = "exercise-" .. label,
        class = "exercise",
        ["data-carnap-label"] = label,
    })
end

local function lines(str)
    local pos = 1;
    return function()
        if not pos then return nil end
        local  p1, p2 = string.find(str, "\r?\n", pos)
        local line
        if p1 then
            line = str:sub(pos, p1 - 1)
            pos = p2 + 1
        else
            line = str:sub(pos)
            pos = nil
        end
        return line
    end
end

local function chunks(s)
    local currentChunk = nil
    local result = {}
    for line in lines(s) do
        if not string.match(s,"^|") then
            if currentChunk then
                table.insert(result,currentChunk)
            end
            currentChunk = {
                label = string.gmatch(line,"%S*")(),
                problem = string.gmatch(line,"%S*%s*(.*)")()
            }
        else
            table.insert(currentChunk,line)
        end
    end
    table.insert(result,currentChunk)
    return result
end


return {
    wrapper = wrapper,
    chunks = chunks
}
