-- Workspace params
_marker = "^fg(#ff0000)"
_markerend = "^fg()"
all_marker = " - "
ws_template = nil
ws_curr = nil
kbd_template = nil
sys_template = nil
vol_template = nil
date = nil
mpd_status = nil

netmon_avgin = nil
netmon_avgout = nil
netmon_template = nil

netmon_kbsin = nil
netmon_kbsout = nil
netmon = nil

mpd_pipe = io.popen("dzen2 -dock -bg '#000000' -h 19 -tw 0  -x 0 -ta r -w 910 -p -fn 'PragmataPro:style=bold:size=12' ", "w")
mpd_pipe:setvbuf("line")

settings = {
      device = "enp6s0",
      show_avg = 0,       -- show average stat?
      avg_sec = 60,       -- default, shows average of 1 minute
      show_count = 0,     -- show tcp connection count?
      interval = 1*1000,  -- update every second
}

local function wrp(tmplte)
    return "^fg(#287373)[^fg(#cccccc) " .. tmplte .. " ^fg(#287373)]^fg(#cccccc)"
end

local function wrp2(tmplte)
    return "^fg(#287373)[^fg(#cccccc)" .. tmplte .. "^fg(#287373)]^fg(#cccccc)"
end

vol_template = "test"

local function dzen_update()
    local template = ""
    if date then
        template = template.."^pa(2;)^bg(#000000)^ba()"..wrp(date).."^ba()^bg()"
    end
    if ws_curr then
            template = template..wrp(ws_curr)
    end
    if kbd_template then
            template = template..wrp(kbd_template)
    end
    if netmon then 
        template = template..wrp("net: " .. netmon)
    end
    dzen_pipe:write(template..'\n')
end

local function mpd_dzen_update()
    local template = ""
    if mpd_status then
        template = template..mpd_status
    end
    mpd_pipe:write(template..'\n')
end

local function dzen_input()
    local dzen_input, reg = nil, nil

    f = io.open(dzen_output, "r")
    dzen_input = f:read("*l")
    f:close()

    if dzen_input ~= nil then
            print("AAAA "..dzen_input.."\n")
            io.flush()
        reg = dzen_input:lookup_region()
        if reg ~=nil then
            reg:goto_focus()
        end
    end
end

local function update_frame()
    local fr
    ioncore.defer( function() 
	local cur=ioncore.current()
	if obj_is(cur, "WClientWin") and
	  obj_is(cur:parent(), "WMPlex") then
	    cur=cur:parent()
	end
	fr=cur:name()
    end)
end

local function ws_current(t)
    local scr=ioncore.find_screen_id(0)
    local curws = scr:mx_current()
    local wstype, c
    local pager=""
    local name_pager=""
    local name_pager_plus=""
    local curindex = scr:get_index(curws)+1
    n = scr:mx_count(1)
    for i=1,n do
        tmpws=scr:mx_nth(i-1)
        wstype=obj_typename(tmpws)
	if wstype=="WIonWS" then
	    c="i"
	elseif wstype=="WFloatWS" then
	    c="f"
	elseif wstype=="WPaneWS" then
	    c="p"
	elseif wstype=="WGroupWS" then
	    c="g"
	else
	    c="c"
	end
	if i==curindex then
            name_pager=name_pager..tmpws:name()
	    pager=pager..c
	end
    end

    local fr,cur

    -- Older versions without an ioncore.current() should
    -- skip update_frame.
    update_frame()

    ws_curr = name_pager
    dzen_update()
end

local function setup_hooks()
    local hook
    hook = ioncore.get_hook("screen_managed_changed_hook")
    ioncore.get_hook("region_notify_hook"):add(ws_current)
end

-- Init
setup_hooks()

local function date_update()
    date = os.date("%H:%M")
    dzen_update()
    date_timer:set((60-os.date("%S"))*1000, date_update)
end

local function kbd_update()
    local klay
    local f = nil
    local template = ""

    f = io.popen("/home/neg/bin/mon/klay2", "r")
    klay = f:read("*l")
    f:close()
    template = template..klay

    kbd_template = template
    dzen_update()
    kbd_timer:set(200, kbd_update)
end

date_timer = ioncore.create_timer()
date_timer:set(1000, date_update)
mpd_timer = ioncore.create_timer()
mpd_timer:set(1000, mpd_update)
kbd_timer = ioncore.create_timer()
kbd_timer:set(200, kbd_update)

local positions = {}    -- positions where the entries will be
local last = {}         -- the last readings
local history_in = {}   -- history to calculate the average
local history_out = {}
local total_in, total_out = 0, 0
local counter = 0       --

--
-- tokenize the string
--
local function tokenize(str)
    local ret = {}
    local i = 0
    local k = nil

    for k in string.gfind(str, '(%w+)') do
        ret[i] = k
        i = i + 1
    end
    return ret
end

--
-- calculate the average
--
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

--
-- parse the information
--
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

