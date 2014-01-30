-- Pop bfilter's little GUI window into the Ion3 statusbar:
-- Some of its windows can only be distinguished by their name (window title): "BFilter" for the main one, and "About BFilter", "BFilter Operation Log", "BFilter Request Log".
-- Oh, interesting: Ion3 window titles must be globally unique.  If you're say composing an e-mail with "BFilter" as the subject line, then run BFilter, its window will be titled "BFilter<1>".  The name pattern now takes this into account.  Uh, hang on, how do we know which one came first?  We'll assume that "BFilter" is the real program.
-- Oh, but not windows named "About BFilter", or "Basic Configuration", etc., just the tray icon window.

defwinprop{
	class = "Bfilter-gui",
	instance = "bfilter-gui",
	name = "^BFilter$",
--	Hmm, problem with regexp not matching plain "BFilter", the common case!  No grouping in regepxs in Ion3?!
--	name = "^BFilter(<[0-9]*>)?$",
	-- Bit ugly but works:
--	name = "^BFilter[0-9<>]*$",
--	name = "^BFilter.*$",

	statusbar = 'systray_bfilter',
--	switchto = "false",
--	transient_mode = "off",
}

-- The "About BFilter" window does not advertise itself as transient (but it probably should).
defwinprop {
	class = "Bfilter-gui",
	instance = "bfilter-gui",
	name = "^About BFilter.*",
	transient_mode = "on",	-- Hmm, doesn't work?
	statusbar = 'systray_bfilter',
}

