function show_only_necessary_tabs_in_frame(fp)
    if WFrame.mode(fp) == 'floating' then
	-- Escape: floatws thing should not be handled
        return
    end

    -- First the logic, then the propagation back to ion

    -- It should *not* be shown if there is only one app
    -- However, this (single) app should not be tagged,
    -- because then we would want to show it.

    -- Assume the tabbar should be shown.
    local show_bar = true
    -- if WMPlex.mx_count(fp) != 1 then
    local rg = fp:mx_nth(0)
    if rg == nil then show_bar = false
    else
        if not rg:is_tagged() then
            show_bar = false
        end
    end
    -- end

    -- Propagate choice
    notioncore.defer(function()
        -- don't touch transient frames
        if fp:mode() ~= "transient" then
	    if show_bar then
                fp:set_mode("tiled")
            else
                fp:set_mode("tiled-alt")
            end
        end	
     end)
end

function show_only_necessary_tabs_in_frame_wrapper(ftable)
    show_only_necessary_tabs_in_frame(ftable.reg)
end

function min_tabs_setup_hook()
    local hk=notioncore.get_hook("frame_managed_changed_hook")
    hk:add(show_only_necessary_tabs_in_frame_wrapper)
end

function min_tabs_tag_wrapper(fr,reg)
    -- Note the ugly code: this actually caters for two versions of ion3
    -- I am only including this because I like Ubuntu [CC]
    local oldversion = (reg["toggle_tag"] ~= nil)
    if oldversion then
        reg:toggle_tag() -- old version (for Ubuntu, can be removed later on)
    else
        reg:set_tagged("toggle") -- new version
    end
    -- recompute tabbar state
    show_only_necessary_tabs_in_frame(fr)
end
min_tabs_setup_hook()
