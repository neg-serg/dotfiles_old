function current_interface()
    local host="google.com"
    local default_net_="enp7s0"

    local pipe_host_ip = io.popen("getent ahosts "..host.." | head -1 | awk '{print $1}'","r")
    local active_net_interface= io.popen("ip link show up | awk -F \":\" '/state UP/ {print $2}'")
    local host_ip = pipe_host_ip:read("*l")
    pipe_host_ip:close()

    if host_ip ~= nil and host_ip ~= "" then
        local pipe_host_dev = io.popen("ip route get "..host_ip.." | grep -Po '(?<=(dev )).*(?= src)'|tr -d '[:space:]'")
        local host_dev = pipe_host_dev:read("*l")
        pipe_host_dev:close()
    end

    if host_dev ~= "" and host_dev ~= nil then
        return host_dev
    else
        return default_net_
    end
end

local net_conf = {
    device = current_interface(),
    show_avg = 0,       -- show average stat?
    avg_sec = 30,       -- default, shows average of 1 minute
    interval = 1*1000,  -- update every second
}

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
    if not string.find(s, net_conf.device) then
        return false        -- the device does not exist
    end

    return true
end

local function calc_avg(lin, lout)
    if counter == net_conf.avg_sec then
        counter = 0
    end

    total_in = total_in - history_in[counter] + lin
    history_in[counter] = lin

    total_out = total_out - history_out[counter] + lout
    history_out[counter] = lout

    counter = counter + 1

    return total_in/net_conf.avg_sec, total_out/net_conf.avg_sec
end

local function parse_netmon_info()
    local s
    local lin, lout

    for s in io.lines('/proc/net/dev') do
        local f = string.find(s, net_conf.device)
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

    if net_conf.show_avg == 1 then
        local avgin, avgout = calc_avg(lin/1024, lout/1024)
        output = output .. string.format(" (%.1fK/%.1fK)", avgin, avgout)
        netmon_avgin = fmt(avgin)
        netmon_avgout = fmt(avgout)
        dzen_update()
    end

    netmon_kbsin = fmt(kbsin)
    netmon_kbsout  = fmt(kbsout)
    dmain.net = output
    dzen_update()

    net_timer:set(net_conf.interval, update_netmon_info)
end

local function init_netmon_monitor()
    if sanity_check() then
        net_timer = notioncore.create_timer()
        net_timer:set(net_conf.interval, update_netmon_info)
        last[0], last[1] = parse_netmon_info()

        if net_conf.show_avg == 1 then
            for i=0,net_conf.avg_sec-1 do
                history_in[i], history_out[i] = 0, 0
            end
        end
        update_netmon_info()
        dzen_update()
    else
        dmain.net  = "oops"
        dzen_update()
    end
end

init_netmon_monitor()
