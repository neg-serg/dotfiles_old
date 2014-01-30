
pid_property_atom = ioncore.x_intern_atom("_NET_WM_PID", false)	-- Always 262?

-- Note: WClientWin and WWindow (and descendents) have an :xid(), but others don't.  Can we type the function arguments?
function get_pid_of_region(region)
	if region ~= nil and (region.__typename == "WClientWin" or region.__typename == "WWindow") then
		return ioncore.x_get_window_property(region:xid(), pid_property_atom, 0, 0, true)[1]
	else
		return nil
	end
end