--
-- update the netmon monitor
--
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

--
-- is everything ok to begin with?
--
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
    local n = table.getn(t)
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

--
-- start the timer
-- 
local function init_netmon_monitor()
    if sanity_check() then
        net_timer = ioncore.create_timer()
        net_timer:set(settings.interval, update_netmon_info)
        last[0], last[1] = parse_netmon_info()
        
        if settings.show_avg == 1 then
            for i=0,settings.avg_sec-1 do
                history_in[i], history_out[i] = 0, 0
            end
        end
        
        netmon_template = "xxxxxxxxxxxxxxxxxxxxxxx"
        update_netmon_info()
        dzen_update()
    else
        netmon  = "oops"
        netmon_hint = "critical"
        dzen_update()
    end
end

init_netmon_monitor()

-- bugs/requests/comments: delirium@hackish.org
-- requires that netcat is available in the path

local mpd_defaults={
    -- 500 or less makes seconds increment relatively smoothly while playing
    update_interval=500,
    -- mpd server info (localhost:6600 are mpd defaults)
    address="localhost",
    port=6600,
    -- mpd password (if any)
    password=nil,
    template = wrp2(">>")..wrp("%artist - %title %pos/%len")
}

local success
local last_success

local function saferead(file)
  local data, err, errno
  repeat
    data, err, errno = file:read()
  until errno ~= 4 -- EINTR
  return data, err, errno
end

local function get_mpd_status()
    local cmd_string = "status\ncurrentsong\nclose\n"
    if mpd_defaults.password ~= nil then
        cmd_string = "password " .. mpd_defaults.password .. "\n" .. cmd_string
    end
    cmd_string = string.format('echo -n "%s" | netcat %s %d',
                               cmd_string, mpd_defaults.address, mpd_defaults.port)
    
    last_success = success
    success = false
                               
    local mpd = io.popen(cmd_string, "r")

    -- welcome msg
    local data = saferead(mpd)
    if data == nil or string.sub(data,1,6) ~= "OK MPD" then
    mpd:close()
        return "mpd not running"
    end

    -- 'password' response (if necessary)
    if mpd_defaults.password ~= nil then
        repeat
            data = saferead(mpd)
        until data == nil or string.sub(data,1,2) == "OK" or string.sub(data,1,3) == "ACK"
        if data == nil or string.sub(data,1,2) ~= "OK" then
      mpd:close()
            return "bad mpd password"
        end
    end
    
    local info = {}

    -- 'status' response
    repeat
        data = saferead(mpd)
        if data == nil then break end

        local _,_,attrib,val = string.find(data, "(.-): (.*)")
        if attrib == "time" then
            _,_,info.pos,info.len = string.find(val, "(%d+):(%d+)")
            info.pos = string.format("%d:%02d", math.floor(info.pos / 60), math.mod(info.pos, 60))
            info.len = string.format("%d:%02d", math.floor(info.len / 60), math.mod(info.len, 60))
        elseif attrib == "volume" then
            info.volume = val
        elseif attrib == "state" then
            info.state = val
        end
    until string.sub(data,1,2) == "OK" or string.sub(data,1,3) == "ACK"
    if data == nil or string.sub(data,1,2) ~= "OK" then
    mpd:close()
        return "error querying mpd status"
    end

    -- 'currentsong' response
    repeat
        data = saferead(mpd)
        if data == nil then break end

        local _,_,attrib,val = string.find(data, "(.-): (.*)")
        if     attrib == "Artist" then info.artist = val
        elseif attrib == "Title"  then info.title  = val
        elseif attrib == "Album"  then info.album  = val
        elseif attrib == "Track"  then info.num    = val
        elseif attrib == "Date"   then info.year   = val
        end
    until string.sub(data,1,2) == "OK" or string.sub(data,1,3) == "ACK"
    if data == nil or string.sub(data,1,2) ~= "OK" then
    mpd:close()
        return "error querying current song"
    end

    mpd:close()

    success = true

    -- done querying; now build the string
    if info.state == "play" then
        local mpd_st = mpd_defaults.template
        -- fill in %values
        mpd_st = string.gsub(mpd_st, "%%([%w%_]+)", function (x) return(info[x]  or "") end)
        mpd_st = string.gsub(mpd_st, "%%%%", "%%")
        mpd_st = mpd_st .. wrp("Vol: " .. info.volume.."%")
        return mpd_st
    elseif info.state == "pause" then
        return "Paused"
    else
        return ""
    end
end


local mpd_timer

local function update_mpd()
    -- update unless there's an error that's not yet twice in a row, to allow
    -- for transient errors due to load spikes
    local mpd_st = get_mpd_status()
    mpd_status = mpd_st
    mpd_dzen_update()
    mpd_timer:set(mpd_defaults.update_interval, update_mpd)
end

-- Init
mpd_timer = ioncore.create_timer()
-- mpd_timer:set(mpd_defaults.interval, update_mpd)
update_mpd()
