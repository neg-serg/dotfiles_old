local function framelist(iter)
    transparent_table = {}
    nontransparent_table = {}

    local entries={}
    local ws_add=function(s) if s then table.insert(entries, s) end end

    iter(function(obj)
             if obj_is(obj, "WMPlex") then
                 if obj:mx_count() == 0 then
                    table.insert(transparent_table, obj)
                    ws_add(obj:xid())
                 else
                    table.insert(nontransparent_table, obj)
                 end
             end
             return true
         end)
    return entries
end

local function maketransparent(reg)
    local atom_client_opacity = notioncore.x_intern_atom("_NET_WM_WINDOW_OPACITY", false)
    local opacity_level = 3435973836
    -- local full_opacity_level = 4294967295

    framelist(notioncore.region_i)

    for _,reg in ipairs(transparent_table) do
        notioncore.x_change_property(reg:xid(), atom_client_opacity, 6, 32, "replace", {opacity_level})
    end

    for _,reg in ipairs(nontransparent_table) do
        notioncore.x_delete_property(reg:xid(), atom_client_opacity)
    end
end

local function setup_scratchpad()
    local winprop = notioncore.getwinprop(reg)
    if winprop.scratchpad == true then
        reg:set_grattr("scratchpad", "set")
    end
end

local function hookhandler(reg, how)
    notioncore.defer(function() maketransparent() end)
    notioncore.defer(function() setup_scratchpad() end)
end

notioncore.get_hook("clientwin_mapped_hook"):add(hookhandler)
notioncore.get_hook("clientwin_unmapped_hook"):add(hookhandler)
notioncore.get_hook("region_notify_hook"):add(hookhandler)
