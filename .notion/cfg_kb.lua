Neg_kb = {}

Neg_kb.WMPlex_toplevel = {
    ---------------------
    -- WMPlex toplevel --
    ---------------------
    kpress("Mod4+slash",       "ioncore.goto_previous()"),
    kpress("Mod1+Tab",         "ioncore.goto_previous()"),
    kpress("Mod1+space",       "nop()"),
    kpress("Mod4+F2", "repl(_)"),

    kpress("Mod4+Shift+D", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),

    -------------------------------------------------------------------------------------
    --[[ SCRATCHPADS  ]]--------------------------------
    --------------------
    kpress("Mod4+d",         "console(_)"),
    kpress("Mod4+p",         "named_scratchpad(_, 'float2')"),
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
    kpress("XF86AudioStop",        "ioncore.exec_on(_, 'mpc stop')"),
    kpress("XF86AudioLowerVolume", "ioncore.exec_on(_, 'mpc volume -1')"),
    kpress("XF86AudioRaiseVolume", "ioncore.exec_on(_, 'mpc volume +1')"),
    kpress("Mod4+Control+T",       "ioncore.exec_on(_, 'dipser -S')"),
    kpress("Mod4+8",               "ioncore.exec_on(_, 'mpc volume 0 || amixer -q set Master 0% mute')"),
    kpress("Mod4+8+Shift",         "ioncore.exec_on(_, 'mpc volume 100 || amixer -q set Master 100% unmute ')"),
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
    kpress("Mod4+Control+Shift+u", "ioncore.exec_on(_, 'sudo systemctl suspend')"),
    -------------------------------------------------------------------------------------
    --[[  PROGS RUN by APP  ]]-----------------------------
    --------------------------
    kpress("Mod4+1", "app.byinstance('~/bin/wim', 'URxvt', 'wim')"),
    kpress("Mod4+x", "app.byinstance('~/bin/urxvt', 'URxvt','MainTerminal')"),
    kpress("Mod4+Control+a", "app.byclass_withtag(nil, 'Vmware',nil, 'virt')"),
    kpress("Mod4+b", "app.byclass_withtag(nil, 'mpv',nil, 'video')"),
    kpress("Mod4+w", "app.byinstance_withtag('/usr/lib/firefox/firefox', 'Firefox','Navigator',nil,'www')"),
    kpress("Mod4+o", "app.byclass_withtag('zathura','Zathura','pdf')"),
    kpress("Mod4+Control+C", "app.byclass('~/bin/sx /home/neg/dw/', 'Sxiv')"),
    -------------------------------------------------------------------------------------
    --[[  MISC  ]]---------------------------------------
    --------------
    kpress("Mod4+Control+Q", "WRegion.rqclose_propagate(_, _sub)"),
    kpress("Mod4+U",         "ioncore.exec_on(_, 'udiskie-umount -a')"),
    kpress("Mod3+M",         "ioncore.exec_on(_, '~/bin/scripts/rofi_xprop')"),
    kpress("Mod4+Shift+U",   "ioncore.exec_on(_, 'eject')"),
    kpress("Mod4+Shift+F",   "app.byinstance('lowriter', 'VCLSalFrame', 'libreoffice-writer')"),
    -- Rename frame --
    kpress("Mod4+c",        "ioncore.exec_on(_, 'sh ~/bin/clip')"),
    submap("Mod1+E",{
        kpress("p", "ioncore.exec_on(_, 'pavucontrol')"),
        kpress("d", "ioncore.exec_on(_, 'stardict')"),
        kpress("Shift+t", "ioncore.exec_on(_, '~/bin/scripts/toggle_stalonetray')"),
        kpress("t", "ioncore.exec_on(_, 'urxvt')"),
        kpress("v", "ioncore.exec_on(_, 'vmware')"),
        kpress("m", "app.byinstance('~/bin/term/mutt', 'URxvt', 'mutt')"),
        kpress("s", "ioncore.exec_on(_, 'skype')"),
        kpress("q", "ioncore.exec_on(_, '~/bin/mpd_sel.sh')"),
        kpress("i", "ioncore.exec_on(_, '~/bin/pls -output')"),
        kpress("o", "ioncore.exec_on(_, '~/bin/pls -sink')"),
        kpress("w", "ioncore.exec_on(_, '~/bin/webcam')"),
        kpress("n", "app.byinstance('nicotine.py || nicotine', 'Nicotine.py', 'nicotine.py')"),
        kpress("Shift+o", "ioncore.exec_on(_, '~/bin/pls -vol')"),
        kpress("Shift+d", "ioncore.exec_on(_, '~/bin/scripts/exec_demo.sh')"),
        kpress("Control+r", "app.byinstance('cr3', 'Cr3', 'cr3')"),
        kpress("Shift+r", "ranger(_)"),
        kpress("Shift+g", "gdb(_)"),
        kpress("l", "radare2(_)"),
        kpress("Shift+k", "ioncore.exec_on(_, '~/bin/scripts/toggle_keynav')"),
    }),
}

