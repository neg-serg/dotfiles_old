local Neg_kb = {}
local M1 = "Mod1+" M2 = "Mod2+"
local M3 = "Mod3+" M4 = "Mod4+"
local M5 = "Mod5+" Ct = "Control+"
local Sh = "Shift+"

Neg_kb.WMPlex_toplevel = {
    kpress(M4.."M",      function() spawn('~/bin/scripts/rofi_xprop' .. ' ' .. notioncore.current():xid()) end),
    kpress(M4.."F11",    function() rofi.mainmenu() end),
    kpress(M4.."slash",  function() notioncore.goto_previous() end),
    kpress(M1.."Tab",    function() notioncore.goto_previous() end),
    --[[ scratchpads  ]]--------------------------------
    kpress(M4.."D",      function() console() end),
    kpress(M4.."F",      function() ncmpcpp() end),
    kpress(M4.."E",      function() namsc('im') end),
    kpress(M4..Ct.."G",  function() rofi.goto_or_create_ws(notioncore.current()) end),
    kpress(M1.."G",      function() rofi.goto_win(notioncore.current()) end),
    --[[ wasd / push direction ]]-----------------------
    kpress(M4..Ct.."W", function(_) _:push_direction('up') end),
    kpress(M4..Ct.."A", function(_) _:push_direction('left') end),
    kpress(M4..Ct.."S", function(_) _:push_direction('down') end),
    kpress(M4..Ct.."D", function(_) _:push_direction('right') end),
    --[[  progs run by app  ]]--------------------------
    kpress(M4.."1",      function() app.byclass_withtag('~/bin/wim', 'wim', nil, 'editor') end),
    kpress(M4..Sh.."1",  function() app.byclass_withtag('emacs', 'Emacs', nil, 'geditor') end),
    kpress(M4..Ct.."1",  function() app.byclass_withtag('atom', 'Atom', nil, 'aeditor') end),
    kpress(M4.."F1",     function() app.byclass_withtag('~/bin/scripts/jetbrains.sh idea', 'jetbrains-idea', nil, 'ide') end),
    kpress(M4.."F2",     function() app.byclass_withtag('~/bin/scripts/jetbrains.sh webstorm', 'jetbrains-webstorm', nil, 'ide') end),
    kpress(M4.."F3",     function() app.byclass_withtag('~/bin/scripts/jetbrains.sh clion', 'jetbrains-clion', nil, 'ide') end),
    kpress(M4.."F4",     function() app.byclass_withtag('~/bin/scripts/jetbrains.sh android-studio', 'jetbrains-android-studio', nil, 'ide') end),
    kpress(M4.."X",      function() app.byinstance('~/bin/urxvt', 'URxvt','MainTerminal') end),
    kpress(M4.."B",      function() app.byclass_withtag(nil, 'mpv', nil, 'video') end),
    kpress(M4.."W",      function() app.byinstance_withtag(
        'firefox || /usr/bin/firefox-developer',
        'Firefox',
        'Navigator',
        nil,
        'www') 
    end),
    kpress(M4.."O",      function() app.byclass_withtag('zathura', 'Zathura', 'pdf') end),
    kpress(M4..Ct.."E",  function() app.byclass_withtag(nil, 'Vmware', nil, 'virt') end),
    kpress(M4..Ct.."C",  function() app.byclass('~/bin/sx ~/dw/*', 'Sxiv') end),
    --[[  misc  ]]---------------------------------------
    kpress(M4..Sh.."F",  function() app.byinstance('lowriter', 'VCLSalFrame', 'libreoffice-writer') end),
    kpress(M4..Sh.."T",  function() 
        ns_exec(
            'stalonetray', -- class
            'stalonetray -c ${XDG_CONFIG_HOME}/stalonetrayrc', --app
            'stalonetray'   --ns
        )
    end),
    kpress(M4..Sh.."E",  function() weechat() end),
    submap(M1.."E",{
        kpress(Ct.."R", function() app.byinstance('cr3', 'Cr3', 'cr3') end),
        kpress("A",     function() namsc('firefox-dialog') end),
        submap("C", {
            kpress("C", function() spawn('p copy') end),
            kpress("P", function() spawn('p paste') end),
        }),
        kpress("D",     function() spawn('~/bin/scripts/dzen-dict') end),
        kpress("F",     function() namsc('float') end),
        kpress("I",     function() spawn('~/bin/pls -output') end),
        kpress("L",     function() radare2() end),
        kpress("M",     function() mutt() end),
        kpress("N",     function() nicotine() end),
        kpress("O",     function() spawn('~/bin/pls -sink') end),
        kpress("P",     function() spawn('st pulsemixer') end),
        kpress("Q",     function() spawn('~/bin/mpd_sel.sh') end),
        kpress("S",     function() spawn('skype') end),
        kpress(Sh.."D", function() spawn('~/bin/scripts/exec_demo.sh') end),
        kpress(Sh.."D", "notioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
        kpress(Sh.."G", function() gdb() end),
        kpress(Sh.."K", function() spawn('~/bin/scripts/toggle_keynav') end),
        kpress(Sh.."O", function() spawn('~/bin/pls -vol') end),
        kpress(Sh.."R", function() ranger() end),
        kpress("T",     function() spawn('urxvt') end),
        kpress("V",     function() spawn('vmware') end),
        kpress("W",     function() webcam() end),
        kpress(Sh.."B", function() 
            local browser_list = { "yandex-browser-beta"
                                   , "chromium"
                                   , "google-chrome"
                                   , "google-chrome-stable"
                                   , "tor-browser-en"
                                 }
            local function gen_www_list_()
                local str = ""
                for i,v in ipairs(browser_list) do
                    if i < #browser_list then
                        str = str .. v .. " || "
                    else
                        str = str .. v
                    end
                end
                return str
            end
            spawn(gen_www_list_())
        end),
    }),
}

Neg_kb.WScreen = {
    submap(M1.."E", {
        kpress("E",     function() notioncore.goto_activity() end),
        kpress(Ct.."T", function() notioncore.tagged_clear() end),
        kpress("C", function(_) WRegion.rqclose(_, false) end),
        kpress("L",     "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
        kpress(Sh.."L", "WRegion.rqorder(_chld, 'back')","_chld:non-nil"),
    }),
    kpress(M4.."grave", "notioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
    ---------------------------------------------------------
    kpress(M4.."H", "_chld:focus_direction('left')", "_chld:non-nil"),
    kpress(M4.."J", "_chld:focus_direction('down')", "_chld:non-nil"),
    kpress(M4.."K", "_chld:focus_direction('up')", "_chld:non-nil"),
    kpress(M4.."L", "_chld:focus_direction('right')", "_chld:non-nil"),
    ---------------------------------------------------------
    -- kpress("Print", function() make_root_screenshot() end),
    kpress("Print", function() make_scr() end),
    kpress(M1.."Print", function() make_current_window_screenshot() end),
}

Neg_kb.WClientWin = {
    kpress(M4..Ct.."Q", function(_) WRegion.rqclose(_, false) end),
    kpress(M4.."T",     function(_) WRegion.set_tagged(_,'toggle') end),
    kpress(M1.."comma", function(_) WClientWin.quote_next(_) end),
}

Neg_kb.WGroupCW = {
    kpress_wait(M4.."Q", function(_) WGroup.set_fullscreen(_, 'toggle') end),
    submap(M4.."0", {
        kpress_wait("w",   function() submapped(rofi.renameworkspace()) end),
        kpress_wait("f",   function(_) submapped(rofi.renameframe(_)) end),
    }),
}

Neg_kb.WFrame = {
    kpress(M4.."S", function(_) nsp_hide() end),
    kpress(M4.."backslash", function(_) WFrame.switch_next(_) end),
    kpress(M4.."3", function(_) WFrame.switch_next(_) end),
    submap(M1.."E", {
        kpress("H", function(_) WFrame.maximize_horiz(_) end),
        kpress("V", function(_) WFrame.maximize_vert(_) end),
    }),
    kpress(M4.."R",         function(_) WFrame.begin_kbresize(_) end),
    mdrag("Button1@border", function(_) WFrame.p_resize(_) end), 
    mdrag(M4.."Button3",    function(_) WFrame.p_resize(_) end),
    mdrag(M1.."Button1",    function(_) WFrame.p_move(_) end),
    kpress(M1.."U",         function(_) WRegion.rqorder(_, 'front') end),
}

Neg_kb.WMPlex = {
    submap(M1.."E",{kpress_wait(Sh.."Q", "WRegion.rqclose_propagate(_, _sub)"),}),
}

Neg_kb.WFrame_toplevel = {
    kpress(M4.."A", function(_) rofi.attach_win(_) end),
    kpress(M1.."A", function(_) notioncore.tagged_attach(_) end),
    submap(M1.."E", {
        kpress("H", function(_) WFrame.maximize_horiz(_) end),
        kpress("V", function(_) WFrame.maximize_vert(_) end),
    }),
}

Neg_kb.floating = {
    mdrag("Button1@tab",     function() WFrame.p_move(_) end),

    kpress(M4..Ct.."F", function(_) _:maximize_fill_toggle('vh') end),
    kpress(M4..Ct.."V", function(_) _:maximize_fill_toggle('vert') end),

    submap(M1.."E", { kpress("B", function(_) mod_tiling.mkbottom(_) end), }),
}

Neg_kb.WMoveresMode = {
    kpress("Escape", function(_) WMoveresMode.cancel(_) end),
    kpress("Return", function(_) WMoveresMode.finish(_) end),
    kpress(Ct.."C",  function(_) WMoveresMode.finish(_) end),

    kpress("H",      function(_) WMoveresMode.resize(_, 1, 0, 0, 0) end),
    kpress("L",      function(_) WMoveresMode.resize(_, 0, 1, 0, 0) end),
    kpress("K",      function(_) WMoveresMode.resize(_, 0, 0, 1, 0) end),
    kpress("J",      function(_) WMoveresMode.resize(_, 0, 0, 0, 1) end),

    kpress("A",      function(_) WMoveresMode.resize(_, 1, 0, 0, 0) end),
    kpress("D",      function(_) WMoveresMode.resize(_, 0, 1, 0, 0) end),
    kpress("W",      function(_) WMoveresMode.resize(_, 0, 0, 1, 0) end),
    kpress("S",      function(_) WMoveresMode.resize(_, 0, 0, 1, 0) end),

    kpress(Sh.."H",   function(_) WMoveresMode.resize(_,-1, 0, 0, 0) end),
    kpress(Sh.."L",   function(_) WMoveresMode.resize(_, 0,-1, 0, 0) end),
    kpress(Sh.."K",   function(_) WMoveresMode.resize(_, 0, 0,-1, 0) end),
    kpress(Sh.."J",   function(_) WMoveresMode.resize(_, 0, 0, 0,-1) end),
    
    kpress(Sh.."A",   function(_) WMoveresMode.resize(_,-1, 0, 0, 0) end),
    kpress(Sh.."D",   function(_) WMoveresMode.resize(_, 0,-1, 0, 0) end),
    kpress(Sh.."W",   function(_) WMoveresMode.resize(_, 0, 0,-1, 0) end),
    kpress(Sh.."S",   function(_) WMoveresMode.resize(_, 0, 0, 0,-1) end),

    kpress(M1.."H",   function(_) WMoveresMode.move(_,-1, 0) end),
    kpress(M1.."L",   function(_) WMoveresMode.move(_, 1, 0) end),
    kpress(M1.."K",   function(_) WMoveresMode.move(_, 0,-1) end),
    kpress(M1.."J",   function(_) WMoveresMode.move(_, 0, 1) end),
}

Neg_kb.Tiling = {
    kpress(M4.."K",     function() goto_dir('up') end),
    kpress(M4.."J",     function() goto_dir('down') end),
    kpress(M4.."H",     function() goto_dir('left') end),
    kpress(M4.."L",     function() goto_dir('right') end),
    kpress(M4..Sh.."W", function() tiling_split('top') end),
    kpress(M4..Sh.."A", function() tiling_split('left') end),
    kpress(M4..Sh.."S", function() tiling_split('bottom') end),
    kpress(M4..Sh.."D", function() tiling_split('right') end),
    kpress(M4.."2",     function() tiling_transpose() end),
    kpress(M4..Sh.."3", function() tiling_flip() end),
    kpress(M4..Ct.."X", function() tiling_unsplit() end),
    kpress(M4..Ct.."W", function(_) move_current.move(_, "up") end),
    kpress(M4..Ct.."S", function(_) move_current.move(_, "down") end),
    kpress(M4..Ct.."A", function(_) move_current.move(_, "left") end),
    kpress(M4..Ct.."D", function(_) move_current.move(_, "right") end),
    kpress(M4..Ct.."m", function() rofi.tilingmenu() end),
    kpress(M4.."I",     function(_) dynamic_view.toggle(_, 'term',  'left') end),
    kpress(M4..Ct.."I", "multiple_split(_, _sub, 'top')"), -- vertical layout
    kpress(M4..Ct.."O", "multiple_split(_, _sub, 'left')"), -- horizontal layout
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
