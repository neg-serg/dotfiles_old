local Neg_kb = {}

Neg_kb.WMPlex_toplevel = {
    kpress("M1+space", "query_lua(_)"), kpress("M4+space", function() end),
    kpress("M4+M",     function() spawn('~/bin/scripts/rofi_xprop' .. ' ' .. notioncore.current():xid()) end),
    kpress("M4+Sh+L",  function() spawn(notioncore.lookup_script('notion-lock')) end),
    kpress("M4+Sh+D",  "notioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
    kpress("M4+F11",   function() rofi.mainmenu() end),
    kpress("M4+slash", function() notioncore.goto_previous() end),
    kpress("M1+Tab",   function() notioncore.goto_previous() end),
    kpress("M4+T",     "min_tabs_tag_wrapper(_,_sub)", "_sub:non-nil"),
    --[[ scratchpads  ]]--------------------------------
    kpress("M4+d",     function() console() end),
    kpress("M4+F",     function() ncmpcpp() end),
    kpress("M4+p",     function() namsc('float2') end),
    kpress("M4+E",     function() namsc('im') end),
    kpress("M4+Ct+G",  function() rofi.goto_or_create_ws(notioncore.current()) end),
    kpress("M1+G",     function() rofi.goto_win(notioncore.current()) end),
    kpress("M4+F9",    function() notioncore.create_ws(notioncore.current()) end),
    --[[  progs run by app  ]]-----------------------------
    kpress("M4+1",     function() app.byclass_withtag('~/bin/wim', 'wim', nil, 'editor') end),
    kpress("M4+x",     function() app.byinstance('~/bin/urxvt', 'URxvt','MainTerminal') end),
    kpress("M4+b",     function() app.byclass_withtag(nil, 'mpv', nil, 'video') end),
    kpress("M4+w",     function() app.byinstance_withtag(
        '/usr/bin/firefox-beta||/usr/bin/firefox-nigtly||firefox',
        'Firefox',
        'Navigator',
        nil,
        'www') 
    end),
    kpress("M4+o",     function() app.byclass_withtag('zathura', 'Zathura', 'pdf') end),
    kpress("M4+Ct+A",  function() app.byclass_withtag(nil, 'Vmware', nil, 'virt') end),
    kpress("M4+Ct+C",  function() app.byclass('~/bin/sx ~/dw/*', 'Sxiv') end),
    --[[  misc  ]]---------------------------------------
    kpress("M4+Sh+F",  function() app.byinstance('lowriter', 'VCLSalFrame', 'libreoffice-writer') end),
    kpress("M4+Sh+T",  function() namsc('stalonetray') end),
    kpress("M4+Sh+W",  function() weechat() end),
    submap("M1+E",{
        kpress("Ct+r", function() app.byinstance('cr3', 'Cr3', 'cr3') end),
        kpress("Ct+w", "autoprop(_sub, _, true)", "_sub:WGroupCW"),
        kpress("d",    function() spawn('~/bin/scripts/dzen-dict') end),
        kpress("i",    function() spawn('~/bin/pls -output') end),
        kpress("m",    function() mutt() end),
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
        kpress("w",    function() webcam() end),
    }),
}

Neg_kb.WScreen = {
    submap("M1+E", {
        kpress("Ct+A", function() notioncore.goto_activity() end),
        kpress("Ct+t", function() notioncore.tagged_clear() end),
        kpress("c", function(_) WRegion.rqclose(_, false) end),
        kpress("L",    "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
        kpress("Sh+L", "WRegion.rqorder(_chld, 'back')","_chld:non-nil"),
    }),
    kpress("M4+grave", "notioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
    ---------------------------------------------------------
    kpress("M4+H", "_chld:focus_direction('left')", "_chld:non-nil"),
    kpress("M4+J", "_chld:focus_direction('down')", "_chld:non-nil"),
    kpress("M4+K", "_chld:focus_direction('up')", "_chld:non-nil"),
    kpress("M4+L", "_chld:focus_direction('right')", "_chld:non-nil"),
    ---------------------------------------------------------
    kpress("Print", function() make_root_screenshot() end),
    kpress("M1+Print", function() make_current_window_screenshot() end),
}

Neg_kb.WClientWin = {
    kpress("M4+Ct+Q", function(_) WClientWin.kill(_) end),
    kpress("M1+comma", function(_) WClientWin.quote_next(_) end),
}

Neg_kb.WGroupCW = {
    kpress_wait("M4+Q", function(_) WGroup.set_fullscreen(_, 'toggle') end),
    kpress("M4+0", function() rofi.renameworkspace() end),
}

Neg_kb.WFrame = {
    kpress("M4+S", function(_) nsp_hide() end),
    kpress("M4+6", function(_) rofi.renameframe(_) end),
    kpress("M4+backslash", function(_) WFrame.switch_next(_) end),
    kpress("M4+3", function(_) WFrame.switch_next(_) end),
    submap("M1+E", {
        kpress("H", function(_) WFrame.maximize_horiz(_) end),
        kpress("V", function(_) WFrame.maximize_vert(_) end),
    }),
    kpress("M4+R",          function(_) WFrame.begin_kbresize(_) end),
    mclick("Button1@tab",   function(_) WFrame.p_switch_tab(_) end), 
    mclick("Button2@tab",   function(_) WFrame.p_switch_tab(_) end),
    mdrag("Button1@border", function(_) WFrame.p_resize(_) end), 
    mdrag("M4+Button3",     function(_) WFrame.p_resize(_) end),
    mdrag("M1+Button1",     function(_) WFrame.p_move(_) end),
    mdrag("Button1@tab",    function(_) WFrame.p_tabdrag(_) end), 
    mdrag("Button2@tab",    function(_) WFrame.p_tabdrag(_) end),
    kpress("M1+U",          function(_) WRegion.rqorder(_, 'front') end),
}

Neg_kb.WMPlex = {
    submap(META.."E",{kpress_wait("Sh+Q", "WRegion.rqclose_propagate(_, _sub)"),}),
}

Neg_kb.WFrame_toplevel = {
    kpress("M4+A", function(_) rofi.attach_win(_) end),
    kpress("M1+A", function(_) notioncore.tagged_attach(_) end),
    submap("M1+E", {
        kpress("H", function(_) WFrame.maximize_horiz(_) end),
        kpress("V", function(_) WFrame.maximize_vert(_) end),
    }),
}

Neg_kb.floating = {
    mpress("Button1@tab",    function() WRegion.rqorder(_, 'front') end),
    mpress("Button1@border", function() WRegion.rqorder(_, 'front') end),
    mclick("M1+Button1",     function() WRegion.rqorder(_, 'front') end),
    mclick("M1+Button3",     function() WRegion.rqorder(_, 'back') end),
    kpress("M1+U",           function() WRegion.rqorder(_, 'front') end),
    mdrag("Button1@tab",     function() WFrame.p_move(_) end),

    kpress("M1+Ct+H", function(_) _:push_direction('left') end),
    kpress("M1+Ct+J", function(_) _:push_direction('down') end),
    kpress("M1+Ct+K", function(_) _:push_direction('up') end),
    kpress("M1+Ct+L", function(_) _:push_direction('right') end),

    kpress("M1+Ct+F", function(_) _:maximize_fill_toggle('vh') end),
    kpress("M1+Ct+V", function(_) _:maximize_fill_toggle('vert') end),

    submap("M1+E", { kpress("B", function(_) mod_tiling.mkbottom(_) end), }),
}

Neg_kb.WMoveresMode = {
    kpress("Escape", function(_) WMoveresMode.cancel(_) end),
    kpress("Return", function(_) WMoveresMode.finish(_) end),
    kpress("Ct+C",   function(_) WMoveresMode.finish(_) end),

    kpress("h",      function(_) WMoveresMode.resize(_, 1, 0, 0, 0) end),
    kpress("l",      function(_) WMoveresMode.resize(_, 0, 1, 0, 0) end),
    kpress("k",      function(_) WMoveresMode.resize(_, 0, 0, 1, 0) end),
    kpress("j",      function(_) WMoveresMode.resize(_, 0, 0, 0, 1) end),

    kpress("a",      function(_) WMoveresMode.resize(_, 1, 0, 0, 0) end),
    kpress("d",      function(_) WMoveresMode.resize(_, 0, 1, 0, 0) end),
    kpress("w",      function(_) WMoveresMode.resize(_, 0, 0, 1, 0) end),
    kpress("s",      function(_) WMoveresMode.resize(_, 0, 0, 1, 0) end),

    kpress("Sh+h",   function(_) WMoveresMode.resize(_,-1, 0, 0, 0) end),
    kpress("Sh+l",   function(_) WMoveresMode.resize(_, 0,-1, 0, 0) end),
    kpress("Sh+k",   function(_) WMoveresMode.resize(_, 0, 0,-1, 0) end),
    kpress("Sh+j",   function(_) WMoveresMode.resize(_, 0, 0, 0,-1) end),
    
    kpress("Sh+a",   function(_) WMoveresMode.resize(_,-1, 0, 0, 0) end),
    kpress("Sh+d",   function(_) WMoveresMode.resize(_, 0,-1, 0, 0) end),
    kpress("Sh+w",   function(_) WMoveresMode.resize(_, 0, 0,-1, 0) end),
    kpress("Sh+s",   function(_) WMoveresMode.resize(_, 0, 0, 0,-1) end),

    kpress("M1+h",   function(_) WMoveresMode.move(_,-1, 0) end),
    kpress("M1+l",   function(_) WMoveresMode.move(_, 1, 0) end),
    kpress("M1+k",   function(_) WMoveresMode.move(_, 0,-1) end),
    kpress("M1+j",   function(_) WMoveresMode.move(_, 0, 1) end),
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
    kpress("M4+Ct+W", function(_) move_current.move(_, "up") end),
    kpress("M4+Ct+S", function(_) move_current.move(_, "down") end),
    kpress("M4+Ct+A", function(_) move_current.move(_, "left") end),
    kpress("M4+Ct+D", function(_) move_current.move(_, "right") end),
    kpress("M4+Ct+m", function() rofi.tilingmenu() end),
    kpress("M4+Ct+d", function(_) collapse.collapse(_) end),
    kpress("M4+i",    function(_) dynamic_view.toggle(_, 'term',  'left') end),
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
