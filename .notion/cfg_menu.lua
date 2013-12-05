-------------------------------[[  MENU  ]]-------------------------------------

defmenu("mainmenu", {
    menuentry("Run...",      "mod_query.query_exec(_)"),
    menuentry("Terminal",    "ioncore.exec_on(_, XTERM or 'xterm')"),
    menuentry("Lock screen", "ioncore.exec_on(_, 'xlock')"),
    submenu("Styles",        "stylemenu"),
    submenu("Session",       "sessionmenu"),
})
-- Session control menu
defmenu("sessionmenu", {
    menuentry("Save",        "ioncore.snapshot()"),
    menuentry("Restart",     "ioncore.restart()"),
    menuentry("Restart TWM", "ioncore.restart_other('twm')"),
    menuentry("Exit",        "ioncore.shutdown()"),
})
-- Context menu (frame actions etc.)
defctxmenu("WFrame", "Frame", {
    menuentry("Close",          "WRegion.rqclose_propagate(_, _sub)"),
    menuentry("Attach tagged", "ioncore.tagged_attach(_)", { priority = 0 }),
    menuentry("Clear tags",    "ioncore.tagged_clear()", { priority = 0 }),
    menuentry("Window info",   "mod_query.show_tree(_, _sub)", { priority = 0 }),
})
defctxmenu("WGroup","Group",{menuentry("Toggle tag","WRegion.set_tagged(_, 'toggle')"), menuentry("De/reattach","ioncore.detach(_, 'toggle')"),})
defctxmenu("WGroupWS", "Workspace", {menuentry("Close","WRegion.rqclose(_)"),
    menuentry("Rename", "mod_query.query_renameworkspace(nil, _)"),
    menuentry("Attach tagged", "ioncore.tagged_attach(_)"),})
defctxmenu("WClientWin", "Client window", {menuentry("Kill","WClientWin.kill(_)"),})

-- Extra context menu extra entries for floatframes. 
defctxmenu("WFrame.floating", "Floating frame", {
    append=true,
    menuentry("New tiling", "mod_tiling.mkbottom(_)"),
})

-- Context menu for tiled workspaces.
defctxmenu("WTiling", "Tiling", {
    menuentry("Transpose", "WTiling.transpose_at(_, _sub)"),
    menuentry("Untile", "mod_tiling.untile(_)"),
    menuentry("Destroy frame","WTiling.unsplit_at(_, _sub)"),
    menuentry("Split vertically","WTiling.split_at(_, _sub, 'bottom', true)"),
    menuentry("Split horizontally","WTiling.split_at(_, _sub, 'right', true)"),
    menuentry("Flip", "WTiling.flip_at(_, _sub)"),
    menuentry("Transpose", "WTiling.transpose_at(_, _sub)"),
    menuentry("Untile", "mod_tiling.untile(_)"),
    submenu("Float split", {
        menuentry("At left","WTiling.set_floating_at(_, _sub, 'toggle', 'left')"),
        menuentry("At right","WTiling.set_floating_at(_, _sub, 'toggle', 'right')"),
        menuentry("Above","WTiling.set_floating_at(_, _sub, 'toggle', 'up')"),
        menuentry("Below","WTiling.set_floating_at(_, _sub, 'toggle', 'down')"),
    }),
    submenu("At root", {
        menuentry("Split vertically","WTiling.split_top(_, 'bottom')"),
        menuentry("Split horizontally","WTiling.split_top(_, 'right')"),
        menuentry("Flip", "WTiling.flip_at(_)"),
        menuentry("Transpose", "WTiling.transpose_at(_)"),
    }),
})


