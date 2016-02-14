Neg_kb = {}

Neg_kb.WMPlex_toplevel = {
    ---------------------
    -- WMPlex toplevel --
    ---------------------
    kpress("M1+space", "query_lua(_)"), kpress("M4+space", function() end),
    kpress("M4+M",     function() spawn('~/bin/scripts/rofi_xprop' .. ' ' .. _chld:xid()) end),
    kpress("M4+Sh+L",  function() swawn(notioncore.lookup_script('notion-lock')) end),
    kpress("M4+Sh+D",  "notioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
    kpress("M4+F11",   function() rofi.mainmenu() end),
    kpress("M4+slash", function() notioncore.goto_previous() end),
    kpress("M1+Tab",   function() notioncore.goto_previous() end),
    kpress("M4+T",     "min_tabs_tag_wrapper(_,_sub)", "_sub:non-nil"),
    --[[ SCRATCHPADS  ]]--------------------------------
    kpress("M4+d",     function() console() end),
    kpress("M4+F",     function() ncmpcpp() end),
    kpress("M4+p",     function() namsc('float2') end),
    kpress("M4+E",     function() namsc('im') end),
    kpress("M4+Ct+G",  function() rofi.goto_or_create_ws(notioncore.current()) end),
    kpress("M1+G",     function() rofi.goto_win(notioncore.current()) end),
    kpress("M4+F9",    function() notioncore.create_ws(notioncore.current()) end),
    --[[  PROGS RUN by APP  ]]-----------------------------
    kpress("M4+1",     function() app.byclass('~/bin/wim', 'wim') end),
    kpress("M4+x",     function() app.byinstance('~/bin/urxvt', 'URxvt','MainTerminal') end),
    kpress("M4+b",     function() app.byclass_withtag(nil, 'mpv',nil, 'video') end),
    kpress("M4+w",     function() app.byinstance_withtag('/usr/bin/firefox-beta||/usr/bin/firefox-nigtly||firefox', 'Firefox','Navigator',nil,'www') end),
    kpress("M4+o",     function() app.byclass_withtag('zathura','Zathura','pdf') end),
    kpress("M4+Ct+A",  function() app.byclass_withtag(nil, 'Vmware',nil, 'virt') end),
    kpress("M4+Ct+C",  function() app.byclass('~/bin/sx ~/dw/*', 'Sxiv') end),
    --[[  MISC  ]]---------------------------------------
    kpress("M4+Ct+Q",  "WRegion.rqclose_propagate(_, _sub)"),
    kpress("M4+Sh+F",  function() app.byinstance('lowriter', 'VCLSalFrame', 'libreoffice-writer') end),
    kpress("M4+Sh+T",  function() namsc('stalonetray') end),
    kpress("M4+Sh+W",  function() weechat() end),
    submap("M1+E",{
        kpress("Ct+r", function() app.byinstance('cr3', 'Cr3', 'cr3') end),
        kpress("Ct+w", "autoprop(_sub, _, true)", "_sub:WGroupCW"),
        kpress("d",    function() spawn('~/bin/scripts/dzen-dict') end),
        kpress("i",    function() spawn('~/bin/pls -output') end),
        kpress("m",    function() app.byclass('~/bin/scripts/run_mutt', 'mutt') end),
        kpress("n",    function() app.byinstance('nicotine.py || nicotine', 'Nicotine.py', 'nicotine.py') end),
        kpress("o",    function() spawn('~/bin/pls -sink') end),
        kpress("p",    function() spawn('st pulsemixer') end),
        kpress("q",    function() spawn('~/bin/mpd_sel.sh') end),
        kpress("Sh+d", function() spawn('~/bin/scripts/exec_demo.sh') end),
        kpress("Sh+k", function() spawn('~/bin/scripts/toggle_keynav') end),
        kpress("Sh+o", function() spawn('~/bin/pls -vol') end),
        kpress("Sh+r", function() ranger() end),
        kpress("l",    function() radare2() end),
        kpress("Sh+g", function() gdb() end),
        kpress("s",    function() spawn('skype') end),
        kpress("t",    function() spawn('urxvt') end),
        kpress("v",    function() spawn('vmware') end),
        kpress("w",    function() spawn('~/bin/webcam') end),
    }),
}

Neg_kb.WScreen = {
    ---------------------
        -- WScreen --    
    ---------------------
    submap("M1+E", {
            kpress("Ct+A", function() notioncore.goto_activity() end),
            kpress("Ct+t", function() notioncore.tagged_clear() end),
            }),
    kpress("M4+Sh+1", function() notioncore.goto_nth_screen(0) end),
    kpress("M4+Sh+2", function() notioncore.goto_nth_screen(1) end),
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
    kpress("Print", function() make_root_screenshot() end),
    kpress("M1+Print", function() make_current_window_screenshot() end),
}

Neg_kb.WClientWin = {
    ---------------------
      -- WClientWin --   
    ---------------------
    submap("M1+E", {
        kpress("C",        "WklientWin.kill(_)"),}),
        kpress("M1+comma", "WClientWin.quote_next(_)"),
}

Neg_kb.WGroupCW = {
    ---------------------
       -- WGroupCW --   
    ---------------------
    kpress_wait("M4+Q", "WGroup.set_fullscreen(_, 'toggle')"),
    kpress("M4+0",      "rofi.renameworkspace(_)"),
    kpress("M4+9", function() comp_man_please() end),
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
    kpress("Escape", "WMoveresMode.cancel(_)"),
    kpress("Return", "WMoveresMode.finish(_)"),
    kpress("Ct+C",   "WMoveresMode.finish(_)"),

    kpress("h",      "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("l",      "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",     "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("k",      "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("j",      "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    kpress("a",      "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("d",      "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("w",      "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("s",      "WMoveresMode.resize(_, 0, 0, 1, 0)"),
                    
    kpress("Sh+h",   "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Sh+l",   "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Sh+Up",  "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Sh+k",   "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Sh+j",   "WMoveresMode.resize(_, 0, 0, 0,-1)"),
    
    kpress("Sh+a",   "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Sh+d",   "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Sh+w",   "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Sh+s",   "WMoveresMode.resize(_, 0, 0, 0,-1)"),
                    
    kpress("M1+h",   "WMoveresMode.move(_,-1, 0)"),
    kpress("M1+l",   "WMoveresMode.move(_, 1, 0)"),
    kpress("M1+k",   "WMoveresMode.move(_, 0,-1)"),
    kpress("M1+j",   "WMoveresMode.move(_, 0, 1)"),
}

Neg_kb.Tiling = {
    kpress("M4+k",    function() goto_dir('up') end),
    kpress("M4+j",    function() goto_dir('down') end),
    kpress("M4+h",    function() goto_dir('left') end),
    kpress("M4+l",    function() goto_dir('right') end),
    kpress("M4+Ct+H", function() tiling_split('right') end),
    kpress("M4+Ct+L", function() tiling_split('left') end),
    kpress("M4+Ct+K", function() tiling_split('bottom') end),
    kpress("M4+Ct+J", function() tiling_split('top') end),
    kpress("M4+2",    function() tiling_transpose() end),
    kpress("M4+Sh+3", function() tiling_flip() end),
    kpress("M4+Ct+X", function() tiling_unsplit() end),
    kpress("M4+Ct+W", function(ws) move_current.move(ws, "up") end),
    kpress("M4+Ct+S", function(ws) move_current.move(ws, "down") end),
    kpress("M4+Ct+A", function(ws) move_current.move(ws, "left") end),
    kpress("M4+Ct+D", function(ws) move_current.move(ws, "right") end),
    kpress("M4+Ct+m", function() rofi.tilingmenu() end),
    kpress("M4+Ct+d", function() collapse.collapse(_) end),
    kpress("M4+i",    "dynamic_view.toggle(_, 'term',  'left')"),
    kpress("M4+Ct+i", "multiple_split(_, _sub, 'top')"), -- vertical layout
    kpress("M4+Ct+o", "multiple_split(_, _sub, 'left')"), -- horizontal layout
}

defbindings("WMPlex.toplevel",   Neg_kb.WMPlex_toplevel)
defbindings("WScreen",           Neg_kb.WScreen)
defbindings("WClientWin",        Neg_kb.WClientWin)
defbindings("WGroupCW",          Neg_kb.WGroupCW)
defbindings("WMPlex",            Neg_kb.WMPlex)
defbindings("WFrame",            Neg_kb.WFrame)
defbindings("WFrame.toplevel",   Neg_kb.WFrame_toplevel)
defbindings("WFrame.floating",   Neg_kb.floating)
defbindings("WMoveresMode",      Neg_kb.WMoveresMode)
defbindings("WTiling",           Neg_kb.Tiling)
