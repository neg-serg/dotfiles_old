home_        = os.getenv("HOME")
notion_path_ = home_ .. "/.notion/"

dofile(notion_path_.."load_file"..".lua")

local mod_list = {
    "mod_notionflux",    -- socket-based notion ipc
    "mod_tiling",        -- static tiling notion module
    "mod_xrandr",        -- xrandr support for notion
    "mod_dock",          -- dock support for notion
    "mod_xkbevents",     -- xkbevents support
}

local cfg_list = { 
    "dbg",               -- functions for stderr debbuging
    "cfg_settings",      -- notioncore.set
    "cfg_rules",         -- window placement rules
    "cfg_layouts",       -- a bunch of default layouts
    "app",               -- module to jump by class, tag, instance etc
    "named_scratchpad",  -- named scratchpad module
    "hide_tabs",         -- hide tabs
    "net_client_list",   -- net client list to provide `wmctrl -l`
    "directions",        -- 2bwm-like directions
    "screenshot",        -- screenshot script
    "cfg_dzen",          -- dzen config
    "rofi",              -- rofi module for menu
    "cfg_autostart",     -- apps autostart
    "functions",         -- helpers. Primarily for cfg_kb.lua
    "cfg_kb",            -- keybindings
    "cfg_xrandr",        -- xrandr config
    "transparency",      -- autoset transparency
    "dzen_bg",           -- background reader for dzen
    "lua_repl"           -- experimental script standalone lua repl
}

for _,mod in ipairs(mod_list) do
    dopath(mod)
end

for _,mod in ipairs(cfg_list) do
    load_file(mod)
end
