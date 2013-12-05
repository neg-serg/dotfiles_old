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
    submap(META.."E", {
       --Tile frame, if no tiling exists on the workspace
        kpress("B", "mod_tiling.mkbottom(_)"),
    }),
})
defbindings("WScreen", {
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
        kpress("AnyModifier+L", "WRegion.rqorder(_chld, 'front')","_chld:non-nil"),
    }),

})

defctxmenu("WFrame.floating", "Floating frame", {
    append=true,
    menuentry("New tiling", "mod_tiling.mkbottom(_)"),
})
