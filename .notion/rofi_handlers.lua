function rename_frame_handler(frame_name,frame)
    if not (frame_name == nil or frame_name == '') then
        frame:set_name(frame_name)
    end
end

function rename_workspace_handler(wsname,ws)
    if not (wsname == nil or wsname == '') then
        ws:set_name(wsname)
    end
end

function attach_win_handler(str,frame)
    local cwin=notioncore.lookup_clientwin(str)
    if not cwin then return end
    local reg=cwin:groupleader_of()
    local function attach()
        frame:attach(reg, {switchto=true})
    end
    if frame:rootwin_of()~=reg:rootwin_of() then
    elseif reg:manager()==frame then
        reg:goto_focus()
    else
        notioncore.defer(function () attach() end)
    end
end

function goto_or_create_ws_handler(name,reg)
    if not (name == nil or name == '') then
        workspace_handler(reg,name)
    end
end

function mainmenu_handler(x)
    action = {
        ["save"]=function() notioncore.snapshot() end,
        ["restart"]=function() notioncore.restart() end,
        ["xrandr-set"]=function() notioncore.exec('~/bin/scripts/rofi-randr') end,
        ["ratpoison-restart"]=function() notioncore.restart_other("ratpoison") end,
        ["cwm-restart"]=function() notioncore.restart_other("cwm") end,
        ["twm-restart"]=function() notioncore.restart_other("twm") end,
        ["dwm-restart"]=function() notioncore.restart_other("dwm") end,
    }
    action[x]()
end

function workspace_handler(reg,name)
    local ws=notioncore.lookup_region(name, "WGroupWS")
    if ws then
        ws:goto_focus()
    else 
        local tmpl={
            name=(name~="" and name),
            switchto=true
        } 
        layout = "full"
        notioncore.create_ws(reg:screen_of(),tmpl,layout)
    end
end
