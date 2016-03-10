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
    news="",    dev2="",
    dev3="",    term2="",
    firefox="", viber="",
    vid="",     steam=""
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

neg.dzen.siji = {
    rect                = "\u{e000}",
    invrect             = "\u{e001}",
    tiling_default      = "\u{e002}",
    tiling_bottom       = "\u{e003}",
    tiling_bottom_stack = "\u{e004}",
    tiling_grid         = "\u{e005}",
    tiling_float        = "\u{e006}",
    tiling_fibbo        = "\u{e007}",
    tiling_fibboinverse = "\u{e008}",
    master2_standard    = "\u{e009}",
    master2_bottom      = "\u{e00a}",
    bluetooth           = "\u{e00b}",
    usb                 = "\u{e00c}",
    power               = "\u{e00d}",
    arch                = "\u{e00e}",
    pacman              = "\u{e00f}",
    bone1               = "\u{e010}",
    bone2               = "\u{e011}",
    bone3               = "\u{e012}",
    bone4               = "\u{e013}",
    bone5               = "\u{e014}",
    clock               = "\u{e015}",
    inv_clock           = "\u{e016}",
    rectclock           = "\u{e017}",
    inv_rectclock       = "\u{e018}",
    diamond_clock       = "\u{e019}",
    inv_diamond_clock   = "\u{e01a}",
    termometer          = "\u{e01b}",
    termometer_vert     = "\u{e01c}",
    termometer_bold     = "\u{e01d}",
    terminal            = "\u{e01e}",
    note                = "\u{e01f}",
    ddr2                = "\u{e020}",
    ddr4                = "\u{e021}",
    hz1                 = "\u{e022}",
    hz2                 = "\u{e023}",
    hz3                 = "\u{e024}",
    hz4                 = "\u{e025}",
    cpu                 = "\u{e026}",
    vortex              = "\u{e027}",
    microscheme         = "\u{e028}",
    lock                = "\u{e029}",
    chest1              = "\u{e02a}",
    chest2              = "\u{e02b}",
    cannon              = "\u{e02c}",
    wifi                = "\u{e02d}",
    i1                  = "\u{e02e}",
    i2bold              = "\u{e02f}",
    bat0_vert           = "\u{e030}",
    bat50_vert          = "\u{e031}",
    bat75_vert          = "\u{e032}",
    bat100_vert         = "\u{e033}",
    bat0_vert_fat       = "\u{e034}",
    bat50_vert_fat      = "\u{e035}",
    bat75_vert_fat      = "\u{e036}",
    bat100_vert_fat     = "\u{e037}",
    bat0_small          = "\u{e038}",
    bat50_small         = "\u{e039}",
    bat75_small         = "\u{e03a}",
    bat100_small        = "\u{e03b}",
    bat0_fat            = "\u{e03c}",
    bat50_fat           = "\u{e03d}",
    bat75_fat           = "\u{e03e}",
    bat100_fat          = "\u{e03f}",
    lighting            = "\u{e040}",
    fork_vert           = "\u{e041}",
    fork                = "\u{e042}",
    inv_fork            = "\u{e043}",
    signal5             = "\u{e044}",
    signal50            = "\u{e045}",
    signal100           = "\u{e046}",
    vert2               = "\u{e047}",
    vert3               = "\u{e048}",
    hor2                = "\u{e049}",
    hor3                = "\u{e04a}",
    hor5                = "\u{e04b}",
    microphone          = "\u{e04c}",
    headphone           = "\u{e04d}",
    sound_vol0          = "\u{e04e}",
    sound_mute          = "\u{e04f}",
    sound_on            = "\u{e050}",
    minsound_vol0       = "\u{e051}",
    minsound_mute       = "\u{e052}",
    minsound_on         = "\u{e053}",
    prev_track          = "\u{e054}",
    scroll_prev         = "\u{e055}",
    record              = "\u{e056}",
    stop                = "\u{e057}",
    play                = "\u{e058}",
    pause               = "\u{e059}",
    next_track          = "\u{e05a}",
    scroll_next         = "\u{e05b}",
    music               = "\u{e05c}",
    sound               = "\u{e05d}",
    cur_arr_right       = "\u{e05e}",
    cur_arr_left        = "\u{e05f}",
    arr_up              = "\u{e060}",
    arr_down            = "\u{e061}",
    arr_right           = "\u{e062}",
    arr_left            = "\u{e063}",
    cur_arr_up          = "\u{e064}",
    cur_arr_down        = "\u{e065}",
    cur_arr_up2         = "\u{e066}",
    cur_arr_down2       = "\u{e067}",
    cur_arr_right2      = "\u{e068}",
    cur_arr_left2       = "\u{e069}",
    cur_arr_right3      = "\u{e06a}",
    cur_arr_left3       = "\u{e06b}",
    arr_up2             = "\u{e06c}",
    arr_down2           = "\u{e06d}",
    arr_right2          = "\u{e06e}",
    arr_left2           = "\u{e06f}",
    mail_quad           = "\u{e070}",
    inv_mail_quad       = "\u{e071}",
    mail                = "\u{e072}",
    inv_mail            = "\u{e073}",
    im                  = "\u{e074}",
    human               = "\u{e075}",
    rect_cross          = "\u{e076}",
    warn1               = "\u{e077}",
    warn2               = "\u{e078}",
    stop_sign           = "\u{e079}",
    monitor             = "\u{e09f}",
    warn_rect1          = "\u{e0a7}",
    warn_rect2          = "\u{e0a8}",
    eye                 = "\u{e0a9}",
    ghost               = "\u{e0aa}",
    msg_inv             = "\u{e0ad}",
    windows             = "\u{e0b1}",
    house               = "\u{e0b2}",
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
    transparent_background = true,
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
    padding_pixels    = 2,
    highlight_pixels  = 1,
    shadow_pixels     = 1,
    spacing           = 0,
})

gr.refresh()
