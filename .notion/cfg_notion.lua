--------------------------------[[ CONSTS ]]----------------------------------------
META="Mod1+"
function dzen_delete()
    os.execute("pkill dzen2")
    os.execute("pkill rofi")
    os.execute("pkill -f \'lua /home/neg/.notion/mpd_dzen.lua\'")
end

hook_deinit = ioncore.get_hook("ioncore_deinit_hook")
local hook_deinit = ioncore.get_hook("ioncore_deinit_hook")
if hook_deinit then
    hook_deinit:add(dzen_delete)
end
dzen_pipe = io.popen("dzen2 -dock -bg '#000000' -h 19 -tw 0 -x 0 -ta l -w 1000 -p -fn 'PragmataPro for Powerline:style=bold:size=12' ", "w")
dzen_pipe:setvbuf("line")
--------------------------------[[ IONCORE ]]---------------------------------------
ioncore.set{
    dblclick_delay=250,
    ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<..."),
    ioncore.defshortening("(.*)", "$1$|$1$<..."),
    ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2"),
    ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<..."),
    ioncore.defshortening("XMMS - (.*)", "$1$|...$>$1"),
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
    autoraise=true,
	edge_resistance=200,	-- The default is so unrestrictive that I wasn't even aware of it!
	framed_transients=true,
}
--------------------------------[[ DOPATH ]]-----------------------------------------
dopath("cfg_rules")
dopath("mod_tiling")
dopath("cfg_layouts.lua")
dopath("app")
dopath("mod_sp")
dopath("named_scratchpad")
dopath("min_tabs")
dopath("net_client_list")
dopath("move_current")
dopath("directions")
dopath("mod_notionflux")
dopath("screenshot")
dopath("mod_dock")
dopath("cfg_dzen")
dopath("rofi_goto")
dopath("cfg_autostart")
dopath("mod_xkbevents")
dopath("helpers")
dopath("cfg_kb")
dopath("mod_xrandr")
dopath("cfg_xrandr")
dopath("transparency")

ioncore.get_hook('clientwin_do_manage_alt'):add(
    function(cwin, table)
    ioncore.write_savefile("windowinfos", cwin:get_ident())
end)
