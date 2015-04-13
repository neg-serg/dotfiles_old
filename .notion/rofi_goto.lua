function rofi_template(rofi_prefix,ipc_file)
    local font_name = "Pragmata Pro for Powerline"
    local font_size =  12
    local font_style = "bold"
    local rofi_font = '-font "' .. font_name .. ' '.. font_style ..' ' .. font_size .. '"'
    local rofi_width = 1850
    local rofi_cmd='rofi -auto-select -dmenu -opacity "90" -lines "10" -yoffset -22 '.. rofi_font .. ' -fg' ..
    '"#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020" -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi_width
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. ipc_file, "w")
    rofi_pipe:setvbuf("line")
end

dopath("rofi_handlers")

function complete_clientwin()
    return complete_name(ioncore.clientwin_i)
end

function complete_ws()
    return workspacelist(ioncore.region_i)
end

local function mk_completion_add(entries)
    return function(s) 
               if s then
                   table.insert(entries, s)
               end
           end
end

local function sort(entries)
    table.sort(entries, function(a, b) return a.name < b.name end)
    return entries
end

function workspacelist(iter)
    local entries={}
    local ws_add=mk_completion_add(entries)
    
    iter(function(obj)
             if obj_is(obj, "WGroupWS") then
                ws_add(obj:name())
             end
             return true
         end)
    
    return entries
end

function complete_name(iter)
    local entries={}
    local list_add=mk_completion_add(entries)
    
    iter(function(reg)
             if not string.match(reg:name(), "dzen.*title") then
                list_add(reg:name())
             end
             return true
         end)
    
    return entries
end

-- menuentry("Rename",         "mod_query.query_renameworkspace(nil, _)"),
-- menuentry("Attach tagged", "ioncore.tagged_attach(_)", { priority = 0 }),
-- menuentry("Clear tags",    "ioncore.tagged_clear()", { priority = 0 }),
-- menuentry("Window info",   "mod_query.show_tree(_, _sub)", { priority = 0 }),
-- 
-- --DOC
-- -- This function asks for a name new for the frame where the query
-- -- was created.
-- function mod_query.query_renameframe(frame)
--     mod_query.query(frame, TR("Frame name:"), frame:name(),
--                     function(frame, str) frame:set_name(str) end,
--                     nil, "framename")
-- end

function rofi_renameworkspace(mplex,ws)
    if not mplex then
        assert(ws)
        mplex=ioncore.find_manager(ws, "WMPlex")
    elseif not ws then
        assert(mplex)
        ws=ioncore.find_manager(mplex, "WGroupWS")
    end
    
    assert(mplex and ws)

    local tbl = {}
    local ws_file = "/tmp/rename_ws"
    local rofi_prefix = ' -p "[workspace_name] >> "'
    rofi_template(rofi_prefix,ws_file)
    rofi_pipe:close() 
    fp = io.open(ws_file)
    wsname = fp:read("*l")
    ws:set_name(wsname)
    fp:close()
end

function complete_mainmenu(entries)
    table.insert(entries, "save")  --  ioncore.snapshot()
    table.insert(entries, "restart") --  ioncore.restart()
    table.insert(entries, "restart ratpoison") -- ioncore.restart_other('ratpoison')
end

function rofi_mainmenu()
    local tbl = {}
    local rofi_prefix = ' -p "[mainmenu] >> "'
    local mainmenu_file = "/tmp/mainmenu"
    rofi_template(rofi_prefix,mainmenu_file)
    complete_mainmenu(tbl)
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(goto_win_file)
    x = fp:read("*l")
    mainmenu_handler(x)
    fp:close()
end

function rofi_goto_win()
    local tbl = {}
    local goto_win_file = "/tmp/goto_win"
    local rofi_prefix = ' -p "[go] >> "'
    rofi_template(rofi_prefix,goto_win_file)
    tbl = complete_clientwin()
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(goto_win_file)
    x = fp:read("*l")
    fp:close(rofi_prefix, goto_win_file)
    local win = ioncore.lookup_clientwin(x)
    if win then
        ioncore.defer(function () win:goto_focus() end)
    end
end

function rofi_goto_or_create_ws(reg)
    local tbl = {}
    local ws_file = "/tmp/goto_ws"
    local rofi_prefix = ' -p "[ws] >> "'
    rofi_template(rofi_prefix,ws_file)
    tbl = complete_ws()
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(ws_file)
    name = fp:read("*l")
    if not (name == nil or name == '') then
        workspace_handler(reg,name)
    end
    fp:close()
end

function rofi_attach_win(frame, str)
    tbl = {}
    attach_win_file = "/tmp/attach_win"
    prefix = ' -p "[attach] >> "'
    rofi_template(prefix,attach_win_file)
    tbl = complete_clientwin()
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(attach_win_file)
    str = fp:read("*l")
    fp:close()

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
