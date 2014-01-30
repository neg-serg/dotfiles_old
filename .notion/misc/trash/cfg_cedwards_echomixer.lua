-- ion3 configuration for echomixer utility for Echo audio hardware.
-- Note: the "<1>"s appended to the target frame identifiers are because of the second screen: I already have workspaces set up with frames with those names, and ion appends the "<n>" to keep them unique when adding new ones.

-- Title	Class	Instance
--
-- "Gina24 Echomixer v1.0.5"	"Emixer"	"emixer"
-- "Gina24 Misc controls"	"Eximer"	"misc"
-- "Gina24 Line volume"	"Emixer"	"line"
-- "Gina24 PCM volume"	"Emixer"	"pcm"
-- "Gina24 Monitor mixer"	"Emixer"	"mixer"
-- "Gina24 VU-meters"	"Emixer"	"vumeters"
-- "Gina24 Mixer"		"Emixer"	"gridmixer"

defwinprop{
	class = "Emixer",
	instance = "emixer",
	target = "echomixer-main"
}

defwinprop{
	class = "Emixer",
	instance = "misc",
	target = "echomixer-misc"
}

defwinprop{
	class = "Emixer",
	instance = "vumeters",
	target = "echomixer-vumeters"
}

defwinprop{
	class = "Emixer",
	instance = "gridmixer",
	target = "echomixer-gridmixer"
}

defwinprop{
	class = "Emixer",
	instance = "line",
	target = "echomixer-line"
}

defwinprop{
	class = "Emixer",
	instance = "mixer",
	target = "echomixer-monitor"
}

defwinprop{
	class = "Emixer",
	instance = "pcm",
	target = "echomixer-pcm"
}

