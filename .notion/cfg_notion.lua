 --_:attach_new({type="WFloatWS", layer=2}):goto()
--------------------------------[[ CONSTS ]]----------------------------------------
META="Mod1+"
--------------------------------[[ IONCORE ]]---------------------------------------

ioncore.set{
    dblclick_delay=250,
    ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2"),
    ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<..."),
    ioncore.defshortening("(.*)", "$1$|$1$<..."),
    ignore_net_active_window=false,
    float_placement_padding=2,
    warp=false,
    kbresize_delay=1000000,
    mousefocus="disabled",
    opaque_resize=true,
    switchto=true,
    unsqueeze=true,
    screen_notify=false,
    autosave_layout=false,
    autoraise=true,
	edge_resistance=200,	-- The default is so unrestrictive that I wasn't even aware of it!
}

--------------------------------[[ DOPATH ]]-----------------------------------------
dopath("mod_statusbar")
dopath("cfg_layouts.lua")
dopath("app")
dopath("mod_sp")
dopath("named_scratchpad")
dopath("mod_query")
dopath("mod_menu")
dopath("mod_tiling")
dopath("min_tabs")
dopath("bookmarks")
dopath("net_client_list")
dopath("move_current")
dopath("direction2")
dopath("dynamic_view")
-- dopath("mod_fuzzy_query")
dopath("cfg_tiling")
dopath("dbg")
dopath("mod_xrandr")
dopath("cfg_xrandr")
dopath("mod_notionflux")
dopath("sp_app")
dopath("vim_bindings")
dopath("goto-by-tag")
dopath("sp_app")

