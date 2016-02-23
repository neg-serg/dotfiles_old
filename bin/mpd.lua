#!/usr/sbin/lua

dofile("/home/neg/.notion/dzen_helpers.lua")
require("os")

local mpd_defaults={
    update_interval=500, -- 500 or less makes seconds increment relatively smoothly while playing
    address="localhost", -- mpd server info (localhost:6600 are mpd defaults)
    port=6600,           -- mpd server default port
    password=nil,        -- mpd password (if any)
}

local mpd_len = 80
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

local function font_fallback(str)
    local size = ":size=12"
    if string.match(str, ".*[а-я][А-Я]*") == nil then
        mpd_len = 80
        return str
    else
        mpd_len = 110
        return "^fn(Iosevka" .. size .. ":bold)" .. str .. "^fn()"
    end
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
        return "[ no mpd ]"
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
        info_artist = info["artist"] or ""
        info_title = info["title"] or ""
        mpd_st = font_fallback(info_artist .. " - " .. info_title)
        if mpd_st:len() > mpd_len then
            mpd_st = string.sub(mpd_st,1,mpd_len - 4)
            mpd_st = mpd_st .. "..."
        end
        mpd_position = (info["pos"] or "") .."/".. (info["len"] or "")
        mpd_st = wrp(">>", "[","]") .. wrp(mpd_st.." "..mpd_position)
        mpd_st = mpd_st .. wrp("Vol: " .. info.volume.."%")
        print(mpd_st)
        return mpd_st
    elseif info.state == "pause" then
        print(wrp("||","[","]")) return wrp("||")
    else
        print " " return " "
    end
end

get_mpd_status()
