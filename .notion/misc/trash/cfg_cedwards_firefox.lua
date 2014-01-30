local Firefox_Class = "Minefield"
local Firefox_Target_Frame = "web-browser"

-- transient_mode = "current" | "off" ?
defwinprop{
	class = Firefox_Class,
--	class = "Minefield",
--	class = "Firefox",
--	class = "Firefox|Minefield",	-- Nope.  NOTE: Lua has patterns, not regular expressions.
--	class = "(Firefox)?(Minefield)?",
--	class = "(Minefield)?",
	instance = "Navigator",
--	role = "browser",
	target = Firefox_Target_Frame,
	transient_mode = "off",
}

-- Don't pop the Downloads window to the front automatically:
defwinprop{
	class = Firefox_Class,
--	class = "Firefox\|Minefield",
	instance = "Download",
--	name = ".*Downloads",
	target = Firefox_Target_Frame,
	switchto = false,
	jumpto = false,
	fullscreen = false,	-- Dunno why I had this here before and set to true!
	ignore_resizeinc = true,
}

defwinprop{
	class = Firefox_Class,
--	class = "(Firefox)?(Minefield)?",
	instance = "(gecko)?(Dialog)?",
	name = "Authentication Required",
	target = Firefox_Target_Frame,
--	transient_mode = "off",
--	ignore_resizeinc = true
}

-- Firefox "open with/save" dialogs (they seem to resize without notifying Ion properly and end up with button residue on the screen):
-- Hmm, maybe not: the dialog doesn't appear immediately, and the statusbar is too small for it anyway.  Is there a limit to the statusbar height?
--[[
defwinprop{
	class = "Firefox-bin",
	instance = "gecko",
	"Opening *",
--	ignore_resizeinc = false,
	transient_mode = "off",
	statusbar = "systray",
}
--]]


defwinprop{
	class = Firefox_Class,
	instance = "gecko",
	name = "Opening .*",
	ignore_resizeinc = false,
	transient_mode = "on"
}

