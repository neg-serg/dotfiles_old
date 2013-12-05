-- $Id: ewmh_pager.lua 3536 2009-05-16 15:15:52Z agriffis $
--
-- Copyright 2009 Aron Griffis <agriffis n01se.net>
-- Released under the GNU GPL v2.1
--

local XA_CARDINAL = 6
local XA_INTEGER = 19

local num_atom = ioncore.x_intern_atom("_NET_NUMBER_OF_DESKTOPS", false)
local idx_atom = ioncore.x_intern_atom("_NET_CURRENT_DESKTOP", false)

local pager_timer = ioncore.create_timer()
local need_pager_update = true

local function update_pager()
    if need_pager_update then
        need_pager_update = false
        local scr = ioncore.find_screen_id(0)
        local num = scr:mx_count()
        local cur = scr:mx_current()
        local idx = scr:get_index(cur)
        local rootwin = scr -- reg:rootwin_of()
        ioncore.x_change_property(rootwin:xid(), num_atom, XA_CARDINAL, 32, "replace", {num})
        ioncore.x_change_property(rootwin:xid(), idx_atom, XA_CARDINAL, 32, "replace", {idx})
    end
    pager_timer:set(250, update_pager)
end

pager_timer:set(250, update_pager)

local function async_update_pager(reg, s)
    need_pager_update = true
    function update_pager()
end

ioncore.get_hook("region_notify_hook"):add(async_update_pager)
