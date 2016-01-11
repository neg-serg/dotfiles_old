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
    local action = {
        ["save"]=function() 
            notioncore.snapshot() 
        end,
        ["restart"]=function() 
            notioncore.restart() 
        end,
        ["xrandr-set"]=function() 
            notioncore.exec('~/bin/scripts/rofi-randr')
        end,
        ["ratpoison-restart"]=function() 
            notioncore.restart_other("ratpoison")
        end,
        ["cwm-restart"]=function() 
            notioncore.restart_other("cwm")
        end,
        ["twm-restart"]=function() 
            notioncore.restart_other("twm")
        end,
        ["dwm-restart"]=function() 
            notioncore.restart_other("dwm")
        end,
        ["lock_screen"]=function() 
            notioncore.exec('/usr/share/notion/notion-lock')
        end,
        ["window_info"]=function() 
            notioncore.exec_on(ioncore.current(), 
            '~/bin/scripts/rofi_xprop' .. ' ' ..  ioncore.current():xid()) 
        end,
        ["close"]=function() 
            WRegion.rqclose_propagate(ioncore.current(), ioncore.current():current())
        end,
        ["attach_tagged"]=function() 
            notioncore.tagged_attach(ioncore.current())
        end,
        ["clear_tags"]=function() 
            notioncore.tagged_clear()
        end,
        ["rename_ws"]=function() 
            rofi.renameworkspace()
        end,
        ["new_tiling"]=function() 
            new_tiling()
        end,
        [""]=nil,
    }
    action[x]()
end

function tilingmenu_handler(x)
    local tiling_action = {
        ["transpose"]=function() tiling_transpose() end,
        ["untile"]=function() tiling_untile() end,
        ["destroy_frame"]=function() tiling_unsplit() end,
        ["split"]=function() tiling_split('left') end,
        ["vsplit"]=function() tiling_split('top') end,
        ["flip"]=function() tiling_flip() end,
        ["float/at_left"]=function() 
            set_floating('left')
        end,
        ["float/at_right"]=function() 
            set_floating('right')
        end,
        ["float/above"]=function() 
            set_floating('up')
        end, 
        ["float/below"]=function() 
            set_floating('down')
        end,
        ["root/vsplit"]=function() 
            tiling_root_split('bottom')        
        end,
        ["root/split"]=function() 
            tiling_root_split('right')        
        end,
        ["root/flip"]=function() 
            tiling_flip(1)
        end,
        ["root/transpose"]=function() 
            tiling_transpose(1)
        end, 
        [""]=nil,
    }
    tiling_action[x]()
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
