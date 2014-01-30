-- GtkTerm's "configuration saved" dialog appears behind the main one, which is idiotic.
defwinprop{
	class = "Gtkterm",
	instance = "gtkterm",
	name = "???",
--	target = "web-browser",
	transient_mode = "on",
	switchto = true,
	jumpto = true,
}

