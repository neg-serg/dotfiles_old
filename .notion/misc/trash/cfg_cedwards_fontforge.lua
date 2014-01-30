local FontForge_Class = "fontforge"	-- NOTE: all lowercase.
local FontForge_Instance = "fontforge"
local FontForge_Default_Frame = "fontforge-browser"


-- Generally pop things in the main browser window (so as not to obscure the glyph editing):
defwinprop {
	class = FontForge_Class,
	instance = FontForge_Instance,
	target = FontForge_Default_Frame,
}

-- Glyph editor window:
defwinprop {
	class = FontForge_Class,
	instance = FontForge_Instance,
	name = "(.*) at (.*) from (.*)",
	target = "fontforge-glyph",
}

-- Tools palette window:
defwinprop {
	class = FontForge_Class,
	instance = FontForge_Instance,
	name = "Tools",
	target = "fontforge-tools",
	acrobatic = "true",
}

-- Layers palette window:
defwinprop {
	class = FontForge_Class,
	instance = FontForge_Instance,
	name = "Layers",
	target = "fontforge-layers",
	acrobatic = "true",
}

-- Startup splash window:
defwinprop {
	class = FontForge_Class,
	instance = FontForge_Instance,
	name = "FontForge",
	transient = "true",
}