-------------------------------------[[ KLUDGES ]]----------------------------------
--[ Set all windows float ]------------------------
defwinprop{lazy_resize=true}
-------------------------------------[[ TERM ]]-------------------------------------
defwinprop{class="URxvt",instance="MainTerminal",transient_mode="off",target="term",lazy_resize=true
,ignore_max_size=false, ignore_min_size=false, ignore_aspect=false,ignore_resizeinc=true
}
defwinprop{class="URxvt",instance="mutt",transient_mode="off",target="float2",lazy_resize=true}
defwinprop{class="URxvt",instance="code",transient_mode="off",ignore_cfgrq=true, target="notes",lazy_resize=true}
defwinprop{class="yakuake",instance="*",transient_mode="off",ignore_cfgrq=true, lazy_resize=true, float=true}
-------------------------------------[[ WEB ]]---------------------------------------
defwinprop{class="Chromium",transient_mode="off",transient_mode="off",jumpto=true,target="web",lazy_resize=true}
defwinprop{class="Chromium-browser",transient_mode="off",transient_mode="off",target="web",lazy_resize=true}
defwinprop{class="Opera",instance="startupdialog",transient_mode="off",target="web",lazy_resize=true}
defwinprop{instance="opera",transient_mode="off",transient_mode="off",target="web",lazy_resize=true}
defwinprop{class="Dwb",transient_mode="off",jumpto="on",target="web",lazy_resize=true}
defwinprop{class="Firefox",role="browser",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="browser"}
defwinprop{class="Firefox",role="Manager",instance="Download",transient_mode="off",jumpto="off",target="float2",lazy_resize=true,tag="browser"}
defwinprop{class="Firefox",instance="Dialog",float=true,tag="browser"}
defwinprop{class="Firefox",instance="firefox",role="GtkFileChooserDialog",
    max_size = {w=1024,h=768},
    min_size = {w=800,h=600},
    float=true,
    tag="browser"
}
defwinprop{class="Conkeror",instance="Navigator",transient_mode="off",target="web",lazy_resize=true,tag="browser"}
defwinprop{class="Iceweasel",role="browser",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="browser"}
defwinprop{class="Vimprobable2",role="vimprobable2",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="browser"}
-------------------------------------[[ IM ]]---------------------------------------
defwinprop{instance="kopete",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="skype",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="finch",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="centerim",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="centerim",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="weechat-curses",jumpto=false,winlist_ignore=true,transient_mode="off",target="weechat",lazy_resize=true}
-------------------------------------[[ DOC ]]---------------------------------------
defwinprop{class="Okular",instance="okular",transient_mode="off",jumpto=true,target="doc",lazy_resize=true}
defwinprop{name="Open Document*",class="Okular",instance="okular",transient_mode="off",jumpto=true,target="doc",float=true,lazy_resize=true}
defwinprop{class="Apvlv",instance="apvlv",transient_mode="off",jumpto=true,target="doc",lazy_resize=true}
defwinprop{class="Zathura",instance="zathura",transient_mode="off",jumpto=true,target="doc",lazy_resize=true}
defwinprop{class="Evince",instance="evince",transient_mode="off",jumpto=true,target="doc",lazy_resize=true}
defwinprop{class="XDvi", target="doc",lazy_resize=true}
defwinprop{class="libreoffice*", instance="*", target="doc",lazy_resize=true}
defwinprop{class="Cr3", instance="cr3",target="doc",lazy_resize=true}
-------------------------------------[[ MEDIA ]]---------------------------------------
defwinprop{class="gmpc",    target="media",  lazy_resize=true}
defwinprop{class="MPlayer",  jumpto=true, transient_mode="off", target="media"}
defwinprop{class="mplayer2", jumpto=true, transient_mode="off", target="media"}
defwinprop{class="mpv",      jumpto=true, transient_mode="off", target="media"}
defwinprop{class="feh",     instance="feh",  jumpto="on", transient_mode="off", float=true,lazy_resize=true}
--defwinprop{class="Sxiv",    instance="sxiv", jumpto="off", transient_mode="off", target="media",lazy_resize=true}
-------------------------------------[[ DEV ]]--------------------------------------
defwinprop{class="Gvim",instance="gvim",target="dev",lazy_resize=true,jumpto=true,transient_mode="off",transparent=false,
-- ignore_max_size=false, ignore_min_size=false, ignore_aspect=true,ignore_resizeinc=true
}
defwinprop{class="URxvt",instance="wim",target="dev",lazy_resize=true,jumpto=true,transient_mode="off",transparent=false,
-- ignore_max_size=false, ignore_min_size=false, ignore_aspect=true,ignore_resizeinc=true
}
defwinprop{class="Qvim",instance="qvim",target="dev",lazy_resize=true,jumpto=true,transient_mode="off",
    -- max_size = {w=1584,h=864},
    -- min_size = {w=1584,h=864},
    -- float=true
ignore_max_size=false, ignore_min_size=false, ignore_aspect=false,ignore_resizeinc=true
}
defwinprop{class="Emacs",instance="emacs",target="dev",lazyresize=true,jumpto=true}
defwinprop{class="Emacs",instance="emacs",name="Question",float=true}
-------------------------------------[[ VM ]]--------------------------------------
defwinprop{class="vmware",instance="Vmware" ,jumpto=true,transient_mode="off", float=true,target="vm"}
defwinprop{class="VirtualBox", jumpto=false,target="vm",transient_mode="off",lazy_resize=true}
defwinprop{class="Vmware", jumpto=false,target="vm",transient_mode="on",lazy_resize=true}
defwinprop{class="QEMU", jumpto=false,target="vm",transient_mode="on",lazy_resize=true}
-------------------------------------[[   GIMP  ]]-----------------------------
defwinprop{class = "Gimp",acrobatic = true}
-- defwinprop{class="Gimp",instance="gimp",jumpto=true,role="gimp-image-window",transient_mode="off",target="g-win"}
--
-- defwinprop{class="Gimp",instance="gimp",jumpto=true,role="gimp-file-open",transient_mode="off",target="g-win",float=true}
-- defwinprop{class="Gimp",instance="gimp",jumpto=true,role="gimp-file-save",transient_mode="off",target="g-win",float=true}
-- defwinprop{class="Gimp",instance="gimp",jumpto=true,role="gimp-message-dialog",transient_mode="off",target="g-win",float=true}
-- defwinprop{class="Gimp",instance="gimp",jumpto=true,role="gimp-image-new",transient_mode="off",target="g-win",float=true}
-- defwinprop{class="Gimp",instance="gimp",jumpto=true,role="gimp-toolbox-color-dialog",transient_mode="off",target="g-win",float=true}
--
-- defwinprop{class="Gimp",instance="gimp",role="gimp-toolbox",transient_mode="on",target="g-right-b",acrobatic = true}
-- defwinprop{class="Gimp",instance="gimp",role="gimp-*tool",transient_mode="on",target="g-right-b",acrobatic = true}
-------------------------------------[[ TRAY'n'DOCK ]]------------------------------
--defwinprop{is_dockapp = true,statusbar = "systray",
           --max_size = {w=8,h=8},
           --min_size = {w=8,h=8},
--}
--defwinprop{class="dzen", statusbar="systray"}
-- defwinprop{class="Avant-window-navigator",target="*dock*"}
--defwinprop{is_dockapp=true,target="*dock*"}
defwinprop{class = "stalonetray", instance = "stalonetray", statusbar="systray_stalone"} 
defwinprop{instance = "stalonetray", statusbar="systray_stalone"} 
defwinprop{class = "stalonetray", statusbar="systray_stalone"} 
defwinprop{is_dockapp = true, statusbar="systray_stalone"}
-------------------------------------[[  ETC  ]]-------------------------------------
defwinprop{class="Xfce*",float=true,lazy_resize=true}
defwinprop{class="Xmessage",float=true,lazy_resize=true}
defwinprop{class="com-sun-javaws-Main",float=true,lazy_resize=true}
--defwinprop{class="Wine",float=true,lazy_resize=true,target="wine"}
defwinprop{instance="recoll",jumpto=false,winlist_ignore=true,target="search",lazy_resize=true}
defwinprop{instance="stardict",jumpto=true,winlist_ignore=true,transient_mode="off",winlist_ignore=true,target="float",lazy_resize=true}
defwinprop{instance="lxappearance",jumpto=true,winlist_ignore=true,transient_mode="off",winlist_ignore=true,target="float",lazy_resize=true}
defwinprop{class="rdesktop",instance="rdesktop",transient_mode="off",jumpto=true,target="rdesktop",lazy_resize=true}
defwinprop{class="Conky",winlist_ignore=true,instance="Conky",target="conky",lazy_resize=true}
defwinprop{class="Ktorrent",winlist_ignore=true,transient_mode="off",instance="ktorrent",target="torrent",lazy_resize=true}
defwinprop{class="URxvt", instance="mpd-pad",winlist_ignore=true,transient_mode="off",target="ncmpcpp",lazy_resize=true}
defwinprop{class="URxvt", instance="mpd-pad2",winlist_ignore=true,transient_mode="off",target="ncmpcpp",lazy_resize=true}
defwinprop{class="Pavucontrol", instance="pavucontrol",winlist_ignore=true,transient_mode="off",target="float",lazy_resize=true}
defwinprop{instance="wicd", winlist_ignore=true,transient_mode="off",target="wicd",lazy_resize=true}
defwinprop{instance="ranger", winlist_ignore=true,transient_mode="off",target="ranger",lazy_resize=true}
defwinprop{instance="mixer",winlist_ignore=true,transient_mode="off",target="alsa",lazy_resize=true}
defwinprop{instance="htop", winlist_ignore=true,transient_mode="off",target="top",lazy_resize=true}
defwinprop{instance="gcolor2", winlist_ignore=true,transient_mode="off",lazy_resize=true,float=true}
defwinprop{instance="gpick", winlist_ignore=true,transient_mode="off",lazy_resize=true,target=float}
defwinprop{class="Vuze", winlist_ignore=true,transient_mode="off",target="torrent",lazy_resize=true}
defwinprop{class="Anamnesis", winlist_ignore=true,transient_mode="off",target="float2",lazy_resize=true,jumpto=true}
defwinprop{class="*",instance="*", transparent=false,lazy_resize=true}
-- defwinprop{class="*",instance="*", winlist_ignore=true,transient_mode="off",target="etc",float=true,lazy_resize=true}
-------------------------------------------------------------------------------------
--[  KEY BINDINGS   ]------------------------------
---------------------
-- local vmtable={class="vmware",instance="Vmware"}

