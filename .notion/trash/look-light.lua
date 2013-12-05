-- look_cleanwhite.lua a bright theme fitting white terminals
--
-- uses Terminus fonts
--
--				-- René van Bevern <rvb@debian.org>

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = "grey70",
    highlight_colour = "grey70",
    background_colour = "#E4E4E4",
    foreground_colour = "black",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 1,
    border_style = "elevated",
    font = "-elite-terminal-bold-r-normal--14-140-72-72-c-80-koi8-r",
    text_align = "center",
    transparent_background = false,
})

de.defstyle("frame", {
    based_on = "*",

    de.substyle("active", {
	padding_colour = "black",
    }),

    padding_colour = "grey70",
    background_colour = "#E4E4E4",
    shadow_colour = "white",
    highlight_colour = "white",
    transparent_background = true,

})

de.defstyle("tab", {
    based_on = "*",
    highlight_pixels = 1,
    shadow_pixels = 1,
    padding_pixels = 0,
    highlight_colour = "grey70",
    shadow_colour = "grey70",
    de.substyle("active-selected", {
        shadow_colour = "black",
        highlight_colour = "black",
        background_colour = "darkslategray",
        foreground_colour = "white",
    }),
    de.substyle("inactive-unselected", {
        background_colour = "#d8d8d8",
        foreground_colour = "#606060",
    }),
    text_align = "center",
})

de.defstyle("tab-menuentry", {
    based_on = "tab",
    text_align = "left",
    spacing = 1,
})

de.defstyle("tab-menuentry-big", {
    based_on = "tab-menuentry",
    padding_pixels = 10,
})

de.defstyle("input-edln", {
    based_on = "*",
    de.substyle("*-cursor", {
        background_colour = "#000000",
        foreground_colour = "#d8d8d8",
    }),
    de.substyle("*-selection", {
        background_colour = "#f0c000",
        foreground_colour = "#000000",
    }),
})

gr.refresh()
