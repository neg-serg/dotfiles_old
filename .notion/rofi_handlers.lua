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
    local cwin=ioncore.lookup_clientwin(str)
    if not cwin then return end
    local reg=cwin:groupleader_of()
    local function attach()
        frame:attach(reg, {switchto=true})
    end
    if frame:rootwin_of()~=reg:rootwin_of() then
    elseif reg:manager()==frame then
        reg:goto_focus()
    else
        ioncore.defer(function () attach() end)
    end
end

function goto_or_create_ws_handler(name,reg)
    if not (name == nil or name == '') then
        workspace_handler(reg,name)
    end
end

function mainmenu_handler(x)
    action = {
        ["save"]=function() ioncore.snapshot() end,
        ["restart"]=function() ioncore.restart() end,
        ["xrandr-set"]=function() ioncore.exec('~/bin/scripts/rofi-randr') end,
        ["ratpoison-restart"]=function() ioncore.restart_other("ratpoison") end,
        ["cwm-restart"]=function() ioncore.restart_other("cwm") end,
        ["twm-restart"]=function() ioncore.restart_other("twm") end,
        ["dwm-restart"]=function() ioncore.restart_other("dwm") end,
    }
    action[x]()
end

function mpdmenu_handler(x)
    local action = {
        ["title_copy"]=function() ioncore.exec('mpc current | xsel -bi') end,
        ["artist_copy"]=function() ioncore.exec('mpc current -f \'[%artist%]\'|xsel -bi') end,
        ["mpd_show"]=function() ioncore.exec('~/bin/mpd_dzen_info') end,
    }
    action[x]()
end

function workspace_handler(reg,name)
    local ws=ioncore.lookup_region(name, "WGroupWS")
    if ws then
        ws:goto_focus()
    else 
        local tmpl={
            name=(name~="" and name),
            switchto=true
        } 
        layout = "full"
        ioncore.create_ws(reg:screen_of(),tmpl,layout)
    end
end
