-- Workspace params
_marker = "^fg(#ff0000)"
_markerend = "^fg()"
all_marker = " - "
ws_template = nil
sys_template = nil
vol_template = nil
date = nil

local function dzen_update()
    local template = ""
    if ws_template then
            template = template..ws_template
    end
    if vol_template then
        template = template.."^pa(732;)^bg(#000000)^ba(16, _RIGHT)"..vol_template.."^bg()^ba()"
    end
    -- if sys_template then
    --     template = template.."^pa(868;)^i(/home/bva/.notion/icons/battery_full_outline.xbm)".."^pa(884;)^bg(#000000)^ba(80, _RIGHT)"..sys_template.."^ba()^bg()"
    -- end
    if date then
        template = template.."^pa(964;)^bg(#000000)^ba(216, _RIGHT)"..date.."^ba()^bg()"
    end

--    print(template)
--    io.flush()
    dzen_pipe:write(template..'\n')
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
            reg:goto()
        end
    end
end

local function prepare_ws_template(t)
    local reg, activity_reg = t["reg"], {}

    if not obj_is(reg, "WScreen") then
        return
    end

    local ws_names_all, wsname_pre, wsname_post = nil, "", ""

    local function find_all_activity(reg)
        local act_is_set, reg2 = "", nil
        reg2 = ioncore.find_manager(reg, "WGroupWS")
        if (obj_is(reg2, "WGroupWS"))
            then
                activity_reg[reg2:name()] = true
            end
        return true
    end
    ioncore.activity_i(find_all_activity)

    local function inform(screen)
        if screen:mx_count() == 0 then
            return
        end

        local ws_names, before, id = nil, true, screen:id()

        local function compose_ws_names(ws)
            local marker, markerend, current = "", "", false
            local wsn = ws:name() or "?"

            if ws == screen:mx_current() then
                marker = _marker
                markerend = _markerend
                before = false
                current = true
            else
                marker = "^ca(1, echo "..wsn..")"
                markerend = "^ca()"
                if (activity_reg[wsn]) then
                    marker = "^fg(#00ff00)"..marker
                    markerend = markerend.."^fg()"
                end
            end

            if not ws_names then
                ws_names = marker..wsn..markerend
            else
                ws_names = ws_names.." "..marker..wsn..markerend
            end

            if before and not current then
                if wsname_pre == "" then
                    wsname_pre = wsn
                else
                    wsname_pre = wsname_pre.." "..wsn
                end
            elseif not current then
                if wsname_post == "" then
                    wsname_post = wsn
                else
                    wsname_post = wsname_post.." "..wsn
                end
            end

            return true
        end

        screen:mx_i(compose_ws_names)

        if not ws_names_all then
            ws_names_all = ws_names
        else
            ws_names_all = ws_names_all..all_marker..ws_names
        end
    end

    ioncore.region_i(inform, "WScreen")

    ws_template = ws_names_all
    dzen_update()
end

local function prepare_query(reg, activity)
    local t = {}
    if (activity == "activity") then
        t.reg = reg:screen_of()
        prepare_ws_template(t)
    end
end

local function setup_hooks()
    local hook

    hook = ioncore.get_hook("screen_managed_changed_hook")
    if hook then
        hook:add(prepare_ws_template)
    end
    ioncore.get_hook("region_notify_hook"):add(prepare_query)
end

-- Init
setup_hooks()

local function date_update()
    date = os.date("%A, %d %b %H:%M")
    dzen_update()
    date_timer:set((60-os.date("%S"))*1000, date_update)
end

local function vol_update()
    local ci = "amixer -c0 sset PCM 1dB+ > /dev/null"
    local cd = "amixer -c0 sset PCM 1dB- > /dev/null"
    local masterval, pcmval, capval = nil, nil, nil
    local f = nil
    local bar = ""
    local template = ""

    f = io.popen("amixer -c0 get Master", "r")
    masterval, masterstate = f:read("*a"):match("Mono\: Playback %d+ %[(%d+.)%] %[.+%] %[(%w+)%]")
    f:close()
    f = io.popen("amixer -c0 get PCM", "r")
    pcmval = f:read("*a"):match("Front Left\: Playback %d+ .(%d+.)")
    f:close()
    f = io.popen("amixer -c0 get 'Internal Mic'", "r")
    capval, capstate = f:read("*a"):match("Front Left\: Capture %d+ %[(%d+.)%] %[.+%] %[(%w+)%]")
    f:close()

    if masterstate == "off" then
        template = template.."^fg(#ff0000)"
        template = template.."^i(/home/bva/.notion/icons/vol-7.xbm)"
        template = template.."^fg()"
        template = template..masterval
    else
        template = template.."^i(/home/bva/.notion/icons/vol-7.xbm)"
        template = template..masterval
    end
    template = "^ca(1, amixer -q -c0 set Master toggle)^ca(4, amixer -q -c0 sset Master 1dB+)^ca(5, amixer -q -c0 sset Master 1dB-)"..template.."^ca()^ca()^ca()"

    template = template.."^ca(4, amixer -q -c0 sset PCM 1dB+)^ca(5, amixer -q -c0 sset PCM 1dB-)"..pcmval.."^ca()^ca()"

    if capstate == "off" then
        template = template.."^ca(1, amixer -q -c0 set 'Internal Mic' toggle)^ca(4, amixer -q -c0 sset 'Internal Mic' 1dB+)^ca(5, amixer -q -c0 sset 'Internal Mic' 1dB-)"
        template = template.."^fg(#ff0000)"
        template = template.."^i(/home/bva/.notion/icons/microphone.xbm)"
        template = template.."^fg()"
        template = template..capval.."^ca()^ca()^ca()"
    else
        template = template.."^ca(1, amixer -q -c0 set 'Internal Mic' toggle)^ca(4, amixer -q -c0 sset 'Internal Mic' 1dB+)^ca(5, amixer -q -c0 sset 'Internal Mic' 1dB-)^i(/home/bva/.notion/icons/microphone.xbm)"
        template = template..capval.."^ca()^ca()^ca()"
    end

--    f = io.popen("echo "..masterval.." | gdbar -h 4 -w 50 -min 0 -max 74 -nonl", "r")
--    bar = f:read("*l")
--    f:close()
--    f = io.popen("echo "..pcmval.." | gdbar -h 4 -w 50 -min 0 -max 255 -nonl", "r")
--    bar = "^p(-20;+5)"..f:read("*l")
--    f:close()
--    template = template..bar

--    print(masterval)
--    io.flush()
    vol_template = template
    dzen_update()
    vol_timer:set(1000, vol_update)
end

local function system_update()
    -- brp = io.open("/sys/devices/platform/smapi/BAT0/remaining_percent", "r"):read()
    -- brt = io.open("/sys/devices/platform/smapi/BAT0/remaining_running_time", "r"):read()
    -- if (brt == "not_discharging") then
    --         brt = io.open("/sys/devices/platform/smapi/BAT0/remaining_charging_time", "r"):read()
    --         if (brt == "not_charging") then
    --             brt = 0
    --         end
    -- end
    -- sys_template = brp.."%["..((brt-brt%60)/60)..":"..(brt%60).."]"
    dzen_update()
    sys_timer:set(60*1000, system_update)
end

date_timer = ioncore.create_timer()
date_timer:set(1000, date_update)
vol_timer = ioncore.create_timer()
vol_timer:set(1000, vol_update)
sys_timer = ioncore.create_timer()
sys_timer:set(1000, system_update)
--dzen_input_timer = ioncore.create_timer()
--dzen_input_timer:set(100, dzen_input)
