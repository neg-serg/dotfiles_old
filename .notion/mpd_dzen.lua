#!/usr/bin/env lua
require('math')
require("os")

dofile("/home/neg/.notion/dzen_helpers.lua")

function mpd_dzen_update()
    local template = ""
    if mpd_status then
        template = template..mpd_status
    end
    mpd_pipe:write(template..'\n')
end

mpd_pipe = io.popen("dzen2 -dock -bg '#000000' -h 19 -tw 0  -x 0 -ta r -w 910 -p -fn 'PragmataPro for Powerline:style=bold:size=12' ", "w")
mpd_pipe:setvbuf("line")

local mpd_defaults={
    -- 500 or less makes seconds increment relatively smoothly while playing
    update_interval=500,
    -- mpd server info (localhost:6600 are mpd defaults)
    address="localhost",
    port=6600,
    -- mpd password (if any)
    password=nil,
    template = wrp(">>", "[","]") .. wrp("%artist - %title %pos/%len")
}
-- bugs/requests/comments: delirium@hackish.org
-- requires that netcat is available in the path

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
            info.pos = string.format("%d:%02d", math.floor(info.pos / 60), math.fmod(info.pos, 60))
            info.len = string.format("%d:%02d", math.floor(info.len / 60), math.fmod(info.len, 60))
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

timer = function (time)
    local init = os.time()
    local diff=os.difftime(os.time(),init)
    while true do
        coroutine.yield(diff)
        diff=os.difftime(os.time(),init)
    end
end

co=coroutine.create(timer)
    local socket=require('socket')
    coroutine.resume(co) -- timer starts here!
    while coroutine.status(co)~="dead" do
        coroutine.resume(co)
        local mpd_st = get_mpd_status()
        mpd_status = mpd_st
        mpd_dzen_update()
        socket.sleep(0.5)
end
