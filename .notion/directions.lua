-- $Id: directions.lua 3444 2009-03-24 02:10:59Z agriffis $
--
-- Copyright (c) 2008 Aron Griffis <agriffis n01se.net>
-- Released under the GNU GPL v2.1
--
--[[ example bindings
defbindings("WFrame.floating", {
    kpress(ALTMETA.."H", "_:push_direction('left')"),
    kpress(ALTMETA.."J", "_:push_direction('down')"),
    kpress(ALTMETA.."K", "_:push_direction('up')"),
    kpress(ALTMETA.."L", "_:push_direction('right')"),
    kpress(ALTMETA.."F", "_:maximize_fill_toggle('vh')"),
    kpress(ALTMETA.."V", "_:maximize_fill_toggle('vert')"),
})
defbindings("WScreen", {
    kpress(META.."H", "_chld:focus_direction('left')", "_chld:non-nil"),
    kpress(META.."J", "_chld:focus_direction('down')", "_chld:non-nil"),
    kpress(META.."K", "_chld:focus_direction('up')", "_chld:non-nil"),
    kpress(META.."L", "_chld:focus_direction('right')", "_chld:non-nil"),
})
--]]

-- debugging function
local function spit(s)
    io.stderr:write(tostring(s).."\n")
end

-- debugging function
local function spittab(t)
    for k,v in pairs(t) do
        io.stderr:write(tostring(k).." = "..tostring(v).."\n")
    end
end

function WRegion.overlap_score(reg1, reg2, dir)
    local r1g = reg1:geom()
    local r2g = reg2:geom()
    local avg, upper, lower, score

    --[[

     ----------+
               |
     lower --> | +--------
               | |
               | |
     ----------+ | <--upper
                 |
                 +--------

    --]]
    
    if dir == 'vert' then
        avg = (r1g.h + r2g.h) / 2
        lower = math.max(r1g.y, r2g.y)
        upper = math.min(r1g.y+r1g.h, r2g.y+r2g.h)
        return (upper - lower) / avg
    end

    if dir == 'horiz' then
        avg = (r1g.w + r2g.w) / 2
        lower = math.max(r1g.x, r2g.x)
        upper = math.min(r1g.x+r1g.w, r2g.x+r2g.w)
        return (upper - lower) / avg
    end

    ioncore.warn_traced("WRegion.overlap_score called with dir = "..dir)
end

function WRegion.overlaps(reg1, reg2, dir)
    return reg1:overlap_score(reg2, dir) > 0
end

-- focus_direction: Send focus to window right/left/down/up
function WRegion.focus_direction(reg, dir)
    -- For now, only handle WGroupWS
    local mgr = reg:manager()
    if not obj_is(mgr, 'WGroupWS') then
        spit("focus_direction: ugh, a middle manager: "..obj_typename(mgr))
        return
    end

    local rg = reg:geom()
    local axis = (dir == 'right' or dir == 'left') and 'horiz' or 'vert'
    local perp = (axis == 'vert') and 'horiz' or 'vert'
    local nr, ng, ns, nd -- region, geometry, overlap score, distance

    mgr:managed_i(function(tr)
        if not obj_is(tr, "WFrame") then
            --spit("focus_direction: skipping "..obj_typename(tr))
            return true
        end

        -- skip if tg doesn't lie in the right direction
        local tg = tr:geom()
        if dir == 'right' and tg.x <= rg.x then return true end
        if dir == 'left'  and tg.x >= rg.x then return true end
        if dir == 'down'  and tg.y <= rg.y then return true end
        if dir == 'up'    and tg.y >= rg.y then return true end

        local ts = tr:overlap_score(reg, perp)
        local td = (axis == 'horiz') and math.abs(tg.x - rg.x) or math.abs(tg.y - rg.y)

        --spit("focus_direction: t = ("..tr:name()..", "..td..", "..ts..")")

        -- use tr if nr isn't set yet
        if not nr then
            nr, ng, ns, nd = tr, tg, ts, td
            return true
        end

        --spit("focus_direction: n = ("..nr:name()..", "..nd..", "..ns..")")

        -- prefer an overlap
        if ns > 0 and ts <= 0 then return true end
        if ts > 0 and ns <= 0 then
            nr, ng, ns, nd = tr, tg, ts, td
            return true
        end

        -- prefer the closer one
        if nd < td then return true end
        if td < nd then 
            nr, ng, ns, nd = tr, tg, ts, td
            return true 
        end

        -- prefer higher overlap score
        if ns > ts then return true end
        if ts > ns then
            nr, ng, ns, nd = tr, tg, ts, td
            return true
        end

        -- keep looking
        return true
    end)

    if nr then
        nr:goto()
    end
end

-- collide: Determine what window or dock a floating window will hit
-- if it moves in a given direction.
local function collide(reg, dir, pad)
    local mgr = reg:manager()
    local rg = reg:geom()
    local cr, cg
    if not pad then
        pad = ioncore.get().float_placement_padding or 1 -- old hardcoded value
    end

    mgr:managed_i(function(tr)
        if not (obj_is(tr, "WFrame") or obj_is(tr, "WDock")) then
            --spit("push_direction: skipping "..obj_typename(tr))
            return true
        end
        local tg = tr:geom()
        if dir == 'right' then
            if tg.x <= rg.x+rg.w+pad or
                (not tr:overlaps(reg, 'vert')) or
                (cg and cg.x <= tg.x) then return true end
        end
        if dir == 'left' then
            if tg.x+tg.w+pad >= rg.x or
                (not tr:overlaps(reg, 'vert')) or
                (cg and cg.x+cg.w >= tg.x+tg.w) then return true end
        end
        if dir == 'down' then
            if tg.y <= rg.y+rg.h+pad or
                (not tr:overlaps(reg, 'horiz')) or
                (cg and cg.y <= tg.y) then return true end
        end
        if dir == 'up' then
            if tg.y+tg.h+pad >= rg.y or
                (not tr:overlaps(reg, 'horiz')) or
                (cg and cg.y+cg.h >= tg.y+tg.h) then return true end
        end
        cr, cg = tr, tg
        return true
    end)

    return cg
