-- monochromatic colorsheme for ion by warl0ck <warl0ck@eml.cc> 

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = "#000000",
    highlight_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#009000",
    padding_pixels = 0,
    highlight_pixels = 0,
    shadow_pixels = 0,
    border_style = "elevated",
    font = "-artwiz-anorexia-medium-r-normal--11-110-75-75-p-90-koi8-r",
    text_align = "center",
})

de.defstyle("frame", {
    based_on = "*",
    shadow_colour = "#001010",
    highlight_colour = "#000000",
    padding_colour = "#006000",
    background_colour = "#000000",
    foreground_colour = "#ffffff",
    padding_pixels = 0,
    highlight_pixels = 0,
    shadow_pixels = 0,
    de.substyle("active", {
        shadow_colour = "#009000",
        highlight_colour = "#009000",
        padding_colour = "#000900",
        foreground_colour = "#ffffff",
    }),
})

de.defstyle("frame-ionframe", {
    based_on = "frame",
    border_style = "inlaid",
    padding_pixels = 0,
    spacing = 0,
})

de.defstyle("frame-floatframe", {
    based_on = "frame",
    border_style = "ridge"
})

de.defstyle("tab", {
    padding_pixels = 0,
    highlight_pixels = 0,
    shadow_pixels = 3,
    based_on = "*",
    de.substyle("active-selected", {
    font = "-artwiz-anorexia-medium-r-normal--11-110-75-75-p-90-koi8-r",
        shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#00A000",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#006000",

    }),
    de.substyle("inactive-selected", {
        shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#007000",
    }),
    de.substyle("inactive-unselected", {
        shadow_colour = "#000000",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#004000",
    }),
    text_align = "center",
})

de.defstyle("tab-frame", {
    based_on = "tab",
    de.substyle("*-*-*-*-activity", {
        shadow_colour = "#00AA00",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#000000",
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
    padding_pixels = 7,
    font = "-elite-light-medium-r-normal--12-120-72-72-c-60-koi8-r ",
})

de.defstyle("input", {
    based_on = "*",
    font = "-elite-light-medium-r-normal--12-120-72-72-c-60-koi8-r ",
    shadow_colour = "#008000",
    highlight_colour = "#008000",
    background_colour = "#000000",
    foreground_colour = "#00a000",
    border_style = "elevated",
    padding_pixels = 2,
    highlight_pixels = 1,
    shadow_pixels = 1,
    de.substyle("*-cursor", {
        background_colour = "#00A000",
        foreground_colour = "#000000",
    }),
    de.substyle("*-selection", {
        background_colour = "#00A000",
        foreground_colour = "#000000",
    }),
})


gr.refresh()
