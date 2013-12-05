--FONT="-hell-monobook-bold-r-normal--20-20-72-72-m-100-iso10646-1"
FONT="-hell-monobook-bold-r-normal--16-160-72-72-m-80-iso10646-1"
--FONT="-hell-monobook-medium-r-normal--28-280-72-72-m-140-iso10646-1"
if not gr.select_engine("de") then return end
de.reset()

de.defstyle("*", {
--  font = "-hell-monobook-bold-r-normal--24-240-72-72-m-120-iso10646-1",
--  font = "-hell-monobook-bold-r-normal--20-20-72-72-m-100-iso10646-1",
    font = FONT,
    padding_colour = "#000000",
    shadow_colour = "#000000",
    highlight_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#87AF87",
    padding_pixels = 0,
    spacing = 0,
    highlight_pixels = 2,
    shadow_pixels = 2,
    text_align = "center",
    transparent_background = false,
--  de.substyle("important", { foreground_colour = "#ffff00", }),
--  de.substyle("critical", { foreground_colour = "#ff0000", }),
--  de.substyle("gray", { foreground_colour = "#505050", }),
--  de.substyle("red", { foreground_colour = "#ff0000", 
})

de.defstyle("frame", {
    --based_on = "*",
    de.substyle("active", {
        shadow_colour = "#666666",
        border_sides=tnl,
        highlight_colour = "#666666",
        padding_colour = "#000000",
        background_colour = "#000000",
        foreground_colour = "#ffffff",
        padding_pixels = 3,
        highlight_pixels = 1,
        shadow_pixels = 1,
        border_style="inlaid",
        transparent_background = true,
    }),
    shadow_colour = "#333333",
	border_sides=tnl,
    highlight_colour = "#333333",
    padding_colour = "#000000",
    background_colour = "#000000",
    foreground_colour = "#ffffff",
    padding_pixels = 3,
    highlight_pixels = 1,
    shadow_pixels = 1,
	border_style="inlaid",
    transparent_background = true,
})

de.defstyle("frame-ionframe",{
    based_on = "frame",
    border_style = "inlaid",
    padding_pixels = 0,
    spacing = 0,
})

de.defstyle("frame-floatframe", {based_on = "frame",border_style = "ridge"})

de.defstyle("tab", {
    font = FONT,
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
    transparent_background = false,
        padding_colour = "#000000",
        shadow_colour = "#287373",
        highlight_colour = "#287373",
      --shadow_colour = "#53A6A6",
      --highlight_colour = "#53A6A6",
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
    font = FONT,
})

de.defstyle("input", {
    --based_on = "*",
	padding_colour = "#000000",
	shadow_colour = "#53A6A6",
    highlight_colour = "#53A6A6",
    background_colour = "#000000",
    foreground_colour = "#899CA1",
    padding_pixels = 2,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
    transparent_background = false,
    font = FONT,
    border_style = "inlaid",
    de.substyle("*-cursor", {
        background_colour = "#5E468C",
        foreground_colour = "#000000",
        transparent_background = false,
    }),
    de.substyle("*-selection", {
        background_colour = "#222222",
        foreground_colour = "#cccccc",
    }),
})

de.defstyle("stdisp", {
  based_on = "*",
	padding_colour = "#000000",
	shadow_colour = "#3579a8",
    highlight_colour = "#3579a8",
    background_colour = "#000000",
    foreground_colour = "#AAAAAA",
    padding_pixels = 3,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
    border_sides = lr,
    border_style = "inlaid",
de.substyle("important", {
   	        foreground_colour = "orange",
   	    }),
   	
   	    de.substyle("critical", {
   	        foreground_colour = "red",
   	    }),
        de.substyle("gray", {
            foreground_colour = "#505050",
        }),
        de.substyle("red", {
            foreground_colour = "#ff0000", 
        })
})
gr.refresh()
