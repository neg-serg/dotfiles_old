notioncore.set{
    dblclick_delay=250,
    
    notioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    notioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    notioncore.defshortening("[^:]+: (.*)", "$1$|$1$<..."),
    notioncore.defshortening("(.*)", "$1$|$1$<..."),
    notioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2"),
    notioncore.defshortening("(.*) - Mozilla", "$1$|$1$<..."),
    notioncore.defshortening("XMMS - (.*)", "$1$|...$>$1"),

    ignore_net_active_window=true,      -- ignore _NET_ACTIVE_WINDOW request
    float_placement_padding=2,          -- Pixels between frames
    warp=false,                         -- Move pointer while you focus reg
    kbresize_delay=1000000,             -- Resize region delay
    mousefocus="disabled",              -- Do not use mouse focus
    opaque_resize=true,                 -- Draw window while resize
    switchto=true,                      -- Switch to new apps by default
    unsqueeze=true,                     -- Unsqueeze transients/menus/queries/etc
    screen_notify=true,                 -- Use actnotify for urgent windows 
    autosave_layout=false,              -- Do not autosave layout state
    autoraise=true,                     -- Autoraise regions in groups on goto.
	edge_resistance=200,                -- The default is so unrestrictive that I wasn't even aware of it!
	framed_transients=true,             -- Put transients in nested frames
	window_stacking_request="activate", -- Activate after window stacking request
}
