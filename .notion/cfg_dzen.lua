dopath("dzen_helpers")

function dzen_delete()
    os.execute("pkill dzen2")
    os.execute("pkill rofi")
    os.execute("pkill -f \'lua /home/neg/.notion/mpd_dzen.lua\'")
end
local hook_deinit = notioncore.get_hook("ioncore_deinit_hook")
if hook_deinit then
    hook_deinit:add(dzen_delete)
end

dzen_pipe = io.popen("dzen2 -dock -bg ".. neg.dzen.bg_ .." -h ".. neg.dzen.h_ .." -tw 0 -x 0 -ta l -w ".. neg.dzen.main_w_ .. " -p -fn ".. neg.dzen.panel_font_ .. " ", "w")
dzen_pipe:setvbuf("line")
ws_curr = nil
kbd_template = nil
sys_template = nil
date = nil
netmon = nil
xkb_layout = nil

settings = {
      device = "enp6s0",
      show_avg = 0,       -- show average stat?
      avg_sec = 3,        -- default, shows average of 1 minute
      show_count = 0,     -- show tcp connection count?
      interval = 1*1000,  -- update every second
}

local function ws_current(t)
    local scr=notioncore.find_screen_id(0)
    local curws
    if scr ~= nil then
        curws = scr:mx_current()
        local wstype, c
        local pager=""
        local name_pager=""
        local name_pager_plus=""
        if curindex == nil then curindex = 0 end
        local curindex = 0
        if scr == nil then curindex = 0 else
            curindex = scr:get_index(curws)+1
        end
        n = scr:mx_count(1)
        for i=1,n do
            tmpws=scr:mx_nth(i-1)
            wstype=obj_typename(tmpws)
        if i==curindex then name_pager=name_pager..tmpws:name() end
        end
        local fr,cur

        local ws_map = {
            "term", "web",
            "dev", "doc",
            "media", "gimp",
            "admin", "jetbrains",
            "steam", "torrent",
            "vm", "wine"
        }
        local ws_numbered = false
        for i, v in ipairs(ws_map) do
            if name_pager == ws_map[i] then
                ws_curr = i .. ": " .. ws_map[i]
                ws_numbered = true
                break
            end
        end
        if not ws_numbered then
            ws_curr = name_pager
        end
        dzen_update()
    end
end

local function setup_hooks()
    local hook
    hook = notioncore.get_hook("screen_managed_changed_hook")
    notioncore.get_hook("region_notify_hook"):add(ws_current)
end

-- Init
setup_hooks()

local function date_update()
    date = os.date("%H:%M")
    dzen_update()
    date_timer:set((60-os.date("%S"))*1000, date_update)
end

function kbd_update()
    local klay
    local f = nil
    local template = ""

    f = io.popen("/home/neg/bin/mon/klay2", "r")
    klay = f:read("*l")
    f:close()
    template = template..klay

    kbd_template = template
    dzen_update()
end

date_timer = notioncore.create_timer()
date_timer:set(1000, date_update)
kbd_update()

local positions = {}    -- positions where the entries will be
local last = {}         -- the last readings
local history_in = {}   -- history to calculate the average
local history_out = {}
local total_in, total_out = 0, 0
local counter = 0       --

local function tokenize(str)
    local ret = {}
    local i = 0
    local k = nil

    for k in string.gmatch(str, '(%w+)') do
        ret[i] = k
        i = i + 1
    end
    return ret
end

local function sanity_check()
    local f = io.open('/proc/net/dev', 'r')
    local e

    if not f then
        return false
    end

    local s = f:read('*line')
    s = f:read('*line')         -- the second line, which should give
                                -- us the positions of the info we seek

    local t = tokenize(s)
    local n = #t
    local i = 0

    for i = 0,n do
        if t[i] == "bytes" then
            positions[0] = i
            break
        end
    end

    i = positions[0] + 1

    for i=i,n do
        if t[i] == "bytes" then
            positions[1] = i
            break
        end
    end

    if not positions[0] or not positions[1] then
        return false
    end

    s = f:read('*a')        -- read the whole file
    if not string.find(s, settings.device) then
        return false        -- the device does not exist
    end

    return true
end

local function calc_avg(lin, lout)
    if counter == settings.avg_sec then
        counter = 0
    end

    total_in = total_in - history_in[counter] + lin
    history_in[counter] = lin

    total_out = total_out - history_out[counter] + lout
    history_out[counter] = lout

    counter = counter + 1

    return total_in/settings.avg_sec, total_out/settings.avg_sec
end

local function parse_netmon_info()
    local s
    local lin, lout

    for s in io.lines('/proc/net/dev') do
        local f = string.find(s, settings.device)
        if f then
            local t = tokenize(s)
            return t[positions[0]], t[positions[1]]
    end
    end
    return nil, nil
end

local function update_netmon_info()
    local s
    local lin, lout

    local function fmt(num)
    return(string.format("%.1fK", num))
    end

    lin, lout = parse_netmon_info()
    if not lin or not lout then
        return
    end

    last[0], lin = lin, lin - last[0]
    last[1], lout = lout, lout - last[1]

    local kbsin = lin/1024
    local kbsout = lout/1024

    local output = string.format("%.1fK/%.1fK", kbsin, kbsout)

    if settings.show_avg == 1 then
    local avgin, avgout = calc_avg(lin/1024, lout/1024)
        output = output .. string.format(" (%.1fK/%.1fK)", avgin, avgout)

    netmon_avgin = fmt(avgin)
    netmon_avgout = fmt(avgout)
    dzen_update()
    end

    netmon_kbsin = fmt(kbsin)
    netmon_kbsout  = fmt(kbsout)
    netmon = output
    dzen_update()

    net_timer:set(settings.interval, update_netmon_info)
end

local function init_netmon_monitor()
    if sanity_check() then
        net_timer = notioncore.create_timer()
        net_timer:set(settings.interval, update_netmon_info)
        last[0], last[1] = parse_netmon_info()

        if settings.show_avg == 1 then
            for i=0,settings.avg_sec-1 do
                history_in[i], history_out[i] = 0, 0
            end
        end
        update_netmon_info()
        dzen_update()
    else
        netmon  = "oops"
        dzen_update()
    end
end

init_netmon_monitor()
