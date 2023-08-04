return {
    {
        Code = function (elem)
            -- rename attribute "system" to 
            -- "data-carnap-render-system"
            if elem.attributes.system then
                local sys = elem.attributes.system
                elem.attributes["data-carnap-render-system"] = sys
                elem.attributes.system = nil
            end
            return elem
        end,
    }
}
