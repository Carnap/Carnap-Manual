local function wrapper(opts, label, content)
    local spans = pandoc.Plain({
        pandoc.Span(label,{}),
    })
    if opts.points then
        spans = pandoc.Plain({
            pandoc.Span(label,{}),
            pandoc.Span(opts.points .. " pts"),
        })
    end
    return pandoc.Div({spans, content},{
        id = "exercise-" .. label,
        class = "exercise",
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
        if not line:match("^|") then
            if currentChunk then
                table.insert(result,currentChunk)
            end
            currentChunk = {
                label = line:match("%S*"),
                problem = line:match("%S*%s*(.*)"),
                body = nil
            }
        else
            if currentChunk.body == nil then
                currentChunk.body = line:match("^|(.*)")
            else
                currentChunk.body = currentChunk.body .. '\n' .. line:match("^|(.*)")
            end
        end
    end
    table.insert(result,currentChunk)
    return result
end


return {
    wrapper = wrapper,
    chunks = chunks
}
