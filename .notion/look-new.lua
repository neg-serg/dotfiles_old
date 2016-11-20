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
    bar = "none",
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
    floatframe_tab_min_w   = 10000,
    floatframe_bar_max_w_q = 1,
})


de.defstyle("tab", {
    font              = neg.basefont,
    padding_colour    = neg.padding_color,
    shadow_colour     = "#53A6A6",
    highlight_colour  = "#53A6A6",
    background_colour = neg.def_bg,
    foreground_colour = "#899CA1",
    foreground_colour = "#899CA1",
    padding_pixels    = 3,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    spacing           = 0,
    border_style      = "inlaid",
    border_sides      = tb,
    de.substyle("active-selected", {
        padding_colour    = neg.padding_color,
        shadow_colour     = "#287373",
        highlight_colour  = "#287373",
        background_colour = neg.def_bg,
        foreground_colour = "#AAAAAA",
    }),
    de.substyle("active-unselected", {
        shadow_colour     = "#222222",
        highlight_colour  = "#222222",
        background_colour = neg.def_bg,
        foreground_colour = "#898989",
    }),
    de.substyle("inactive-selected", {
        shadow_colour     = "#535353",
        highlight_colour  = "#535353",
        padding_colour    = neg.padding_color,
        background_colour = neg.def_bg,
        foreground_colour = neg.def_fg,
    }),
    de.substyle("inactive-unselected", {
        shadow_colour     = "#222222",
        highlight_colour  = "#222222",
        background_colour = neg.def_bg,
        foreground_colour = neg.def_fg,
    }),
    text_align = "center",
})

de.defstyle("tab-frame", {
    based_on = "tab",
    de.substyle("*-*-*-*-activity", {
        shadow_colour     = "#666666",
        highlight_colour  = "#000000",
        background_colour = neg.def_bg,
        foreground_colour = neg.def_fg,
    }),
})

de.defstyle("tab-frame-ionframe", {
    based_on = "tab-frame",
    spacing  = 1,
})

de.defstyle("tab-menuentry", {
    based_on         = "tab",
    text_align       = "left",
    highlight_pixels = 0,
    shadow_pixels    = 0,
})

de.defstyle("tab-menuentry-big", {
    based_on       = "tab-menuentry",
    padding_pixels = 0,
    font           = neg.basefont,
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

de.defstyle("frame-tiled-alt", {
    bar = "none",
})

de.defstyle("frame-unknown-alt", {
    bar = "none",
})

de.defstyle("frame-floating-alt", {
    bar = "none",
})

de.defstyle("frame-transient-alt", {
    bar = "none",
})

gr.refresh()
