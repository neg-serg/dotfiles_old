-- ion3 configuration for my system information and monitoring workspace.


-- Title	Class	Instance
-- WM_NAME	WM_CLASS[1]	WM_CLASS[0]
--
-- xosview@zaphod	XOsview	xosview

-- You can find out the names for running X clients using "xlsclients -l" or xwininfo(maybe?) or wininfo (GTK).

defwinprop{
	class = "XOsview",
	instance = "xosview",
	target = "xosview"
}

defwinprop{
	class = "Gnome-system-log",
	instance = "gnome-system-log",
	target = "console"
}

-- Now using urxvt, actually
defwinprop{
	class = "URxvt",
	instance = "htop",
	target = "top"
}

defwinprop{
	class = "URxvt",
	instance = "top",
	target = "top"
}

defwinprop{
	class = "XTerm",
	instance = "top",
	target = "top"
}

defwinprop{
	class = "URxvt",
	instance = "messages",
	target = "messages"
}

