dopath("rofi_handlers")

local rf={
    font = '-font "' .. 'Pragmata Pro for Powerline' .. ' '.. 'bold' ..' ' .. 12 .. '"',
    common = ' -auto-select -dmenu -opacity 95 -yoffset -22 ',
    colors = ' -fg "#666666" -bg "#000" -hlfg "#aaaaaa" -hlbg "#194558" -bc "#202020"',
    width = 1850,
}

local function rofi_template(pref,file_name,lines,fn)
------------------------------------------
    local function new_ipc_file(file_name)
        local shm_dir = "/tmp"
        return shm_dir .. "/" .. file_name
    end
------------------------------------------
    local function handle_input(func)
        if func ~= nil then
            local t = func()
            for i in pairs(t) do rofi_pipe:write(t[i],'\n') end
        end
        rofi_pipe:close() 
    end
------------------------------------------
    local function new_rofi_prefix(prefix)
        local function quote(str)
            return '"' .. str:gsub('\\', '\\\\'):gsub('"', '\\"') .. '"'
        end
        local lb = '[' rb = ']'
        local prompt = ' >> '
        local str = lb .. prefix .. rb .. prompt
        return " -p " .. quote(str)
    end
------------------------------------------
    local rofi_prefix = new_rofi_prefix(pref)
    local columns = 0
    local columns_str = ""
    local ipc_file = new_ipc_file(file_name)
    if lines == nil then lines = 10 else
        columns = 10
        columns_str = ' -columns ' .. columns
    end
    local rofi_cmd='rofi '.. rf.font .. rf.common .. ' -lines ' .. lines .. columns_str .. rf.colors .. ' -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rf.width
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. ipc_file, "w")
    rofi_pipe:setvbuf("line")
    handle_input(fn)
    local fp = io.open(ipc_file)
    answer = fp:read("*l")
    fp:close()
    return answer
end

local function complete_ws()
    local t={}
    local ws_add=(function(s) if s then table.insert(t, s) end end)
    ioncore.region_i(function(obj)
             if obj_is(obj, "WGroupWS") then
                ws_add(obj:name())
             end
             return true
         end)
    return t
end

local function complete_name()
    local t={}
    local list_add=(function(s) if s then table.insert(t, s) end end)
    ioncore.clientwin_i(function(reg)
             if not string.match(reg:name(), "dzen.*title") then
                list_add(reg:name())
             end
             return true
         end)
    return t
end

function rofi_renameworkspace(mplex,ws)
    if not mplex then
        assert(ws) mplex=ioncore.find_manager(ws, "WMPlex")
    elseif not ws then
        assert(mplex) ws=ioncore.find_manager(mplex, "WGroupWS")
    end
    assert(mplex and ws)
    local wsname = rofi_template("new_ws_name :: "..ws:name(),"rename_ws",_,_)
    rename_workspace_handler(wsname,ws)
end

local function complete_mainmenu()
    local t = {"save", "restart", "ratpoison-restart", "xrandr-set" }
    local str='ctd'
    for i = 1, #str do
        local c = str:sub(i,i)
        table.insert(t, c .. "wm-restart")
    end
    return t
end

local function complete_mpd_menu()
    local t = { "title_copy", "artist_copy", "mpd_show" }
    return t
end

function rofi_renameframe(frame)
    local frame_name = rofi_template("frame_name :: "..frame:name(),"rename_frame",_,_)
    rename_frame_handler(frame_name,frame)
end

function rofi_mainmenu()
    local x = rofi_template("mainmenu","mainmenu",_,complete_mainmenu)
    mainmenu_handler(x)
end

function rofi_mpdmenu()
    local x = rofi_template("mpdmenu","mpd",_,complete_mpd_menu)
    mpdmenu_handler(x)
end

function rofi_goto_win()
    local x = rofi_template("goto_win","go",_,complete_name)
    local win = ioncore.lookup_clientwin(x)
    if win then
        ioncore.defer(function () win:goto_focus() end)
    end
end

function rofi_goto_or_create_ws(reg)
    local name = rofi_template("goto_ws","ws",1,complete_ws)
    goto_or_create_ws_handler(name,reg)
end

function rofi_attach_win(frame,str)
    local str = rofi_template("attach","attach_win",_,complete_name)
    attach_win_handler(str,frame)
end
