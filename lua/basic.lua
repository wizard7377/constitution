local stringify_orig = (require 'pandoc.utils').stringify


function Pandoc(doc)
    local hblocks = {}
    currentArticle = 0 
    currentSection = 0
    for i,el in pairs(doc.blocks) do
        local elty = el.t 
        local nel = el
        if elty == "Div" and el.classes[1] == "Comment" then 
            nel = nil
        elseif elty == "Header" then 
            if el.level == 2 then 
                currentArticle = currentArticle + 1
                currentSection = 0
                local newtxt = "Article " .. tostring(currentArticle) .. ":"
                nel = pandoc.Header(el.level, pandoc.Str(newtxt), el.attr)
            elseif el.level == 3 then 
                currentSection = currentSection + 1
                local newtxt = "Section " .. toString(currentArticle) .. "." .. tostring(currentSection) .. ":"
                nel = pandoc.Header(el.level, pandoc.Str(newtxt), el.attr)
            else 
                nel = el
            end
        else 
            nel = el
        end
        if not (nel == nil) then 
            table.insert(hblocks, nel)
    
        end
    end
    return pandoc.Pandoc(hblocks, doc.meta)
end