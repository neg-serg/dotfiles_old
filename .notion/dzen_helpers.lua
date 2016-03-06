home_=os.getenv("HOME")

dmain = {
    ws   = nil,
    kbd  = nil,
    date = nil,
    net  = nil
}

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
    if dmain.date then
        template = template.."^pa(2;)^bg(#000000)^ba()"..wrp(dmain.date).."^ba()^bg()"
    end
    if dmain.ws then
        template = template..wrp(dmain.ws)
    end
    if dmain.kbd then
        template = template..wrp(dmain.kbd)
    end
    if dmain.net then 
        template = template..wrp("net: " .. dmain.net)
    end
    dzen_pipe:write(template..'\n')
end