end

-- push_direction: Move a floating window right/left/down/up until it bumps
-- into another floating window or a dock.
function WRegion.push_direction(reg, dir)
    local pad = ioncore.get().float_placement_padding or 1 -- old hardcoded value
    local mgr = reg:manager()
    local mg = mgr:geom()
    local rg = reg:geom()
    local cg = collide(reg, dir)
    local ng = {}

    if dir == 'right' then
        ng.x = cg and cg.x-rg.w-pad or mg.w-rg.w
    elseif dir == 'left' then
        ng.x = cg and cg.x+cg.w+pad or 0
    elseif dir == 'down' then
        ng.y = cg and cg.y-rg.h-pad or mg.h-rg.h
    elseif dir == 'up' then
        ng.y = cg and cg.y+cg.h+pad or 0
    end

    reg:rqgeom(ng)
    reg:goto()  -- XXX sometimes we lose focus...?
end

local XA_INTEGER = 19

-- set_geom_prop: Store old/new geometry of the window into its X properties
-- ox, oy, ow, oh, nx, ny, nw, nh
local function set_geom_prop(reg, sg)
    local atom = ioncore.x_intern_atom("_ION_SAVED_GEOM", false)
    local g = {
        sg.ox or -1,
        sg.oy or -1,
        sg.ow or -1,
        sg.oh or -1,
        sg.nx or -1,
        sg.ny or -1,
        sg.nw or -1,
        sg.nh or -1,
    }
    return ioncore.x_change_property(reg:xid(), atom, XA_INTEGER, 32, "replace", g)
end

-- get_geom_prop: Restore the geometry of the window from X properties
local function get_geom_prop(reg)
    local atom = ioncore.x_intern_atom("_ION_SAVED_GEOM", true)
    if atom then
        local g = ioncore.x_get_window_property(reg:xid(), atom, XA_INTEGER, 0, true)
        if g then
            local sg = {
                ox = g[1] ~= -1 and g[1] or nil,
                oy = g[2] ~= -1 and g[2] or nil,
                ow = g[3] ~= -1 and g[3] or nil,
                oh = g[4] ~= -1 and g[4] or nil,
                nx = g[5] ~= -1 and g[5] or nil,
                ny = g[6] ~= -1 and g[6] or nil,
                nw = g[7] ~= -1 and g[7] or nil,
                nh = g[8] ~= -1 and g[8] or nil,
            }
            ioncore.x_delete_property(reg:xid(), atom)
            return sg
        end
    end
    return nil
end

-- maximize_fill: Grow a floating window right/left/down/up until it bumps into
-- another floating window or a dock.
function WRegion.maximize_fill(reg, dir)
    if dir == 'vert' then
        reg:maximize_fill('up')
        reg:maximize_fill('down')
    elseif dir == 'horiz' then
        reg:maximize_fill('left')
        reg:maximize_fill('right')
    elseif dir == 'vh' then
        reg:maximize_fill('vert')
        reg:maximize_fill('horiz')
    elseif dir == 'hv' then
        reg:maximize_fill('vert')
        reg:maximize_fill('horiz')
    else
        local pad = ioncore.get().float_placement_padding or 1 -- hardcoded val
        local mgr = reg:manager()
        local mg = mgr:geom()
        local rg = reg:geom()
        local cg = collide(reg, dir, pad-1)
        local ng = {}

        if dir == 'up' then
            ng.y = cg and cg.y+cg.h+pad or 0
            ng.h = rg.h + rg.y - ng.y
        elseif dir == 'down' then
            ng.h = cg and cg.y-rg.y-pad or mg.h-rg.y
        elseif dir == 'left' then
            ng.x = cg and cg.x+cg.w+pad or 0
            ng.w = rg.w + rg.x - ng.x
        elseif dir == 'right' then
            ng.w = cg and cg.x-rg.x-pad or mg.w-rg.x
        end

        reg:rqgeom(ng)
    end
    reg:goto()  -- XXX sometimes we lose focus...?
end

function WRegion.maximize_fill_toggle(reg, dir)
    local sg = get_geom_prop(reg) or {}
    local rg = reg:geom()
    local h = (dir == 'vh' or dir == 'hv' or dir == 'horiz' or dir == 'left' or dir == 'right')
    local v = (dir == 'vh' or dir == 'hv' or dir == 'vert' or dir == 'up' or dir == 'down')

    if (h and sg.ow) or (v and sg.oh) then
        local ng = {}
        if h and sg.ow then
            ng.w = sg.ow
            if rg.x == sg.nx then
                ng.x = sg.ox -- restore x only if not moved
            end
            sg.ox = nil
            sg.ow = nil
        end
        if v and sg.oh then
            ng.h = sg.oh
            if rg.y == sg.ny then
                ng.y = sg.oy -- restore y only if not moved
            end
            sg.oy = nil
            sg.oh = nil
        end
        reg:rqgeom(ng)
        set_geom_prop(reg, sg)
        return
    end

    if h then
        sg.ox = rg.x
        sg.ow = rg.w
    end
    if v then
        sg.oy = rg.y
        sg.oh = rg.h
    end

    reg:maximize_fill(dir)

    rg = reg:geom()
    if v then
        sg.ny = rg.y
        sg.nh = rg.h
    end
    if h then
        sg.nx = rg.x
        sg.nw = rg.w
    end
    set_geom_prop(reg, sg)
end
