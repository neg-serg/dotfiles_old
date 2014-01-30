-- xscanimage
--
defwinprop{
	class = "Xscanimage",
	instance = "xscanimage",
	name = ".*scanner",
	target = "graphics",
	switchto = true,
	jumpto = true,
	fullscreen = false,
	ignore_resizeinc = true,
}

defwinprop{
	class = "Xscanimage",
	instance = "xscanimage",
	name = "xscanimage preview",
	switchto = true,
	jumpto = false,
	fullscreen = false,
	ignore_resizeinc = false,
}

defwinprop{
	class = "Xscanimage",
	instance = "xscanimage",
	name = "Scanning",
	switchto = true,
	jumpto = false,
	fullscreen = false,
	ignore_resizeinc = false,
}
