function named_scratchpad(reg, name, mode)
    local named_sp
    local default_w, default_h = 720, 480
    local scr = reg:screen_of()
    local geom_scr = scr:geom()

    local geom_loc = {
        w = math.min(geom_scr.w, default_w),
        h = math.min(geom_scr.h, default_h),
    }
    geom_loc.x = (geom_scr.w - geom_loc.w) / 2
    geom_loc.y = (geom_scr.h - geom_loc.h) / 2

    named_sp = notioncore.lookup_region(name, "WFrame")

    if not named_sp then
        named_sp = scr:attach_new({
                                   type="WFrame",
                                   name=name,
                                   unnumbered=true,
                                   modal=false,
                                   hidden=true,
                                   sizepolicy="free",
                                   geom=geom_loc,
                                   style="scratchpad",
                                  })
                              end
    if not mode then
        mode = "toggle"
    end
    WMPlex.set_hidden(named_sp:parent(), named_sp, mode)
    named_sp:rqorder("front")
    named_sp:set_grattr("scratchpad", "set")
    return named_sp
end

function named_sp_raiseorhide(reg, name)
    if reg:current():name() == name then
        named_scratchpad(reg, name, "unset")
    else
        local sp=named_scratchpad(reg, name, "set")
        sp:rqorder("front")
    end
end
