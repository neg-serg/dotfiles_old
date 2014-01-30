defwinprop{
	class = "Evolution",
	instance = "evolution",
	name = ".* Evolution",
	target = "mail<1>"
--	transient_mode = "current",
}

-- Handle certain windows specially:
-- "Save Image", "Mail Server Password Required", "Saving ..." | "... Saved"

defwinprop{
	class = "Thunderbird-bin",
	instance = "Gecko",
	name = "Compose: .*",
	switchto = true,
	jumpto = true,
	fullscreen = false,
	ignore_resizeinc = true,
}

-- Server login dialogs:
defwinprop{
	class = "Evolution",
	instance = "evolution",
	name = "Enter Password .*",
	switchto = true,
	jumpto = true,
	fullscreen = false,
	ignore_resizeinc = true,
}

defwinprop{
	class = "Thunderbird-bin",
	instance = "Gecko",
	name = "Saving .*",
--	name = "(Saving .*|.* Saved)",
	switchto = false,
	jumpto = false
}

defwinprop{
	class = "Thunderbird-bin",
	instance = "Gecko",
	name = "Save Image",
	switchto = true,
	jumpto = false,
	fullscreen = false,
	ignore_resizeinc = true,
}

