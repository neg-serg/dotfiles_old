-- Also:
-- "Bottom Expanded Edge Panel"
-- "Left Expanded Edge Panel"
-- "Right Expanded Edge Panel"

-- See this thread for how to get panels to dock in the stdisp thingy
-- http://www.mail-archive.com/ion-general@lists.berlios.de/msg02129.html

--ioncore.get_hook("clientwin_do_manage_alt"):add(
--	function(...winprop field...)
--		panel = WMPlex.set_stdisp(_, {pos = 'bl'}, {reg = winprop_field})
--		WRegion.set_name(panel, "panel")
--	end
--)

defwinprop{
	-- The main Gnome menu with Applications|Places|System
	-- 1600 x 60 default dimensions
	class = "Gnome-panel",
	instance = "gnome-panel",
--	name = ".*Expanded Edge Panel.*",
	name = "Bottom Expanded Edge Panel",
	is_panel = true,
	-- http://modeemi.fi/~tuomov/repos/ion-scripts-3/scripts/panel.lua
	min_size = { w = 1600, h = 60 },
--	target = "gnome-panel",
--	switchto = true,
--	jumpto = true,
--	fullscreen = true,
--	ignore_resizeinc = true,
}

-- Gnome Keyring dialog should appear as a dialog (duh).
defwinprop {
	class = "Gnome-keyring-ask",
	instance = "gnome-keyring-ask",
	-- umm, make it a dialog?
	transient_mode = "current",
}

