scratchpad_ = {}

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

local function maketransparent()
    local atom_client_opacity = core.x_intern_atom("_NET_WM_WINDOW_OPACITY", false)
    local std_opacity         = 3435973836
    local full_opacity        = 4000000
    local ultra_std_opacity   = 400000000
    local s

    local ultratransparent_ = {}
    local transparent_ = {}
    local nontransparent_ = {}

    core.clientwin_i(function(cwin)
        local winprop = ioncore.getwinprop(cwin)
        if winprop and winprop.scratchpad == "true" then 
            table.insert(scratchpad_, find_manager(cwin, "WFrame"))
        end
        if cwin:name() ~= "" then
            local reg_ = find_manager(cwin, "WFrame")
            if reg_ then
                table.insert(nontransparent_, reg_)
            end
        end
        return true
    end)

    local function framelist(iter)
        iter(function(obj)
            if obj_is(obj, "WFrame") then
                if find(obj, scratchpad_) or
                    find(obj:name(), scratchpad_list) 
                   then
                    table.insert(transparent_, obj)
                else
                    local group = find_manager(obj,"WTiling")
                    if group then
                        local split__ =  WTiling.split_tree(group)
                        local mt
                        local tname
                        local o
                        local ret__

                        if split__ then
                            if type(split__) == 'userdata' then
                                mt = getmetatable(split__)
                                o = '['
                                if mt and mt.__index then
                                    tname = mt.__index.__typename
                                    if tname then
                                        o = o .. tname
                                    end
                                    if tdir then
                                        o = o .. tdir
                                    end
                                end
                                ret__ = o .. ']'
                            end
                            
                            if ret__ == "[WSplitSplit]" then
                                table.insert(ultratransparent_, obj)
                            -- elseif ret__ == "[WSplitRegion]" then
                            --     table.insert(nontransparent_, obj)
                            --     -- table.insert(ultratransparent_, obj)
                            end
                        end
                        ----------------------------------------------------------
                        -- local lol__=false
                        -- if split__.br ~= nil then
                        --     if split__.br().br ~= nil or split__.br().lr then
                        --         table.insert(transparent_, obj)
                        --         lol__=true
                        --     end
                        -- end
                        -- if split__.lr ~= nil then
                        --     if split__.lr().lr ~= nil or split__.lr().br then
                        --         table.insert(transparent_, obj)
                        --         lol__=true
                        --     end
                        -- end
                        -- if lol__ == false then
                        table.insert(ultratransparent_, obj)
                        -- end
                    end
                end
            end
            return true
        end)
        return true
    end
    framelist(core.region_i)

    for _,reg in ipairs(transparent_) do
        core.x_change_property(reg:xid(), atom_client_opacity, 6, 32, "replace", {std_opacity})
    end

    for _,reg in ipairs(ultratransparent_) do
        core.x_change_property(reg:xid(), atom_client_opacity, 6, 32, "replace", {full_opacity})
    end

    for _,reg in ipairs(nontransparent_) do
        core.x_delete_property(reg:xid(), atom_client_opacity)
    end
end

local setup_scratchpads = function()
    local s
    core.clientwin_i(function(cwin)
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


local function transparency_handler(reg, how)
    core.defer(function() maketransparent() end)
end

local function scratchpads_handler(reg, how)
    core.defer(function() setup_scratchpads() end)
    scratchpad_ = {}
end

core.get_hook("clientwin_mapped_hook"):add(transparency_handler)
core.get_hook("clientwin_unmapped_hook"):add(transparency_handler)
core.get_hook("region_notify_hook"):add(transparency_handler)

core.get_hook("clientwin_mapped_hook"):add(scratchpads_handler)
