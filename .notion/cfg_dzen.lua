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

function dzen_delete()
    os.execute("pkill dzen2")
    os.execute("pkill rofi")
end

local hook_deinit = notioncore.get_hook("ioncore_deinit_hook")
if hook_deinit then
    hook_deinit:add(dzen_delete)
end

if dzen_pipe == nil then
    dzen_pipe = io.popen("dzen2 -dock -bg ".. 
                        neg.dzen.bg_ ..
                        " -h ".. neg.dzen.h_ ..
                        " -tw 0 -x 0 -ta l -w ".. 
                        neg.dzen.main_w_ .. 
                        " -p -fn ".. 
                        neg.dzen.panel_font_ .. 
                        " ", "w"
                        ) dzen_pipe:setvbuf("line")
end

dopath("dzen/ws")
dopath("dzen/date")
dopath("dzen/kbd")
dopath("dzen/netmon")
