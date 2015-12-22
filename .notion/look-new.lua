neg = {}

neg.basefont = "xft:PragmataPro for Powerline-12:bold"
neg.statusfont = "xft:PragmataPro for Powerline-12:bold"

neg.padding_color="#000000"
neg.def_bg="#000000"
neg.def_fg="#666666"
neg.scratchpad_border="#1F3B4F"
neg.frame_def_border="#000000"

if not gr.select_engine("de") then return end
de.reset()

de.defstyle("*", {
    font = neg.basefont,
    padding_colour = neg.padding_color,
    shadow_colour = neg.frame_def_border,
    highlight_colour = neg.frame_def_border,
    background_colour = neg.def_bg,
    foreground_colour = neg.def_fg,
    padding_pixels = 0,
    spacing = 0,
    highlight_pixels = 0,
    shadow_pixels = 0,
    text_align = "center",
    transparent_background = false,
})

de.defstyle("frame", {
    shadow_colour = neg.frame_def_border,
    highlight_colour = neg.frame_def_border,
    border_sides=tnl,
    padding_colour = neg.padding_color,
    background_colour = neg.def_bg,
    foreground_colour = "#ffffff",
    padding_pixels = 0,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style="groove",
    de.substyle("*-*-active-scratchpad", {
        shadow_colour = neg.scratchpad_border,
        highlight_colour = neg.scratchpad_border,
        border_sides=tnl,
        padding_colour = neg.padding_color,
        background_colour = neg.def_bg,
        foreground_colour = "#ffffff",
        padding_pixels = 2,
        highlight_pixels = 2,
        shadow_pixels = 2,
        spacing = 3,
    }),
    de.substyle("active", {
        shadow_colour = "#222222",
        highlight_colour = "#222222",
        border_sides=tnl,
        padding_colour = neg.padding_color,
        background_colour = "#000000",
        foreground_colour = "#ffffff",
        padding_pixels = 0,
        highlight_pixels = 0,
        shadow_pixels = 0,
    }),
    gr.refresh()    
})

de.defstyle("frame-ionframe",{
    based_on = "frame",
    border_style = "inlaid",
    padding_pixels = 0,
    spacing = 0,
})

de.defstyle("frame-transient", {
    shadow_colour = "#1F3B4F",
    highlight_colour = "#1F3B4F",
    border_sides=tnl,
    padding_colour = neg.padding_color,
    background_colour = neg.def_bg,
    foreground_colour = "#ffffff",
    padding_pixels = 2,
    highlight_pixels = 2,
    shadow_pixels = 2,
    spacing = 3,
})

de.defstyle("frame-floating", {
    based_on = "frame",
    border_style = "ridge",
    floatframe_tab_min_w = 10000,
    floatframe_bar_max_w_q = 1,
})


de.defstyle("tab", {
    font = neg.basefont,
    padding_colour = neg.padding_color,
    shadow_colour = "#53A6A6",
    highlight_colour = "#53A6A6",
    background_colour = neg.def_bg,
    foreground_colour = "#899CA1",
    foreground_colour = "#899CA1",
    padding_pixels = 3,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
    border_style = "inlaid",
    border_sides = tb,
    de.substyle("active-selected", {
        padding_colour = neg.padding_color,
        shadow_colour = "#287373",
        highlight_colour = "#287373",
        background_colour = neg.def_bg,
        foreground_colour = "#AAAAAA",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#222222",
        highlight_colour = "#222222",
        background_colour = neg.def_bg,
        foreground_colour = "#898989",
    }),
    de.substyle("inactive-selected", {
        shadow_colour = "#535353",
        highlight_colour = "#535353",
        padding_colour = neg.padding_color,
        background_colour = neg.def_bg,
        foreground_colour = neg.def_fg,
    }),
    de.substyle("inactive-unselected", {
        shadow_colour = "#222222",
        highlight_colour = "#222222",
        background_colour = neg.def_bg,
        foreground_colour = neg.def_fg,
    }),
    text_align = "center",
})

de.defstyle("tab-frame", {
    based_on = "tab",
    de.substyle("*-*-*-*-activity", {
        shadow_colour = "#666666",
        highlight_colour = "#000000",
        background_colour = neg.def_bg,
        foreground_colour = neg.def_fg,
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
    font = neg.basefont,
})

de.defstyle("input", {
    padding_colour = neg.padding_color,
    shadow_colour = "#3579a8",
    highlight_colour = "#3579a8",
    background_colour = neg.def_bg,
    foreground_colour = "#899CA1",
    padding_pixels = 2,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
    font = neg.basefont,
    border_style = "inlaid",
    de.substyle("*-cursor", {
        background_colour = "#5E468C",
        foreground_colour = "#000000",
    }),
    de.substyle("*-selection", {
        background_colour = "#999999",
        foreground_colour = "#000000",
    }),
})


-- Defines style for input queries. In will be "blue" for queries in insert
-- mode and "green" for queries in normal (command) mode.
-- mode parameter is string: "insert" or "normal"
function inputstyle(mode)
	local t = {
		based_on = "*",
		shadow_colour = "", -- To be defined below
		highlight_colour = "", -- To be defined below
		background_colour = "", -- To be defined below
        foreground_colour = "#899CA1",
        padding_pixels = 1,
        highlight_pixels = 1,
        shadow_pixels = 1,
        border_style = "elevated",
        de.substyle("*-cursor", {
            background_colour = "#5E468C",
            foreground_colour = "#000000",
        }),
        de.substyle("*-selection", {
            background_colour = "#999999",
            foreground_colour = "#000000",
        }),
		font = neg.basefont,
	}
	
	if mode == "insert" then
		-- Blue
		t.shadow_colour = "#3579a8"
		t.highlight_colour = "#3579a8"
		t.background_colour = neg.def_bg
	else
		-- Grey
		t.shadow_colour = "#313131"
		t.highlight_colour = "#313131"
		t.background_colour = neg.def_bg
	end

	de.defstyle("input", t);
	gr.refresh()
end


de.defstyle("stdisp", {
    based_on = "*",
    font=neg.statusfont,
    padding_colour = neg.padding_color,
    shadow_colour = "#3579a8",
    highlight_colour = "#3579a8",
    background_colour = neg.def_bg,
    foreground_colour = "#AAAAAA",
    padding_pixels    = 2,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    spacing           = 0,
})
gr.refresh()
