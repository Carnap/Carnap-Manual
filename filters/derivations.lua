local exercises = require("exercises")

return {
    {
        CodeBlock = function (elem)
            local isDerivation = false
            local isPlayground = nil
            local config = nil
            local systems = {
                AllenSL = { system = "allenSL"},
                AllenSLPlus = {system = "allenSLPlus"},
                ArthurSL = {system = "arthurSL", guides = "indent", options = "fonts resize"},
                ArthurQL = {system = "arthurQL", guides = "indent", options = "fonts resize"},
                BelotPD = {system = "belotPD", options ="render"},
                BelotPDE = {system = "belotPDE", options ="render"},
                BelotPDEPlus = {system = "belotPDEPlus", options ="render"},
                BelotPDPlus = {system = "belotPDPlus", options ="render"},
                BelotSD = {system = "belotSD", options ="render"},
                BelotSDPlus = {system = "belotSDPlus", options ="render"},
                BonevacQL = {system = "bonevacQL", guides = "montague", options = "fonts resize"},
                BonevacSL = {system = "bonevacSL", guides = "montague", options = "fonts resize"},
                CortensSL = {system = "cortensSL", guides = "cortens", options = "fonts resize"},
                CortensQL = {system = "cortensQL", guides = "cortens", options = "fonts resize"},
                DavisSL = {system = "davisSL", options ="render"},
                DavisQL = {system = "davisQL", options ="render"},
                EbelsDugganFOL = {system = "ebelsDugganFOL", guides = "fitch", options = "fonts resize"},
                EbelsDugganTFL = {system = "ebelsDugganTFL", guides = "fitch", options = "fonts resize"},
                ElementaryST = {system = "elementarySetTheory",options ="resize render"},
                FirstOrder = {system = "firstOrder",guides ="montague",options ="resize"},
                FirstOrderNonC = {system = "firstOrderNonC",guides ="montague",options ="resize"},
                ForallxQL = {system = "magnusQL", options ="render"},
                ForallxQLPlus = {system = "magnusQLPlus", options ="render"},
                ForallxSL = {system = "magnusSL", options ="render"},
                ForallxSLPlus = {system = "magnusSLPlus", options ="render"},
                GallowPL = {system = "gallowPL", options ="render"},
                GallowPLPlus = {system = "gallowPLPlus", options ="render"},
                GallowSL = {system = "gallowSL", options ="render"},
                GallowSLPlus = {system = "gallowSLPlus", options ="render"},
                GamutIPND = {system = "gamutIPND", guides ="hausman", options = "resize fonts" },
                GamutMPND = {system = "gamutMPND", guides ="hausman", options = "resize fonts" },
                GamutND = {system = "gamutND", guides ="hausman", options = "resize fonts" },
                GamutNDDesc = {system = "gamutNDDesc", guides ="hausman", options = "resize fonts" },
                GamutNDSOL = {system = "gamutNDSOL", guides ="hausman", options = "resize fonts" },
                GamutNDPlus = {system = "gamutNDPlus", guides ="hausman", options = "resize fonts" },
                GamutPND = {system = "gamutPND", guides ="hausman", options = "resize fonts" },
                GamutPNDPlus = {system = "gamutPNDPlus", guides ="hausman", options = "resize fonts" },
                GoldfarbAltND = {system = "goldfarbAltND"},
                GoldfarbAltNDPlus = {system = "goldfarbAltNDPlus"},
                GoldfarbND = {system = "goldfarbND"},
                GoldfarbNDPlus = {system = "goldfarbNDPlus"},
                GoldfarbPropND = {system = "goldfarbPropND"},
                Hardegree4 = {system = "hardegree4", guides = "montague", options = "fonts"},
                Hardegree5 = {system = "hardegree5", guides = "montague", options = "fonts"},
                HardegreeB = {system = "hardegreeB", guides = "montague", options = "fonts"},
                HardegreeD = {system = "hardegreeD", guides = "montague", options = "fonts"},
                HardegreeK = {system = "hardegreeK", guides = "montague", options = "fonts"},
                HardegreeL = {system = "hardegreeL", guides = "montague", options = "fonts"},
                HardegreeMPL = {system = "hardegreeMPL", guides = "montague", options = "fonts"},
                HardegreePL = {system = "hardegreePL", options = "render"},
                HardegreePL2006 = {system = "hardegreePL2006", options = "render"},
                HardegreeSL = {system = "hardegreeSL", options = "render"},
                HardegreeSL2006 = {system = "hardegreeSL2006", options = "render"},
                HardegreeT = {system = "hardegreeT", guides = "montague",  options = "fonts"},
                HardegreeWTL = {system = "hardegreeWTL", guides = "montague", options = "render fonts"},
                HausmanPL = {system = "hausmanPL", guides ="hausman", options = "resize fonts" },
                HausmanSL = {system = "hausmanSL", guides ="hausman", options = "resize fonts" },
                HowardSnyderPL = {system = "howardSnyderPL", guides ="howardSnyder", options = "resize fonts" },
                HowardSnyderSL = {system = "howardSnyderSL", guides ="howardSnyder", options = "resize fonts" },
                HurleyPL = {system = "hurleyPL", guides = "hurley", options = "resize"},
                HurleySL = {system = "hurleySL", guides = "hurley", options = "resize"},
                IchikawaJenkinsQL = {system = "ichikawaJenkinsQL", options ="render"},
                IchikawaJenkinsSL = {system = "ichikawaJenkinsSL", options ="render"},
                JohnsonSL = {system = "johnsonSL"},
                JohnsonSLPlus = {system = "johnsonSLPlus"},
                LemmonProp = {system = "lemmonProp", options ="hideNumbering render resize"},
                LemmonQuant = {system = "lemmonQuant", options ="hideNumbering render resize"},
                LandeProp = {system = "landeProp", options ="hideNumbering render resize"},
                LandeQuant = {system = "landeQuant", options ="hideNumbering render resize"},
                LogicBookPD = {system = "LogicBookPD"},
                LogicBookPDE = {system = "LogicBookPDE"},
                LogicBookPDEPlus = {system = "LogicBookPDEPlus"},
                LogicBookPDPlus = {system = "LogicBookPDPlus"},
                LogicBookSD = {system = "LogicBookSD"},
                LogicBookSDPlus = {system = "LogicBookSDPlus"},
                MontagueQC = {system = "montagueQC",options ="resize"},
                MontagueSC = {system = "montagueSC",options ="resize"},
                PolySecondOrder = {system = "polyadicSecondOrder"},
                Prop = {system = "prop", guides ="montague",options ="resize"},
                PropNonC = {system = "propNonC",guides ="montague",options ="resize"},
                PropNL = {system = "propNL",guides ="montague",options ="resize"},
                PropNLStrict = {system = "propNLStrict",guides ="montague",options ="resize"},
                GregorySD = {system = "gregorySD",guides ="fitch",options ="indent fonts resize render"},
                GregorySDE = {system = "gregorySDE",guides ="fitch",options ="indent fonts resize render"},
                GregoryPD = {system = "gregoryPD",guides ="fitch",options ="indent fonts resize render"},
                GregoryPDE = {system = "gregoryPDE",guides ="fitch",options ="indent fonts resize render"},
                SecondOrder = {system = "secondOrder"},
                SeparativeST = {system = "separativeSetTheory",options ="resize render"},
                TomassiPL = {system = "tomassiPL", options ="resize render hideNumbering"},
                TomassiQL = {system = "tomassiQL", options ="resize render hideNumbering"},
                WinklerFOL = {system = "winklerFOL", guides = "fitch", options = "resize"},
                WinklerTFL = {system = "winklerTFL", guides = "fitch", options = "resize"},
                ZachFOL = {system = "thomasBolducAndZachFOL", options ="render"},
                ZachFOL2019 = {system = "thomasBolducAndZachFOL2019", options ="render"},
                ZachFOLCore = {system = "thomasBolducAndZachFOLCore", options ="render"},
                ZachFOLEq = {system = "zachFOLEq"},
                ZachFOLPlus2019 = {system = "thomasBolducAndZachFOLPlus2019", options ="render"},
                ZachPropEq = {system = "zachPropEq"},
                ZachTFL = {system = "thomasBolducAndZachTFL", options ="render"},
                ZachTFL2019 = {system = "thomasBolducAndZachTFL2019", options ="render"},
                ZachTFLCore = {system = "thomasBolducAndZachTFLCore", options ="render"},
            }

            for _, val in pairs(elem.classes) do
                if val == "ProofChecker" or val == "Playground" then isDerivation = true end
                if val == "Playground" then isPlayground = true end
                for k, _ in pairs(systems) do
                    if k == val then config = k end
                end
            end

            if isDerivation and isPlayground then
                local contents = exercises.formatChunk(elem.text) or ""
                local problems = {}

                local newOpts = { ["data-carnap-type"] = "proofchecker", }

                exercises.transferAttributes(systems[config] or {}, newOpts)
                exercises.transferAttributes(elem.attributes, newOpts)

                local optstring = ""
                for k, v in pairs(newOpts) do
                    optstring = optstring .. k .. "=\"" .. v .. "\" "
                end
                --need the RawBlock here to avoid insertion of unwanted newlines
                local body = pandoc.RawBlock("html", "<div " .. optstring .. ">" .. (contents or "") .. "</div>")
                table.insert(problems, exercises.wrapper({}, "Playground", body))
                return pandoc.Div(problems)
            elseif isDerivation then
                local chunks = exercises.chunks(elem.text)
                local problems = {}

                for _,chunk in ipairs(chunks) do
                    local newOpts = {
                        ["data-carnap-type"] = "proofchecker",
                        ["data-carnap-goal"] = chunk.problem,
                        ["data-carnap-submission"] = "saveAs:"..chunk.label,
                    }

                    exercises.transferAttributes(systems[config] or {}, newOpts)
                    exercises.transferAttributes(elem.attributes, newOpts)

                    local optstring = ""
                    for k, v in pairs(newOpts) do
                        optstring = optstring .. k .. "=\"" .. v .. "\" "
                    end
                    local body = pandoc.RawBlock("html", "<div " .. optstring .. ">" .. (chunk.body or "") .. "</div>")
                    table.insert(problems, exercises.wrapper({}, chunk.label, body))
                end
                return pandoc.Div(problems)
            else
                return elem
            end
        end,
    }
}
