-- IMPORTANT: see prioritise_on_focus.lua for the new version of this.
--
-- Lua script for Ion to boost/lower the scheduling priority of an X11 client process when it gains/loses focus.
-- CME 2009-02-12
-- Yay, it works!
-- Two major limitations: (1) it requires superuser privileges to shift process niceness around willy-nilly (ionice is OK, however), and (2) it only affects the process that implements the actual X client, e.g. a terminal process running inside an xterm won't get any boost, only the xterm (actually, this might be OK: the terminal is interactive -> should be responsive; the attached process is probably less so).  And, similarly, programs that run as multiple processes (e.g. firefox, vmware) will only have the process attached to the X window boosted/cut.  (I wonder what the various firefox-bin process actually do...)

-- TODO: ensure the screensaver doens't get a boost!
-- TODO: check out Linux capabilities, e.g. CAP_SYS_NICE (man capabilities); it might be possible to 
-- TODO: have the active window/process/whatever name appear in the statusbar (see e.g. Emanuele Giaquinta's statusbar_fname.lua)
-- TODO: store the activated process's niceness and restore it again on deactivation.


-- Once tested, pop this in cfg_user.lua:
-- dopath("change_priority_on_activation_change")


-- Returns the Unix/system process ID of a window owner.
-- Note API change: it's not ioncore.x_internal_atom() any more!
local pid_prop_atom = ioncore.x_intern_atom("_NET_WM_PID", false)	-- This can't just be nested within the x_get_window_property call, for reasons.
local function get_process_id_of_window(w)
	-- Ah, the [1] is a table reference!
	return ioncore.x_get_window_property(w:xid(), pid_prop_atom, 0, 0, true)[1]
end


-- Hook for changing the process priority:
local function change_priority_on_activation_change(region, event)
--	print()
--	print("change_priority_on_activation_change()")
--	print(tostring(region.__typename))
--	print(event)
	if (tostring(region.__typename) ~= "WClientWin") then return end
	if (region == nil) then return end

--    if t.tfor then return false end -- ignore transients with this PID
--	local pid = tostring(get_process_id_of_window(region))
	-- Weeeeeird...I'm getting an off-by-one error on SOME process IDs...
	-- Also, sometimes this gives a nil reference error (e.g. on startup).  TODO: fix. ;)
	if (region:xid() == nil) then print("region:xid() was nil!") return end
	if (ioncore.x_get_window_property(region:xid(), pid_prop_atom, 0, 0, true) == nil) then print("window property was nil!") return end
	local pid = ioncore.x_get_window_property(region:xid(), pid_prop_atom, 0, 0, true)[1]
	if (pid == nil) then print("pid was nil!") return end
--	print("got focus: PID " .. pid)
	-- TODO: Should maybe check the sanity of pid before trying to change any priorities...
	if (event == "activated") or (event == "pseudoactivated") then
		-- Give the foreground (active, in-focus) window's process a boost:
	--	print("boosting PID " .. pid)
		os.execute("/usr/bin/sudo /usr/bin/renice -1 -p " .. pid)	-- Ah, you may have to be superuser to make a process less nice...
		os.execute("/usr/bin/ionice -c 2 -n 0 -p " .. pid)	--	print ("activated")
	elseif (event == "inactivated") or (event == "pseudoinactivated") then
		-- Lower the priority of a window's process when it loses focus:
	--	print("lowering PID " .. pid)
		os.execute("/usr/bin/renice +19 -p " .. pid)
		os.execute("/usr/bin/ionice -c 2 -n 7 -p " .. pid)
	end

--	return pid

end


-- OK, how to attach the function (event-handler) to the event?
ioncore.get_hook("region_notify_hook"):remove(change_priority_on_activation_change)
print(ioncore.get_hook("region_notify_hook"):listed(change_priority_on_activation_change))

hook = ioncore.get_hook("region_notify_hook")
if hook then
    hook:add(change_priority_on_activation_change)
	print("change_priority_on_activation_change() hooked OK")
end
--OR
--ioncore.get_hook("region_notify_hook"):add(change_priority_on_activation_change)

print(ioncore.get_hook("region_notify_hook"):listed(change_priority_on_activation_change))


--ioncore.get_hook("region_notify_hook"):remove(change_priority_on_activation_change)
print(ioncore.get_hook("region_notify_hook"):listed(change_priority_on_activation_change))


-- A test!
--ioncore.get_hook("clientwin_do_manage_alt"):add(function() print("clientwin_do_manage_alt hook called.") end)
--ioncore.get_hook("ioncore_sigchld_hook"):add(function(pid) print("ioncore_sigchld_hook hook called.") print(pid) end)

-- Hmm, I think print() doesn't actually produce output in certain contexts..don't rely on it!



-- For reporting via statusbar:
--local function...

--ioncore.defer(function() get_fname() mod_statusbar.update() end)
-- ...and update the statusbar for the first time:
--statusbar_??()
--mod_statusbar.inform('pid', pid)
--mod_statusbare.update(true)

