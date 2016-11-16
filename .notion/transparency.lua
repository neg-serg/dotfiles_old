scratchpad_table = {}
local function find(a, tbl)
    for _,a_ in ipairs(tbl) do if
        a_ == a then return true end
    end
end

local function find_manager(obj, t)
    while obj~=nil do
        if obj_is(obj, t) then
            return obj
        end
        obj=obj:manager()
    end
end

local function framelist(iter)
    iter(function(obj)
        if obj_is(obj, "WFrame") then
            if find(obj, scratchpad_table) then
                table.insert(transparent_table, obj)
                -- table.insert(ultratransparent_table, obj)
            else
                table.insert(ultratransparent_table, obj)
            end
        end
        return true
    end)
    return true
end

local function maketransparent()
    local atom_client_opacity = notioncore.x_intern_atom("_NET_WM_WINDOW_OPACITY", false)
    local opacity_level = 3435973836
    local full_opacity_level = 40000000
    local ultra_opacity_level = 400000000
    local s

    ultratransparent_table = {}
    transparent_table = {}
    nontransparent_table = {}

    notioncore.clientwin_i(function(cwin)
        local winprop = ioncore.getwinprop(cwin)
        if winprop and winprop.scratchpad == "true" then 
            table.insert(scratchpad_table, find_manager(cwin, "WFrame"))
        end
        if cwin:name() ~= "" then
            local reg_ = find_manager(cwin, "WFrame")
            if reg_ then
                table.insert(nontransparent_table, reg_)
            end
        end
        return true
    end)

    framelist(notioncore.region_i)

    for _,reg in ipairs(transparent_table) do
        notioncore.x_change_property(reg:xid(), atom_client_opacity, 6, 32, "replace", {opacity_level})
    end

    for _,reg in ipairs(ultratransparent_table) do
        notioncore.x_change_property(reg:xid(), atom_client_opacity, 6, 32, "replace", {full_opacity_level})
    end

    for _,reg in ipairs(nontransparent_table) do
        notioncore.x_delete_property(reg:xid(), atom_client_opacity)
    end
end

local setup_scratchpads = function()
    local s
    notioncore.clientwin_i(function(cwin)
        local winprop = ioncore.getwinprop(cwin)
        if winprop and winprop.scratchpad == "true" then 
            s = cwin
            return false
        else
            return true
        end
    end)
    if s then
        find_manager(s,"WFrame"):set_grattr("scratchpad", "set")
    end
end


local function hookhandler(reg, how)
    notioncore.defer(function() maketransparent() end)
    notioncore.defer(function() setup_scratchpads() end)
end

notioncore.get_hook("clientwin_mapped_hook"):add(hookhandler)
notioncore.get_hook("clientwin_unmapped_hook"):add(hookhandler)
notioncore.get_hook("region_notify_hook"):add(hookhandler)
