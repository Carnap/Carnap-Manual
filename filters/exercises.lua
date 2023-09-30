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

local function formatChunk(c)
    local result = nil
    for line in lines(c) do
        if result == nil then
            result = line:match("^|?%d*%.?(.*)")
        else
            result = result .. '\n' .. line:match("^|?%d*%.?(.*)")
        end
    end
    return result
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
            if currentChunk == nil then --do nothing
            elseif currentChunk.body == nil then
                currentChunk.body = line:match("^|?%d*%.?(.*)")
            else
                currentChunk.body = currentChunk.body .. '\n' .. line:match("^|?%d*%.?(.*)")
            end
        end
    end
    table.insert(result,currentChunk)
    return result
end

local function simpleCipher(s)
    local ints = { utf8.codepoint(s, 1, string.len(s)) }
    local i = 1
    local key = "wallis"
    local data = {}
    for _,v in ipairs(ints) do
        local char = string.sub(key,i,i)
        table.insert(data, utf8.codepoint(char) ~ v)
        i = (i % 6) + 1
    end
    local result = {}
    for k,v in ipairs(data) do
        result[k] = utf8.char(v)
    end
    return data, result, '[' .. table.concat(data,',') .. ']'
end

local function simpleHash(s)
    local ints = { utf8.codepoint(s, 1, string.len(s)) }
    local seed = 21938
    for _,v in ipairs(ints) do
        seed = seed*19 ~ v
    end
    return seed
end

local function sanitizeHTML(s)
    s=s:gsub("%&","&amp;")
    s=s:gsub("%<","&lt;")
    s=s:gsub("%>","&gt;")
    s=s:gsub("\n","<br/>")
    s=s:gsub("\"","&quot;")
    s=s:gsub("\'","&apos;")
    s=s:gsub("(% +)", function(c) return " "..("&nbsp;"):rep(#c-1) end)
    return s
end

local function transferAttributes(attrs,new)
    for k,v in pairs(attrs) do
        new["data-carnap-" .. k] = v
    end
end

return {
    wrapper = wrapper,
    chunks = chunks,
    simpleCipher = simpleCipher,
    simpleHash = simpleHash,
    formatChunk = formatChunk,
    sanitizeHTML = sanitizeHTML,
    lines = lines,
    transferAttributes = transferAttributes,
}
