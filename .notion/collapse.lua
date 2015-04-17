collapse={}

function collapse.take_frame_to_here(region, current)
    if region ~= current then
        region:managed_i(
            function (cwin)
                ioncore.defer(
                    function ()
                        current:attach(cwin)
                    end)
                return true
            end)
        ioncore.defer(
            function ()
                region:rqclose()
            end)
    end
    return true                  
end

function collapse.collapse(ws)
    local current = ws:current()
    ws:managed_i(
        function (region)
            return collapse.take_frame_to_here(region, current)
        end)
   current:goto_focus()
end

function multiple_split(ws, frame)
    local active_cwin = frame:current()
    ws:split_at(frame, 'left', true)
    
    local i = 0
    local count = frame:mx_count()
    frame:managed_i(
        function(cwin)
            i = i + 1
            if i == count then return false end
            if cwin ~= active_cwin then
                ioncore.defer(
                    function()
                        ws:split_at(frame, 'top', true)
                    end)
            end
            return true
        end)
    
    ioncore.defer(
        function()
            active_cwin:parent():goto_focus()
        end)
    return true
end


defbindings("WTiling", {
    kpress("Mod4+Control+D", "collapse.collapse(_)"),
})
defbindings("WTiling", {
    -- vertical layout
--  kpress("Mod4+Control+i" , "multiple_split(_, _sub, 'top')"),
    -- horizontal layout
    kpress("Mod4+Control+o" , "multiple_split(_, _sub, 'left')"),
})
