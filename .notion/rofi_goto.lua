rf={
    font = '-font "' .. 'Pragmata Pro for Powerline' .. ' '.. 'bold' ..' ' .. 12 .. '"',
    common = ' -auto-select -dmenu -opacity 95 -yoffset -22 ',
    colors = ' -fg "#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020"',
    width = 1850,
}

function rofi_template(rofi_prefix,ipc_file,lines)
    local columns = 0
    local columns_str = ""
    if lines == nil then
        lines = 10
    else
        columns = 10
        columns_str = ' -columns ' .. columns
    end
    local rofi_cmd='rofi '.. rf.font .. rf.common .. ' -lines ' .. lines .. columns_str .. rf.colors .. ' -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rf.width
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. ipc_file, "w")
    rofi_pipe:setvbuf("line")
end

dopath("rofi_handlers")

local function new_ipc_file(file_name)
    shm_dir = "/tmp"
    return shm_dir .. "/" .. file_name
end

local function new_rofi_prefix(prefix)
    local function quote(str)
        return '"' .. str:gsub('\\', '\\\\'):gsub('"', '\\"') .. '"'
    end
    local lb = '['
    local rb = ']'
    local prompt = ' >> '
    str = lb .. prefix .. rb .. prompt
    return " -p " .. quote(str)
end

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
    local ws_file = new_ipc_file("rename_ws")
    local rofi_prefix = new_rofi_prefix("main_menu")
    rofi_template(rofi_prefix,ws_file)
    rofi_pipe:write(ws:name(),'\n')
    rofi_pipe:close() 
    fp = io.open(ws_file)
    wsname = fp:read("*l")
    if not (wsname == nil or wsname == '') then
        ws:set_name(wsname)
    end
    fp:close()
end

function complete_mainmenu(entries)
    table.insert(entries, "save")  --  ioncore.snapshot()
    table.insert(entries, "restart") --  ioncore.restart()
    table.insert(entries, "ratpoison-restart") -- ioncore.restart_other('ratpoison')
    local str='ctd'
    for i = 1, #str do
        local c = str:sub(i,i)
        table.insert(entries, c .. "wm-restart")
    end
end

function complete_mpd_menu(entries)
    table.insert(entries, "title_copy")
    table.insert(entries, "artist_copy")
    table.insert(entries, "mpd_show")
    table.insert(entries, "resolution-set")
end

function rofi_renameframe(frame)
    local file_name = new_ipc_file("rename_frame")
    local prefix =  new_rofi_prefix("frame_name")
    rofi_template(prefix,file_name)
    rofi_pipe:write(frame:name(),'\n')
    rofi_pipe:close() 
    local fp = io.open(file_name)
    frame_name = fp:read("*l")
    if not (frame_name == nil or frame_name == '') then
        frame:set_name(frame_name)
    end
    fp:close()
end

function rofi_mainmenu()
    local tbl = {}
    local mainmenu_file = new_ipc_file("mainmenu")
    local rofi_prefix = new_rofi_prefix("mainmenu")
    rofi_template(rofi_prefix,mainmenu_file)
    complete_mainmenu(tbl)
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(mainmenu_file)
    x = fp:read("*l")
    mainmenu_handler(x)
    fp:close()
end

function rofi_mpdmenu()
    local tbl = {}
    local mpdmenu_file = new_ipc_file("mpdmenu")
    local rofi_prefix = new_rofi_prefix("mpd")
    rofi_template(rofi_prefix,mpdmenu_file)
    complete_mpd_menu(tbl)
    for i in pairs(tbl) do rofi_pipe:write(tbl[i],'\n') end
    rofi_pipe:close() 
    fp = io.open(mpdmenu_file)
    x = fp:read("*l")
    mpdmenu_handler(x)
    fp:close()
end

function rofi_goto_win()
    local tbl = {}
    local goto_win_file = new_ipc_file("goto_win")
    local rofi_prefix = new_rofi_prefix("go")
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
    local ws_file = new_ipc_file("goto_ws")
    local rofi_prefix = new_rofi_prefix("ws")
    rofi_template(rofi_prefix,ws_file,1)
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
    attach_win_file = new_ipc_file("attach_win")
    prefix = new_rofi_prefix("attach")
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
