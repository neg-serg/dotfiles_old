-- look_soothing.lua drawing engine configuration file for Ion.

text_fg = "#d3d7cf"

frame_bg = "#2e2d2d"
frame_highlight = "#3f3f3d"
frame_shadow = "#201f1f"

active_bg = "#184880"
active_shadow = "#1B3657"
active_highlight = "#124887"

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = frame_shadow,
    highlight_colour = frame_highlight,
    background_colour = frame_bg,
    foreground_colour = text_fg,
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    font = "-windows-proggytinysz-medium-r-normal--10-80-96-96-c-60-iso8859-1",
    text_align = "center",
})

de.defstyle("tab", {
    de.substyle("active-selected", {
        shadow_colour = active_shadow,
        highlight_colour = active_highlight,
        background_colour = active_bg,
        foreground_colour = text_fg,
    }),
    text_align = "center",
})

de.defstyle("input", {
    de.substyle("*-cursor", {
        background_colour = text_fg,
        foreground_colour = frame_bg,
    }),
    de.substyle("*-selection", {
        background_colour = active_bg,
        foreground_colour = text_fg,
    }),
})

dopath("lookcommon_emboss")

de.defstyle("frame-tiled", {
    spacing = 0,
})

de.defstyle("frame-tiled-alt", {
    spacing = 0,
})

de.defstyle("tab-frame-tiled", {
    spacing = 0,
})

gr.refresh()

