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

return wrapper
