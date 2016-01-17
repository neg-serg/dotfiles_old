-- local utf8 = require 'lua-utf8'

neg      = {}
neg.dzen = {}
neg.rofi = {}

neg.font       = "PragmataPro for Powerline"
neg.font_size  = "12"
neg.basefont   = "xft:".. neg.font .."-"..neg.font_size..":bold"
neg.statusfont = "xft:".. neg.font .."-"..neg.font_size..":bold"

neg.padding_color     = "#000000"
neg.def_bg            = "#000000"
neg.def_fg            = "#666666"
neg.scratchpad_border = "#1F3B4F"
neg.frame_def_border  = "#000000"

neg.rofi.bg   = "\"#000000\""
neg.rofi.fg   = "\"#666666\""
neg.rofi.hlfg = "\"#aaaaaa\""
neg.rofi.hlbg = "\"#194558\""
neg.rofi.bc   = "\"#202020\""

neg.dzen.panel_font_ = "'".. neg.font..":style=bold:size=".. neg.font_size .."'"
neg.dzen.bg_         = '"#000000"'
neg.dzen.h_          = 19
neg.dzen.main_w_     = "1000"
neg.dzen.mpd_w_      = "910"

neg.dzen.fancy_table = {
    term="",    dev="",
    admin="",   web="",
    media="",   im="",
    look="",    right="",
    center="",  left="",
    data="",    vertical_dots="",
    grid="",    gtd="",
    gtd="",     text="",
    play="",    pic="",
    game="",    monitor="",
    news=""
}

neg.dzen.powersym = {
    right    = "", -- \xe0b0
    left     = "", -- \xe0b2
    right_br = "", -- \xe0b1
    left_br  = "", -- \xe0b3
    branch   = "", -- \xe0a0
    lock     = ""  -- \xe0a2
}

--  font = "Ionicons" -- http://ionicons.com/
neg.dzen.ioniconssym = {
    battery_charge = '\u{f111}',
    battery_low    = '\u{f112}',
    battery_mid    = '\u{f115}',
    battery_high   = '\u{f114}',
    battery_full   = '\u{f113}',
    volume_high    = '\u{f257}',
    volume_low     = '\u{f258}',
    volume_medium  = '\u{f259}',
    volume_mute    = '\u{f25a}',
    close          = '\u{f128}'
}

--  font = "octicons" -- https://octicons.github.com/
neg.dzen.octiconsym = {
    bug           = '\u{f091}',
    browser       = '\u{f0c5}',
    question      = '\u{f02c}',
    mirror        = '\u{f024}',
    unfold        = '\u{f039}',
    screen_full   = '\u{f066}',
    screen_normal = '\u{f067}',
    puzzle        = '\u{f0c0}',
    rocket        = '\u{f033}',
    light_bulb    = '\u{f000}',
    dashboard     = '\u{f07d}',
    mail          = '\u{f03b}',
    mail_read     = '\u{f03c}'
}

--  font = "Typicons" -- http://typicons.con (battery)
neg.dzen.typiconssym = {
    battery_charge = '\u{e02a}',
    battery_low    = '\u{e02d}',
    battery_mid    = '\u{e02e}',
    battery_high   = '\u{e02c}',
    battery_full   = '\u{e02b}',
    volume_down    = '\u{e132}',
    volume_mute    = '\u{e133}',
    volume_up      = '\u{e134}',
    volume         = '\u{e135}',
    flag           = '\u{e074}',
    plug           = '\u{e0cd}',
    time           = '\u{e120}'
}

