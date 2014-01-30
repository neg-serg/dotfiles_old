-- A first attempt at getting dialogs out of the freakin' way of the main application window, which is very often absolutely necessary.
-- Of course, this doesn't work so nicely when the main window is in the scratchpad workspace, but oh well...
-- "Edit File.*"
-- "Question"	Maybe appearing over the main window for this is OK.
-- "VIM .* Search.*"
-- TODO: figure out how to get regular expression OR to work.

-- This WOULD be really nice, but Ion won't set focus on anything in the systray. :(
--[[
defwinprop{
	class = "Gvim",
	instance = "gvim",
	name = "VIM .* Search.*",	-- NOTE: RE, not glob!  Also, the dash character in that window title is apparently not a hyphen!
--	transient_mode = "",	-- Doesn't seem to matter
	statusbar = "systray",	-- TODO: create another systray just for dialogs.
}
]]

-- Actually, these may be OK to have floating atop the main window...I like big file requester dialogs...
--[[
defwinprop{
	class = "Gvim",
	instance = "gvim",
	name = "Edit File.*",
	statusbar = "systray_dialog",
}
]]
