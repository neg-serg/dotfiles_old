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
            if i == curindex then 
                name_pager=name_pager..tmpws:name() 
            end
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
                dmain.ws = i .. ": " .. ws_map[i]
                ws_numbered = true
                break
            end
        end
        if not ws_numbered then
            dmain.ws = name_pager
        end
        dzen_update()
    end
end

local function setup_hooks()
    local hook
    hook = notioncore.get_hook("screen_managed_changed_hook")
    notioncore.get_hook("region_notify_hook"):add(ws_current)
end

setup_hooks()
