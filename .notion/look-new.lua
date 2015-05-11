local basefont = "xft:PragmataPro for Powerline-12:bold"
local statusfont = "xft:PragmataPro for Powerline-12:bold"

if not gr.select_engine("de") then return end
de.reset()

de.defstyle("*", {
    font = basefont,
    padding_colour = "#000000",
    shadow_colour = "#000000",
    highlight_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#666666",
    padding_pixels = 0,
    spacing = 0,
    highlight_pixels = 0,
    shadow_pixels = 0,
    text_align = "center",
    transparent_background = false,
})

de.defstyle("frame", {
    shadow_colour = "#000000",
    border_sides=tnl,
    highlight_colour = "#000000",
    padding_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#ffffff",
    padding_pixels = 0,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style="groove",
    de.substyle("*-*-active-scratchpad", {
        shadow_colour = "#1F3B4F",
        border_sides=tnl,
        highlight_colour = "#1F3B4F",
        padding_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#ffffff",
        padding_pixels = 2,
        highlight_pixels = 2,
        shadow_pixels = 2,
        spacing = 3,
    }),
    de.substyle("active", {
        shadow_colour = "#222222",
        border_sides=tnl,
        highlight_colour = "#222222",
        padding_colour = "#000000",
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
    border_sides=tnl,
    highlight_colour = "#1F3B4F",
    padding_colour = "#000000",
    background_colour = "#000000",
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
    font = basefont,
    padding_colour = "#000000",
    shadow_colour = "#53A6A6",
    highlight_colour = "#53A6A6",
    background_colour = "#000000",
    foreground_colour = "#899CA1",
    foreground_colour = "#899CA1",
    padding_pixels = 3,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
    --border_sides=tnl,
    --border_sides = lr,
    border_style = "inlaid",
    border_sides = tb,
    de.substyle("active-selected", {
        padding_colour = "#000000",
        shadow_colour = "#287373",
        highlight_colour = "#287373",
        background_colour = "#000000",
        foreground_colour = "#AAAAAA",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#222222",
        highlight_colour = "#222222",
        background_colour = "#000000",
        foreground_colour = "#898989",
    }),
    de.substyle("inactive-selected", {
        padding_colour = "#000000",
        shadow_colour = "#535353",
        highlight_colour = "#535353",
        background_colour = "#000000",
        foreground_colour = "#666666",
    }),
    de.substyle("inactive-unselected", {
        shadow_colour = "#222222",
        highlight_colour = "#222222",
        background_colour = "#000000",
        foreground_colour = "#666666",
    }),
    text_align = "center",
})

de.defstyle("tab-frame", {
    based_on = "tab",
    de.substyle("*-*-*-*-activity", {
        shadow_colour = "#666666",
        highlight_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#666666",
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
    font = basefont,
})

de.defstyle("input", {
    padding_colour = "#000000",
    shadow_colour = "#3579a8",
    highlight_colour = "#3579a8",
    background_colour = "#000000",
    foreground_colour = "#899CA1",
    padding_pixels = 2,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
    font = basefont,
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
		font = basefont,
	}
	
	if mode == "insert" then
		-- Blue
		t.shadow_colour = "#3579a8"
		t.highlight_colour = "#3579a8"
		t.background_colour = "#000000"
	else
		-- Grey
		t.shadow_colour = "#313131"
		t.highlight_colour = "#313131"
		t.background_colour = "#000000"
	end

	de.defstyle("input", t);
	gr.refresh()
end


de.defstyle("stdisp", {
  based_on = "*",
  font=statusfont,
  padding_colour = "#000000",
  shadow_colour = "#3579a8",
  highlight_colour = "#3579a8",
  background_colour = "#000000",
  foreground_colour = "#AAAAAA",
  padding_pixels    = 2,
  highlight_pixels  = 1,
  shadow_pixels     = 1,
  spacing           = 0,
})
gr.refresh()
