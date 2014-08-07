-- look_greyviolet.lua drawing engine configuration file for Ion.

FONT_STATUS="-hell-monobook-bold-r-normal--16-160-72-72-m-80-iso10646-1"
FONT="-elite-laptop-bold-r-normal--28-280-72-72-c-140-koi8-r"

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = "#777777",
    highlight_colour = "#eeeeee",
    background_colour = "#aaaaaa",
    foreground_colour = "#000000",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    font = FONT,
    text_align = "center",
})

de.defstyle("tab", {
    font = FONT,
    de.substyle("active-selected", {
        shadow_colour = "#333366",
        highlight_colour = "#aaaacc",
        background_colour = "#666699",
        foreground_colour = "#eeeeee",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#777777",
        highlight_colour = "#eeeeee",
        background_colour = "#aaaaaa",
        foreground_colour = "#000000",
    }),
    de.substyle("inactive-selected", {
        shadow_colour = "#777788",
        highlight_colour = "#eeeeff",
        background_colour = "#9999aa",
        foreground_colour = "#000000",
    }),
    de.substyle("inactive-unselected", {
        shadow_colour = "#777777",
        highlight_colour = "#eeeeee",
        background_colour = "#aaaaaa",
        foreground_colour = "#000000",
    }),
    text_align = "center",
})

de.defstyle("frame", {
    --based_on = "*",
    de.substyle("active", {
        shadow_colour = "#222222",
        border_sides=tnl,
        highlight_colour = "#222222",
        padding_colour = "#e4e4e4",
        background_colour = "#e4e4e4",
        foreground_colour = "#ffffff",
        padding_pixels = 0,
        highlight_pixels = 0,
        shadow_pixels = 0,
        --border_style="inlaid",
        transparent_background = true,
    }),
    de.substyle("scratchpad", {
        shadow_colour = "#2222ff",
        border_sides=tnl,
        highlight_colour = "#2222ff",
        padding_colour = "#e4e4e4",
        background_colour = "#e4e4e4",
        foreground_colour = "#ffffff",
        padding_pixels = 0,
        highlight_pixels = 0,
        shadow_pixels = 0,
        --border_style="inlaid",
        transparent_background = false,
    }),
    shadow_colour = "#e4e4e4",
    border_sides=tnl,
    highlight_colour = "#e4e4e4",
    padding_colour = "#e4e4e4",
    background_colour = "#e4e4e4",
    foreground_colour = "#ffffff",
    padding_pixels = 0,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style="elevated",
    transparent_background = true,
})

de.defstyle("frame-ionframe",{
    based_on = "frame",
    border_style = "inlaid",
    padding_pixels = 0,
    spacing = 0,
})


de.defstyle("input", {
    de.substyle("*-cursor", {
        background_colour = "#000000",
        foreground_colour = "#aaaaaa",
    }),
    de.substyle("*-selection", {
        background_colour = "black",
        foreground_colour = "white",
    }),
})

de.defstyle("stdisp", {
  based_on = "*",
  font=FONT_STATUS,
  padding_colour = "#e4e4e4",
  shadow_colour = "#3579a8",
  highlight_colour = "#3579a8",
  background_colour = "#e4e4e4",
  foreground_colour = "#000000",
  padding_pixels    = 2,
  highlight_pixels  = 1,
  shadow_pixels     = 1,
  spacing           = 0,

  de.substyle("green",     { foreground_colour = "#00ff00", }),
  de.substyle("blue",      { foreground_colour = "#0000ff", }),
  de.substyle("cyan",      { foreground_colour = "#00ffff", }),
  de.substyle("magenta",   { foreground_colour = "#ff00ff", }),
  de.substyle("yellow",    { foreground_colour = "#ffff00", }),
  de.substyle("important", { foreground_colour = "orange", }),
  de.substyle("red",       { foreground_colour = "#ff0000", }),
  de.substyle("critical",  { foreground_colour = "red", }),
  de.substyle("gray",      { foreground_colour = "#505050", }),
})

gr.refresh()

