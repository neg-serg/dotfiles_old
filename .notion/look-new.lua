dopath("style_settings.lua")
if not gr.select_engine("de") then return end
de.reset()

de.defstyle("*", {
    font                   = neg.basefont,
    padding_colour         = neg.padding_color,
    shadow_colour          = neg.frame_def_border,
    highlight_colour       = neg.frame_def_border,
    background_colour      = neg.def_bg,
    foreground_colour      = neg.def_fg,
    padding_pixels         = 0,
    spacing                = 0,
    highlight_pixels       = 0,
    shadow_pixels          = 0,
    text_align             = "center",
})

de.defstyle("frame", {
    shadow_colour     = "#333333",
    highlight_colour  = "#333333",
    padding_colour    = "#333333",
    border_sides      = tnl,
    background_colour = neg.def_bg,
    padding_pixels    = 0,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    border_style      = "groove",
    de.substyle("*-*-active-scratchpad", {
        shadow_colour     = neg.scratchpad_border,
        highlight_colour  = neg.scratchpad_border,
        border_sides      = tnl,
        padding_colour    = neg.padding_color,
        background_colour = neg.def_bg,
        padding_pixels    = 2,
        highlight_pixels  = 2,
        shadow_pixels     = 2,
        spacing           = 3,
    }),
    de.substyle("active", {
        shadow_colour     = "#000000",
        highlight_colour  = "#000000",
        border_sides      = tnl,
        padding_colour    = neg.padding_color,
        background_colour = "#000000",
        padding_pixels    = 0,
        highlight_pixels  = 0,
        shadow_pixels     = 0,
    }),
})

de.defstyle("frame-ionframe",{
    based_on       = "frame",
    border_style   = "inlaid",
    padding_pixels = 0,
    spacing        = 0,
})

de.defstyle("frame-transient", {
    shadow_colour     = "#1F3B4F",
    highlight_colour  = "#1F3B4F",
    border_sides      = tnl,
    padding_colour    = neg.padding_color,
    background_colour = neg.def_bg,
    padding_pixels    = 0,
    highlight_pixels  = 0,
    shadow_pixels     = 0,
    spacing           = 0,
})

de.defstyle("frame-floating", {
    based_on               = "frame",
    border_style           = "ridge",
})

de.defstyle("stdisp", {
    based_on          = "*",
    font              = neg.statusfont,
    padding_colour    = neg.padding_color,
    shadow_colour     = "#3579a8",
    highlight_colour  = "#3579a8",
    background_colour = neg.def_bg,
    foreground_colour = "#AAAAAA",
    padding_pixels    = 2,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    spacing           = 0,
})

de.defstyle("actnotify", {
    based_on          = "*",
    font              = neg.statusfont,
    padding_colour    = neg.padding_color,
    shadow_colour     = "#3579a8",
    highlight_colour  = "#3579a8",
    background_colour = neg.def_bg,
    foreground_colour = "#AAAAAA",
    gravity           = "top",
    padding_pixels    = 0,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    spacing           = 0,
})

gr.refresh()
