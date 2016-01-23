local function table_ret(x)
    local tt = {
        ["sym"]=neg.dzen.fancy_table,
        ["oct"]=neg.dzen.octiconsym,
        ["pow"]=neg.dzen.powersym,
        ["ion"]=neg.dzen.ioniconssym,
        ["typi"]=neg.dzen.typiconssym
    }
    return tt[x]
end

local function font_ret(x,size)
    local size_part
    if size ~= nil then
        size_part=":size=".. size
    else 
        size_part=""
    end
    local tt ={
        ["sym"]="^fn(".. neg.font .. size_part .. ":bold)",
        ["oct"]="^fn(" .. "octicons:style=Regular".. size_part .. ")",
        ["ion"]="^fn(" .. "Ionicons:style=Regular".. size_part .. ")",
        ["typi"]="^fn(" .. " Typicons".. size_part .. ")",
        ["pow"]="^fn(".. neg.font .. size_part .. ":bold)",
        ["reset"]="^fn(".. neg.font ..":bold)",
    }
    return tt[x]
end

local function i_getter(x,t,size)
    if size ~= nil then
        return font_ret(x,size) .. table_ret(x)[t] .. font_ret("reset")
    else
        return font_ret(x) .. table_ret(x)[t] .. font_ret("reset")
    end
end

local function i_get(i_size,name)
    local index = i_size.index
    local size = i_size.size
    local tt = {
        ["sym"]=function(index,size) return i_getter("sym",index,size) end,
        ["oct"]=function(index,size) return i_getter("oct",index,size) end,
        ["pow"]=function(index,size) return i_getter("pow",index,size) end,
        ["ion"]=function(index,size) return i_getter("ion",index,size) end,
        ["typi"]=function(index,size) return i_getter("typi",index,size) end,
    }
    if name ~= nil then
        return tt[name](index,size)
    else
        return i_getter("sym",index,size)
    end
end

local ws_map = {
    {name="term",       sym=i_get({index="term2",size=15})},
    {name="web",        sym=i_get({index="web"})},
    {name="dev",        sym=i_get({index="dev3",size=15})},
    {name="doc",        sym=i_get({index="data"})},
    {name="media",      sym=i_get({index="media"})},
    {name="gimp",       sym=i_get({index="pic"})},
    {name="admin",      sym=i_get({index="admin"})},
    {name="jetbrains",  sym=i_get({index="dev"})},
    {name="steam",      sym=i_get({index="game"})},
    {name="torrent",    sym=i_get({index="center"})},
    {name="vm",         sym=i_get({index="vertical_dots"})},
    {name="wine",       sym=i_get({index="game"})}
}

local function get_ico(t)
    local ico_path
    local xdg_conf_home = os.getenv("XDG_CONFIG_HOME")
    if xdg_conf ~= nil then
        ico_path=xdg_conf_home.."/dzen/"..t..".xbm"
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
        local ws_numbered = false
        for i, v in ipairs(ws_map) do
            if name_pager == ws_map[i].name then
                if ws_map[i].sym ~= nil then
                    dmain.ws = i .. ": " .. ws_map[i].sym .. " ".. ws_map[i].name
                else
                    dmain.ws = i .. ": " .. ws_map[i].name
                end
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
