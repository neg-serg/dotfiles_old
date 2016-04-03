dopath("rofi_handlers")

local width = nil

rofi = {}
rofi.fontsz = 17

function rofi.font(t)
    local font_size = rofi.fontsz
    local font_name = neg.font
    if t ~= nil then
        if t.sz ~= nil and t.sz > 4 then
            font_size = t.sz
        end
        if t.font ~= nil and t.font ~= "" then
            font_name = font
        end
    end
    return '-font "' .. font_name .. ' ' .. 'bold' .. ' ' .. font_size .. '"'
end

rofi.yoff = ' -yoffset ' .. - neg.dzen.h_ - 3 
local id_user = io.popen('id -u'):read("*l")
rofi.pid = ' -pid /run/user/' .. id_user .. '/rofi_notion.pid'

if width == nil then -- rofi.width = 1850
    local screen_width_fd = io.popen("xrandr -q |awk '/Screen/{print $8}'","r")
    local screen_width_data = screen_width_fd:read("*l")
    if screen_width_data == nil then
        screen_width_data = 1920
    end
    width = screen_width_data - 70
    rofi.width = width
    screen_width_fd:close()
end

local function rofi_template(_t,flags,t_font)
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
    local rofi_prefix
    if _t.pref ~= nil then 
        rofi_prefix = new_rofi_prefix(_t.pref)
    else
        rofi_prefix = new_rofi_prefix("")
    end
    local columns = 0
    local columns_str = ""
    local ipc_file = new_ipc_file(_t.file_name)
    ------------------------------------------
    local common = ' -dmenu -opacity 90 ' .. rofi.yoff .. rofi.pid .. ' ' 
    local colors = ' -fg '..neg.rofi.fg..' -bg '..neg.rofi.bg..' -hlfg '..neg.rofi.hlfg..' -hlbg '..neg.rofi.hlbg..' -bc '..neg.rofi.bc
    if _t.lines == nil then _t.lines = 10 else
        columns = 10
        columns_str = ' -columns ' .. columns
    end

    if flags == nil then flags = "" end

    local rfont

    if t_font then
        rfont = rofi.font(t_font)
    else
        rfont = rofi.font()
    end

    local rofi_cmd='rofi '.. rfont .. common .. ' -lines ' .. _t.lines .. columns_str .. colors .. ' -bw 2 -location 6' ..
    ' -padding 2 -width ' .. rofi.width .. flags
    rofi_pipe = io.popen(rofi_cmd .. rofi_prefix .. "> " .. ipc_file, "w")
    rofi_pipe:setvbuf("line")
    if _t.fn ~= nil then handle_input(_t.fn) end
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
    table.insert(t,"lock_screen")
    table.insert(t,"close")
    table.insert(t,"attach_tagged")
    table.insert(t,"clear_tags")
    table.insert(t,"window_info")
    for i = 1, #str do
        local c = str:sub(i,i)
        table.insert(t, c .. "wm-restart")
    end
    table.insert(t,"rename_ws")
    table.insert(t,"new_tiling")
    table.insert(t,"detach")
    return t
end

local function complete_tilingmenu()
    local t = {
        "transpose",
        "untile",
        "destroy_frame",
        "split",
        "vsplit",
        "flip",
        "float/at_left",
        "float/at_right",
        "float/above",
        "float/below",
        "root/vsplit",
        "root/split",
        "root/flip",
        "root/transpose",
        "lock_screen"
    }
    return t
end

function rofi.renameworkspace()
    local scr = ioncore.find_screen_id(0)
    local ws = scr:mx_current()
    local mplex=notioncore.find_manager(ws, "WMPlex")
    if not mplex then
        mplex = ws:current()
        ws=notioncore.find_manager(mplex, "WGroupWS")
    end
    assert(mplex and ws)
    local opt = {
        pref = "new_ws_name :: "..ws:name(),
        file_name = "rename_ws"
    }
    local wsname = rofi_template(opt)
    rename_workspace_handler(wsname,ws)
end

function rofi.renameframe(frame)
    local opt = {
        pref = "frame_name :: "..frame:name(),
        file_name = "rename_frame",
    }
    local frame_name = rofi_template(opt)
    rename_frame_handler(frame_name,frame)
end

function rofi.mainmenu()
    local opt = {
        pref = "main_menu",
        file_name = "main_menu",
        lines = 2,
        fn = complete_mainmenu,
    }
    local x = rofi_template(opt,nil,{sz=12})
    mainmenu_handler(x)
end

function rofi.tilingmenu()
    local opt = {
        pref = "tiling_menu",
        file_name = "tiling_menu",
        lines = 2,
        fn = complete_tilingmenu,
    }
    local x = rofi_template(opt,nil,{sz=12})
    tilingmenu_handler(x)
end

function rofi.goto_win()
    local t = {}
    t = complete_name()
    if #t > 1 then
        local opt = {
            pref = "goto_win",
            file_name = "go",
            fn = complete_name,
        }
        local x = rofi_template(opt)
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
    local opt = {
        pref = "goto_ws",
        file_name = "ws",
        lines = 1,
        fn = complete_ws,
    }
    local name = rofi_template(opt)
    goto_or_create_ws_handler(name,reg)
end

function rofi.attach_win(frame,str)
    local opt = {
        pref = "attach",
        file_name = "attach_win",
        fn = complete_name,
    }
    local str = rofi_template(opt)
    attach_win_handler(str,frame)
end
