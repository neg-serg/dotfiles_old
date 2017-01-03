#!/usr/sbin/lua

require("os")

local home_=os.getenv("HOME")
local notion_path_=home_.."/.notion"

dofile(notion_path_.."/style_settings.lua")

local mpd_defaults={
    update_interval=500, -- 500 or less makes seconds increment relatively smoothly while playing
    address="localhost", -- mpd server info (localhost:6600 are mpd defaults)
    port=6600,           -- mpd server default port
    password=nil,        -- mpd password (if any)
    mpd_len = 80,        -- default mpd string length
}

local alter_fn="Iosevka"
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
    local size = ":size=" .. neg.font_size
    local need_in_fallback_ = true
    if need_in_fallback_ then
        if string.match(str, ".*[a-zA-Zа-яА-Я].*") ~= nil then
            mpd_defaults.mpd_len = 80
            return str
        else
            mpd_defaults.mpd_len = 110
            return "^fn("..alter_fn..size..":Bold)"..str.."^fn()"
        end
    else
        return str
    end
end

local function get_mpd_status()
    local cmd_string = "status\n"
                     .. "currentsong\n"
                     .. "close\n"
    if mpd_defaults.password ~= nil then
        cmd_string = "password " 
                   .. mpd_defaults.password
                   .. "\n"
                   .. cmd_string
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
        print(wrp("no mpd", "[","]"))
        return wrp("no mpd", "[","]")
    end

    -- 'password' response (if necessary)
    if mpd_defaults.password ~= nil then
        repeat
            data = saferead(mpd)
        until data == nil or string.sub(data,1,2) == "OK" or string.sub(data,1,3) == "ACK"
        if data == nil or string.sub(data,1,2) ~= "OK" then
            mpd:close()
            print(wrp("bad mpd password", "[","]"))
            return wrp("bad mpd password", "[","]")
        end
    end

    local info = {}
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
        print("error querying mpd status")
        return wrp("error querying mpd status", "[","]")
    end

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
        return wrp("error querying current song", "[","]")
    end

    mpd:close()
    success = true

    -- done querying; now build the string
    if info.state == "play" then
        info_artist = info["artist"] or ""
        info_title = info["title"] or ""
        mpd_st = font_fallback(info_artist .. " - " .. info_title)
        if mpd_st:len() > mpd_defaults.mpd_len then
            mpd_st = string.sub(mpd_st,1, mpd_defaults.mpd_len - 4).. "…"
        end
        mpd_position = (info["pos"] or "") .."/".. (info["len"] or "")
        mpd_st = wrp(">>", "[","]") 
              .. wrp(mpd_st.." "..mpd_position)
              .. wrp("Vol: " .. info.volume.."%")
        print(mpd_st)
        return mpd_st
    elseif info.state == "pause" then
        print(wrp("||","[","]")) return wrp("||","[","]")
    else
        return "Mda"
    end
end

get_mpd_status()
