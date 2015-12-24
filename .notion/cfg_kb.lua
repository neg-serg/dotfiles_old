Neg_kb = {}

Neg_kb.WMPlex_toplevel = {
    ---------------------
    -- WMPlex toplevel --
    ---------------------
    kpress("M4+slash", "notioncore.goto_previous()"),
    kpress("M1+Tab",   "notioncore.goto_previous()"),
    kpress("M1+space", "nop()"),
    kpress("M4+F2",    "repl(_)"),
    kpress("M4+F11",   "rofi.mainmenu()"),
    kpress("M4+Sh+L",  "notioncore.exec_on(_, notioncore.lookup_script('notion-lock'))"),
    kpress("M4+Sh+D",  "notioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
    -------------------------------------------------------------------------------------
    --[[ SCRATCHPADS  ]]--------------------------------
    --------------------
    kpress("M4+d",       "console(_)"),
    kpress("M4+p",       "named_scratchpad(_, 'float2')"),
    kpress("M4+F",       "ncmpcpp(_)"),
    
    kpress("M4+E",       "named_scratchpad(_, 'im')"),
    kpress("M4+Ct+9",    "named_scratchpad(_, 'wicd')"),
    kpress("M4+Ct+2",    "named_scratchpad(_, 'alsa')"),
    kpress("M4+Ct+4",    "named_scratchpad(_, 'etc')"),
    kpress("M4+Ct+G",    "rofi.goto_or_create_ws(_)"),
    kpress("M1+G",       "rofi.goto_win(_)"),
    kpress("M4+F9",      "notioncore.create_ws(_)"),
    submap("M4+Ct+R", {
        kpress("t", "notioncore.exec_on(_, 'xcalib -c')"),
        kpress("i", "notioncore.exec_on(_, 'xcalib -alter -invert')"),
        kpress("r", "notioncore.exec_on(_, 'xcalib -red 0.1 0.0 1 -a')"),
    }),

    -------------------------------------------------------------------------------------
    --[[ SLEEP ]]-----------------------------------------
    -------------
    kpress("XF86Sleep", "notioncore.exec_on(_, 'sudo systemctl suspend')"),
    kpress("M4+Ct+Sh+u", "notioncore.exec_on(_, 'sudo systemctl suspend')"),
    -------------------------------------------------------------------------------------
    --[[  PROGS RUN by APP  ]]-----------------------------
    --------------------------
    kpress("M4+1",     "app.byclass('~/bin/wim', 'wim')"),
    kpress("M4+x",     "app.byinstance('~/bin/urxvt', 'URxvt','MainTerminal')"),
    kpress("M4+Ct+a",  "app.byclass_withtag(nil, 'Vmware',nil, 'virt')"),
    kpress("M4+b",     "app.byclass_withtag(nil, 'mpv',nil, 'video')"),
    kpress("M4+w",     "app.byinstance_withtag('/usr/bin/firefox-beta||/usr/bin/firefox-nigtly||firefox', 'Firefox','Navigator',nil,'www')"),
    kpress("M4+o",     "app.byclass_withtag('zathura','Zathura','pdf')"),
    kpress("M4+Ct+C",  "app.byclass('~/bin/sx ~/dw/*', 'Sxiv')"),
    -------------------------------------------------------------------------------------
    --[[  MISC  ]]---------------------------------------
    --------------
    kpress("M4+Ct+Q",  "WRegion.rqclose_propagate(_, _sub)"),
    kpress("M4+U",     "notioncore.exec_on(_, 'udiskie-umount -a')"),
    kpress("M4+M",     "notioncore.exec_on(_, '~/bin/scripts/rofi_xprop')"),
    kpress("M4+Sh+U",  "notioncore.exec_on(_, 'eject -T')"),
    kpress("M4+Sh+F",  "app.byinstance('lowriter', 'VCLSalFrame', 'libreoffice-writer')"),
    kpress("M4+c",     "notioncore.exec_on(_, '~/bin/clip')"),
    kpress("M4+Sh+m",  "rofi.mpdmenu()"),
    kpress("M4+Sh+t",  "named_scratchpad(_, 'stalonetray')"),
    submap("M1+E",{
        kpress("Ct+r", "app.byinstance('cr3', 'Cr3', 'cr3')"),
        kpress("d",    "notioncore.exec_on(_, 'stardict')"),
        kpress("i",    "notioncore.exec_on(_, '~/bin/pls -output')"),
        kpress("l",    "radare2(_)"),
        kpress("m",    "app.byclass('~/bin/scripts/run_mutt', 'mutt')"),
        kpress("n",    "app.byinstance('nicotine.py || nicotine', 'Nicotine.py', 'nicotine.py')"),
        kpress("o",    "notioncore.exec_on(_, '~/bin/pls -sink')"),
        kpress("p",    "notioncore.exec_on(_, 'pavucontrol')"),
        kpress("q",    "notioncore.exec_on(_, '~/bin/mpd_sel.sh')"),
        kpress("Sh+d", "notioncore.exec_on(_, '~/bin/scripts/exec_demo.sh')"),
        kpress("Sh+g", "gdb(_)"),
        kpress("Sh+k", "notioncore.exec_on(_, '~/bin/scripts/toggle_keynav')"),
        kpress("Sh+o", "notioncore.exec_on(_, '~/bin/pls -vol')"),
        kpress("Sh+r", "ranger(_)"),
        kpress("s",    "notioncore.exec_on(_, 'skype')"),
        kpress("t",    "notioncore.exec_on(_, 'urxvt')"),
        kpress("v",    "notioncore.exec_on(_, 'vmware')"),
        kpress("w",    "notioncore.exec_on(_, '~/bin/webcam')"),
    }),
}

Neg_kb.WScreen = {
    submap("M1+E", {
            kpress("Ct+A", "notioncore.goto_activity()"),
            kpress("Ct+t", "notioncore.tagged_clear()"),
            }),
    kpress("M4+Sh+1",      "notioncore.goto_nth_screen(0)"),
    kpress("M4+Sh+2",      "notioncore.goto_nth_screen(1)"),
    kpress("M4+Sh+comma",  "notioncore.goto_prev_screen()"),
    kpress("M4+Sh+period", "notioncore.goto_next_screen()"),
    submap("M1+E", {
        kpress("AnyModifier+L",    "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
        kpress("AnyModifier+Sh+L", "WRegion.rqorder(_chld, 'back')","_chld:non-nil"),
    }),
    kpress("M4+grave", "notioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
    ---------------------------------------------------------
    kpress("M4+H", "_chld:focus_direction('left')", "_chld:non-nil"),
    kpress("M4+J", "_chld:focus_direction('down')", "_chld:non-nil"),
    kpress("M4+K", "_chld:focus_direction('up')", "_chld:non-nil"),
    kpress("M4+L", "_chld:focus_direction('right')", "_chld:non-nil"),
    ---------------------------------------------------------
    -- Screenshots
    kpress("Print", "make_root_screenshot()"),
    kpress("M1+Print", "make_current_window_screenshot()"),
}

Neg_kb.WClientWin = {
    submap("M1+E", {
        kpress("C",        "WklientWin.kill(_)"),}),
        kpress("M1+comma", "WClientWin.quote_next(_)"),
}

Neg_kb.WGroupCW = {
    kpress_wait("M4+Q", "WGroup.set_fullscreen(_, 'toggle')"),
    kpress("M4+0",      "rofi.renameworkspace(_)"),
    kpress("M4+9",      "comp_man_please()"),
}

Neg_kb.WMPlex = {
    submap(META.."E",{kpress_wait("Q", "WRegion.rqclose_propagate(_, _sub)"),}),
}

Neg_kb.WFrame = {
    kpress("M4+S","mod_sp.set_shown(notioncore.lookup_region(_:name(), 'WFrame'), 'unset' )" ),
    kpress("M4+6","rofi.renameframe(_)"),
    kpress("M4+backslash", "WFrame.switch_next(_)"),
    kpress("M4+3", "WFrame.switch_next(_)"),
    submap("M1+E", {
      kpress("H", "WFrame.maximize_horiz(_)"),
      kpress("V", "WFrame.maximize_vert(_)"),
    }),
    kpress("M4+R",          "WFrame.begin_kbresize(_)"),
    mclick("Button1@tab",   "WFrame.p_switch_tab(_)"), mclick("Button2@tab", "WFrame.p_switch_tab(_)"),
    mdrag("Button1@border", "WFrame.p_resize(_)"), mdrag(META.."Button3", "WFrame.p_resize(_)"),
    mdrag("M1+Button1",     "WFrame.p_move(_)"),
    mdrag("Button1@tab",    "WFrame.p_tabdrag(_)"), mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
    kpress("M1+U",          "WRegion.rqorder(_, 'front')" ),
}

Neg_kb.WFrame_toplevel = {
    kpress("M4+A", "rofi.attach_win(_)"),
    kpress("M1+A", "notioncore.tagged_attach(_)"),
    submap("M1+E", {
        kpress("H", "WFrame.maximize_horiz(_)"),
        kpress("V", "WFrame.maximize_vert(_)"),
    }),
}

Neg_kb.floating = {
    mpress("Button1@tab",    "WRegion.rqorder(_, 'front')"),
    mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
    mclick("M1+Button1",     "WRegion.rqorder(_, 'front')"),
    mclick("M1+Button3",     "WRegion.rqorder(_, 'back')"),
    kpress("M1+U",           "WRegion.rqorder(_, 'front')" ),
    mdrag("Button1@tab",     "WFrame.p_move(_)"),

    kpress("M1+Ct+H", "_:push_direction('left')"),
    kpress("M1+Ct+J", "_:push_direction('down')"),
    kpress("M1+Ct+K", "_:push_direction('up')"),
    kpress("M1+Ct+L", "_:push_direction('right')"),
    kpress("M1+Ct+F", "_:maximize_fill_toggle('vh')"),
    kpress("M1+Ct+V", "_:maximize_fill_toggle('vert')"),
    submap("M1+E", { kpress("B", "mod_tiling.mkbottom(_)"), }),
}

Neg_kb.WMoveresMode = {
    kpress("AnyModifier+Escape", "WMoveresMode.cancel(_)"),
    kpress("AnyModifier+Return", "WMoveresMode.finish(_)"),

    kpress("Left",     "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("h",        "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("Right",    "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("l",        "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",       "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("k",        "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("Down",     "WMoveresMode.resize(_, 0, 0, 0, 1)"),
    kpress("j",        "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    kpress("Sh+Left",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Sh+h",     "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Sh+Right", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Sh+l",     "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Sh+Up",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Sh+k",     "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Sh+Down",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),
    kpress("Sh+j",     "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    kpress("M1+Left",  "WMoveresMode.move(_,-1, 0)"),
    kpress("M1+Right", "WMoveresMode.move(_, 1, 0)"),
    kpress("M1+Up",    "WMoveresMode.move(_, 0,-1)"),
    kpress("M1+Down",  "WMoveresMode.move(_, 0, 1)"),
}

Neg_kb.Tiling = {
    kpress("M4+Up",   "notioncore.goto_next(_sub, 'up',    {no_ascend=_})"),
    kpress("M4+k",    "notioncore.goto_next(_sub, 'up',    {no_ascend=_})"),
    kpress("M4+Down", "notioncore.goto_next(_sub, 'down',  {no_ascend=_})"),
    kpress("M4+j",    "notioncore.goto_next(_sub, 'down',  {no_ascend=_})"),
    kpress("M4+Left", "notioncore.goto_next(_sub, 'left',  {no_ascend=_})"),
    kpress("M4+h",    "notioncore.goto_next(_sub, 'left',  {no_ascend=_})"),
    kpress("M4+Right","notioncore.goto_next(_sub, 'right', {no_ascend=_})"),
    kpress("M4+l",    "notioncore.goto_next(_sub, 'right', {no_ascend=_})"),
    kpress("M4+Ct+H", "WTiling.split_at(_, _sub, 'right', true)"),
    kpress("M4+Ct+L", "WTiling.split_at(_, _sub, 'left', true)"),
    kpress("M4+Ct+K", "WTiling.split_at(_, _sub, 'bottom', true)"),
    kpress("M4+Ct+J", "WTiling.split_at(_, _sub, 'top', true)"),
    kpress("M4+2",    "WTiling.transpose_at(_, _sub)"),
    kpress("M4+3",    "WTiling.flip_at(_, _sub)"),
    kpress("M4+Ct+X", "WTiling.unsplit_at(_, _sub)"),
    kpress("M4+Ct+W", function(ws) move_current.move(ws, "up") end),
    kpress("M4+Ct+S", function(ws) move_current.move(ws, "down") end),
    kpress("M4+Ct+A", function(ws) move_current.move(ws, "left") end),
    kpress("M4+Ct+D", function(ws) move_current.move(ws, "right") end),
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
