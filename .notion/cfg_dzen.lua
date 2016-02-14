dopath("dzen_helpers")

function dzen_delete()
    os.execute("pkill dzen2 && pkill rofi")
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
