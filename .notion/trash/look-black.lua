-- monochromatic colorsheme for ion by warl0ck <warl0ck@eml.cc> 

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    font = "-elite-terminal-bold-r-normal--14-140-72-72-c-80-koi8-r",
	padding_colour = "#87AF87",
	shadow_colour = "#000000",
    highlight_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#87AF87",
    padding_pixels = 0,
    spacing = 0,
    highlight_pixels = 2,
    shadow_pixels = 2,
    --border_style = "elevated",
    text_align = "center",
    transparent_background = true,
})

de.defstyle("frame", {
    --based_on = "*",
    shadow_colour = "#67B07F",
	border_sides=tnl,
    highlight_colour = "#67B07F",
    padding_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#ffffff",
    padding_pixels = 2,
    highlight_pixels = 1,
    shadow_pixels = 1,
	border_style="elevated",
    transparent_background = true,
})

de.defstyle("frame-ionframe", {
    based_on = "frame",
    border_style = "inlaid",
    padding_pixels = 0,
    spacing = 0,
})

de.defstyle("frame-floatframe", {
    based_on = "frame",
	--border_style = "elevated",
    border_style = "ridge"
})

de.defstyle("tab", {
		padding_colour = "#000000",
		shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#006000",
	border_style="inlaid",
    padding_pixels = 2,
    spacing = 2,
    highlight_pixels = 1,
    shadow_pixels = 1,
	border_sides = tb,
    de.substyle("active-selected", {
    transparent_background = true,
		shadow_colour = "#97C097",
		highlight_colour = "#97C097",
		background_colour = "#000000",
		foreground_colour = "#97C097",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#67B07F",
        highlight_colour = "#87AF87",
        background_colour = "#000000",
        foreground_colour = "#87AF87",

    }),
    de.substyle("inactive-selected", {
		shadow_colour = "#67B07F",
		highlight_colour = "#67B07F",
		background_colour = "#000000",
		foreground_colour = "#87B07F",
    }),
    de.substyle("inactive-unselected", {
        shadow_colour = "#40A070",
        highlight_colour = "#40A070",
        background_colour = "#000000",
        foreground_colour = "#40A070",
    }),
    text_align = "center",
})

de.defstyle("tab-frame", {
    based_on = "tab",
    de.substyle("*-*-*-*-activity", {
        shadow_colour = "#87AF87",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#87AF87",
    }),
})

de.defstyle("tab-frame-ionframe", {
    based_on = "tab-frame",
    spacing = 1,
})

de.defstyle("tab-menuentry", {
    based_on = "tab",
    text_align = "left",
    highlight_pixels = 0,
    shadow_pixels = 0,
})

de.defstyle("tab-menuentry-big", {
    based_on = "tab-menuentry",
   padding_pixels = 0,
})

de.defstyle("input", {
    --based_on = "*",
		shadow_colour = "#87AF87",
		highlight_colour = "#87AF87",
		background_colour = "#000000",
		foreground_colour = "#87AF87",
    transparent_background = true,
    border_style = "elevated",

    padding_pixels = 0,
    highlight_pixels = 1,
    shadow_pixels = 0,
    de.substyle("*-cursor", {
        background_colour = "#87AF87",
        foreground_colour = "#000000",
    }),
    de.substyle("*-selection", {
        background_colour = "#87AF87",
        foreground_colour = "#000000",
    }),
})


de.defstyle("stdisp", {
    based_on = "*",
	padding_colour = "#000000",
	shadow_colour = "#87B07F",
    highlight_colour = "#87B07F",
    background_colour = "#000000",
    foreground_colour = "#87AF87",
    padding_pixels = 3,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 2,
	border_sides = lr,
    border_style = "groove",
    --de.substyle("important", {
        --foreground_colour = "green",
    --}),

    --de.substyle("critical", {
        --foreground_colour = "red",
    --}),
})
gr.refresh()