Neg_kb.WScreen = {
    submap("Mod1+E", {
            kpress("I", "ioncore.goto_activity()"),
            kpress("T", "ioncore.tagged_clear()"),
            }),
    kpress("Mod4+Shift+1", "ioncore.goto_nth_screen(0)"),
    kpress("Mod4+Shift+2", "ioncore.goto_nth_screen(1)"),
    kpress("Mod4+Shift+comma", "ioncore.goto_prev_screen()"),
    kpress("Mod4+Shift+period", "ioncore.goto_next_screen()"),
    submap("Mod1+E", {
        kpress("AnyModifier+L", "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
        kpress("AnyModifier+Shift+L", "WRegion.rqorder(_chld, 'back')","_chld:non-nil"),
    }),
    kpress("Mod4+grave", "ioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
    ---------------------------------------------------------
    kpress("Mod4+H", "_chld:focus_direction('left')", "_chld:non-nil"),
    kpress("Mod4+J", "_chld:focus_direction('down')", "_chld:non-nil"),
    kpress("Mod4+K", "_chld:focus_direction('up')", "_chld:non-nil"),
    kpress("Mod4+L", "_chld:focus_direction('right')", "_chld:non-nil"),
    ---------------------------------------------------------
    -- Screenshots
    kpress("Print", "make_root_screenshot()"),
    kpress("Mod1+Print", "make_current_window_screenshot()"),
}

Neg_kb.WClientWin = {
    submap("Mod1+E", {
        kpress("C", "WklientWin.kill(_)"),}),
        kpress("Mod1+comma", " WClientWin.quote_next(_)"),
}

Neg_kb.WGroupCW = {
    kpress_wait("Mod4+Q", "WGroup.set_fullscreen(_, 'toggle')"),
}

Neg_kb.WMPlex = {
    submap(META.."E",{kpress_wait("Q", "WRegion.rqclose_propagate(_, _sub)"),}),
}

Neg_kb.WFrame = {
    kpress("Mod4+S","mod_sp.set_shown(ioncore.lookup_region(_:name(), 'WFrame'), 'unset' )" ),
    submap("Mod1+E", {
      kpress("H", "WFrame.maximize_horiz(_)"),
      kpress("V", "WFrame.maximize_vert(_)"),
    }),
    kpress("Mod4+R", "WFrame.begin_kbresize(_)"),
    mclick("Button1@tab", "WFrame.p_switch_tab(_)"), mclick("Button2@tab", "WFrame.p_switch_tab(_)"),
    mdrag("Button1@border", "WFrame.p_resize(_)"),   mdrag(META.."Button3", "WFrame.p_resize(_)"),
    mdrag("Mod1+Button1", "WFrame.p_move(_)"),
    mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),     mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
    kpress("Mod1+U", "WRegion.rqorder(_, 'front')" ),
}

Neg_kb.WFrame_toplevel = {
    kpress("Mod4+A", "rofi_attach_win(_)"),
    kpress("Mod4+backslash", "WFrame.switch_next(_)"),
    kpress("Mod1+A", "ioncore.tagged_attach(_)"),
    submap("Mod1+E", {
        --Maximize the frame horizontally/vertically
        kpress("H", "WFrame.maximize_horiz(_)"),
        kpress("V", "WFrame.maximize_vert(_)"),
    }),
}

Neg_kb.floating = {
    mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
    mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
    mclick("Mod1+Button1", "WRegion.rqorder(_, 'front')"),
    mclick("Mod1+Button3", "WRegion.rqorder(_, 'back')"),
    -- kpress("Mod1+L", "WRegion.rqorder(_, 'back')" ),
    kpress("Mod1+U", "WRegion.rqorder(_, 'front')" ),
    mdrag("Button1@tab", "WFrame.p_move(_)"),

    kpress("Mod1+Control+H", "_:push_direction('left')"),
    kpress("Mod1+Control+J", "_:push_direction('down')"),
    kpress("Mod1+Control+K", "_:push_direction('up')"),
    kpress("Mod1+Control+L", "_:push_direction('right')"),
    kpress("Mod1+Control+F", "_:maximize_fill_toggle('vh')"),
    kpress("Mod1+Control+V", "_:maximize_fill_toggle('vert')"),
    submap("Mod1+E", { kpress("B", "mod_tiling.mkbottom(_)"), }),
}

Neg_kb.WMoveresMode = {
    kpress("AnyModifier+Escape", "WMoveresMode.cancel(_)"),
    kpress("AnyModifier+Return", "WMoveresMode.finish(_)"),

    kpress("Left",        "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("Right",       "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",          "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("Down",        "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    kpress("h",           "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("l",           "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("k",           "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("j",           "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    kpress("Shift+Left",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+Right", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+Up",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+Down",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    kpress("Shift+h",     "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+l",     "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+k",     "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+j",     "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    kpress("Mod1+Left",   "WMoveresMode.move(_,-1, 0)"),
    kpress("Mod1+Right",  "WMoveresMode.move(_, 1, 0)"),
    kpress("Mod1+Up",     "WMoveresMode.move(_, 0,-1)"),
    kpress("Mod1+Down",   "WMoveresMode.move(_, 0, 1)"),
}

Neg_kb.Tiling = {
    --Split current frame vertically
    kpress("Mod4+Down", "ioncore.goto_next(_sub, 'down',  {no_ascend=_})"),
    kpress("Mod4+Up",   "ioncore.goto_next(_sub, 'up',    {no_ascend=_})"),
    kpress("Mod4+Left", "ioncore.goto_next(_sub, 'left',  {no_ascend=_})"),
    kpress("Mod4+Right","ioncore.goto_next(_sub, 'right', {no_ascend=_})"),
    kpress("Mod4+j",    "ioncore.goto_next(_sub, 'down',  {no_ascend=_})"),
    kpress("Mod4+k",    "ioncore.goto_next(_sub, 'up',    {no_ascend=_})"),
    kpress("Mod4+h",    "ioncore.goto_next(_sub, 'left',  {no_ascend=_})"),
    kpress("Mod4+l",    "ioncore.goto_next(_sub, 'right', {no_ascend=_})"),
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
}

defbindings("WMPlex.toplevel", Neg_kb.WMPlex_toplevel)
defbindings("WScreen", Neg_kb.WScreen)
defbindings("WClientWin", Neg_kb.WClientWin)
defbindings("WGroupCW", Neg_kb.WGroupCW)
defbindings("WMPlex", Neg_kb.WMPlex)
defbindings("WFrame", Neg_kb.WFrame)
defbindings("WFrame.toplevel", Neg_kb.WFrame_toplevel)
defbindings("WFrame.floating", Neg_kb.floating)
defbindings("WMoveresMode", Neg_kb.WMoveresMode)
defbindings("WTiling", Neg_kb.Tiling)
