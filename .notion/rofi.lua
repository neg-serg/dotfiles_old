dopath("rofi_handlers")

local width = nil

rofi = {}
rofi.fontsz = 17
rofi.font = '-font "' .. 'Pragmata Pro for Powerline' .. ' '.. 'bold' ..' ' .. rofi.fontsz .. '"'
rofi.yoff = ' -yoffset ' .. - neg.dzen.h_ - 3 
if width == nil then -- rofi.width = 1850
    local screen_width_fd = io.popen("xrandr -q |awk '/Screen/{print $8}'","r")
    width = screen_width_fd:read("*l") - 70
    rofi.width = width
    screen_width_fd:close()
end

local function rofi_template(pref,file_name,lines,fn,flags)
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
    ------------------------------------------
    local common = ' -auto-select -dmenu -opacity 95 ' .. rofi.yoff .. ' '
    local colors = ' -fg '..neg.rofi.fg..' -bg '..neg.rofi.bg..' -hlfg '..neg.rofi.hlfg..' -hlbg '..neg.rofi.hlbg..' -bc '..neg.rofi.bc
    if lines == nil then lines = 10 else
        columns = 10
        columns_str = ' -columns ' .. columns
    end

    if flags == nil then flags = "" end

    local rofi_cmd='rofi '.. rofi.font .. common .. ' -lines ' .. lines .. columns_str .. colors .. ' -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi.width .. flags
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
    notioncore.region_i(function(obj)
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
    notioncore.clientwin_i(function(reg)
             if not (string.match(reg:name(), "dzen.*title") or string.match(reg:name(), "stalonetray"))  then
                list_add(reg:name())
             end
             return true
         end)
    return t
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
    local t = { "title_copy", "artist_copy", "mpd_show"  }
    local tt = {}
    for i,v in ipairs(t) do
        table.insert(tt, i .. " - [ " .. v .. " ]")
    end
    return tt
end

function rofi.renameworkspace(mplex,ws)
    if not mplex then
        assert(ws) mplex=notioncore.find_manager(ws, "WMPlex")
    elseif not ws then
        assert(mplex) ws=notioncore.find_manager(mplex, "WGroupWS")
    end
    assert(mplex and ws)
    local wsname = rofi_template("new_ws_name :: "..ws:name(),"rename_ws",_,_)
    rename_workspace_handler(wsname,ws)
end

function rofi.renameframe(frame)
    local frame_name = rofi_template("frame_name :: "..frame:name(),"rename_frame",_,_)
    rename_frame_handler(frame_name,frame)
end

function rofi.mainmenu()
    local x = rofi_template("mainmenu","mainmenu",_,complete_mainmenu)
    mainmenu_handler(x)
end

function rofi.mpdmenu()
    local x = rofi_template("mpdmenu","mpd",_,complete_mpd_menu," -auto-select ")
    mpdmenu_handler(x)
end

function rofi.goto_win()
    local t = {}
    t = complete_name()
    if #t > 1 then
        local x = rofi_template("goto_win","go",_,complete_name)
        local win = notioncore.lookup_clientwin(x)
        if win then
            notioncore.defer(function () win:goto_focus() end)
        end
    else
        local x = t[1]
        local win = notioncore.lookup_clientwin(x)
        if win then
            notioncore.defer(function () win:goto_focus() end)
        end

    end
end

function rofi.goto_or_create_ws(reg)
    local name = rofi_template("goto_ws","ws",1,complete_ws)
    goto_or_create_ws_handler(name,reg)
end

function rofi.attach_win(frame,str)
    local str = rofi_template("attach","attach_win",_,complete_name)
    attach_win_handler(str,frame)
end
