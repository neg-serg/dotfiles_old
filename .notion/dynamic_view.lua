dynamic_view = {}
dynamic_view.cache = {}

function dynamic_view.toggle (active_ws, target_ws_name, direction)
    local target_ws = notioncore.lookup_region(target_ws_name, 'WGroupWS')
    if not target_ws then return end
    local target_frame = target_ws:current():current()
    local key = active_ws:name()
    if not dynamic_view.cache[key] then dynamic_view.cache[key] = {} end
    local grabbed = dynamic_view.cache[key]
    
    if not grabbed[target_ws_name] then
        if target_frame:mx_count() == 0 then return end
        local temp_frame = active_ws:split_at(active_ws:current(), direction, false)
        dynamic_view.move_clients(target_frame, temp_frame)
        grabbed[target_ws_name] = temp_frame
    else
        temp_frame = grabbed[target_ws_name]
        dynamic_view.move_clients(temp_frame, target_frame)
        active_ws:unsplit_at(active_ws:current())
        grabbed[target_ws_name] = nil
    end
end

function dynamic_view.move_clients (from_frame, to_frame)
    from_frame:mx_i(function (cwin)
        notioncore.defer(function ()
            to_frame:attach(cwin)
        end)
        return true
    end)
end

defbindings("WTiling", {
   kpress("Mod4+i", "dynamic_view.toggle(_, 'term',  'left')"),
})
