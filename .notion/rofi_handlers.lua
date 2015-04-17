function rename_workspace_handler(ws, str)
    ws:set_name(str)
end

function mainmenu_handler(x)
    if x == "save" then
        ioncore.snapshot()
    end
    if x == "restart" then
        ioncore.restart()
    end
    if x == "restart ratpoison" then
        ioncore.restart_other('ratpoison')
    end
end

function attach_win_handler()
    local cwin=ioncore.lookup_clientwin(str)
    if not cwin then
        return
    end
    local reg=cwin:groupleader_of()
    
    local function attach()
        frame:attach(reg, { switchto = true })
    end
    if frame:rootwin_of()~=reg:rootwin_of() then
        
    elseif reg:manager()==frame then
        reg:goto_focus()
    else
        ioncore.defer(function () attach() end)
    end
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

function rename_workspace_handler(ws, str)
    ws:set_name(str)
end
