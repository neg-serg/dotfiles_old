notioncore.set{
    dblclick_delay=250,
    
    notioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    notioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    notioncore.defshortening("[^:]+: (.*)", "$1$|$1$<..."),
    notioncore.defshortening("(.*)", "$1$|$1$<..."),
    notioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2"),
    notioncore.defshortening("(.*) - Mozilla", "$1$|$1$<..."),
    notioncore.defshortening("XMMS - (.*)", "$1$|...$>$1"),

    ignore_net_active_window=false,
    float_placement_padding=2,
    warp=false,
    kbresize_delay=1000000,
    mousefocus="disabled",
    opaque_resize=true,
    switchto=true,
    unsqueeze=true,
    screen_notify=true,
    autosave_layout=false,
    autoraise=true,          -- Autoraise regions in groups on goto.
	edge_resistance=200,     -- The default is so unrestrictive that I wasn't even aware of it!
	framed_transients=false, -- Put transients in nested frames
	window_stacking_request="activate",
}
--------------------------------[[ DOPATH ]]-----------------------------------------
dopath("cfg_rules")
dopath("autoprop")
dopath("mod_tiling")
dopath("cfg_layouts.lua")
dopath("app")
dopath("mod_sp")
dopath("named_scratchpad")
dopath("min_tabs")
dopath("net_client_list")
dopath("directions")
dopath("mod_notionflux")
dopath("screenshot")
dopath("mod_dock")
dopath("cfg_dzen")
dopath("rofi")
dopath("cfg_autostart")
dopath("mod_xkbevents")
dopath("helpers")
dopath("cfg_kb")
dopath("mod_xrandr")
dopath("cfg_xrandr")
dopath("transparency")
dopath("dzen_bg")

notioncore.get_hook('clientwin_do_manage_alt'):add(
    function(cwin, table)
    notioncore.write_savefile("windowinfos", cwin:get_ident())
end)
