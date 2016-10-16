home_=os.getenv("HOME")
notion_dzen_=false

dmain = {
    ws   = nil,
    kbd  = nil,
    date = nil,
    net  = nil
}

function dzen_update()
    if notion_dzen_ then
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
end

function dzen_delete()
    os.execute("pkill admiral")
    os.execute("pkill dzen2")
    os.execute("pkill rofi")
    if not notion_dzen_ then
        os.execute(home_.."/bin/scripts/panels")
    end
end

local hook_deinit = notioncore.get_hook("ioncore_deinit_hook")
if hook_deinit then
    hook_deinit:add(dzen_delete)
end

if notion_dzen_ then
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
end

dopath("dzen/ws")
if notion_dzen_ then
    dopath("dzen/date")
    dopath("dzen/kbd")
    dopath("dzen/netmon")
end
