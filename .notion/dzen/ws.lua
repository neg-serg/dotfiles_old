local function get_sym(t)
    return neg.dzen.fancy_table[t]
end

local function get_oct(t)
    return "^fn(octicons:style=Regular)".. neg.dzen.octiconsym[t] .. "^fn(PragmataPro for Powerline:bold)"
end

local function get_pow(t,size)
    if size ~= nil then
        return "^fn(PragmataPro for Powerline:size=".. size .. ":bold)".. neg.dzen.powersym[t] .. "^fn(PragmataPro for Powerline:bold)"
    else
        return neg.dzen.powersym[t]
    end
end

local function get_ion(t)
    return "^fn(Ionicons)".. neg.dzen.ioniconssym[t] .. "^fn(PragmataPro for Powerline:bold)"
end

local function get_typi(t)
    return "^fn( Typicons)".. neg.dzen.typiconssym[t] .. "^fn(PragmataPro for Powerline:bold)"
end

local function get_ico(t)
    local ico_path
    if os.getenv("XDG_CONFIG_HOME") ~= nil then
        ico_path=os.getenv("XDG_CONFIG_HOME").."/dzen/"..t..".xbm"
    else
        ico_path=os.getenv("HOME").."/.config/dzen/"..t..".xbm"
    end
    if io.open(ico_path,"r") ~= nil then
        return "^i(" .. ico_path  .. ")"
    else
        return ""
    end
end

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
            {name="term",       sym=get_sym("monitor")},
            {name="web",        sym=get_sym("web")},
            {name="dev",        sym=get_sym("text")},
            {name="doc",        sym=get_sym("data")},
            {name="media",      sym=get_sym("media")},
            {name="gimp",       sym=get_sym("pic")},
            {name="admin",      sym=get_sym("admin")},
            {name="jetbrains",  sym=get_sym("dev")},
            {name="steam",      sym=get_sym("game")},
            {name="torrent",    sym=get_sym("center")},
            {name="vm",         sym=get_sym("vertical_dots")},
            {name="wine",       sym=get_sym("game")}
        }
        local ws_numbered = false
        for i, v in ipairs(ws_map) do
            if name_pager == ws_map[i].name then
                dmain.ws = i .. ": " .. ws_map[i].sym .. " ".. ws_map[i].name
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
