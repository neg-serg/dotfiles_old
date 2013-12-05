-- $Id: exec_on2.lua 3047 2008-03-17 15:30:30Z agriffis $
--
-- Copyright (c) 2008 Aron Griffis <agriffis n01se.net>
-- Released under the GNU GPL v2.1

ioncore.orig_exec_on = ioncore.exec_on

function ioncore.exec_on(reg, cmd, merr_internal)
    if obj_is(reg:manager(), "WTiling") then
        local geom=reg:geom()
        ioncore.orig_exec_on(reg, "env"..
            " ION3_FRAME_WIDTH="..geom.w..
            " ION3_FRAME_HEIGHT="..geom.h..
            " "..cmd, merr_internal)
    else
        ioncore.orig_exec_on(reg, cmd, merr_internal)
    end
end
