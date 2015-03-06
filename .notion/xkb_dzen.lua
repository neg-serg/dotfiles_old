xkbion_set {
    {name="en", action = function() 
        xkb_layout = "en"
        dzen_update()
        mod_xkbevents.lock_group(0)
    end},
    {name="ru", action = function() 
        xkb_layout = "ru"
        dzen_update()
        mod_xkbevents.lock_group(1)
    end},
    key="Caps_Lock",
}


function xkbion_set (groups) -- the only global created by xkbion.lua

    if not groups or type(groups) ~= "table" then error("bad args") end
    if not groups[1] or type(groups[1]) ~= "table" then
        error("default group is undefined")
    end

    -- window_group_prop(w) - get XKBION_GROUP integer property of window `w' (set it to 1 if it's not yet defined)
    -- window_group_prop(w, group) - set XKBION_GROUP property of window `w' to integer `group'
    -- "XKBION_GROUP" is just the default name
    local window_group_prop
    do
        local XA_INTEGER = 19
        local atom = notioncore.x_intern_atom( tostring( groups.atomname or "XKBION_GROUP" ) )
        if not atom or type(atom) ~= "number" then
            error("Cannot intern atom " .. atomname)
        end
        window_group_prop = function(w, gnum)
            if not w or type(w) ~= "userdata" or not w.xid or type(w.xid) ~= "function" then return 1 end
            local xid = tonumber( w:xid() )
            if gnum == nil then
                local t = notioncore.x_get_window_property( xid, atom, XA_INTEGER, 1, true )
                if t and type(t) == "table" and t[1] ~= nil then
                    do return tonumber(t[1]) end
                else
                    gnum = 1
                end
            else
                gnum = tonumber(gnum)
            end
            -- we're here if the second argument is set or if the window does not have our property yet
            notioncore.defer( function()
                notioncore.x_change_property( xid, atom, XA_INTEGER, 32, "replace", {gnum} )
            end )
            return gnum
        end
    end

    local set_group
    do
        local current_gnum = 1
        local first_time = true
        set_group = function(w, do_increment)
            local gnum
            if w then
                gnum = window_group_prop(w)
            else
                gnum = 1
            end
            if do_increment then gnum = gnum + 1 end
            local g = groups[gnum]
            if not g then gnum, g = 1, groups[1] end
            if not g then return end -- error in settings, groups[1] not defined
            if first_time then
                first_time = false
            elseif gnum == current_gnum then
                return
            end
            window_group_prop(w, gnum) -- it's OK to call it even it `w' is nil
            if g.command then
                notioncore.exec(g.command)
            end
            if g.action then notioncore.defer(g.action) end
            current_gnum = gnum
            local group_name = g.name
            xkb_layout = group_name
            dzen_update()
        end
    end

    notioncore.get_hook("region_notify_hook"):add(
        function(reg, action)
            if (reg ~= nil) and (tostring(reg.__typename) == "WClientWin") then
                if (action == "activated") or (action == "pseudoactivated") then
                    set_group(reg)
                end
            end
        end
    )

    local key = groups.key
    if key and type(key) == "string" then
        defbindings("WClientWin", {
            kpress(key, function (_, _sub) set_group(_, true)  end)
        })
    end

    set_group() -- initialize

end -- xkbion_set()
