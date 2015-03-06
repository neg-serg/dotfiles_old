function wrp(tmplte, left_side, right_side)
    local bracket_color = "#287373"
    local fg_color      = "#cccccc"
    local left_side     = left_side or "[ "
    local right_side    = right_side or " ]"
    local function setcol(color)
        return "^fg(".. color .. ")"
    end
    return setcol(bracket_color) .. left_side ..
           setcol(fg_color) .. tmplte .. setcol(bracket_color) 
           .. right_side .. setcol(fg_color)
end

function dzen_update()
    local template = ""
    if date then
        template = template.."^pa(2;)^bg(#000000)^ba()"..wrp(date).."^ba()^bg()"
    end
    if ws_curr then
            template = template..wrp(ws_curr)
    end
    if kbd_template then
            template = template..wrp(kbd_template)
    end
    if netmon then 
        template = template..wrp("net: " .. netmon)
    end
    dzen_pipe:write(template..'\n')
end