--  font = "Climacons\\-Font" -- http://adamwhitcroft.com/climacons
neg.dzen.climaconssym = {
     cloud                     = "\u{e000}",
     cloud_sun                 = "\u{e001}",
     cloud_moon                = "\u{e002}",
     rain                      = "\u{e003}",
     rain_sun                  = "\u{e004}",
     rain_moon                 = "\u{e005}",
     showers                   = "\u{e006}",
     showers_sun               = "\u{e007}",
     showers_moon              = "\u{e008}",
     downpour                  = "\u{e009}",
     downpour_sun              = "\u{e00a}",
     downpour_moon             = "\u{e00b}",
     drizzle                   = "\u{e00c}",
     drizzle_sun               = "\u{e00d}",
     drizzle_moon              = "\u{e00e}",
     sleet                     = "\u{e00f}",
     sleet_sun                 = "\u{e010}",
     sleet_moon                = "\u{e011}",
     hail                      = "\u{e012}",
     hail_sun                  = "\u{e013}",
     hail_moon                 = "\u{e014}",
     flurries                  = "\u{e015}",
     flurries_sun              = "\u{e016}",
     flurries_moon             = "\u{e017}",
     snow                      = "\u{e018}",
     snow_sun                  = "\u{e019}",
     snow_moon                 = "\u{e01a}",
     fog                       = "\u{e01b}",
     fog_sun                   = "\u{e01c}",
     fog_moon                  = "\u{e01d}",
     haze                      = "\u{e01e}",
     haze_sun                  = "\u{e01f}",
     haze_moon                 = "\u{e020}",
     wind                      = "\u{e021}",
     wind_cloud                = "\u{e022}",
     wind_sun                  = "\u{e023}",
     wind_moon                 = "\u{e024}",
     lightning                 = "\u{e025}",
     lightning_sun             = "\u{e026}",
     lightning_moon            = "\u{e027}",
     sun                       = "\u{e028}",
     sunset                    = "\u{e029}",
     sunrise                   = "\u{e02a}",
     sun_low                   = "\u{e02b}",
     sun_lower                 = "\u{e02c}",
     moon                      = "\u{e02d}",
     moon_new                  = "\u{e02e}",
     moon_first_crescent       = "\u{e02f}",
     moon_first_half           = "\u{e030}",
     moon_first_three_quarter  = "\u{e031}",
     moon_full                 = "\u{e032}",
     moon_last_three_quarter   = "\u{e033}",
     moon_last_half            = "\u{e034}",
     moon_last_crescent        = "\u{e035}",
     snowflake                 = "\u{e036}",
     tornado                   = "\u{e037}",
     thermometer_empty         = "\u{e038}",
     thermometer_low           = "\u{e039}",
     thermometer_medium_low    = "\u{e03a}",
     thermometer_medium_high   = "\u{e03b}",
     thermometer_high          = "\u{e03c}",
     thermometer_full          = "\u{e03d}",
     celcius                   = "\u{e03e}",
     farenheit                 = "\u{e03f}",
     compass                   = "\u{e040}",
     compass_north             = "\u{e041}",
     compass_east              = "\u{e042}",
     compass_south             = "\u{e043}",
     compass_west              = "\u{e044}",
     umbrella                  = "\u{e045}",
     sunglasses                = "\u{e046}",
     cloud_refresh             = "\u{e047}",
     cloud_down                = "\u{e048}",
     cloud_up                  = "\u{e049}"
}

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
    transparent_background = false,
})

de.defstyle("frame", {
    shadow_colour     = neg.frame_def_border,
    highlight_colour  = neg.frame_def_border,
    border_sides      = tnl,
    padding_colour    = neg.padding_color,
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
        shadow_colour     = "#222222",
        highlight_colour  = "#222222",
        border_sides      = tnl,
        padding_colour    = neg.padding_color,
        background_colour = "#000000",
        padding_pixels    = 0,
        highlight_pixels  = 0,
        shadow_pixels     = 0,
    }),
    gr.refresh()    
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

de.defstyle("input", {
    padding_colour    = neg.padding_color,
    shadow_colour     = "#3579a8",
    highlight_colour  = "#3579a8",
    background_colour = neg.def_bg,
    foreground_colour = "#899CA1",
    padding_pixels    = 2,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    spacing           = 0,
    font              = neg.basefont,
    border_style      = "inlaid",
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
		based_on          = "*",
		shadow_colour     = "", -- To be defined below
		highlight_colour  = "", -- To be defined below
		background_colour = "", -- To be defined below
        foreground_colour = "#899CA1",
        padding_pixels    = 1,
        highlight_pixels  = 1,
        shadow_pixels     = 1,
        border_style      = "elevated",
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
	if mode == "insert" then -- Blue
		t.shadow_colour     = "#3579a8"
		t.highlight_colour  = "#3579a8"
		t.background_colour = neg.def_bg
	else -- Grey
		t.shadow_colour     = "#313131"
		t.highlight_colour  = "#313131"
		t.background_colour = neg.def_bg
	end
	de.defstyle("input", t);
	gr.refresh()
end


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
gr.refresh()