defbindings("WMPlex.toplevel", {
    --kpress("Shift_R",        "mod_sp.set_shown(ioncore.lookup_region(_:name(),'WFrame'),'unset' )"),
    kpress("Mod4+slash",       "ioncore.goto_previous()"),
    kpress("Mod1+Tab",         "ioncore.goto_previous()"),
    kpress("Mod1+space",       "nop()"),
    kpress("Mod1+grave",       "mod_query.query_exec(_)"),
    kpress("Mod4+Shift+grave", "mod_query.query_lua(_)"),
    -- kpress("Mod4+space",       "named_scratchpad(_, 'misc')"),
    -- kpress("Mod1+G",           "mod_query.query_fuzzy_gotoclient(_)"),
    kpress("Mod1+G",           "mod_menu.menu(_, _sub, 'windowlist')"),
    -- kpress("Mod1+G",           "mod_query.query_gotoclient(_)"),

    kpress("Mod4+G",           "mod_menu.menu(_, _sub, 'workspacelist')"),
    -- kpress("Mod4+3",           "named_scratchpad(_, 'ranger')"),
    -- kpress("Mod4+4",           "sp_app(_, 'vmware', vmtable)"),
    -- kpress("Mod4+4",           "sp_app.toggle(_,'urxvt -tr -name testme',{name=\"ranger\",class=\"URxvt\",instance=\"testme\"})"),

    kpress("Mod4+Control+G",   "mod_query.query_workspace(_)"),
    --kpress("Mod1+Control+G", "mod_query.query_gotoclient(_)"),

    kpress("Mod4+M",           "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),
    kpress("Mod4+Shift+D", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),

-------------------------------------------------------------------------------------
--[[ SCRATCHPADS  ]]--------------------------------
--------------------
    --kpress("Mod4+F1",      "named_scratchpad(_, 'littleterm')"),
    --kpress("Mod4+Prior",   "named_scratchpad(_, 'volume')"),
    kpress("Mod4+d",         "named_scratchpad(_, 'float')"),
    kpress("Mod4+p",         "named_scratchpad(_, 'float2')"),
    kpress("Mod1+p",         "named_scratchpad(_, 'torrent')"),
    -- kpress("Mod4+F",      "named_scratchpad(_, 'ncmpcpp')"),
    kpress("Mod4+F",         "ncmpcpp(_)"),
    kpress("Mod4+E",         "named_scratchpad(_, 'im')"),
    kpress("Mod4+Control+9", "named_scratchpad(_, 'wicd')"),
    kpress("Mod4+Control+2", "named_scratchpad(_, 'alsa')"),
    kpress("Mod4+Control+4", "named_scratchpad(_, 'etc')"),
-------------------------------------------------------------------------------------
--[[  PLAYER CONTROL ]]---------------------------------
-----------------------
    kpress("XF86AudioPrev",        "ioncore.exec_on(_, 'mpc prev')"),
    kpress("XF86AudioNext",        "ioncore.exec_on(_, 'mpc next')"),
    kpress("XF86AudioPlay",        "ioncore.exec_on(_, 'mpc toggle')"),
    kpress("XF86AudioStop",      "ioncore.exec_on(_, 'mpc stop')"),
    kpress("XF86AudioLowerVolume", "ioncore.exec_on(_, 'mpc volume -5')"),
    kpress("XF86AudioRaiseVolume", "ioncore.exec_on(_, 'mpc volume +5')"),
    kpress("Mod4+Control+T",       "ioncore.exec_on(_, 'dipser -S')"),
    kpress("Mod4+8",               "ioncore.exec_on(_, 'amixer -q set Master 0% mute')"),
    kpress("Mod4+8+Shift",         "ioncore.exec_on(_, 'amixer -q set Master 100% unmute ')"),

    --kpress("Mod4+Shift+Z",       "ioncore.exec_on(_, 'amixer -c0 sset -q Master 5-')"),
    --kpress("Mod4+Shift+X",       "ioncore.exec_on(_, 'amixer -c0 sset -q Master 5+')"),
    submap("Mod4+Control+R", {
        kpress("t", "ioncore.exec_on(_, 'xcalib -c')"),
        kpress("i", "ioncore.exec_on(_, 'xcalib -alter -invert')"),
        kpress("r", "ioncore.exec_on(_, 'xcalib -red 0.1 0.0 1 -a')"),
    }),

-------------------------------------------------------------------------------------
--[[ RESTART ]]----------------------------------------
---------------
    kpress("Mod4+apostrophe", "ioncore.restart()"),
-------------------------------------------------------------------------------------
--[[ SLEEP ]]-----------------------------------------
-------------
    kpress("XF86Sleep", "ioncore.exec_on(_, 'sudo pm-suspend')"),
    -- kpress("Alt_R+l", "ioncore.exec_on(_, '')"),
    --kpress("XF86Sleep", "ioncore.exec_on(_, 'sudo hibernate-ram')"),
    --kpress("Mod4+Control+Shift+u", "ioncore.exec_on(_, 'sudo /usr/sbin/hibernate-ram')"),
-------------------------------------------------------------------------------------
--[[  PROGS RUN by APP  ]]-----------------------------
--------------------------
    kpress("Mod4+1", "app.byinstance('~/bin/wim', 'URxvt', 'wim')"),
    --kpress("Help", "ioncore.exec_on(_, 'urxvt -fn xft:terminus -e ncmpcpp')"),
    --kpress("Mod1+Control+a", "app.byinstance('~/bin/virt.sh', 'VirtualBox')"),
    kpress("Mod1+Control+a", "app.byinstance('', 'Vmware')"),
    --kpress("Mod4+b", "app.byclass('', 'MPlayer')"),
    --kpress("Mod4+b", "app.byclass('', 'mplayer2')"),
    kpress("Mod4+b", "app.byclass('', 'mpv')"),
    kpress("Mod4+x", "app.byinstance('~/bin/urxvt', 'URxvt','MainTerminal')"),
    -- kpress("Mod4+w", "app.byinstance('dwb', 'Dwb','dwb')"),
    kpress("Mod4+w", "app.byinstance('firefox', 'Firefox','Navigator')"),
    -- kpress("Mod4+w", "app.byinstance('icecat', 'Firefox','Navigator')"),
    --kpress("Mod4+w", "app.byclass('firefox', 'Iceweasel')"),
    --kpress("Mod4+w", "app.byclass('chromium', 'Chromium')"),
    --kpress("Mod4+w", "app.byclass('chromium-browser', 'Chromium-browser')"),
    --kpress("Mod4+w", "app.byclass('conkeror','Conkeror')"),
    --kpress("Mod4+o", "app.byinstance('evince', 'Evince','evince')"),
    --kpress("Mod4+o", "app.byclass('okular', 'Okular')"),
    kpress("Mod4+o", "app.byclass('zathura','Zathura')"),
    -- kpress("Mod4+1", "app.byclass('gvim', 'Gvim')"),
    kpress("Mod4+Control+C", "app.byclass('~/bin/sx /home/neg/dw/', 'Sxiv')"),
    --kpress("Mod4+e", "app.byclass('kopete', 'Kopete')"),
    --kpress("Mod4+Control+R", "app.byclass('skype', 'Skype')"),
    --kpress("Mod4+f", "app.byinstance('mpd-pad')"),
-------------------------------------------------------------------------------------
--[[  MISC  ]]---------------------------------------
--------------
    kpress("Mod4+Control+Q", "WRegion.rqclose_propagate(_, _sub)"),
    kpress("Mod4+F4",        "ioncore.exec_on(_, 'eject')"),
    -- kpress("Mod4+Control+P", "ioncore.exec_on(_, 'anamnesis --browser')"),
    kpress("Mod4+U",         "ioncore.exec_on(_, 'udiskie-umount -a')"),
    kpress("Mod4+Shift+F",   "app.byinstance('lowriter', 'VCLSalFrame', 'libreoffice-writer')"),
    -- kpress("Mod4+Shift+F",   "app.class('libreoffice-writer', '')"),
    -- kpress("Mod4+F12",       "ioncore.exec_on(_, 'switch-sound-output.sh')"),
    --kpress("Mod4+F6",        "ioncore.exec_on(_, '~/bin/misc/music')"),
    -- Rename frame --
    kpress("Mod4+c",        "ioncore.exec_on(_, 'ruby ~/bin/clipd.rb menu')"),
    submap("Mod1+E",{
        kpress("p", "ioncore.exec_on(_, 'pavucontrol')"),
        kpress("r", "mod_query.query_renameframe(_)"),
        kpress("t", "ioncore.exec_on(_, 'urxvt')"),
        kpress("v", "ioncore.exec_on(_, 'vmware')"),
        kpress("m", "app.byinstance('~/bin/term/mutt', 'URxvt', 'mutt')"),
        kpress("s", "ioncore.exec_on(_, 'skype')"),
        kpress("q", "ioncore.exec_on(_, '~/bin/mpd_sel.sh')"),
        kpress("i", "ioncore.exec_on(_, '~/bin/pls -output')"),
        kpress("o", "ioncore.exec_on(_, '~/bin/pls -sink')"),
        kpress("Shift+o", "ioncore.exec_on(_, '~/bin/pls -vol')"),
        --kpress("t", "ioncore.exec_on(_, '~/bin/chat')"),
        --kpress("r", "ioncore.exec_on(_, '~/bin/term')"),
        kpress("Control+r", "app.byinstance('cr3', 'Cr3', 'cr3')"),
        kpress("Shift+r", "app.byinstance('~/bin/term/ranger', 'URxvt', 'Ranger')"),
        kpress("Shift+k", "ioncore.exec_on(_, 'keynav')"),
    }),
----------------------------[[ TRANPARENCY  ]]---------------------------------
--  submap("Mod4+J", {
--      kpress("j", "ioncore.exec_on(_, 'transset-df 0.9 ')"),
--      kpress("t", "ioncore.exec_on(_, 'transset-df 1   ')"),
--  }),
})

-------------------------------------------------------------------------------------
--[[  MENU  ]]---------------------------------------
--------------
defbindings("WMenu", {
    kpress("Escape",    "WMenu.cancel(_)"), kpress("Control+G", "WMenu.cancel(_)"),
    kpress("Return",    "WMenu.finish(_)"), kpress("Control+M", "WMenu.finish(_)"),
    kpress("Control+N", "WMenu.select_next(_)"),
    kpress("Control+P", "WMenu.select_prev(_)"),
    kpress("Down",      "WMenu.select_next(_)"),
    kpress("Up",        "WMenu.select_prev(_)"),
    --Clear the menu's typeahead find buffer
    kpress("BackSpace", "WMenu.typeahead_clear(_)"),
    kpress("Control+H", "WMenu.typeahead_clear(_)"),

})
defbindings("WScreen", {
    -- kpress("Mod4+F3",        "_:attach_new({type='WGroupWS'})"),
    kpress("Mod4+F3",           "_:attach_new({type='WTiling', name='Instant Messaging'}):goto()"),
    submap("Mod1+E", {
            kpress("I", "ioncore.goto_activity()"),
            kpress("T", "ioncore.tagged_clear()"),
            kpress("K", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
            }),

    --kpress("Mod4+u","attach_new({type="WTiling", name="Instant Messaging"}):goto()"),
    submap(META.."E", {
        kpress("I", "ioncore.goto_activity()"),
        kpress("T", "ioncore.tagged_clear()"),
    }),
    kpress("Mod4+Shift+1", "ioncore.goto_nth_screen(0)"),
    kpress("Mod4+Shift+2", "ioncore.goto_nth_screen(1)"),
    kpress("Mod4+Shift+comma", "ioncore.goto_prev_screen()"),
    kpress("Mod4+Shift+period", "ioncore.goto_next_screen()"),
    --Display the main menu.
    --kpress("F12", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"),
    mpress("Button3", "mod_menu.pmenu(_, _sub, 'mainmenu')"),
    --Display the window list menu
    mpress("Button2", "mod_menu.pmenu(_, _sub, 'windowlist')"),
    submap("Mod1+E", {
        --Backward-circulate focus
        --kpress("AnyModifier+Tab", "ioncore.goto_next(_chld, 'left')", "_chld:non-nil"),
        --Raise focused object, if possible
        -- kpress("AnyModifier+E", "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
        kpress("AnyModifier+L", "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
        kpress("AnyModifier+Shift+L", "WRegion.rqorder(_chld, 'back')","_chld:non-nil"),
    }),
    -- kpress("Mod1+Shift+s","WRegion.rqorder(_chld, 'front')","_chld:non-nil"),

    kpress("F12", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"),
    kpress("Mod4+grave", "ioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
    kpress("Mod1+grave", "mod_query.query_exec(_)"),

--  kpress("KP_6", "MusicPD.next()"),
--  kpress("KP_4", "MusicPD.previous()"),
--  kpress("KP_2", "MusicPD.volume_down()"),
--  kpress("KP_8", "MusicPD.volume_up()"),
--  kpress("KP_5", "MusicPD.toggle_play()"),
--  kpress("KP_7", "MusicPD.toggle_repeat()"),
--  kpress("KP_9", "MusicPD.toggle_random()"),
    ---------------------------------------------------------
    kpress("Mod4+H", "_chld:focus_direction('left')", "_chld:non-nil"),
    kpress("Mod4+J", "_chld:focus_direction('down')", "_chld:non-nil"),
    kpress("Mod4+K", "_chld:focus_direction('up')", "_chld:non-nil"),
    kpress("Mod4+L", "_chld:focus_direction('right')", "_chld:non-nil"),
    ---------------------------------------------------------
})

defbindings("WClientWin", {
    submap("Mod1+E", {
        kpress("C", "WklientWin.kill(_)"),}),
        kpress("Mod1+comma", " WClientWin.quote_next(_)"),
})

defbindings("WGroupCW", {
    kpress_wait("Mod4+Return", "WGroup.set_fullscreen(_, 'toggle')"),
    kpress_wait("Mod4+Q", "WGroup.set_fullscreen(_, 'toggle')"),
})
defbindings("WMPlex",{
    submap(META.."E",{kpress_wait("Q", "WRegion.rqclose_propagate(_, _sub)"),}),
    --kpress_wait("Mod4+N", "WClientWin.nudge(_sub)", "_sub:WClientWin"),
})
-- Frames for transient windows ignore this bindmap
defbindings("WFrame", {
    kpress( "Mod4+S","mod_sp.set_shown(ioncore.lookup_region(_:name(), 'WFrame'), 'unset' )" ),
    -- kpress( "Mod4+S","mod_sp.set_shown(ioncore.lookup_region(_:name(), 'WGroupWS'), 'unset' )" ),
    submap("Mod1+E", {
      kpress("H", "WFrame.maximize_horiz(_)"),
      kpress("V", "WFrame.maximize_vert(_)"),
    }),
    --mpress("Button3", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),
    kpress("Mod4+R", "WFrame.begin_kbresize(_)"),
    mclick("Button1@tab", "WFrame.p_switch_tab(_)"), mclick("Button2@tab", "WFrame.p_switch_tab(_)"),
    mdrag("Button1@border", "WFrame.p_resize(_)"),   mdrag(META.."Button3", "WFrame.p_resize(_)"),
    mdrag("Mod1+Button1", "WFrame.p_move(_)"),
    mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),     mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
    kpress("Mod1+L", "WRegion.rqorder(_, 'back')" ),
    kpress("Mod1+U", "WRegion.rqorder(_, 'front')" ),
})

-- Frames for transient windows ignore this bindmap
defbindings("WFrame.toplevel", {
    kpress("Mod4+A", "mod_query.query_attachclient(_)"),
    kpress("Mod4+backslash", "WFrame.switch_next(_)"),
    --kpress("Mod4+V", "WFrame.switch_next(_)"),
    kpress("Mod1+A", "ioncore.tagged_attach(_)"),
    submap("Mod1+E", {
        -- submap_wait("ioncore.tabnum.show(_)"),
        -- kpress("Q", "WFrame.switch_nth(_, 0)"), kpress("W", "WFrame.switch_nth(_, 1)"),
        -- kpress("E", "WFrame.switch_nth(_, 2)"), kpress("A", "WFrame.switch_nth(_, 3)"),
        -- kpress("S", "WFrame.switch_nth(_, 4)"), kpress("D", "WFrame.switch_nth(_, 5)"),
        -- kpress("Z", "WFrame.switch_nth(_, 6)"), kpress("X", "WFrame.switch_nth(_, 7)"),
        -- kpress("C", "WFrame.switch_nth(_, 8)"),
        --Maximize the frame horizontally/vertically
        kpress("H", "WFrame.maximize_horiz(_)"),
        kpress("V", "WFrame.maximize_vert(_)"),
    }),
})
-- Bindings for floating frames.
defbindings("WFrame.floating", {
    mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
    mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
    mclick(META.."Button1", "WRegion.rqorder(_, 'front')"),
    mclick(META.."Button3", "WRegion.rqorder(_, 'back')"),
    kpress("Mod1+L", "WRegion.rqorder(_, 'back')" ),
    kpress("Mod1+U", "WRegion.rqorder(_, 'front')" ),
    mdrag("Button1@tab", "WFrame.p_move(_)"),
    --mdblclick("Button1@tab", "WFrame.set_shaded(_, 'toggle')"),
    ---------------------------------------------------------
    kpress("Mod1+Control+H", "_:push_direction('left')"),
    kpress("Mod1+Control+J", "_:push_direction('down')"),
    kpress("Mod1+Control+K", "_:push_direction('up')"),
    kpress("Mod1+Control+L", "_:push_direction('right')"),
    kpress("Mod1+Control+F", "_:maximize_fill_toggle('vh')"),
    kpress("Mod1+Control+V", "_:maximize_fill_toggle('vert')"),
    ---------------------------------------------------------
})
defbindings("WMoveresMode", {
    kpress("AnyModifier+Escape", "WMoveresMode.cancel(_)"),
    kpress("AnyModifier+Return", "WMoveresMode.finish(_)"),

    kpress("Left",               "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("Right",              "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",                 "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("Down",               "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    kpress("h",               "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("l",              "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("k",                 "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("j",               "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    kpress("Shift+Left",         "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+Right",        "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+Up",           "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+Down",         "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    kpress("Shift+h",         "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+l",        "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+k",           "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+j",         "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    kpress("Mod1+Left",          "WMoveresMode.move(_,-1, 0)"),
    kpress("Mod1+Right",         "WMoveresMode.move(_, 1, 0)"),
    kpress("Mod1+Up",            "WMoveresMode.move(_, 0,-1)"),
    kpress("Mod1+Down",          "WMoveresMode.move(_, 0, 1)"),
})
--------------------------------------------------------------------------------------------
---------------------------  [[ Tiling  ]]  ------------------------------------
defbindings("WTiling", {
    --Split current frame vertically
    --kpress(META.."S", "WTiling.split_at(_, _sub,'bottom', true)"),
    kpress("Mod4+Down", "ioncore.goto_next(_sub, 'down',  {no_ascend=_})"),
    kpress("Mod4+Up",   "ioncore.goto_next(_sub, 'up',    {no_ascend=_})"),
    kpress("Mod4+Left", "ioncore.goto_next(_sub, 'left',  {no_ascend=_})"),
    kpress("Mod4+Right","ioncore.goto_next(_sub, 'right', {no_ascend=_})"),
    kpress("Mod4+j",    "ioncore.goto_next(_sub, 'down',  {no_ascend=_})"),
    kpress("Mod4+k",    "ioncore.goto_next(_sub, 'up',    {no_ascend=_})"),
    kpress("Mod4+h",    "ioncore.goto_next(_sub, 'left',  {no_ascend=_})"),
    kpress("Mod4+l",    "ioncore.goto_next(_sub, 'right', {no_ascend=_})"),
    --kpress("Mod1+Tab",  "ioncore.goto_next(_sub, 'right')"),
    --submap("Mod4+s",{
    kpress("Mod4+Control+H", "WTiling.split_at(_, _sub, 'right', true)"),
    kpress("Mod4+Control+L", "WTiling.split_at(_, _sub, 'left', true)"),
    kpress("Mod4+Control+K", "WTiling.split_at(_, _sub, 'bottom', true)"),
    kpress("Mod4+Control+J", "WTiling.split_at(_, _sub, 'top', true)"),
    kpress("Mod4+2", "WTiling.transpose_at(_, _sub)"),
    kpress("Mod4+3", "WTiling.flip_at(_, _sub)"),
    --Destroy current frame
    kpress("Mod4+Control+X", "WTiling.unsplit_at(_, _sub)"),
    kpress("Mod4+Control+W", function(ws) move_current.move(ws, "up") end),
    kpress("Mod4+Control+S", function(ws) move_current.move(ws, "down") end),
    kpress("Mod4+Control+A", function(ws) move_current.move(ws, "left") end),
    kpress("Mod4+Control+D", function(ws) move_current.move(ws, "right") end),
    --})
})
-- Frame bindings
defbindings("WFrame.floating", {
    submap(META.."E", { kpress("B", "mod_tiling.mkbottom(_)"), }),
})


defctxmenu("WFrame.floating", "Floating frame", {
    append=true,
    menuentry("New tiling", "mod_tiling.mkbottom(_)"),
})

defmenu("menuattach", {
    -- _:attach_new(ioncore.getlayout("default")) -- works
    menuentry("Float WS", "_:attach_new({type=\"WGroupWS\", switchto=true})"),
    menuentry("Tiling WS", "_:attach_new({type=\"WGroupWS\", switchto=true}):attach_new({type=\"WTiling\", sizepolicy=\"full\", bottom=true})"),
})

function ncmpcpp(ws)
    ioncore.exec_on(ws, '/home/neg/bin/msc')
    named_scratchpad(ws, 'ncmpcpp')
end

function nop()
end
