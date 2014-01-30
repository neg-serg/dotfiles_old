--[[
Author: Etan Reisner
Email: deryni@gmail.com
Summary: Toggle (and create) scratchpads by name.
Version: 0.2
Last Updated: 2007-01-23

Copyright (c) Etan Reisner 2007
--]]

-- Usage: This will create a scratchpad named example_sp
--          kpress(MOD4.."space", "named_scratchpad(_, 'example_sp')")

function named_scratchpad(reg, name, mode)
    local named_sp
    local default_w, default_h = 640, 480
    local scr = reg:screen_of()
    local geom_scr = scr:geom()

    local geom_loc = {
        w = math.min(geom_scr.w, default_w),
        h = math.min(geom_scr.h, default_h),
    }
    geom_loc.x = (geom_scr.w - geom_loc.w) / 2
    geom_loc.y = (geom_scr.h - geom_loc.h) / 2

    named_sp = ioncore.lookup_region(name, "WFrame")

    if not named_sp then
        named_sp = scr:attach_new({
                                   type="WFrame",
                                   name=name,
                                   unnumbered=true,
                                   modal=false,
                                    --pseudomodal=true,
                                   hidden=true,
                                   --layer=2, 
                                   sizepolicy="full",
                                   -- sizepolicy="free",
                                   geom=geom_loc,
                                   style="scratchpad",
                                  })
                              end
    if not mode then
        mode = "toggle"
    end
    mod_sp.set_shown(named_sp, mode)
    named_sp:rqorder("front")
    return named_sp
end

--[[
function toggle_scratch_app(reg, cmdline, class)
    if reg:current():name() == class then
        named_scratchpad(reg, class)
    else
        named_scratchpad(reg, class, "set")
        app.byclass(cmdline, class)
        ioncore.lookup_region(class, "WFrame"):rqorder("front")
    end
end
--]]

function named_sp_raiseorhide(reg, name)
    dbg.echo(reg:current():name())
    if reg:current():name() == name then
        named_scratchpad(reg, name, "unset")
    else
        local sp=named_scratchpad(reg, name, "set")
        sp:rqorder("front")
    end
end

-- vim: set expandtab sw=4:
